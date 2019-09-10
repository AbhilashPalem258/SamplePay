# SamplePay
> A Demo project for learning iOS Framework integration with Cocoapods

![Xcode 9.0+](https://img.shields.io/badge/Xcode-10.3%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-12.4%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-5.0%2B-orange.svg)

## Requirements

- Swift 5.0
- iOS 8.0+
- Xcode 10.3

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `SamplePay` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
 use_frameworks!
 pod 'SamplePay', '~> 0.1.1'
```

To get the full benefits import `SamplePay` wherever you import UIKit

``` swift
import UIKit
import SamplePay
```

## Usage example

```swift
//MARK:- ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func btnAction(_ sender: Any) {
        let options = SamplePayConfigurationOptions.init(rootViewController: self, delegate: self)
        SamplePay.shared.setConfigurationOptions(options: options)
        
        do {
            try SamplePay.shared.enterUserDetails()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
//MARK:- ViewController: SamplePayDelegate Method Implementation
extension ViewController: SamplePayDelegate {
    func didFinishedWithEnteringUserDetails(user: User!) {
        print(user!)
        self.profileImageView.image = user.profilePic
        self.textView.text = String(describing: user!)
    }
    
    func didClickedOnCancel() {
        print("cancelled")
    }
}
```

## Release History

* 0.1.0
  Swift 5.0 initial release

* 0.1.1
  Swift 5.0 Added support for Testing with a demo project
