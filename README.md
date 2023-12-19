# weight_tracker

A Flutter Weight Tracker app

## Assumptions
This app only supports Android and iOS platforms.

Firebase Auth email/password is the only authentication method that will be available in this app.

Only display data for the current logged in user.

The user should not have to log in every time they open the app, only sign user out if the click the sign out button.

Because we are using anonymous auth, once a user logs out their data cannot be retrieved.

Weights are stored and displayed in pounds (instead of kgs)

Valid weight is a number between 0 and 600

## Set Up Instructions

Add google-services.json file to /android/app/ directory

Add GoogleService-Info.plist file to /ios/Runner/ directory

Enter command 'flutter pub get' in the terminal

Open iOS simulator or Android Emulator

Enter 'flutter run' in the terminal 


# screen recordings
https://drive.google.com/drive/folders/1iZZ4mhVg1xKOd6HmwI5ljHFFAaJ5MfhB?usp=drive_link