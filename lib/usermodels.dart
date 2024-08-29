import 'package:shared_preferences/shared_preferences.dart';

class User {
  static late SharedPreferences _preferences;
  static String id = '';
  static String Sign_up_type = '';
  static String _username = '';
  static String _password = '';
  static String _Bio = 'Hey there am using Jasper AI';
  static bool CDP = false;
  static String _email = '';
  static String _token = '';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    id = _preferences.getString('id') ?? '';
    Sign_up_type = _preferences.getString('SignUpType') ?? '';
    _username = _preferences.getString('username') ?? '';
    _password = _preferences.getString('') ?? '';
    _Bio = _preferences.getString('Bio') ?? 'Hey there am using Jasper AI';
    CDP = _preferences.getBool('CDP') ?? false;
    _email = _preferences.getString('email') ?? '';
    _token = _preferences.getString('token') ?? '';
  }

  static Future SetID(String ID) async {
    await _preferences.setString('id', ID);
  }

  static Future SetToken(String token) async {
    await _preferences.setString('token', token);
  }

  static Future SetEmail(String DP) async {
    await _preferences.setString('id', DP);
  }

  static Future SetCDP(bool ss) async {
    await _preferences.setBool('CDP', ss);
  }

  static Future SignUpType(String sut) async {
    await _preferences.setString('id', sut);
  }

  static Future SetUsername(String name) async {
    await _preferences.setString('id', name);
  }

  static Future SetPassword(String password) async {
    await _preferences.setString('id', password);
  }

  static Future SetBio(String Bio) async {
    await _preferences.setString('id', Bio);
  }

  static getID() => id;
  static getSUT() => Sign_up_type;
  static getUsername() => _username;
  static getPassword() => _password;
  static getBio() => _Bio;
  static getCDP() => CDP;
  static getEmail() => _email;
  static getToken() => _token;
}
