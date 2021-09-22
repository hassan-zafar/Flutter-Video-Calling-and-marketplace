import 'package:get_storage/get_storage.dart';

class UserLocalData {
  String s = 'sd';
  final getStorageProference = GetStorage();

  // Future init() async => _preferences = await SharedPreferences.getInstance();

  // Future<bool> logOut() => _preferences.clear();

  Future logOut() => getStorageProference.erase();
  final _userModelString = 'USERMODELSTRING';
  final _uidKey = 'UIDKEY';
  final _isLoggedIn = "ISLOGGEDIN";
  final _emailKey = 'EMAILKEY';
  final _userNameKey = 'USERNAMEKEY';
  // final _phoneNumberKey = 'PhoneNumber';
  // final _imageUrlKey = 'IMAGEURLKEY';
  // final _password = 'PASSWORD';
  final _isAdmin = 'ISADMIN';
  final _token = 'TOKEN';
  final _branches = 'BRANCHES';
  final _classes = 'CLASSES';

  //
  // Setters
  //

  Future setUserModel(String userModel) async =>
      getStorageProference.write(_userModelString, userModel);
  Future setUserEmail(String? email) async =>
      getStorageProference.write(_emailKey, email);
  Future setUserName(String? userName) async =>
      getStorageProference.write(_userNameKey, userName);
  Future setToken(String token) async =>
      getStorageProference.write(_token, token);

  Future setBranches(String branches) async =>
      getStorageProference.write(_branches, branches);
  Future setClasses(String classes) async =>
      getStorageProference.write(_classes, classes);

  Future setIsAdmin(bool? isAdmin) async =>
      getStorageProference.write(_isAdmin, isAdmin);

  Future setUserUID(String? uid) async =>
      getStorageProference.write(_uidKey, uid);

  Future setNotLoggedIn() async =>
      getStorageProference.write(_isLoggedIn, false);

  Future setLoggedIn(bool isLoggedIn) async =>
      getStorageProference.write(_isLoggedIn, isLoggedIn);

  //
  // Getters
  //
  bool? getIsAdmin() => getStorageProference.read(_isAdmin);
  String getUserData() => getStorageProference.read(_userModelString) ?? '';
  String getBranches() => getStorageProference.read(_branches) ?? "";
  String getClasses() => getStorageProference.read(_classes) ?? "";

  String getUserUIDGet() => getStorageProference.read(_uidKey) ?? '';
  bool? isLoggedIn() => getStorageProference.read(_uidKey);
  String getUserEmail() => getStorageProference.read(_emailKey) ?? '';
  String getUserName() => getStorageProference.read(_userNameKey) ?? '';
}
