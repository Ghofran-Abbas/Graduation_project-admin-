import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../fcm_config.dart';
import '../../features/login/data/models/login_secretary_model.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class SharedPreferencesHelper {
  static const _jwtTokenKey = 'jwt_token';
  static const _userRoleKey = 'role_const';
  static const _userIdKey = 'id_const';

  static const _fcmTokenKey = 'fcm_token';

  static Future<void> saveFcmToken(String fcmToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, fcmToken);
  }

  static Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  static Future<void> saveJwtToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtTokenKey, token);
  }

  static Future<String?> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtTokenKey);
  }

  static Future<void> clearJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_jwtTokenKey);
  }
  static Future<void> clearFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
  }



  static Future<bool> isLoggedIn() async {
    final token = await getJwtToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  static Future<void> clearUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRoleKey);
  }

  static Future<void> saveUserID(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, id);
  }

  static Future<int?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);  // Corrected key
  }

  static Future<void> clearUserID() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);  // Corrected key
  }

  static Future<void> saveLoginModel(LoginSecretaryModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(model.toJson());
    await prefs.setString('login_model', jsonString);
  }

  static Future<LoginSecretaryModel?> getLoginModel() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('login_model');

    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return LoginSecretaryModel.fromJson(jsonMap);
    }

    return null;
  }

  static Future<void> clearLoginModel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_model');
  }

  //batool
  // ✅ جديد: دالة موحّدة للحصول على FCM token مع دعم الويب (vapidKey)
  static Future<String?> getOrRequestFcmToken() async {
    // 1) جرّب المخزّن أولاً
    final cached = await getFcmToken();
    if (cached != null && cached.isNotEmpty) return cached;

    final messaging = FirebaseMessaging.instance;

    // 2) تأكد من الإذن (لو لم يُمنح سابقًا)
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return null;
    }

    // 3) جلب التوكن (مع vapidKey لو على الويب)
    String? token;
    try {
      if (kIsWeb) {
        token = await messaging.getToken(vapidKey: FcmConfig.vapidKey);
      } else {
        token = await messaging.getToken();
      }
    } catch (_) {
      token = null;
    }

    // 4) خزّنه في SharedPreferences وأعده
    if (token != null && token.isNotEmpty) {
      await saveFcmToken(token);
    }
    return token;
  }




}
