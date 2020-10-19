import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:firebase_core/firebase_core.dart';

import 'customBottom.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      home: Authentication()
  ));
}

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  FirebaseUser _user;
  String _error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Auth UI Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getMessage(),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: RaisedButton(
                  //child: Text(_user != null ? 'Logout' : 'Login with EMAIL'),
                  child: Text('login with email'),
                  onPressed: _onActionTapped,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: RaisedButton(
                  //child: Text(_user != null ? 'Logout' : 'Login with PHONE'),
                  child: Text('login with phone'),
                  onPressed: _onActionTappedPhone,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
              child: RaisedButton(
                child: Text('login with Facebook'),
                onPressed: _onActionTappedPhone,
              ),
              ),

              _getErrorText(),
              _user != null
                  ? /*FlatButton(
                child: Text('Delete'),
                textColor: Colors.red,
                onPressed: () => _deleteUser(),
              )*/
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()))
            : Container()
            ],
          ),
        ),
      );
  }

  Widget _getMessage() {
    if (_user != null) {
      return Text(
        'Logged in user is: ${_user.displayName ?? ''}',
        style: TextStyle(
          fontSize: 16,
        ),
      );
    } else {
      return Text(
        'Tap the below button to Login',
        style: TextStyle(
          fontSize: 16,
        ),
      );
    }
  }

  Widget _getErrorText() {
    if (_error?.isNotEmpty == true) {
      return Text(
        _error,
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
        ),
      );
    } else {
      return Container();
    }
  }

 /* void _deleteUser() async {
    final result = await FirebaseAuthUi.instance().delete();
    if (result) {
      setState(() {
        _user = null;
      });
    }
  }*/

  void _onActionTapped() {
    if (_user == null) {
      //can be used for mail and phone

      // User is null, initiate auth
      FirebaseAuthUi.instance().launchAuth([
        AuthProvider.email(),
        //AuthProvider.phone()
      ]).then((firebaseUser) {
        setState(() {
          _error = "";
          _user = firebaseUser;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));

        });
      }).catchError((error) {
        if (error is PlatformException) {
          setState(() {
            if (error.code == FirebaseAuthUi.kUserCancelledError) {
              _error = "User cancelled login";
            } else {
              _error = error.message ?? "Unknown error!";
            }
          });
        }
      });
    } else {
     // _logout();

    }
  }

  /*void _logout() async {
    await FirebaseAuthUi.instance().logout();
    setState(() {
      _user = null;
    });
  }*/

  void _onActionTappedPhone() {
    if (_user == null) {
      //can be used for mail and phone

      // User is null, initiate auth
      FirebaseAuthUi.instance().launchAuth([
        //AuthProvider.email(),
        AuthProvider.phone(),
        AuthProvider.facebook()
      ]).then((firebaseUser) {
        setState(() {
          _error = "";
          _user = firebaseUser;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));

        });
      }).catchError((error) {
        if (error is PlatformException) {
          setState(() {
            if (error.code == FirebaseAuthUi.kUserCancelledError) {
              _error = "User cancelled login";
            } else {
              _error = error.message ?? "Unknown error!";
            }
          });
        }
      });
    } else {
      // _logout();

    }
  }
}