import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:layisi/map/map.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/locationPro.dart';
import 'package:layisi/screens/location.dart';
import 'package:layisi/screens/mainscreen.adrt.dart';
import 'package:layisi/shared/sharedpref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomAppBar extends StatefulWidget {

  static const  String id='appbar';



  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  String _location='';
  String _address='';



  @override
  void initState() {
    super.initState();
    getPref();
    getLoc();

  }


  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,log,create;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      city = sharedPreferences.getString(PrefInfo.city);
      country = sharedPreferences.getString(PrefInfo.country);
      status = sharedPreferences.getString(PrefInfo.status);

      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
    });
  }

  String? loke;
  getLoc() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loke = sharedPreferences.getString(PrefInfo.ID);

    String? loco=sharedPreferences.getString('location');
    String? ade=sharedPreferences.getString('address');
    setState(() {
      _location=loco!;
      _address=ade!;
    });
  }


  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefInfo.ID);
    sharedPreferences.remove(PrefInfo.name);
    sharedPreferences.remove(PrefInfo.email);
    sharedPreferences.remove(PrefInfo.num);
    sharedPreferences.remove(PrefInfo.pass);
    sharedPreferences.remove(PrefInfo.pic);
    sharedPreferences.remove(PrefInfo.lon);
    sharedPreferences.remove(PrefInfo.lat);
    sharedPreferences.remove(PrefInfo.ad);
    sharedPreferences.remove(PrefInfo.city);
    sharedPreferences.remove(PrefInfo.country);
    sharedPreferences.remove(PrefInfo.status);

    sharedPreferences.remove(PrefInfo.log);
    sharedPreferences.remove(PrefInfo.create);


    Navigator.pushReplacementNamed(context,MainScreen.id);


  }



  @override
  Widget build(BuildContext context) {

    final locationData=Provider.of<LocationProvider>(context);

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppBar(
                  backgroundColor: Colors.deepOrangeAccent,
                  elevation: 5,
                  title:MaterialButton(
                    onPressed:()
                    {
                      locationData.getCurrentPosition();
                      if(locationData.permissionAllowed==true){


                        Navigator.pushReplacementNamed(context,  Mapma.id);
                      }else{
                        print('Permission not allowed');
                      }
                      // Navigator.pushReplacementNamed(context,  locationL.id);
                    },
                    child:Column(
                      mainAxisSize: MainAxisSize.min,

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Flexible(child: Text(_location==null ?'Address not set':_location,style: const TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis,),)),
                            const Icon(Icons.edit,color: Colors.white,size: 15,),

                          ],
                        ), Flexible(child: Text(_address== null ? 'Press to  set  Location':_address,overflow: TextOverflow.ellipsis,style: const TextStyle(color:Colors.white,fontSize: 12),)),
                      ],
                    ),
                  ),
                  actions: [

                    IconButton(
                      onPressed:(){

                        signOut();


                        // Navigator.pushReplacementNamed(context,LoginForm.id);
                      },
                      icon:const Icon(Icons.power_settings_new_outlined,color:Colors.white),
                    ),

                    IconButton(
                      onPressed:(){

                        //signOut();
                        // Navigator.pushReplacementNamed(context,LoginForm.id);
                      },
                      icon:const Icon(Icons.account_circle_outlined,color:Colors.white),
                    ),

                  ],

                ),
              ),
            );





  }
}