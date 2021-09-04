// https://dart.academy/creational-design-patterns-for-dart-and-flutter-singleton/
class AppMessages {
  static const appName = 'Fetch Data Example';
  static const emptyMessage = 'No data found! Try Again?';
  static const errorMessage = 'Cannot load data now! Try Again?';
  static const updateSuccessMessage = 'Update data successfully';
  static const updateErrorMessage = 'Unable to Update data!!!';
  static const favErrorMessage = 'Your favorite list is empty!';

  static const labelLanguages = 'Languages: %s';

  static const labelCallingCodes = 'Calling Codes: %s';

  static const labelGrid = "Grid View";
  static const labelList = "List View";

  static AppMessages? _instance;

  AppMessages._internal() {
    _instance = this;
  }

  factory AppMessages() => _instance ?? AppMessages._internal();
}
