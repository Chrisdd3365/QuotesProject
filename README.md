# OwlQuotes

## Description:

OwlQuotes is an iOS app developper on Swift 5.0. It's a motivation/inspirational app.
His main purpose is to suggest quotes, images and to write quotes too.

## Main functionnalities:

- Quotes: To allow the user to get random or specific quotes (categories).

- Images: To allow the user to get random or specific images (categories).

- My Own Quote: To allow the user to write his own quotes.

- Favorites: To allow the user to add or to remove a selected quote or a selected image from the list of favorites quotes/images.

- Reminders: To allow the user to add a reminder by creating a local notification at a specific hour. It will repeat daily.

## Others functionnalities:

- Picture: To allow the user to pick a picture from his own photo library or to take a picture with the front or back camera, in order to display it in the background view of the quote.

- Share: To allow the user to share quotes or images through different social networks.

- Date Time Picker: To allow the user to set up the right time to receive a local notification with a random quote in it.

## What I used:

- MVC pattern
- CoreData
- API rest request with TheySaidSo and Quotes On Design

## Running the tests:
- UnitTesting API requests with Double Fake URL Session and Fake Response Data.
- UnitTesting CoreData.
- UnitTesting NotificationsManager.

## Requirements:

- iOS 12.0+
- Xcode 10.2.1
- CocoaPods 

## Dependencies:

- SDWebImage
- HTMLString
- BubbleTransition
- NVActivityIndicatorView
- KRProgressHUD
- DLLocalNotifications
- DateTimePicker

## Design UI:

- Responsive design on all iPhone devices, in portrait mode only.
