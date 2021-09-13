# Agora Movies App

A simple application that lets you discover movies. You can sort the movies by Highest Rated or Popularity. Also, you can check their detailed information like Rating, Plot Synopsis, Release Date etc.

Using Agora, we are sharing the feature of live sessions among fans. If you want to discuss about some new movie, or just wanna hangout with your favourite movie followers, just click on the call button and join the gossips ;)


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software

```
XCode 12.5.1
Agora Account
```


## Deployment

* You have to register for Agora account [here](https://console.agora.io), and can use this [Web Tool](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/) to check the video call feature, using same app id, temp token and channel name. Please make sure to update the "AgoraID.swift" file with those credentials. 
* If you have XCode 12 installed in your system, you are good to go.
* Run below command to install all pods -
```
pod install
```


## Where to look at for Agora code

```text
HeadyMovies/
├── Controllers/
|    └── AgoraVideoCallViewController.swift
└── Helpers/
     └── AgoraID.swift

```

## Built With

Third party framewoks and Library are managed using Cocoapods.

* [Agora](https://cocoapods.org/pods/AgoraRtcEngine_iOS) - iOS library for agora A/V communication, broadcasting and data channel service.
* [DropDown](https://github.com/AssistoLab/DropDown/) - A Material Design drop down for iOS
* [MBProgressHUD](https://cocoapods.org/pods/MBProgressHUD/) - Displays a translucent HUD with an indicator
* [Kingfisher](https://github.com/onevcat/Kingfisher/) - Used to downloading and caching images from server



## Author

**Rajdeep Sahoo**




