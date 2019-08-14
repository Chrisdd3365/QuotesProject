//
//  RandomQuotesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import UserNotifications

class RandomQuotesViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - Outlets
    @IBOutlet weak var randomQuotesScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Properties
    let randomQuotesService = RandomQuotesService()
    var randomQuotes = [RandomQuotes]()
    var slidesViews = [SlideView]()
    var imagePicker: ImagePicker?
    var favoritesQuotes = FavoriteQuote.all
   
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        randomQuotesScrollView.delegate = self
    
        slidesViews = createSlides()
        setupSlideScrollView(slidesViews: slidesViews)
        
        pageControl.numberOfPages = slidesViews.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesQuotes = FavoriteQuote.all
        buttonsSetImage()
    }
    
    //MARK: - Actions
    @IBAction func takePicturesButtonTapped(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func newQuotesButtonTapped(_ sender: UIButton) {
        fetchRandomQuotesData()
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        for i in 0 ..< randomQuotes.count  {
            if i == pageControl.currentPage {
                didTapShareButton(view: slidesViews[i].randomQuotesView)
                print(i)
            }
        }
    }

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        addToFavoritesListSetup()
    }

    //MARK: - Methods
    private func createSlides() -> [SlideView] {
        let slideView0: SlideView = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slideView0.randomQuotesView.randomQuotesViewConfigure = randomQuotes[0]
        
        let slideView1: SlideView = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slideView1.randomQuotesView.randomQuotesViewConfigure = randomQuotes[1]
        
        let slideView2: SlideView = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slideView2.randomQuotesView.randomQuotesViewConfigure = randomQuotes[2]
        
        let slideView3: SlideView = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slideView3.randomQuotesView.randomQuotesViewConfigure = randomQuotes[3]
        
        let slideView4: SlideView = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slideView4.randomQuotesView.randomQuotesViewConfigure = randomQuotes[4]

        return [slideView0, slideView1, slideView2, slideView3, slideView4]
    }
    
    private func setupSlideScrollView(slidesViews: [SlideView]) {
        randomQuotesScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        randomQuotesScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slidesViews.count), height: view.frame.height)
    
        for i in 0 ..< slidesViews.count {
            slidesViews[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            randomQuotesScrollView.addSubview(slidesViews[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(randomQuotesScrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = randomQuotesScrollView.contentSize.width - randomQuotesScrollView.frame.width
        let currentHorizontalOffset: CGFloat = randomQuotesScrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = randomQuotesScrollView.contentSize.height - randomQuotesScrollView.frame.height
        let currentVerticalOffset: CGFloat = randomQuotesScrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slidesViews[0].randomQuotesView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slidesViews[1].randomQuotesView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slidesViews[1].randomQuotesView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slidesViews[2].randomQuotesView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slidesViews[2].randomQuotesView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slidesViews[3].randomQuotesView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slidesViews[3].randomQuotesView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slidesViews[4].randomQuotesView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
        
        if randomQuotesScrollView.contentOffset.y > 0 || randomQuotesScrollView.contentOffset.y < 0 {
            randomQuotesScrollView.contentOffset.y = 0
        }
        
        buttonsSetImage()
    }
    
    

    
    private func fetchRandomQuotesData() {
        randomQuotesService.getRandomQuotes { (success, randomQuotes) in
            if success {
                self.randomQuotes = randomQuotes
                self.slidesViews = self.createSlides()
                self.setupSlideScrollView(slidesViews: self.slidesViews)
            } else {
                self.showAlert(title: "Sorry!", message: "Image not available!")
            }
        }
    }
    
    private func addToFavoritesListSetup() {
        for i in 0 ..< randomQuotes.count  {
            if i == pageControl.currentPage {
                guard let contentRandomQuote = slidesViews[i].randomQuotesView.randomQuotesViewConfigure else { return }
                if checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: "\(contentRandomQuote.id)") == false {
                    favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
                    CoreDataManager.saveRandomQuoteToFavoritesQuotes(contentRandomQuote: contentRandomQuote)
                    favoritesQuotes = FavoriteQuote.all
                } else {
                    favoritesQuotes = FavoriteQuote.all
                    showAlert(title: "Sorry!", message: "You've already added this quote into your favorite list!")
                }
            }
        }
    }
    
    private func buttonsSetImage() {
        for i in 0 ..< randomQuotes.count  {
            if i == pageControl.currentPage {
                guard let contentRandomQuote = slidesViews[i].randomQuotesView.randomQuotesViewConfigure else { return }
                favoriteButton.setImage(updateButtonImage(check: checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: "\(contentRandomQuote.id)"), checkedImage: "favorite", uncheckedImage: "noFavorite"), for: .normal)
            }
        }
    }
    

//    private func notifications(quotes: [QuoteOfTheDay]) {
//        //Content
//        let content = UNMutableNotificationContent()
//        content.title = quotes[0].author ?? ""
//        content.body = quotes[0].quote
//        content.sound = UNNotificationSound.default
//
//        //Trigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = 15
//        dateComponents.minute = 38
//        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalTrigger()), repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: false)
//        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        //Request
//        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//    }
    
//    //HELPER
//    private func timeIntervalTrigger() -> Int {
//        if timeInterval == 0 {
//            return 3600/1
//        }
//        return 3600 / timeInterval
//    }
}

extension RandomQuotesViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        for i in 0 ..< randomQuotes.count  {
            if i == pageControl.currentPage {
                slidesViews[i].randomQuotesView.backgroundImageView.image = image
                print(i)
            }
        }
    }
}
