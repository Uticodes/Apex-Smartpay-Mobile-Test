# Smartpay_Mobile_App

Mobile Developer Screening Test app, designed to evaluate skills and creativity in mobile app
development. This project involves converting a pixel-perfect design of the onboarding and
authentication flow, utilizing a variety of tools and technologies to create a seamless user
experience.

## Getting Started

These instructions will give you heads up on how to get started, architecture flow, implementations using in this project.

### Architecture.

I decide to adopt ```Clean Architecture``` for the development because it allow decoupling different units of your code in an organized manner. That way the code gets easier to understand, modify and test. Read more about this [here](https://dev.to/george_andronchik/clean-architecture-of-flutter-application-part-2-practice-3562)


## The project consist of some basic implementations and patterns which includes:

* MVVM architectural approaches for the Presentation layer
* Network operations with [Dio](https://pub.dev/packages/dio)

* [json_serializable](https://pub.dev/packages/json_serializable) for JSON serialization and deserialization .
* [get_it](https://pub.dev/packages/get_it) For simple Service Locator
* [bloc](https://pub.dev/packages/bloc) A predictable state management library that helps implement the BLoC (Business Logic Component) design pattern.
* [flutter_bloc](https://pub.dev/packages/flutter_bloc) Widgets that make it easy to integrate blocs and cubits into Flutter.
* [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) Flutter Secure Storage provides API to store data in secure storage. Keychain is used in iOS, KeyStore based solution is used in Android


## Documentation & Comments
I use docs blocks to write description, documentation and comment for classes and methods. This should clearly describe it functionality and logic executions. 
I also use simple and understandable naming practice.


### Installing & Setup

* Clone this project from Github to your machine
* Import project to Android Studio using the latest version (Android Studio Iguana and above)
* Run `dart run build_runner build --delete-conflicting-outputs` to build all annotations on the app
* To install the app on your device, you can get the apk from this link: build/app/outputs/flutter-apk/app-release.apk


## To-do
1. Writing Unit Tests
2. Writing Widget Tests


### Domain Layer
1. Create Model classes for the feature if needed.
2. Add the use case to the neccessary repository interface.

### Network(Data) Layer
1. Add remote and cache operations to the `Cache` and `Repository` interface.
2. Add the cache or remote interface implementation to its correct data source classes.
3. Use `DioClientWrapper` to handle client request and error handling 

### Presentation layer
- Add your UI Implementation as specified in the design
- Use Cubit and States to interact with the other layers of the application.

## Application :camera_flash: Screenshots / GIFs


### To get started with flutter:
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

