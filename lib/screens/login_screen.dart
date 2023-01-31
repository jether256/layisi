import 'package:flutter/material.dart';

import '../auth.dart';

class LoginScreen extends StatefulWidget {
  static const  String id='login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade900,
      appBar:AppBar(
        backgroundColor: Colors.deepOrange.shade900,
        title: const Text('Please Continue',style: TextStyle(
          fontSize: 20,color: Colors.white,
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Flexible(
          //     child:Container(
          //       width:MediaQuery.of(context).size.width,
          //       color:Colors.white,
          //         child:Column(
          //           children: [
          //             const SizedBox(
          //               height:50 ,
          //             ),
          //             Image.asset(
          //               'assets/images/logo.png',
          //               color: Colors.deepOrange.shade900,
          //               height: 150,
          //
          //             ),
          //             const SizedBox(
          //               height:5 ,
          //             ),
          //             Text('Buy or Sell',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //
          //               fontSize: 30,
          //               color: Colors.deepOrangeAccent.shade700
          //             ),),
          //           ],
          //
          //       ),
          //     ),
          // ),
          Flexible(
            child:Container(
              child: Auth(),

            ),
          ),
          const Text('if you continue,you are accepting \n Terms and Conditions and Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                ),),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
