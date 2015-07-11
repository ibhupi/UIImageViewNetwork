# UIImageViewNetwork

[![CI Status](http://img.shields.io/travis/Bhupendra Singh/UIImageViewNetwork.svg?style=flat)](https://travis-ci.org/Bhupendra Singh/UIImageViewNetwork)
[![Version](https://img.shields.io/cocoapods/v/UIImageViewNetwork.svg?style=flat)](http://cocoapods.org/pods/UIImageViewNetwork)
[![License](https://img.shields.io/cocoapods/l/UIImageViewNetwork.svg?style=flat)](http://cocoapods.org/pods/UIImageViewNetwork)
[![Platform](https://img.shields.io/cocoapods/p/UIImageViewNetwork.svg?style=flat)](http://cocoapods.org/pods/UIImageViewNetwork)

## Summary

UIImageViewNetwork is easy to use Swift UIImageView extension to download image from network asynchronously in background thread. 

UIImageViewNetwork also safe to use in CollectionViews and TableViews because it ignores downloading image if new url is used for image. In reuseable collection view and table view cells it first checks wheather downloaded image url is same as recent URL or not. Ignore if downloaded image url is different than recent URL.

UIImageViewNetwork also caches downloaded image to reuse. Default cache limit is 100 images. But can be easily customizable. 
TODO: Further improvement in image caching and purging for memory warnings.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```Swift

UIImageView().errorImage = UIImage(named: "ErrorImage")
UIImageView().setImageFromUrl("https://developer.apple.com/assets/elements/icons/128x128/swift_2x.png");

```

## Requirements

## Installation

UIImageViewNetwork is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UIImageViewNetwork"
```

## Author

Bhupendra Singh, ibhupi@gmail.com

## License

UIImageViewNetwork is available under the MIT license. See the LICENSE file for more info.
