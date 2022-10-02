# :sunny: WeatherApp

A **weather app** made with flutter using [openweathermap.org](https://openweathermap.org/) api .

### :department_store: Description

<div align="center">
  <img src="./screenshots/main_page.png#gh-dark-mode-only" width="25%" style="padding-right:10px">
  <img src="./screenshots/light_main_page.png#gh-light-mode-only" width="25%" >
</div>

This is a weather app made using [flutter](https://flutter.dev/) and [openweathermap.org](https://openweathermap.org/) api, with many features like `dark-mode`, `favorite city`,`weekly data` and `current location weather data`.

:computer:**Important packages** used in this app

- _Location tracking and current location_
  These packages help with the current location

  ```yml
  geocoding: ^2.0.1
  geolocator: ^9.0.2
  ```

    <details><summary>Location tracking script</summary>

  This simple dart script allow to fetch the current location

  ```dart
  Future<Position> getPos() async {
  bool _enabled;
  LocationPermission permission;
  _enabled = await Geolocator.isLocationServiceEnabled();
  if (!_enabled) {
      logger.shout("Permissions are disabled")
      return Future.error('Location permission are disabled');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      logger.shout("User denied permission")
      return Future.error('Permission are
      denied');
      }
  }
  if (permission == LocationPermission.deniedForever) {
      logger.shout("permanently denied permission")
      return Future.error('permission are denied forever');
  }
  return await Geolocator.getCurrentPosition();
  }
  ```

    </details>

- _State Management_
  For state management we have used [bloc](https://pub.dev/packages/bloc), which help to separates our business logic from our UI.

:heartbeat: **Feature**

- We have a **weather details** page where we provide a graphical and card based views for weather related information.

<div align="center">
  <img src="./screenshots/weekly_data.png#gh-dark-mode-only" width="25%">
  <img src="./screenshots/light_weekly_data.png#gh-light-mode-only" width="25%">
</div>

- A location can be made :heart: **favorite** which are saved in `shared-preferences` as favorites. Those _locations_ weather is shown as small cards in the second tab.
<div align="center">
  <img src="./screenshots/favourites.png#gh-dark-mode-only" width="25%" style="padding-right:10px">
  <img src="./screenshots/light_favourites.png#gh-light-mode-only" width="25%">
</div>

- **Search** a weather app is not dynamic if there is no search functionality, you can search for a city if it's a valid `city` according to [openweathermap.org](https://openweathermap.org/).

<div align="center">
 <img src="./screenshots/search_location.png#gh-dark-mode-only" width="22%">
  <img src="./screenshots/location search.png#gh-dark-mode-only" width="22%">
  <img src="./screenshots/light_search_location.png#gh-light-mode-only" width="22%">
  <img src="./screenshots/light_location_search.png#gh-light-mode-only" width="22%">
</div>

- :dark_sunglasses: Dark **Theme** ,who loves light theme right, there is a theme-switcher which switch theme from `light-mode` to `dark-mode` and vice-versa.

- Over many timezones there is :clock10: `24:00` format thus there is also a switch for that named **24:00 clock format**
<div align="center">
  <img src="./screenshots/settings_page.png#gh-dark-mode-only" width="25%">
  <img src="./screenshots/light_settings.png#gh-light-mode-only" width="25%">
</div>

### 🏖️ Assets

The `assets` are provided in the `assets` directory which mainly contain the app icon ,and `api` folder contains files related to api responses and `icon` folder contains all the images for :cloud: `weather icons` :rainbow:.

### :running: Run the App

To run the app. Primary need an you need to have a `API KEY` from [openweathermap.org](https://openweathermap.org/).

> To get one log into openweathermap.org and create an API_KEY

Then,

- :cyclone: Clone this repo.

  ```bash
  git clone https://github.com/tuuhin/weather_app
  cd weather_app
  ```

- Create an `.env` file in the `$root` project

  ```bash
  touch .env
  ```

- Add the api key to your .env file
  ```sh
  API_KEY=YOUR_API_KEY
  ```
- :+1: You are now all done with the extra configuration, to run the app
  ```bash
  flutter pub get
  flutter run
  ```

### :end: Conclusion

This **Weather app** was one of my first flutter project and after the results, it fill all of my requirements :smiley:.
