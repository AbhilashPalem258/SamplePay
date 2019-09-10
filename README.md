# SamplePay
> A Demo project for learning iOS Framework integration with Cocoapods

This demo project will help you in the following ways:

1. Create a swift framework  
2. Convert swift framework to Universal framework, which can be integrated by both iPhoneOS and iPhoneSimulator
3. Publish Universal framework to cocoapods 
4. Test driven development of pod using a test project 'SampleTesting'
5. Work with native camera app and import the pic captured
6. Communication between dynamic framework and test project

![Xcode 9.0+](https://img.shields.io/badge/Xcode-10.3%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-8.0+%2B-blue.svg)
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
#### Privacy (iOS 10)

If you are building your app with iOS 10 or newer, you need to add two privacy keys to your app's Info.plist to allow the usage of the camera and photo library, or your app will crash. 

Add the keys below to the `<dict>` tag of your Info.plist, replacing the strings with the description you want to provide when prompting the user:

```
	<key>NSCameraUsageDescription</key>
	<string>Please allow camera access to capture photos</string>
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

#### SamplePayError 

SamplePayError are the errors, which can be thrown incase of any code failure

```swift
//MARK:- SamplePayError
public enum SamplePayError: Error {
    case rootViewControllerNotSet
}
```

#### SamplePayConfigurationOptions 

Need to send the configuration options to SamplePay for proper functioning
*Mandatory

```swift
//MARK:- SamplePayConfigurationOptions
public struct SamplePayConfigurationOptions {
    public weak var rootViewcontroller: UIViewController?
    public weak var delegate: SamplePayDelegate?
    public init(rootViewController: UIViewController?, delegate: SamplePayDelegate?) {
        self.delegate = delegate
        self.rootViewcontroller = rootViewController
    }
}
```

#### SamplePayDelegate 

The delegate methods provide callbacks for some of the most commonly needed events, such as:

```swift
//MARK:- SamplePayDelegate
public protocol SamplePayDelegate: AnyObject {
   func didFinishedWithEnteringUserDetails(user: User!)
   func didClickedOnCancel()
}
```

## Release History

* 0.1.0
  Swift 5.0 initial release

* 0.1.1
  Swift 5.0 Added support for Testing with a demo project
