<p align="center">
   <a href="url"><img src="https://github.com/pamelahdrz/IsleOfDogs/assets/139024919/a34feb99-e4de-44d7-8b1e-d73d6c695efa" height="auto" width="200"></a>
  <h1 align="center">Isle of Dogs</h1>
</p>

![](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![](https://img.shields.io/badge/Xcode-15.0+-blue.svg)
![](https://img.shields.io/badge/-Swift-red.svg)

Isle of Dogs - an app displaying asynchronous saved dogs in a RESTful Service. After displaying, the data is saved to the device; then the next time, the user opens the app, the data displayed is the one that has been saved. Used database - Core Data. Used - Async Await.

<p align="center">
   <a href="url"><img src="https://github.com/pamelahdrz/IsleOfDogs/assets/139024919/48872698-da4d-4c0c-a77a-7d9acf646f23" height="auto" width="200"></a>
</p>

## Challenges
Error handling was a challenge, due to connection and external issues with the service. Also managing when to call the saved data and the endpoint, so when the endpoint response is successful, when the data is been saved. Saved data is only displayed on the second launch of the app.

## Architecture
- MVVM
- Design Pattern: Singleton

## Dependencies
- [Firebase](https://github.com/firebase/firebase-ios-sdk)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Snapkit](https://github.com/SnapKit/SnapKit)

