import 'package:task_2/pages/Info_page.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../model/login_model.dart';
import '../ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),

                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),

                        SizedBox(height: 10),

                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => loginRequestModel.domainName  = input,
                          decoration: new InputDecoration(
                            hintText: "Account",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.airplay,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                      
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => loginRequestModel.userName = input,
                          decoration: new InputDecoration(
                            hintText: "Username",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.verified_user,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        
                        new TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              loginRequestModel.password = input,
                          validator: (input) => input.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),

                        new CheckboxListTile(
                          title: Text('Remember me'),
                          tristate: true,
                          value: loginRequestModel.rememberMe,
                          onChanged: (value) {setState(() {
                            loginRequestModel.rememberMe = !loginRequestModel.rememberMe;
                        });}),

                        // ignore: deprecated_member_use
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () {
                            if (validateAndSave()) {
                              print(loginRequestModel.toRawJson());

                              setState(() {
                                isApiCallProcess = true;
                              });

                              APIService apiService = new APIService();
                              apiService.login(loginRequestModel).then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  }
                                  );
                                  
                                  if (value.statusCode == 200) {
                                    final snackBar = SnackBar(
                                        content: Text("Login Successful"));
                                    // ignore: deprecated_member_use
                                    scaffoldKey.currentState.showSnackBar(snackBar);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage()));
                                    
                                  } else{
                                    final snackBar =
                                        SnackBar(content: Text('$responseMessage code: $statcode', style: TextStyle(fontSize: 18),));
                                    // ignore: deprecated_member_use
                                    scaffoldKey.currentState.showSnackBar(snackBar);
                                  }
                                }

                              });
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                        
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}