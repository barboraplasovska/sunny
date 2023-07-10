# Sunny ☀️

Sunny is a simple weather application. By default, it asks the user permission
for their current location to show the Weather at their current position. The user can
add other places and delete them as they likes.
Features include hourly temperature for the next 24 hours, daily highest and
lowest temperatures for the next 10 days, as well as feel like temperature,
humidity, wind direction and speed and visibility.

## Description
Time spent: 10 hours

### Libraries
I used the following libraries.
| Library                  | Why I used it                                         |
|-----------------------------|-----------------------------------------------------|
| flutter_dotenv    | To load the API_KEY from .env file        |
| http          | To make http request to the API.                  |
| intl          | To format dates.       |
| page_view_dot_indicator  | To show a page indicator.                 |
| shared_preferences   | To store the cities that the user added in the local storage of his device.   |
| geolocator         | To get user's current location.                   |

## Getting started

### API
I used the [WeatherApi](https://www.weatherapi.com/) that has a free tier that allows
me to make 1 Million calls per month and access 3 days of forecast. During the trial
period that lasts 2 weeks, everyone has access to the Pro+ tier which gives 14 days
of forecast. The app displays 10 days of forecast, so you need the Pro+ tier.

For obvious reasons, the API KEY is hidden in a .env file at the root of the project,
so to use this application create this file. You can find the .env.example file at
the root.

```
$ cp .env.example .env
```

And then add your API key.

### Building Sunny

To get started with Sunny, follow these steps:

1. Ensure you have **Flutter** installed on your machine. If you haven't, refer to the Flutter documentation for installation instructions: https://flutter.dev/docs/get-started/install

2. Clone this repository to your local machine.

3. Open a terminal or command prompt and navigate to the project directory.

4. Run the following command to fetch the project dependencies:
   ```bash
   flutter pub get
   ```

5. Connect a device (physical or virtual) to your machine.

6. Run the following command to launch Jaguar on the connected device:
   ```bash
   flutter run
   ```
