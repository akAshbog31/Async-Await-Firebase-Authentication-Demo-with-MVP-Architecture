# Async-Await-Firebase-Authentication-Demo-with-MVP-Architecture
This repository contains a simple iOS app demonstrating how to implement Firebase Authentication using the new Swift async/await syntax, while following the Model-View-Presenter (MVP) architecture pattern. The app allows users to sign up and sign in using their email and password, powered by Firebase Authentication.

Features

Sign up: Users can create a new account using their email and password.
Sign in: Existing users can sign in to their account using their credentials.
Error Handling: The app provides informative error messages for various authentication errors.
Async/Await: Firebase authentication tasks are handled using Swift's async/await syntax, providing a more streamlined and readable codebase.
Model-View-Presenter (MVP) Architecture: The app follows the MVP design pattern, separating concerns for better code organization and testability.
User Property Wrapper for Data Storage: The app utilizes a custom user property wrapper for storing user-specific data securely in UserDefaults.
Requirements
Xcode 13 or later
Swift 5.5 or later
CocoaPods (for Firebase dependencies)

Setup

Clone the repository to your local machine.
Install Firebase dependencies using CocoaPods: pod install
Open the AsyncAwaitFirebaseAuthDemo.xcworkspace file in Xcode.
Add your Firebase project configuration to the app by following the instructions provided by Firebase.
Build and run the app on a simulator or a physical device.

MVP Architecture

The app follows the Model-View-Presenter (MVP) architecture pattern, which separates the app into three distinct components:
Model: Responsible for managing data and business logic.
View: Represents the UI elements and their layouts.
Presenter: Acts as the mediator between the Model and View, handling user interactions and updating the UI.
The MVP architecture allows for easier maintenance, testability, and scalability of the codebase.

User Property Wrapper

To securely store user-specific data, this app utilizes a custom user property wrapper. The user property wrapper abstracts away the complexities of working with UserDefaults, making it easy to save and retrieve data with a clean syntax. The data stored in UserDefaults is encrypted and automatically synchronized between the app and the user's iCloud account.

Usage

Launch the app on your iOS device or simulator.
Tap the "Sign Up" button to create a new account.
Enter your email and password in the respective fields and tap "Sign Up".
If the sign-up is successful, you will be taken to the main screen. Otherwise, an error message will be displayed.
To sign in, tap the "Sign In" button on the main screen.
Enter your email and password in the respective fields and tap "Sign In".
If the sign-in is successful, you will be taken to the main screen. Otherwise, an error message will be displayed.
Acknowledgments
The app uses Firebase Authentication to handle the sign-up and sign-in processes. Special thanks to Firebase for providing a robust and secure authentication solution.

Feel free to contribute to this project by submitting pull requests or reporting issues. Happy coding!

Contact

For any questions or feedback, please contact akashboghani111@gmail.com.
