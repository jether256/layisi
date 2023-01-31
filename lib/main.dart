
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:layisi/provider/advertPro.dart';
import 'package:layisi/provider/auth.dart';
import 'package:layisi/provider/cartegorypro.dart';
import 'package:layisi/provider/chart.dart';
import 'package:layisi/provider/locationPro.dart';
import 'package:layisi/provider/rotation.dart';
import 'package:layisi/provider/subcatpro.dart';
import 'package:layisi/screens/location.dart';
import 'package:layisi/screens/login.dart';
import 'package:layisi/screens/login_screen.dart';
import 'package:layisi/screens/mainscreen.adrt.dart';
import 'package:layisi/screens/myads.dart';
import 'package:layisi/screens/register.dart';
import 'package:layisi/screens/splash_screen.dart';
import 'package:layisi/screens/terms.dart';
import 'package:layisi/screenslogged/home_screen_logged.dart';
import 'package:layisi/screenslogged/main_sc.dart';
import 'package:layisi/screenslogged/profileup.dart';
import 'package:layisi/screenslogged/user.dart';
import 'package:layisi/widgets/banner.dart';
import 'package:provider/provider.dart';

import 'map/map.dart';






Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(

    MultiProvider(
      providers: [


        ChangeNotifierProvider(
          create:(_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => LocationProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => CategoryProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => SubProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => AdvertsProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ChartRoomProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ImagesProvider(),
        ),


      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layisi',
      theme: ThemeData(
          backgroundColor: Colors.deepOrange.shade900,
          fontFamily: 'Gothic'
      ),
      builder:EasyLoading.init(),
      initialRoute: SplashScreen.id,// first route
      routes: {
        //we will add the screens here for easy navigation
        SplashScreen.id:(context)=>SplashScreen(),
        MainScreen.id:(context) => MainScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        Login.id:(context)=>Login(),
        Register.id:(context)=>Register(),
        LocationL.id:(context)=>LocationL(),
        Mapma.id:(context)=>Mapma(),
        MainScreenLogged.id:(context)=>MainScreenLogged(),
        HomeScreenLo.id:(context)=>HomeScreenLo(),
        Bann.id:(context)=>Bann(),
        //SellerCarForm.id:(context)=>SellerCarForm(),
        UserReviewScreen.id:(context)=>UserReviewScreen(),
        ProfileUpdateScreen.id:(context)=>ProfileUpdateScreen(),
        MyAdsScreen.id:(context)=>MyAdsScreen(),
        Terms.id:(context)=>Terms(),
      },
    );
  }
}

