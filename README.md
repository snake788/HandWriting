# HandWriting

HandWriting is a simple iOS application allowing to convert text into PNG handwriting.

You can also:
  - Pick a font through a list and show details like name, neatness, recursivity, thickness and embellishment
  - Sort fonts list among title, neatness or character thickness
  - Tap the converted text of your choice
  - Add options to round off your PNG render (color, character width, render height, render width, line-spacing)
  - Generate PNG render
  - Display list of all your PNG renders through a collection of images 


### How to get started

- Download source code
- Installation with CocoaPods by simply run the following command into the project directory :
```sh
$ pod install
```
- Open HandWriting.xcworkspace

### Version
1.0

### Requirements
- iOS >= 9.3

### Frameworks
> [CocoaPods](https://cocoapods.org)
- The best dependency manager for Cocoa projects

> [CoreData](https://developer.apple.com/library/watchos/documentation/Cocoa/Conceptual/CoreData/index.html)
- Allow to store data into external file rather than store binary directly into database (the goal of this app)
- Apple homemade framework
- Easily tracks changes from his persitant store
- Add abstraction layer for entities data model

> [AFNetworking](https://github.com/AFNetworking/AFNetworking)
- The most popular third party networking library
- Build on the top of NSURLSession
- Use and integration are simplified

> [SwiftSpinner](https://github.com/icanzilb/SwiftSpinner)
- Beautiful loading view integration

> [SwiftHSVColorPicker](https://github.com/johankasperi/SwiftHSVColorPicker)
- Simply color picker written in Swift

### Architecture
- MVC
- Storyboard / XIB
- Autolayout

**Yeah!**
