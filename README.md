# Zoom iOS Software Development Kit (SDK)

> Encounter with issues? The answer might be waiting for you at [Frequently Asked Questions]() sections. Check it out!

Zoom SDK makes it easy to integrate Zoom with your iOS applications, and boosts up your applications with the power of Zoom.

* **Easy to use**: Our SDK is built to be easy to use. Just import the libraries, call a few functions, and we will take care all video conferencing related stuffs for you.
* **Localizable**: Our SDK naturally supports 7 major languages, and you can add more to grow your applications internationally.
* **Custom Meeting UI**: If you want to add your own decorations to your Zoom meeting rooms, try our Custom UI feature to make your meeting room special.

## Getting Started

The following instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
* For detailed instructions, please refer to our documentation website: [[https://marketplace.zoom.us/docs/guides/zoom-sdks/ios](https://marketplace.zoom.us/docs/guides/zoom-sdks/ios)];
* If you need support or assistance, please visit our [Zoom Developer Community Forum](https://devforum.zoom.us/);

### Prerequisites

Before you try out our SDK, you would need the following to get started:

* **A Zoom Account**: If you do not have one, you can sign up at [https://zoom.us/signup](https://zoom.us/signup).
  * Once you have your Zoom Account, sign up for a 60-days free trial at [https://developer.zoom.us](https://developer.zoom.us)
* **An iOS device**
  * **[Note]**:**The examples downloaded from here only works on real device. If you want to try it on iOS simulator, or on all architectures (x86_64, i386, etc.) , please use the version (ios-mobilertc-all-*.zip) from release page: [https://github.com/zoom/zoom-sdk-ios/releases](https://github.com/zoom/zoom-sdk-ios/releases);**

### Installing

Clone or download a copy of our SDK files from GitHub. After you unzipped the file, you should have the following folders:

```
├── CHANGELOG.md
├── LICENSE.md
├── [MobileRTCSample] <- Libraries and examples are inside
├── README.md
├── lib
└── version.txt
```
Launch your **Xcode**, navigate to the "MobileRTCSample" folder, and open the MobileRTCSample.xcodeproj file.


```
├── MobileRTCSample
├── MobileRTCSample.xcodeproj
└── MobileRTCSampleScreenShare
```

We provide 2 examples for you:
 * **MobileRTCSample**: An iOS app that has all basic features for login users.
 * **MobileRTCSampleScreenShare**: An iOS app that enables screen sharing feature.


## Running the tests

Connect your iOS device to your computer and simply press "Run" on selected example, the example will run on your device.


## Documentation

Please visit [[https://marketplace.zoom.us/docs/guides/zoom-sdks/ios](https://marketplace.zoom.us/docs/guides/zoom-sdks/ios)] for details of each features and functions.

## Versioning

For the versions available, see the [tags on this repository](https://github.com/zoom/zoom-sdk-ios/tags).

## Change log

Please refer to our [CHANGELOG](CHANGELOG.md) for all changes.

## Frequently Asked Questions (FAQ)

* :one: `dyld: Library not loaded: /usr/lib/libstdc++.6.dylib`:
  * libstdc++ is deprecated for 5+ years, Apple removes it in XCode 10. Our latest SDK release ([v4.1.34076](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.1.34076.1024)) has resolved this issue.
* :two: `dyld: Library not loaded: MobileRTC.framework/MobileRTC`:
  * Our **iOS SDK** is a dynamic library, please import the **MobileRTC.framework** into:
    * **Link Binary With Libraries**
    * **Embedded Binaries**
* :three: `d:undefined symbols for architecture x86_64`:
  * The examples downloaded from here only works on real device. If you want to try it on **iOS simulator**, or on all architectures (**x86_64, i386, etc.**) , please use the version (**ios-mobilertc-all-*.zip**) from release page: [https://github.com/zoom/zoom-sdk-ios/releases](https://github.com/zoom/zoom-sdk-ios/releases);


## License

Please refer to [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* :star: If you like our SDK, please give us a "Star". Your support is what keeps us moving forward and delivering happiness to you! Thanks a million! :smiley:
* If you need any support or assistance, we are here to help you: [Zoom Developer Community Forum](https://devforum.zoom.us/);

---
Copyright ©2018 Zoom Video Communications, Inc. All rights reserved.
