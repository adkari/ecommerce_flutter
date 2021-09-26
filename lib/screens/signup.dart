import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/screens/login.dart';
import 'package:practice/widgets/custom_btn.dart';
import 'package:practice/widgets/custom_input.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(error),
          content: Container(
            child: Text("You've got an error"),
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmail,
        password: _registerPassword,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerFormLoading = false;

  String _registerEmail = '';
  String _registerPassword = '';

  FocusNode _passwordFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text('Create New Account', style: Constants.boldHeading),
          ),
          Column(
            children: [
              CustomInput(
                hintText: 'Email',
                onChanged: (value) {
                  _registerEmail = value;
                },
                onSubmitted: (value) {
                  _passwordFocusNode.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInput(
                hintText: 'Password',
                ispassword: true,
                onChanged: (value) {
                  _registerPassword = value;
                },
                onSubmitted: (value) {
                  _submitForm();
                },
                focusNode: _passwordFocusNode,
              ),
              CustomBtn(
                text: 'Create Account',
                onPressed: () {
                  _submitForm();
                },
                isloading: _registerFormLoading,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_sharp),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Back to Login',
                      style: Constants.regularDarkText,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
