# CryptoWallet

A Flutter Application to keep track of manage your crypto finances.

[<img src="screenshots/coinlayer.png" width="200" height="200"/>](https://coinlayer.com/)
<br>

CryptoWallet uses **Coinlayer** API for fetching latest cryptocoin prices.

## Getting Started

You can directly install the apk file from [releases](https://github.com/MrUnfunny/crypto-wallet/releases).

## App Screens

<p><img src="screenshots/main_screen.png" width="270" height="540" alt="history_screen"/>
<img src="screenshots/sign_up.png" width="270" height="540" alt="favorites"/>
<p><img src="screenshots/sign_in.png" width="270" height="540" alt="home_screen_without_history"/>
<img src="screenshots/home_screen.png" width="270" height="540" alt="home_screen_with_history"/></p>
<img src="screenshots/expense_overview.png" width="270" height="540" alt="settings"/>
</p>

#### Building from source

If you do not have the Flutter SDK installed, follow the instructions from the
Flutter site [here](https://flutter.dev/docs/get-started/install).

To build from source clone the repository:

```
git clone https://github.com/MrUnfunny/crypto-wallet.git
```

Get the dependencies by running this command inside the project directory:

```
flutter packages get
```

Then either run this command to run the app in device:

```
flutter run
```

Or build the apk using this command:

```
flutter build apk
```

#### 🔌 Plugins

| Name                                                                | Usage                            |
| ------------------------------------------------------------------- | -------------------------------- |
| [**flutter_bloc**](https://pub.dev/packages/flutter_bloc)           | State Management                 |
| [**http**](https://pub.dev/packages/http)                           | To handle api calls              |
| [**firebase_auth**](https://pub.dev/packages/firebase_auth)         | For firebase authentication      |
| [**cloud_firestore**](https://pub.dev/packages/cloud_firestore)     | For Firestore                    |
| [**fl_chart**](https://pub.dev/packages/fl_chart)                   | To show line charts              |
| [**equatable**](https://pub.dev/packages/equatable)                 | To simplify equality comparisons |
| [**crypto_font_icons**](https://pub.dev/packages/crypto_font_icons) | To show cryptocoin logo as icons |

### App Overview

This app mainly keeps track of all crypto incomes and expenses. User can add incomes and expenses in five different cryptocurrencies(Bitcoin, Ethereum, Tether, DogeCoin and Ripple).

In HomeScreen, all expenses are visualized in a line chart and crypto specific expenses are shown in line chart in expenses screen. On starting app, it checks whether user is logged in or not and based on it, it shows home screen or main screen showing options to either sign in or sign up with a new account.

**NOTE:** All crypto incomes and expenses are converted to USD by fetching latest price to provide better overview.

### App Structure

The app is structured as follows:

```
/bloc
  /auth
  /firestore
  ... and more
/config
/constant
/models
/presentation
  /common
  /screens
/repository
/utils
```

**bloc** contains the state management layer used for communication between UI and repository. `auth` contains bloc related to authentication such as signin, signup and signout. `firestore` contains bloc related to handling firesore and api calls.

**config** contains common configuration used across the application.

**constant** contains routing information and common constant values such as strings.

**presentation** contains all the UI related code. `common` contains common UI widgets used across multiple screens. `screens` contains code for all different screens.

**repository** contains code for interacting with external servers and other tasks. It contains networking and other third party interactions.
