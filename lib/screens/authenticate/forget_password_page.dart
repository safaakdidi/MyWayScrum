import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:googleads/Layout/header_widget.dart';
import 'package:googleads/Layout/theme_helper.dart';
import 'package:googleads/screens/authenticate/sign_in.dart';
import 'package:hexcolor/hexcolor.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController=TextEditingController();
  bool isSending=false;
_sendRequest() async{


  setState(() {
    isSending=true;
  });
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0x80FF72),
      content: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.email_outlined,
          color: Colors.white,
          size: 30.0,),

          Text(" Check your email ...",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
          ),
          ),
        ],
      ),
      duration: Duration(milliseconds: 3000),
    ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => SignIn()),
    );

  } on FirebaseAuthException catch (error) {
    var message='';
    switch (error.code) {
      case 'invalid-email':
        message='Your email address is not valid.';
        break;

      case 'user-not-found':
        message='User not found.';
        break;

      default:
        message="Something went wrong!";
    }
    showDialog(context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Text(
          'Sending failed',
        ),
        content: Text(message),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text(
            'OK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          )

          )
        ],

      );
    });
  }finally{
    isSending = false;
  }



}
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true, Icons.password_rounded),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Forgot Password?',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text('Enter the email address associated with your account.',
                              style: TextStyle(
                                // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text('We will email you a verification code to check your authenticity.',
                              style: TextStyle(
                                color: Colors.black38,
                                // fontSize: 20,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: ThemeHelper().textInputDecoration("Email", "Enter your email"),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Email can't be empty";
                                  }
                                  else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 40.0),
                            if(isSending)
                              Container(
                                child: CircularProgressIndicator(

                                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor.withOpacity(0.4)),
                                ),

                              ),
                            if(!isSending)
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: RaisedButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      _sendRequest();

                                    }
                                  },
                                  shape: ThemeHelper().Shape(),
                                  padding: EdgeInsets.all(0.0),
                                  child:ThemeHelper().inkStyle(context,"Send") ,
                                ),
                              ),

                            SizedBox(height: 30.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Remember your password? "),
                                  TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignIn()),
                                        );
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}