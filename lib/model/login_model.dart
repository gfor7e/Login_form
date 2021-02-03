import 'dart:convert';

class LoginResponseModel {
  final int statusCode;
  final Body body;

  LoginResponseModel({this.statusCode, this.body});

  factory LoginResponseModel.fromRawJson(String str) => LoginResponseModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        statusCode: json["statusCode"],
        body: Body.fromJson(json["body"]),
    );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "body": body.toJson(),
    };
}

class Body {
    Body({
        this.code,
        this.name,
        this.message,
    });

    final String code;
    final String name;
    final String message;

    factory Body.fromRawJson(String str) => Body.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        code: json["code"],
        name: json["name"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "message": message,
    };
}

class LoginRequestModel {
  String domainName;
  String userName;
  String password;
  bool rememberMe;

  LoginRequestModel({
    this.domainName,
    this.userName,
    this.password,
    this.rememberMe = false
  });
  
  String toRawJson() => json.encode(toJson());

    Map<String, String> toJson() => {
        "domainName": domainName,
        "userName": userName,
        "password": password,
        "rememberMe": rememberMe.toString(),
    };
}

