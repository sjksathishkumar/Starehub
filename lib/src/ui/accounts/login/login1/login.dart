import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../functions.dart';
import '../logo.dart';
import './../../../../models/app_state_model.dart';
import './../../../accounts/login/social/apple_login.dart';
import './../../../accounts/login/social/facebook_login.dart';
import './../../../accounts/login/social/google_login.dart';
import './../../../accounts/login/social/sms_login.dart';
import './../../../widgets/buttons/button.dart';
import '../../../color_override.dart';
import 'forgot_password.dart';
import 'phone_number.dart';
import 'register.dart';


class Login1 extends StatefulWidget {
  @override
  _Login1State createState() => _Login1State();
}

class _Login1State extends State<Login1> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final appStateModel = AppStateModel();
  bool _obscureText = true;
  bool isLoading = false;
  bool isSocialLoginLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
          builder: (context) =>
          Stack(
            children: [
              ListView(
                children: [
                  SizedBox(height: 16.0),
                  Container(
                    margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child:  Form(
                      key: _formKey,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Logo(),
                          SizedBox(
                            height: 16,),
                          PrimaryColorOverride(
                            child: TextFormField(
                              controller: usernameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return appStateModel.blocks.localeText.pleaseEnterUsername;
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: appStateModel.blocks.localeText.username),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 12,),
                          PrimaryColorOverride(
                            child: TextFormField(
                              obscureText: _obscureText,
                              controller: passwordController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return appStateModel.blocks.localeText.pleaseEnterPassword;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      }
                                  ),
                                  labelText: appStateModel.blocks.localeText.password),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          AccentButton(
                            onPressed: () => submit(context),
                            text: appStateModel.blocks.localeText.signIn,
                            showProgress: isLoading,
                          ),
                          SizedBox(height: 12.0),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => Material(child: ForgotPassword())));
                              },
                              child: Text(
                                  appStateModel.blocks.localeText.forgotPassword,
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 15,
                                      color: Colors.grey
                                  ))),
                          FlatButton(
                              padding: EdgeInsets.all(16.0),
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => Material(child: Register())));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      appStateModel.blocks.localeText
                                          .dontHaveAnAccount,
                                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                                          fontSize: 15,
                                          color: Colors.grey
                                      )),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                        appStateModel.blocks.localeText.signUp,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                            color:
                                            Theme.of(context).accentColor)),
                                  ),
                                ],
                              )),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                               /* Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50.0, // height of the button
                                    width: 50.0,
                                    child: Card(
                                      shape: StadiumBorder(),
                                      margin: EdgeInsets.all(0),
                                      color: Color(0xFFEA4335),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Center(
                                          child: IconButton(
                                            splashRadius: 25.0,
                                            splashColor: Colors.transparent,
                                            icon: Icon(
                                              FontAwesomeIcons.google,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              _googleAuthentication(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Card(
                                      shape: StadiumBorder(),
                                      margin: EdgeInsets.all(0),
                                      color: Color(0xFF3b5998),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: IconButton(
                                          splashRadius: 25.0,
                                          icon: Icon(
                                            FontAwesomeIcons.facebook,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            fbLogin(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),*/
                                Platform.isIOS ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Card(
                                      shape: StadiumBorder(),
                                      margin: EdgeInsets.all(0),
                                      color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFFFFFFF) : Color(0xFF000000),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: IconButton(
                                          splashRadius: 25.0,
                                          icon: Icon(
                                            FontAwesomeIcons.apple,
                                            size: 20,
                                            color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                                          ),
                                          onPressed: () {
                                            appleLogIn(context);
                                            //_showDialog(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ) : Container(),
                               /* Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Card(
                                      shape: StadiumBorder(),
                                      margin: EdgeInsets.all(0),
                                      color: Color(0xFF34B7F1),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: IconButton(
                                          splashRadius: 25.0,
                                          icon: Icon(
                                            FontAwesomeIcons.sms,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => Material(child: PhoneNumber())));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              if(isSocialLoginLoading)
              Center(
                child: Dialog(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    child: Wrap(
                      children: [
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new CircularProgressIndicator(),
                            SizedBox(
                              width: 24,
                            ),
                            new Text(appStateModel
                                .blocks.localeText.pleaseWait),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  submit(BuildContext context) async {
    var login = new Map<String, dynamic>();
    if (_formKey.currentState.validate()) {
      login["username"] = usernameController.text;
      login["password"] = passwordController.text;
      setState(() {
        isLoading = true;
      });
      bool status = await appStateModel.login(login, context);
      setState(() {
        isLoading = false;
      });
      if (status) {
        Navigator.of(context).pop();
      }
    }
  }

  //Google Login
  void _googleAuthentication(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    googleUser.authentication
        .then((value) => _loginGoogleUser(value.idToken, googleUser, context));
  }

  _loginGoogleUser(String idToken, GoogleSignInAccount googleUser,
      BuildContext context) async {
    var login = new Map<String, dynamic>();
    login["type"] = 'google';
    login["token"] = idToken;
    login["name"] = googleUser.displayName;
    login["email"] = googleUser.email;
    setState(() {
      isSocialLoginLoading = true;
    });
    bool status = await appStateModel.googleLogin(login, context);
    setState(() {
      isSocialLoginLoading = false;
    });
    if (status) {
      Navigator.of(context).pop();
    }
  }

  //Facebook Login
  fbLogin(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _sendTokenToServer(result.accessToken.token, context);
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        _showErrorOnUI(result.errorMessage);
        break;
    }
  }

  void _showCancelledMessage() {}

  void _showErrorOnUI(String errorMessage) {

  }

  Future _sendTokenToServer(token, BuildContext context) async {
    setState(() {
      isSocialLoginLoading = true;
    });
    bool status = await appStateModel.facebookLogin(token);
    setState(() {
      isSocialLoginLoading = false;
    });
    if (status) {
      Navigator.of(context).pop();
    }
  }

  //Apple Login
  appleLogIn(BuildContext context) async {

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId:
        'com.aboutyou.dart_packages.sign_in_with_apple.example',
        redirectUri: Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
    );

    if(credential.authorizationCode != null) {
      var login = new Map<String, dynamic>();
      login["userIdentifier"] = credential.userIdentifier;
      if(credential.authorizationCode != null)
        login["authorizationCode"] = credential.authorizationCode;
      if(credential.email != null) {
        login["email"] = credential.email;
      } else {
        //await _showDialog(context);
        //TODO If email and name is empty Request Email and Name
      }
      if(credential.userIdentifier != null)
        login["email"] = credential.userIdentifier;
      if(credential.givenName != null)
        login["name"] = credential.givenName;
      else login["name"] = '';
      login["useBundleId"] = Platform.isIOS || Platform.isMacOS ? 'true' : 'false';
      setState(() {
        isSocialLoginLoading = true;
      });
      bool status = await appStateModel.appleLogin(login);
      setState(() {
        isSocialLoginLoading = false;
      });
      if (status) {
        Navigator.of(context).pop();
      }
    }
  }

}
