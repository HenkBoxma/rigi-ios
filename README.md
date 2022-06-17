# [Rigi SDK](https://rigi.io) for iOS

[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://cocoapods.org/pods/RigiSDK)
[![Languages](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/Rigi/Rigi-SDK-ios)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-green.svg)](https://cocoapods.org/pods/RigiSDK)
[![Commercial License](https://img.shields.io/badge/license-Commercial-green.svg)](https://github.com/Rigi/Rigi-SDK-ios/blob/master/LICENSE.md)

Create Rigi previews for your iOS project.

## Table of contents

  1. [Introduction](#introduction)
  1. [Requirements](#requirements)
  1. [Install the Rigi SDK](#install-the-rigi-sdk)
  1. [License](#SDK-at-a-glance)  
  
<br />

## Introduction

**RIGI SDK** for iOS is a development kit that enables an easy and fast integration of Rigi into new or existing iOS apps.

This repository houses the Rigi iOS SDK framework and sample projects.

- **Examples** - The example apps.
- **Releaes** - The Rigi framework and commandline scripts. 

Find out more about Rigi for iOS on [TODO](https://rigi.io). 

<br />

##  Requirements

The minimum requirements for Rigi SDK for iOS are:

- iOS 11+
- Swift 5.0+ / Objective-C
- Rigi SDK for iOS 1.0.0+

<br />

## Install the Rigi SDK

SDK for iOS can be installed through [`CocoaPods`](https://cocoapods.org/)

### Cocoapods 
Install cocoapods (if not already done). Open Terminal and run:

```bash
sudo gem install cocoapods
```

Setup cocoapods in your project (if not already done). Goto your project's root folder and run: 

```bash
pod init
pod install
```

This will setup cocoapods in the project. CocoaPods will create a new project_name.xcworkspace file, a new Podfile and a Pods folder.

Add the following lines to the top of the `Podfile`:

```bash
source 'https://github.com/HenkBoxma/rigi-ios'
source 'https://cdn.cocoapods.org/'
```

Add the Rigi pod. Optionally specify the version you want to use, like so:

```bash
pod 'Rigi', '~> 1.0'
```

Your Podfile now will look something like this:

```bash
platform :ios, '11.0'

source 'https://cdn.cocoapods.org/'
source 'https://github.com/HenkBoxma/rigi-ios-pod.git'

target 'RigiExample' do
  use_frameworks!

  pod 'Rigi'

  # Additionall pods
  # pod 'SVProgressHUD'

end
```


Once you update your Podfile you will need to run either `pod update` or `pod install --repo-update` to update your repos.

Open the project_name.xcworkspace with Xcode.


## Add localisations to Xcode project


Enable base localization in the Xcode project. 
This will set Storyboards and Xibs as the base and will add additional string files for each extra language. 

Add the required extra languages in the Xcode project.

You should also add a pseudo language that will only be used to load marked texts into your project and enables Rigi to capture screenshots and recognise and extract the marked texts. 

Here we chose Zulu (South Africa) as a pseudo language. 

Add a new scheme to run pseudo language in simulator

In Xcode create (or copy) a new scheme and set App language to the new pseudo locale. When the locale can not be selected from the dropdown add a new launch argument -AppleLanguages "(ZU)"


Then remove the pseudo locale from all distribution targets.
Alternatively we could create a specific target that will only be used for Rigi previewting and string extraction. Then we can add the pseudo language files as the only locale for this target. 

TODO - Test the proposed solution above


Add the Rigi SDK to the project

For now just copy the RigiSdk folder to the project and add the folder in Xcode.


Then activate the Rigi SDK in the appDelegate. You can also add a custom pre processor flag to enable Rigi Capture only for a specific build Target.

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions 
    	launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #if RIGI_ENABLED
        RigiSdk.shared.start()
        #endif

        return true
    }
```




## License

Copyright (c) 2022 Rigi.io

<br />








