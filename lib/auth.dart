import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:layisi/screens/login.dart';

class Auth extends StatefulWidget {


  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
          style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all(Colors.white),
      ),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, Login.id);


                },
                child: Row(
                  children: const [
                    Icon(Icons.email_outlined,color: Colors.black,),
                    SizedBox(height: 10,),
                    Text('Continue with Email',style: TextStyle(color: Colors.black),),
                  ],

                ),
            ),
          ),

          const SizedBox(height: 10,),

          SignInButton(
            Buttons.Google,
               text: ('Continue with Google'),
               onPressed:(){},
          ),
          const SizedBox(height: 10,),
          SignInButton(
            Buttons.Facebook,
            text: ('Continue with Facebook'),
            onPressed:(){},
          ),
          // const Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Text('OR',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          // ),
          // const Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Text('Login with Email',
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //     decoration: TextDecoration.underline),),
          // ),
        ],
      ),
    );
  }
}
