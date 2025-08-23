import 'package:flutter/foundation.dart' show kIsWeb;

class FcmConfig {
  // استعمله في كل مكان بدل تكرار النص
  static const String vapidKey =
      'BMUIu0ik_OZJ9r9n3GPXib5fouwP02aKUqHBPJZFio406nmC_henlk7OtEco9fc5xd7Q3q_tZM0RuP6oBBPqTPc';

  static bool get isWeb => kIsWeb;
}
