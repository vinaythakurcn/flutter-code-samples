import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:well_being_app/models/well_being_app_focus.dart';
import 'package:well_being_app/models/http_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:well_being_app/models/user.dart';
import 'package:well_being_app/config.dart' as config;
import 'package:well_being_app/models/well_being_app_sleep.dart';

class Auth with ChangeNotifier {
  String? _id;
  User? _user;

  int _feedbackCounter = 1;
  bool feedbackPopupEnabled = true;

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json"
  };

  bool get isAuth {
    return userId.isNotEmpty;
  }

  String get userId {
    return _id ?? '';
  }

  User? get user {
    return _user;
  }

  int? get feedbackCount {
    return _feedbackCounter;
  }

  increaseFeedbackCount() {
    _feedbackCounter = _feedbackCounter == 6 ? 1 : _feedbackCounter + 1;
  }

  ///
  /// GET User detail
  Future<AppHttpResponse> getUser() async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.getUser(_id!));
      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 400) {
        return AppHttpResponse(status: false, message: response.body);
      } else {
        final responseData = json.decode(response.body);

        /// Setting User's data to global state
        _user = User.set(responseData);

        return AppHttpResponse(
            status: true, message: 'user record found', data: responseData);
      }
    } catch (e) {
      // logout();
      rethrow;
    }
  }

  ///
  /// SIGNUP User to the Application
  /// And stores User's ID in the Shared Preference
  Future<AppHttpResponse> signup(Map<String, dynamic> data) async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.register(_id!));
      final response =
          await http.put(uri, body: jsonEncode(data), headers: headers);

      if (response.statusCode >= 400) {
        return AppHttpResponse(status: false, message: response.body);
      } else {
        final responseData = json.decode(response.body);

        /// Saving User's ID to Persistant Storage
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({'id': responseData['id']});
        prefs.setString('userData', userData);

        /// Setting User's data to global state
        _user = User.set(responseData);

        notifyListeners();
        return AppHttpResponse(
            status: true, message: 'registration successful');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Update User's data in the Application
  Future<AppHttpResponse> updateProfile(Map<String, dynamic> data) async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.updateProfile(_id!));
      final response =
          await http.put(uri, body: jsonEncode(data), headers: headers);

      if (response.statusCode >= 400) {
        return AppHttpResponse(status: false, message: response.body);
      } else {
        final responseData = json.decode(response.body);

        /// Setting User's data to global state
        _user = User.set(responseData);

        notifyListeners();
        return AppHttpResponse(status: true, message: 'profile updated');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Update User's notification token in the Application
  Future<AppHttpResponse> updateNotification(Map<String, dynamic> data) async {
    try {
      final uri =
          Uri.http(config.env['baseURL'], config.updateNotification(_id!));
      final response =
          await http.put(uri, body: jsonEncode(data), headers: headers);

      if (response.statusCode >= 400) {
        return AppHttpResponse(status: false, message: response.body);
      } else {
        return AppHttpResponse(status: true, message: 'profile updated');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Update User's subscription status in the Application
  Future<AppHttpResponse> updateSubcription(bool status) async {
    try {
      final uri =
          Uri.http(config.env['baseURL'], config.updateSubcription(_id!));
      final response = await http.put(
        uri,
        body: jsonEncode({"isSubscribe": status}),
        headers: headers,
      );

      if (response.statusCode >= 400) {
        return AppHttpResponse(status: false, message: response.body);
      } else {
        return AppHttpResponse(status: true, message: 'profile updated');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Update User's Location status in the Application
  Future<AppHttpResponse> updateLocation(double lat, double lng) async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.updateLocation(_id!));
      final response = await http.put(
        uri,
        body: jsonEncode({"latitude": lat, "longitude": lng}),
        headers: headers,
      );

      if (response.statusCode >= 400) {
        return AppHttpResponse(status: false, message: response.body);
      } else {
        return AppHttpResponse(status: true, message: 'profile updated');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Login User
  /// And stores User's ID in the Shared Preference
  Future<AppHttpResponse> login(String email, String password) async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.login());
      final response = await http.post(
        uri,
        body: {'email': email, 'password': password},
      );

      if (response.statusCode >= 400) {
        return AppHttpResponse(status: false, message: response.body);
      } else {
        final responseData = json.decode(response.body);

        /// Saving User's ID to Persistant Storage
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({'id': responseData['id']});
        prefs.setString('userData', userData);

        /// Setting User's data to global state
        _user = User.set(responseData);

        notifyListeners();
        return AppHttpResponse(status: true, message: 'login successful');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Auto Login the user when open the app
  /// It's check for User's ID exists in the Shared Preference
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json.decode(prefs.getString('userData') ?? '');

    _id = extractedUserData['id'].toString();

    try {
      await getUser();
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// LOGOUT the User
  /// And Clears the Shared Preference
  Future<void> logout() async {
    _id = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  ///
  /// Add New User
  /// And stores new User's ID in the Shared Preference
  Future<void> addNewUser(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    try {
      final uri = Uri.http(config.env['baseURL'], config.addNewUser());
      final response =
          await http.post(uri, body: json.encode(data), headers: headers);
      final responseData = json.decode(response.body);

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'id': responseData['id']});
      prefs.setString('userData', userData);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Resends password recovery email to the given email address
  /// when user forgot there password
  Future<AppHttpResponse> forgotPassword(String email) async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.forgetPassword());
      final response = await http.post(uri, body: {'email': email});
      return AppHttpResponse(
          status: response.statusCode < 400, message: response.body);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Add new Feedback
  ///
  Future<AppHttpResponse> addFeedback(
      {required String feedbackMsg, required String isSmiled}) async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.addFeedback(_id!));
      Map<String, dynamic> body = {
        "feedbackMsg": feedbackMsg,
        "isSmiled": isSmiled
      };
      final response =
          await http.post(uri, body: json.encode(body), headers: headers);

      return AppHttpResponse(
          status: response.statusCode < 400, message: response.body);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// GET Check Postcode
  Future<bool> checkPostcode(String postcode) async {
    try {
      final uri =
          Uri.http(config.env['baseURL'], config.checkPostcode(postcode));
      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 400) {
        return false;
      } else {
        return response.body == 'null' ? false : true;
      }
    } catch (e) {
      return false;
    }
  }

  ///
  /// Delete Account
  ///
  Future<AppHttpResponse> deleteAccount() async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.deleteAccount(_id!));

      final response = await http.delete(uri, headers: headers);

      return AppHttpResponse(
          status: response.statusCode < 400, message: response.body);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Fetch WellBeing Sleep Audios
  ///
  Future<List<WellBeingSleepModel>> fetchWellBeingSleepAudios() async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.happiSleepAudios());

      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 400) {
        return [];
      } else {
        final responseData = json.decode(response.body);

        List<WellBeingSleepModel> audios = [];

        for (var el in List<Map<String, dynamic>>.from(responseData)) {
          audios.add(WellBeingSleepModel(
            audioName: el['audioName'] ?? '',
            audioPath: el['audioPath'] ?? '',
            recentlyShown: el['recentlyShown'],
          ));
        }

        // The featured one make the top index Start

        int indexValue = audios.indexWhere((element) =>
            element.recentlyShown != null && element.recentlyShown == true);

        WellBeingSleepModel recentlyShownTemp = audios.elementAt(indexValue);

        audios.removeAt(indexValue);
        audios.insert(0, recentlyShownTemp);
        // The featured one make the top index End

        return audios;
      }
    } catch (e) {
      return [];
    }
  }

  ///
  ///
  /// Fetch WellBeing Focus Audios
  Future<List<WellBeingFocusModel>> fetchWellBeingFocusAudios() async {
    try {
      final uri = Uri.http(config.env['baseURL'], config.happiFocusAudios());

      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 400) {
        return [];
      } else {
        final responseData = json.decode(response.body);

        List<WellBeingFocusModel> audios = [];

        for (var el in List<Map<String, dynamic>>.from(responseData)) {
          audios.add(WellBeingFocusModel(
            id: el['id'] ?? '',
            url: el['url'] ?? '',
            audioPath: el['audioPath'] ?? '',
            audioName: el['audioName'] ?? '',
            recentlyShown: el['recentlyShown'],
          ));
        }

        // The featured one make the top index Start

        int indexValue = audios.indexWhere((element) =>
            element.recentlyShown != null && element.recentlyShown == true);

        WellBeingFocusModel recentlyShownTemp = audios.elementAt(indexValue);

        audios.removeAt(indexValue);
        audios.insert(0, recentlyShownTemp);
        // The featured one make the top index End

        return audios;
      }
    } catch (e) {
      return [];
    }
  }
}
