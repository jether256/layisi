import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:location/location.dart';

import 'home_screen.dart';
import 'login_screen.dart';



class MainScreen extends StatefulWidget {



  static const  String id='main-screen';

  late final LocationData locationData;



  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  late   Widget _currentScreen=  HomeScreen();

   //this is thr first screen when u open app
  final PageStorageBucket _bucket=PageStorageBucket();
  late  int _index=0;
  @override
  Widget build(BuildContext context) {
    Color color=Theme.of(context).primaryColor;
    return Scaffold(
      //resizeToAvoidBottomInset: true,

      body: PageStorage(
        child:_currentScreen ,
        bucket: _bucket ,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: (){


          Navigator.pushReplacementNamed(context, LoginScreen.id);

          //add products
        },
        elevation: 4,
        child:  const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape:  const CircularNotchedRectangle(),
        notchMargin: 0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //left side of floating button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 MaterialButton(
                   minWidth: 40,
                     onPressed:(){




                       setState(() {
                         _index=0;
                         _currentScreen= HomeScreen();
                       });

                     },
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(_index==0 ? Icons.home: Icons.home_outlined),
                       Text('Home',style: TextStyle(color: _index ==0 ? color:Colors.deepOrangeAccent.shade700,
                       fontWeight: _index==0 ? FontWeight.bold :FontWeight.normal,
                       fontSize: 12),),
                     ],
                   ),
                 ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed:(){

                      setState(() {
                        _index=1;
                        _currentScreen=const LoginScreen();
                      });

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==1 ? CupertinoIcons.chat_bubble_fill: CupertinoIcons.chat_bubble),
                        Text('Chats',style: TextStyle(color: _index ==1 ? color:Colors.deepOrangeAccent.shade700,
                            fontWeight: _index==1 ? FontWeight.bold :FontWeight.normal,
                        fontSize: 12),),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed:(){


                      setState(() {
                        _index=2;
                        _currentScreen=const LoginScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==2 ? CupertinoIcons.heart_fill: CupertinoIcons.heart),
                        Text('My Ads',style: TextStyle(color: _index ==2 ? color:Colors.deepOrangeAccent.shade700,
                            fontWeight: _index==2 ? FontWeight.bold :FontWeight.normal,
                            fontSize: 12),),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed:(){


                      setState(() {
                        _index=3;
                        _currentScreen=const LoginScreen();
                      });

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==3 ? CupertinoIcons.person_fill: CupertinoIcons.person),
                        Text('My Account',style: TextStyle(color: _index ==3 ? color:Colors.deepOrangeAccent.shade700,
                            fontWeight: _index==3 ? FontWeight.bold :FontWeight.normal,
                            fontSize: 12),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
