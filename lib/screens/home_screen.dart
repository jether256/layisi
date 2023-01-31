import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layisi/categories/category.dart';
import 'package:layisi/screens/notpro.dart';
import 'package:layisi/screens/product.dart';
import 'package:layisi/widgets/banner.dart';
import 'package:layisi/widgets/customapp.dart';

import 'package:location/location.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:new_version/new_version.dart';


class HomeScreen extends StatefulWidget {


  //static const  String id='home-screen';

  // static const  String id='home-screen';
  //
  // late final LocationData locationData;
  //
  // HomeScreen( this.locationData);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//   String address='uganda';
//
//   bool _loading=false;
//
//   Future<String?>getAddress() async{
// // From coordinates
//     final coordinates = Coordinates(1.10, 45.50);
//     var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     var  first = addresses.first;
//     setState(() {
//       address=first.addressLine!;
//     });
//
//     return first.addressLine;
//
//   }


  @override
  void initState(){
    super.initState();
    _checkVersion();


  }


  void _checkVersion () async{

    final newVersion=NewVersion(
      androidId:"com.snapchat.android",
      iOSId: 'com.google.Vespa',
    );

    final status= await newVersion.getVersionStatus();
    newVersion.showUpdateDialog(
      context: context,
      versionStatus:status!,
      dialogTitle: 'Update!!!!',
      dismissButtonText: 'Skip',
      dialogText: 'Please update the app from${status.localVersion}to${status.storeVersion}',
      dismissAction: (){
        SystemNavigator.pop();
      },
      updateButtonText: 'Lets update',
    );

    print("DEVICE:${status.localVersion}");
    print("STORE:${status.storeVersion}");

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child:SafeArea(
          child:Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              elevation: 5,
              title: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: const [
                      Icon(CupertinoIcons.location_solid,
                        color: Colors.white, size: 18,),
                      Text(
                        'Uganda', style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,),
                    ],

                  ),
                ),
              ),
            ),
          ),
        ),
        ),




      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12,0,12,8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12,0,12,0),
                  child: Row(
                  children:  [
                   Expanded(
                     child: SizedBox(
                       height: 40,
                       child: TextField(
                          decoration: InputDecoration(
                            prefixIcon:const Icon(Icons.search),
                            labelText:'Find mobile phones,computers,cars,land,jobs',
                            labelStyle:  const TextStyle(fontSize: 12),
                            contentPadding:  const EdgeInsets.only(left: 10,right: 10),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),

                              ),
                            ),
                          ),
                     ),
                      ),
                    const SizedBox(height: 10,),
                    const Icon(Icons.notifications_none),
                    const SizedBox(height: 10,),
                  ],
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ClipRRect(
              //     borderRadius:BorderRadius.circular(4),
              //     child: Container(
              //       height: 170,
              //       color: Colors.red,
              //       child: ToPick(),
              //     ),
              //   ),
              // ),


              Padding(
                padding:  const EdgeInsets.fromLTRB(12,8,12,0),
                child: Column(
                  children:  const [
                       Bann(),
                    Category(),
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              const ProNot(),

            ],
          ),
        ),
      ),
    );
  }
}
