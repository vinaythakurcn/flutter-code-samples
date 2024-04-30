import 'custom_extensions.dart';

class Validations {
  static Validations? _instance;

  static Validations get mInstance => _instance ??= Validations();

  bool isFieldEmpty(String? field) {
    return field.isNullOrEmpty();
  }

  bool isInvalidEmail(String field) {
    final emailRegExp =
    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    return !emailRegExp.hasMatch(field);
  }

  bool isInvalidPhone(String field) {
    return field.length < 10;
  }

  bool isInvalidPassword(String field) {
    return field.length < 5;
  }

  bool passwordDoesNotMatch(String field1, String field2) {
    return field1 != field2;
  }

  bool isOtpIncomplete(String otp1, String otp2, String otp3, String otp4) {
    return otp1.isEmpty || otp2.isEmpty || otp3.isEmpty || otp4.isEmpty;
  }
}
