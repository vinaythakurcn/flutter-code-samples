# Flutter Sample Code by Capital Numbers


### Description
This repository has the collection of the sample codes from various projects built in Flutter.


### Folder Structure

- controller - Getx controller classes from the appointment scheduling app
    - calendar - Getx controller that manages the business logic of the Calendar module
- models
    - Registration - Model definition of the Registration module of a saloon management app
    - Subscription - Model definition of the Subscription module of a saloon management app
- providers
    - auth.dart - The Auth provider class, belongs to a well being app, that manage all the authentication and user related task.
- screens - UI screens from the appointment scheduling app
    - calendar - Calendar Module
        - calendar_screen.dart 
        - job_details_screen.dart
- utils
    - custom_extensions.dart - It adds the more extension functions to the `num, String, Widget, Text, bool, object, MenuTimeType`
    - new_version.dart - It provides the information about the app's current version, and the most recent version available in the Apple App Store or Google Play Store as well as the option to update the app to the latest version.
    - validations.dart - It provide the validator function for the Form Field Validation.
- views
    - login - Login module of the saloon app
        - login_screen.dart - Represent/render the Login screen to the UI
        - login_bloc.dart - BLOC Class for the Login which manage all the business logic for the Login screen.
- widgets
    - app_ads.dart - A widget that displays the Google Banner Ads
- main.dart - Starting point of the app. It belongs to a saloon management app where the saloon owners can manage there clients and there details efficiently. Also they can share the clients with other saloon owners

