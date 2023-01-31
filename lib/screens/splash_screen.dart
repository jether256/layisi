import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/screenslogged/main_sc.dart';
import 'package:layisi/shared/sharedpref.dart';

import 'home_screen.dart';
import 'location.dart';
import 'login_screen.dart';
import 'mainscreen.adrt.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  static const  String id='splash';
  //const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {




  @override
  void initState() {

     Timer( const Duration(seconds: 3,),(){

       //navigationPage();
       getPref1();

     });

     super.initState();
  }

  // void navigationPage() {
  //
  //
  //   Future loginstatus = SharedPreference().getLoggedIn();
  //
  //   loginstatus.then((data) {
  //
  //     if (data == true) {
  //
  //
  //
  //       Navigator.pushReplacementNamed(context, LocationL .id);
  //       //Navigator.pushReplacementNamed(context, MainScreenLogged .id);
  //
  //
  //     } else {
  //
  //       Navigator.pushReplacementNamed(context, MainScreen.id);
  //
  //
  //
  //
  //     }
  //   });
  // }
  //



  String? ID1;

  getPref1() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      ID1=sharedPreferences.getString(PrefInfo.ID);

      ID1== null ? sessionLogout():sessionLogin();

    });
  }


  sessionLogout() {
    Navigator.pushReplacementNamed(context,MainScreen.id);
  }

  sessionLogin() {
    Navigator.pushReplacementNamed(context,MainScreenLogged.id);

  }



  @override
  Widget build(BuildContext context) {
    const colorizeColors=[
      Colors.white,
      Colors.grey,
    ];

    const colorizeTextStyle=TextStyle(
      fontSize: 50.0,
      fontFamily: 'Gothic',
    );

    return Scaffold(
      backgroundColor:Colors.deepOrange.shade900,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
                'assets/images/logo.png',
              color: Colors.white,
              height: 200,
            ),
            const SizedBox(height: 10,),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Buy or Sell',
                  textStyle:colorizeTextStyle,
                  colors:colorizeColors,
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }
}
