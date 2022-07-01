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
  1. [Configure Xcode project](#configure-xcode-project)
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

Your Podfile will now look something like this:

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


## Configure your Xcode project


### Enable localization in Xcode

Enable base localization in the Xcode project. 
This will set Storyboards and Xibs as the base and will add additional string files for each extra language. 


### Add languages in Xcode

Add your required languages to the Xcode project.

You should also add a ***pseudo language*** that will only be used to load marked texts into your project and enables Rigi to capture screenshots and recognise and extract the marked texts. 

Here we chose Zulu as a pseudo language. 

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/localization.png)


### Add Rigi Target and Scheme in Xcode

<!--<img src="https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/target-dupl.png" width="200" align="right">-->

You can create a specific target and scheme for the Rigi builds. This keeps your production builds separated from the Rigi builds.

In Xcode create (or copy) a new scheme and set App language to the new pseudo locale. 

<img src="https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/target-dupl.png" width="200">

When the locale can not be selected from the dropdown add a new launch argument  in the scheme

```code
-AppleLanguages "(ZU)"
```


![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/scheme-edit4.png)



### Enable Rigi in Xcode

Optionally you can add a custom preprocessor flag to enable Rigi only for the Rigi build Target.

![Add Rigi preprocessor flag](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/build1.png)

Activate the Rigi SDK in the appDelegate. 

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/app-del.png)


```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions 
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    #if RIGI_ENABLED
        RigiSdk.shared.start()
    #endif

    return true
}
```


## Link your Xcode project to Rigi

### Setup a new project on the Rigi server

1. Create a new Rigi project. 
2. Select your base Xcode language as the Source language. In this example we use EN. 
3. Select the the Pseudo language that you added to the Xcode project. In this example we use Zulu.

TODO add 2 server-setup images



### Extract all localisation files from Xcode project

Optionally you can use the tool [BartyCrouch](https://github.com/Flinesoft/BartyCrouch) to extract your localised texts from Storyboards and Swift code and incrementally update all string files in the project.

See: https://github.com/Flinesoft/BartyCrouch

##### Bartycrouch installation:

```bash
brew install bartycrouch 
```

#### Bartycrouch initialisation:

```bash
bartycrouch init 
```

#### Update string files:

```bash
bartycrouch update 
```

### Setup the Rigi commandline tools

The Rigi SDK comes shipped with several commandline tools to streamline the process of exporting and importing string files and uploading or downloading them from the Rigi server.

To setup the Rigi commandline tools you need to create a ***rigi.ini*** file in your project root folder. A template for the ini file is availlable in the Rigi Pods folder. You can copy the template to your project folder as follows:

```bash
cd [PROJECT_FOLDER]
mkdir Rigi
cp Pods/Rigi/docs/rigi.ini Rigi
```

The ***rigi.ini*** file has several settings that can be customised. The ***PROJECT_NAME*** is required and should exactly match the project name on the Rigi server. 

For most projects the other settings can be left default, however, they can customised set if needed.

```bash
edit Rigi/rigi.ini

# --------------------
# Babylon SDK settings
# --------------------

# Rigi project name:
# - Should match the project name on the Rigi server

PROJECT_NAME="RIGI-PROJECT"

# Folder where downloaded string files will be saved:
# - If empty the default download folder will be used

#DOWNLOAD_FOLDER=~/Downloads

# Simulator documents folder:
# - If empty the last used simulator rigi folder will be used

#SIMULATOR_DOCUMENTS=~/Library/Developer/CoreSimulator/Devices/B6D3A06C-8B50-43D8-B3EE-7469EF7312B7/data/Containers/Data/Application/BFDE44A9-AF81-4B29-8685-BD728F1CEBE3/Documents

# Xcode project folder:
# - If empty the Rigi sdk will try to find the project folder.

#XCODE_PROJECT=~/Projects/Xcode/MY-PROJECT
```

### Zip all localisation files from Xcode project

Use the following command to find and **zip all string files** in the Xcode project to prepare for uploading to the Rigi server.

```bash
cd [PROJECT_FOLDER]
Pods/Rigi/bin/strings-collect.sh
```

### Upload the string files to the Rigi server

Use the following command to open a finder window with the zipped string files that can be uploaded to the Rigi server.

```bash
 cd [PROJECT_FOLDER]
 Pods/Rigi/bin/uploads-open.sh
```
From this folder the zipped string files can be uploaded to the Rigi server (using drag-and-drop)

TODO: add image server-import- 1 t/m 7

The Rigi tokens will have been added to the Pseudo language. The updated language files should now be downloaded and installed in the Xcode project.


### Download the (pseudo) string files from the Rigi server

Export the string files from the server by clicking 'Download files'. You should select the **pseudo language**. Optionally you can also export any other langauge.

After dowloading use following command to install the string files into the Xcode project. This command will look for downloaded zip files in the default **Downloads** folder. This can be changed in the **rigi.ini** settings file. 

```bash
cd [PROJECT_FOLDER]
Pods/Rigi/bin/strings-extract.sh
```


### Make previews in the Simulator (manual)

Now its time to capture previews of the translatable texts in the Xcode Simulator. Run the Target or Scheme that includes the preview code and the pseudo language. In this example we use the **RigiExample Pseudo** scheme which automatically runs the app in the **psuedo language (Zulu)** and activates the Rigi SDK on startup.

Navigate through the app and capture previews of all screens that contain translatable texts.

TODO capture 1

The previews will be saved into the Simulator data folder.


### Collect the previews to upload

You can use the following command to **open the previews in the Simulator folder**. 

This command will try to find the latest saved Rigi preview in any Xcode Simulator folder. When this is not working for your project you can specify a specific Xcode Simulator folder in the **rigi.ini** settings file. 

```bash
cd [PROJECT_FOLDER]
Pods/Rigi/bin/previews-peek.sh
```

TODO preview-peek


When all previews are complete use the following command to **zip the previews** found in the Simulator folder.

```bash
cd [PROJECT_FOLDER]
Pods/Rigi/bin/previews-collect.sh
```

### Upload the previews to the Rigi server

Use the following command to open a finder window with the **zipped previews** that can be uploaded.

```bash
cd [PROJECT_FOLDER]
Pods/Rigi/bin/previews-open.sh
```
The previews can now be uploaded to the Rigi server. 

Select ... then use select and drop the latest zipped previews file.

TODO upload-previews


Download localization files from the Rigi server

After making modifications to the translations or adding new texts to the pseudo language you can download the updated localisations files and extract them in the project folder.

 [PROJECT_FOLDER]/Rigi/bin/update-strings.sh 


Adding new texts to the project

Add new text to the code or storyboards

Extract the text with bartycrouch

 bartycrouch update 
Copy the new text in the source string file (EN)

Compact all string files

 [PROJECT_FOLDER]/Rigi/bin/collect-strings.sh 








Upload the generated file to the server


Approve the new strings for translation

Add the new texts by clicking update


Download the updated SE strings and ZU texts with the new Rigi codes


Extract the marked text files in the code project

 [PROJECT_FOLDER]/Rigi/bin/update-strings.sh 



Start the Rigi preview in the Simulator (manual)
Run the Target or Scheme that includes the preview code and the pseudo language. 
Make previews from the screens with the new (untranslated) texts.

Upload the new previews to the server


New strings files should manually be added to Rigi Goto files, find the new strings file in the source language (EN) and click Add?
To add the new text entries to Rigi, click Approve for translation 

Now the new texts can be translated and download from Rigi






Extract the translated text files in the code project

 [PROJECT_FOLDER]/Rigi/bin/update-strings.sh


## License

Copyright (c) 2022 Rigi.io

<br />








