# TinderCardView


[![iOS](https://img.shields.io/badge/Platform-iOS-orange.svg?style=flat)](https://developer.apple.com/ios/)
[![Swift 5+](https://img.shields.io/badge/Swift-5+-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![TinderCardView](https://img.shields.io/badgeTinder-CardView-orange.svg?style=flat)](https://github.com/Rahul-Mayani/TinderCardView/)
[![Architecture](https://img.shields.io/badge/Architecture%20Pattern-MVVM-green.svg?style=flat)](https://github.com/Rahul-Mayani/TinderCardView/)



Tinder card like carousel to swipe left and right

## Example
![alt text](https://github.com/Rahul-Mayani/TinderCardView/blob/main/sample.mov)

## Requirements

pod 'Kingfisher'
pod 'NVActivityIndicatorView'
pod 'RealmSwift'
pod 'Alamofire'
pod 'RxCocoa'
pod 'RxSwift'
pod 'Cartography'
pod 'SwiftLint'

## Installation

#### Manually
1. Download the project.
2. Add `ZLSwipeableViewSwift` library for card swiping
3. Add necessary files in your project.
4. Congratulations!  

## Usage example
To run the example project, clone the repo, and run pod install from the Example directory first.


```swift

// Add swipeable view
swipeableView = ZLSwipeableView()
swipeableView.allowedDirection = [.None, .Left, .Right]
view.addSubview(swipeableView)

// Add card view
let peopleView = PeopleView(frame: swipeableView.bounds)
peopleView.backgroundColor = UIColor.white


let contentView = Bundle.main.loadNibNamed("PeopleContentView", owner: self, options: nil)?.first! as! PeopleContentView
contentView.translatesAutoresizingMaskIntoConstraints = false
contentView.backgroundColor = peopleView.backgroundColor
peopleView.addSubview(contentView)


```

## Contribute 

We would love you for the contribution to **TinderCardView**, check the ``LICENSE`` file for more info.


## License

TinderCardView is available under the MIT license. See the LICENSE file for more info.
