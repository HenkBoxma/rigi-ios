# [Rigi SDK](https://rigi.io) for iOS

[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://cocoapods.org/pods/RigiSDK)
[![Languages](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/Rigi/Rigi-SDK-ios)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-green.svg)](https://cocoapods.org/pods/RigiSDK)
[![Commercial License](https://img.shields.io/badge/license-Commercial-green.svg)](https://github.com/Rigi/Rigi-SDK-ios/blob/master/LICENSE.md)

Create Rigi previews for your iOS project.


## Table of contents

  1. [Introduction](#introduction)
  1. [Requirements](#requirements)
  1. [Localize the project](#localize-the-xcode-project)
  1. [Setup the Rigi SDK](#add-the-Rigi-SDK-in-Xcode)
  1. [Rigi commandline tools](#Setup-the-Rigi-commandline-tools)
  1. [Setup the Rigi server](#Setup-the-project-on-the-Rigi-server)
  1. [Add Rigi tokens](#Add-Rigi-tokens)
  1. [Make previews](#Make-previews)
  1. [Translate with previews](#Translate-with-previews)
  1. [Import translations](#Import-translations)
  1. [License](#SDK-at-a-glance)  
  
<br />

## Introduction

**RIGI SDK** for iOS is a development kit that enables an easy and fast integration of Rigi into new or existing iOS apps.

This repository houses the Rigi iOS SDK framework and sample projects.

- **Examples** - The example apps.
- **Releaes** - The Rigi framework and commandline scripts. 

Find out more about Rigi for iOS on (https://rigi.io). 

<br />

##  Requirements

The minimum requirements for Rigi SDK for iOS are:

- iOS 11+
- Swift 5.0+ / Objective-C
- Rigi SDK for iOS 1.0.0+

<br />

## Localize the project

To make use of the Rigi SDK we need to enable localization in the Xcode project and add a special ***pseudo language***. Later we will add Rigi codes to the ***pseudo language*** that will be used to highlight translatebale texts in the preview screenshot. This section describes how to setup basic localization in your project.

### Enable localization in Xcode

Enable base localization in the Xcode project. 
This will set Storyboards and Xibs as the base and will add additional string files for each extra language. 

### Add languages in Xcode

Add your required languages to the Xcode project. In this example we choose ***Dutch (NL)***.

You should also add a ***pseudo language*** that will only be used to load marked texts into your project and enables Rigi to capture screenshots and recognise and extract the marked texts. 

Here we will choose Zulu as a pseudo language. 

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/localization.png)


## Setup the Rigi SDK

This section describes how to add the Rigi SDK to your Xcode project using ***cocoapods*** and how to configure the project and the Rigi SDK. 

### Create Rigi Target and Scheme

<!--<img src="https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/target-dupl.png" width="200" align="right">-->

You can create a specific target and scheme for the Rigi builds that will be used to capture previews. This keeps your production builds separated from the Rigi builds.

In Xcode create (or copy) a new scheme and set the App language to the ***pseudo locale*** that will be used to capture previews. 

<img src="https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/target-dupl.png" width="200">

When the locale can not be selected from the dropdown add a new launch argument  in the scheme

<pre class="splash"><code>code
-<span class="type">AppleLanguages</span> <span class="string">"(ZU)"</span></code></pre>


![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/scheme-edit4.png)


### Add the Rigi SDK to Xcode

SDK for iOS can be installed through [`CocoaPods`](https://cocoapods.org/)

Install cocoapods (if not already done). Open Terminal and run:

<pre class="splash"><code><span class="bash">bash</span>
sudo gem install cocoapods</code></pre>

Setup cocoapods in your project (if not already done). Goto your project's root folder and run: 

<pre class="splash"><code><span class="bash">bash</span>
pod <span class="keyword">init</span>
pod install</code></pre>

This will setup cocoapods in the project. CocoaPods will create a new project_name.xcworkspace file, a new Podfile and a Pods folder.

Add the following lines to the top of the `Podfile`:

<pre class="splash"><code><span class="bash">bash</span>
source 'https://github.<span class="property">com</span>/<span class="type">HenkBoxma</span>/rigi-ios'
source 'https://cdn.<span class="property">cocoapods</span>.<span class="property">org</span>/'</code></pre>

Add the Rigi pod. Optionally specify the version you want to use, like so:

<pre class="splash"><code><span class="bash">bash</span>
pod '<span class="type">Rigi</span>', '~&gt; <span class="number">1.0</span>'</code></pre>

Your Podfile will now look something like this:

<pre class="splash"><code><span class="bash">bash</span>
platform :ios, '<span class="number">11.0</span>'

use_frameworks!

source 'https://cdn.<span class="property">cocoapods</span>.<span class="property">org</span>/'
source 'https://github.<span class="property">com</span>/<span class="type">HenkBoxma</span>/rigi-ios-pod.<span class="property">git</span>'

def shared_pods
  # <span class="type">Add</span> shared pods here
end

target '<span class="type">RigiExample</span>' <span class="keyword">do</span>
  shared_pods
end

target '<span class="type">RigiExample Pseudo</span>' <span class="keyword">do</span>
  shared_pods
  pod '<span class="type">Rigi</span>'
end</code></pre>

Once you update your Podfile you will need to run either `pod update` or `pod install --repo-update` to update your repos.

Open the project_name.xcworkspace with Xcode.
<br/>
<br/>

### Enable Rigi in Xcode

Add a custom preprocessor flag to enable Rigi only for the Rigi build Target.

![Add Rigi preprocessor flag](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/build1.png)

Activate the Rigi SDK in the appDelegate. 

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/app-del.png)


<pre class="splash"><code><span class="swift">swift</span>

<span class="keyword">import</span> UIKit

<span class="preprocessing">#if RIGI_ENABLED</span>
<span class="keyword">import</span> Rigi
<span class="preprocessing">#endif</span>

<span class="keyword">@main
class</span> AppDelegate: <span class="type">UIResponder</span>, <span class="type">UIApplicationDelegate</span> {

    <span class="keyword">func</span> application(<span class="keyword">_</span> application: <span class="type">UIApplication</span>, didFinishLaunchingWithOptions launchOptions: [<span class="type">UIApplication</span>.<span class="type">LaunchOptionsKey</span>: <span class="type">Any</span>]?) -&gt; <span class="type">Bool</span> {

        <span class="preprocessing">#if RIGI_ENABLED</span>
        <span class="type">RigiSdk</span>.<span class="property">shared</span>.<span class="call">start</span>()
        <span class="preprocessing">#endif</span>

        <span class="keyword">return true</span>
    }
}</code></pre>

### Configure the Rigi SDK

For most project the Rigi SDK will work fine out of the box. For specific needs the SDK has several options that can be customised. This section will give an overview of these options.

The SDK settings are available on the global ***RigiSdk.shared.settings*** and can be customised as follows:

<pre class="splash"><code><span class="swift">swift</span>

	<span class="type">RigiSdk</span>.<span class="property">shared</span>.<span class="property">settings</span>.<span class="property">addLabelBorders</span> = <span class="keyword">true</span>
	<span class="type">RigiSdk</span>.<span class="property">shared</span>.<span class="property">settings</span>.<span class="property">labelBorderColor</span> = <span class="string">"#800000"</span>
 	<span class="type">RigiSdk</span>.<span class="property">shared</span>.<span class="call">start</span>()</code></pre>
The following configuration options are available:

<pre class="splash"><code><span class="swift">swift</span>

    <span class="comment">// Enable (debug) logging</span>
    <span class="keyword">public var</span> loggingEnabled = <span class="keyword">true</span>

    <span class="comment">// Show the scan button</span>
    <span class="keyword">public var</span> isButtonVisible = <span class="keyword">true</span>

    <span class="comment">// Add timestamps to the preview names</span>
    <span class="keyword">public var</span> addFileTimestamps = <span class="keyword">true</span>

    <span class="comment">// Enable auto scanning when new view controllers are detected in the view hierarchy</span>
    <span class="keyword">public var</span> enableAutoScanning = <span class="keyword">false
    public var</span> autoScanInterval: <span class="type">Double</span> = <span class="number">1</span> <span class="comment">// Should be greater than the delay time below.</span>
    <span class="keyword">public var</span> autoScanCaptureDelay: <span class="type">Double</span> = <span class="number">0.7</span>

    <span class="comment">// This option will make sure only the upper view controller is scanned when multiple view controllers are stacked on the screen.
    // For example in MobilePark the onboarding flow will stack multiple view controllers.</span>
    <span class="keyword">public var</span> onlyScanUpperViewController = <span class="keyword">true</span>

    <span class="comment">// Temporarily clear textfields and textviews to snapshot hint texts</span>
    <span class="keyword">public var</span> autoClearTextFields = <span class="keyword">true</span>

    <span class="comment">// By default embedded or child view controllers will not handled as an 'upper' view controller (like popup windows)
    // Optionally you can register embedded/child view controllers that should be handled as upper view controllers.
    // For example an embedded menu view controller should be regarded as an upper view controller
    // and thus the capture should ignore all views 'behind' the menu view controller.</span>
   <span class="keyword">public var</span> additionalUpperViewControllers: [<span class="type">String</span>] = []

    <span class="comment">// What is the minimum part of the label that should be visible on the screen?</span>
    <span class="keyword">public var</span> minimumOnscreenHorz = <span class="number">0.8</span>
    <span class="keyword">public var</span> minimumOnscreenVert = <span class="number">0.8</span>

    <span class="comment">// Clip the offscreen part of the label?</span>
    <span class="keyword">public var</span> clipOffscreen = <span class="keyword">true
    public var</span> clipStyle: <span class="type">ClipBounds</span> = .<span class="dotAccess">upperViewController</span>

    <span class="comment">// Select the entire button instead of the label inside a UIButton</span>
    <span class="keyword">public var</span> expandToButton = <span class="keyword">false</span>

    <span class="comment">// Add simulator border</span>
    <span class="keyword">public var</span> addDeviceBezels = <span class="keyword">true

    public var</span> previewPosition: <span class="type">DivPosition</span> = .<span class="dotAccess">center</span>

    <span class="comment">// Add borders around translatable texts</span>
    <span class="keyword">public var</span> addLabelBorders = <span class="keyword">false
    public var</span> labelBorderColor = <span class="string">"#0a3679"</span>

    <span class="comment">// Include the Apple system font (San Francisco) for use in Windows</span>
    <span class="keyword">public var</span> includeAppleWebFonts = <span class="keyword">true</span></code></pre>

<br/>


## Rigi commandline tools

The Rigi SDK comes shipped with several commandline tools to streamline the process of exporting and importing string files and uploading or downloading them from the Rigi server.

This section describes how to setup the Rigi commandline tools for your project. 

### Install Bartycrouch (optional)

Optionally you can use the tool [BartyCrouch](https://github.com/Flinesoft/BartyCrouch) to extract your localised texts from Storyboards and Swift code and incrementally update all string files in the project.

See: https://github.com/Flinesoft/BartyCrouch

##### Bartycrouch installation:

<pre class="splash"><code><span class="bash">bash</span>
brew install bartycrouch</code></pre>

#### Bartycrouch initialisation:

<pre class="splash"><code><span class="bash">bash</span>
bartycrouch <span class="keyword">init</span></code></pre>

#### Update string files:

<pre class="splash"><code><span class="bash">bash</span>
bartycrouch update</code></pre>

<br/>

### Setup the Rigi commandline tools

To setup the Rigi commandline tools you need to create a ***rigi.ini*** file in your project root folder. A template for the ini file is availlable in the Rigi Pods folder. You can copy the template to your project folder as follows:

<pre class="splash"><code><span class="bash">bash</span>
cd [<span class="type">PROJECT_FOLDER</span>]
mkdir <span class="type">Rigi</span>
cp <span class="type">Pods</span>/<span class="type">Rigi</span>/docs/rigi.<span class="property">ini</span> <span class="type">Rigi</span></code></pre>

The ***rigi.ini*** file has several settings that can be customised. The ***PROJECT_NAME*** is required and should exactly match the project name on the Rigi server. 

For most projects the other settings can be left default, however, they can customised set if needed.

<pre class="splash"><code><span class="bash">bash</span>
edit <span class="type">Rigi</span>/rigi.<span class="property">ini</span>

# --------------------
# <span class="type">Babylon SDK</span> settings
# --------------------

# <span class="type">Rigi</span> project name:
# - <span class="type">Should</span> match the project name on the <span class="type">Rigi</span> server

<span class="type">PROJECT_NAME</span>=<span class="string">"RIGI-PROJECT"</span>

# <span class="type">Folder</span> <span class="keyword">where</span> downloaded string files will be saved:
# - <span class="type">If</span> empty the <span class="keyword">default</span> download folder will be used

#DOWNLOAD_FOLDER=~/<span class="type">Downloads</span>

# <span class="type">Simulator</span> documents folder:
# - <span class="type">If</span> empty the last used simulator rigi folder will be used

#SIMULATOR_DOCUMENTS=~/<span class="type">Library</span>/<span class="type">Developer</span>/<span class="type">CoreSimulator</span>/<span class="type">Devices</span>/<span class="type">B6D3A06C</span>-8B50-43D8-<span class="type">B3EE</span>-7469EF7312B7/data/<span class="type">Containers</span>/<span class="type">Data</span>/<span class="type">Application</span>/<span class="type">BFDE44A9</span>-<span class="type">AF81</span>-4B29-<span class="number">8685</span>-<span class="type">BD728F1CEBE3</span>/<span class="type">Documents</span>

# <span class="type">Xcode</span> project folder:
# - <span class="type">If</span> empty the <span class="type">Rigi</span> sdk will <span class="keyword">try</span> to find the project folder.

#XCODE_PROJECT=~/<span class="type">Projects</span>/<span class="type">Xcode</span>/<span class="type">MY</span>-<span class="type">PROJECT</span></code></pre>

<br/>

## Setup the Rigi server

### Setup a new project on the Rigi server

1. Create a new Rigi project. 
2. Select your base Xcode language as the ***Source language***. In this example we use EN. 
3. Select the the ***pseudo language*** that you added to the Xcode project. In this example we use Zulu.
4. Add the  In this example we use Zulu.. In this example we use Dutch.
5. Add a ***translation task*** for the target language.
6. Add ***translators*** to the translation task.

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-setup-1.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-setup-2.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/add-language-2.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/add-translation-2.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/select-translator-2.png)

<br/>

## Add Rigi tokens

To make translatable previews we need to add **Rigi tokens** to the **psuedo language files**. The following section describes how to export your language files, import them into the Rigi server and add Rigi codes.

### Zip all localisation files from Xcode project

Use the following command to find and **zip all string files** in the Xcode project to prepare for uploading to the Rigi server.

<pre class="splash"><code><span class="bash">bash</span>
cd [<span class="type">PROJECT_FOLDER</span>]
<span class="type">Pods</span>/<span class="type">Rigi</span>/bin/strings-collect.<span class="property">sh</span></code></pre>
<br/>

### Upload the string files to the Rigi server

Use the following command to open a finder window with the zipped string files that can be uploaded to the Rigi server.

<pre class="splash"><code><span class="bash">bash</span>
 cd [<span class="type">PROJECT_FOLDER</span>]
 <span class="type">Pods</span>/<span class="type">Rigi</span>/bin/strings-open.<span class="property">sh</span></code></pre>
From this folder the zipped string files can be uploaded to the Rigi server (using drag-and-drop)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-import-2.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-import-4.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-import-5.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-import-6.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-import-7.png)

The Rigi tokens will have been added to the Pseudo language. The updated language files should now be downloaded and installed in the Xcode project.

<br/>

### Download the (pseudo) string files from the Rigi server

Next we can export the marked strings files (pseudo language) and import them in the Xcode project.

Export the string files from the server by clicking 'Download files'. You should select the **pseudo language**. Optionally you can also export any other langauge.

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/server-download.png)

After dowloading use following command to install the string files into the Xcode project. This command will look for downloaded zip files in the default **Downloads** folder. This can be changed in the **rigi.ini** settings file. 

<pre class="splash"><code><span class="bash">bash</span>
cd [<span class="type">PROJECT_FOLDER</span>]
<span class="type">Pods</span>/<span class="type">Rigi</span>/bin/strings-extract.<span class="property">sh</span></code></pre>
<br/>

## Make previews

With the Rigi tokens in place you can start to make previews of the translatable texts in the simulator and load the these previews to the Rigi server. This section describes how to do this. 

### Make previews in the Simulator (manual)

Run the Target or Scheme that runs the project in pseudo language. In this example we use the **RigiExample Pseudo** scheme which automatically runs the app in the **psuedo language (Zulu)** and activates the Rigi SDK on startup.

Navigate through the app and capture previews of all screens that contain translatable texts.

<img src="https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/capture-1.png" width="300">

The previews will be saved into the Simulator data folder.

<br/>

### Collect the previews to upload

You can use the following command to **open the previews in the Simulator folder**. 

This command will try to find the latest saved Rigi preview in any Xcode Simulator folder. When this is not working for your project you can specify a specific Xcode Simulator folder in the **rigi.ini** settings file. 

<pre class="splash"><code><span class="bash">bash</span>
cd [<span class="type">PROJECT_FOLDER</span>]
<span class="type">Pods</span>/<span class="type">Rigi</span>/bin/previews-peek.<span class="property">sh</span></code></pre>

<img src="https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/preview-peek.png" width="700">

When all previews are complete use the following command to **zip the previews** found in the Simulator folder.

<pre class="splash"><code><span class="bash">bash</span>
cd [<span class="type">PROJECT_FOLDER</span>]
<span class="type">Pods</span>/<span class="type">Rigi</span>/bin/previews-collect.<span class="property">sh</span></code></pre>
<br/>

### Upload the previews to the Rigi server

Use the following command to open a finder window with the **zipped previews** that can be uploaded.

<pre class="splash"><code><span class="bash">bash</span>
cd [<span class="type">PROJECT_FOLDER</span>]
<span class="type">Pods</span>/<span class="type">Rigi</span>/bin/previews-open.<span class="property">sh</span></code></pre>
<img src="https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/preview-open.png" width="700">


The previews can now be uploaded to the Rigi server. 

Select the latest zipped previews, then use select and drop them into the previews uploader.

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/upload-previews.png)



## Translate with previews

With the previews uploaded to the Rigi server the translator can start translating the texts with context. This section describes the process.

### Translate with preview context

1. On the Rigi server select and open translation task. 
2. Select the text to translate. When a preview is available it will be shown next to the text. Changes to the text will be reflected in the preview. Note: this is just a preview. The updated text might be rendered differently on your device when imported in Xcode.

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/select-translator-0.png)

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/translate-3.png)


## Import translations

After the texts have been translated on the Rigi server they can be imported into the Xcode project. This follows the same procedure as installing the Rigi tokens, described a few sections before.

### Download the translated string files from the Rigi server

Export the translated strings files and import them in the Xcode project.

Export the string files from the server by clicking 'Download files'. You should at leased select the **target language**. Optionlally you can also export the **pseudo language** and install it into Xcode. This is required after new texts have been added to the project.

![](https://raw.githubusercontent.com/HenkBoxma/rigi-ios/main/Docs/Assets/download-translated.png)

After dowloading the string files from the server use following command to install the files into the Xcode project. This command will look for downloaded zip files in the default **Downloads** folder. This can be changed in the **rigi.ini** settings file. 

<pre class="splash"><code><span class="bash">bash</span>
cd [<span class="type">PROJECT_FOLDER</span>]
<span class="type">Pods</span>/<span class="type">Rigi</span>/bin/strings-extract.<span class="property">sh</span></code></pre>
<br/>


## License

Copyright (c) 2022 Rigi.io

<br />









