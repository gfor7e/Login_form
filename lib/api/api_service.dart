import 'package:http/http.dart' as http;
import '../model/login_model.dart';
import 'dart:async';

String domain;
String user;
String responseMessage;
int statcode;


class APIService {
  
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://dmjip36x1i.execute-api.us-east-1.amazonaws.com/dev/login";

    final response = await http.post(url, body: requestModel.toRawJson());
    LoginResponseModel responseMap = LoginResponseModel.fromRawJson(response.body.toString());

    domain = requestModel.domainName;
    user = requestModel.userName;
    statcode = responseMap.statusCode;

    if (statcode == 200) {
       return responseMap;
    }
      
    else{
      responseMessage = responseMap.body.message;
      return(responseMap);
    }
    
  }
}
