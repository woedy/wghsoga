class VerifyEmailModel {
  String? message;
  Data? data;
  Map<String, List<String>>? errors;

  VerifyEmailModel({this.message, this.data, this.errors});

  factory VerifyEmailModel.fromJson(Map<String, dynamic> json) {
    return VerifyEmailModel(
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      errors: json['errors'] != null ? _parseErrors(json['errors']) : null,
    );
  }

  static Map<String, List<String>> _parseErrors(
      Map<String, dynamic> errorData) {
    Map<String, List<String>> errors = {};
    errorData.forEach((key, value) {
      if (value is List) {
        errors[key] = List<String>.from(value);
      } else if (value is String) {
        errors[key] = [value];
      }
    });
    return errors;
  }
}

class Data {
  String? firstName;
  String? lastName;
  String? email;

  Data({
    this.firstName,
    this.lastName,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }
}
