# MyMLChallenge
MeliChallenge is my personal interpretation of MercadoLibre iOS challenge, developed just by myself on November 2023 using UIKit + Swift. 

## Requirements
- XCode Version 15.0.1
- iOS 17.0 

## Technology stack
- Swift
- UIKit 
- Combine
- URLSession
- Kingfisher
- XIB files

## Design Pattern MVVM+Coodinator
- MVVM (Model–view–viewmodel) design patter was choosen to separated to the logic from the UI,
 allowing to be more flexible for unit test, clear resposabilities and clean code. 
- ViewModels uses a dependency injection for data providers to uncouple the source of data.
- ViewModels uses a dependency injection for coordinators, allowing to change and handle the App navigation from one place, no need for changes on ViewModels and or ViewControllers.
 
## Dependencies
- [Kingfisher] - For easy and fast image handling including downloading and caching.

## Networking 
- Combine URLSession api was selected to avoid the overhead of and extra library.

## Notes
- Time spent: around 35hs.



 [Kingfisher]: <https://github.com/onevcat/Kingfisher>

