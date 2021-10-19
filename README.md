# My flutter app
## My 1st flutter app and fetch data from open api
-------------------------
Fetch Sample country list from https://restcountries.com/v3.1/all
and Show all country list into a list view
-------------------------
## Overall app flow:
![Alt text](/resources/app_diagram.png?raw=true "App flow")
## App widget tree
![Alt text](/resources/app_wdiget_tree.png?raw=true "App widget tree")
## Library used:
| Lib name          | Description                           | URL                                       |
| ------------------| ----------------------------------    | ----------------------------------        |
| http              | Network lib                           | https://pub.dev/packages/http             |
| json_serializable | Create code for JSON serialization    | https://pub.dev/packages/json_serializable|
| json_annotation   |                                       | https://pub.dev/packages/json_annotation  |
| flutter_svg       | To load and display SVG files         | https://pub.dev/packages/flutter_svg      |
| hive, hive_flutter| Hive is a no-sql DB, we can store data as key value.  | https://pub.dev/packages/hive      |
| hive_generator    | To generate TypeAdapter for hive      | https://pub.dev/packages/hive_generator   |
| path_provider     | To load commonly used locations on the filesystem | https://pub.dev/packages/path_provider    |
| fluttertoast      | To display toast messages             | https://pub.dev/packages/fluttertoast      |
| provider          | To manage app state management        | https://pub.dev/packages/provider |
| logging           | Log message with data and time prefix | https://pub.dev/packages/logging  |
| sprintf           | To use for string interpolation or format | https://pub.dev/packages/sprintf |
| build_runner      | To generate code according to configuration   | https://pub.dev/packages/build_runner  |
### Customized font use:
 - Roboto Condensed https://fonts.google.com/specimen/Roboto+Condensed
## Some flutter command:
- One time generate code using this command: [https://flutter.dev/docs/development/data-and-backend/json#code-generation]
> flutter pub run build_runner build
-To create fullter app:
> flutter pub outdated
- Create Sample app:
> flutter create flutter_complete_guide
- Run app
> flutter run