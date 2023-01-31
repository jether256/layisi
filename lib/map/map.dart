import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layisi/screenslogged/main_sc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../pref/pref.dart';
import '../provider/locationPro.dart';

class Mapma extends StatefulWidget {
  static const  String id='map';

  @override
  _MapmaState createState() => _MapmaState();
}

class _MapmaState extends State<Mapma> {

  late LatLng currentLocation;
  late GoogleMapController _googleMapController;

  bool _locating = false;

  String? userID, name, email, num, pass, pic, lon, lat, ad, city, country,
      status,  log, create;

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



  @override
  void initState() {
    getPref();
    super.initState();
  }


  Future<void> upDateAd(Map<String, dynamic> map, BuildContext context) async {

    EasyLoading.show(status: 'Saving Location...');

    var response = await http.post(
        Uri.parse('https://layisikla.000webhostapp.com/api/updatelo.php'),
        body: map);
    var result = json.decode(response.body);

    if (response.statusCode == 200) {



      if (result=="Success"){

        EasyLoading.showSuccess('Location saved...');
         Navigator.pushReplacementNamed(context, MainScreenLogged.id);
      }




    } else {
      EasyLoading.showError('Location Failed. to save.');
    }
  }




  @override
  Widget build(BuildContext context) {

    final locationData=Provider.of<LocationProvider>(context);

    setState(() {
      currentLocation=LatLng(locationData.latitude,locationData.longitude);
    });

    void onCreated(GoogleMapController mapController){
      setState(() {
        _googleMapController=mapController;
      });
    }

    return Scaffold(
      body: SafeArea(

        child: Stack(

          children: [


            Expanded(
              child: GoogleMap(
                initialCameraPosition:CameraPosition(
                  target:currentLocation,
                  zoom: 14.4746,
                ),
                zoomControlsEnabled: false,
                minMaxZoomPreference: const MinMaxZoomPreference(
                  1.5,20.8,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                onCameraMove:(CameraPosition position){

                  setState(() {
                    _locating=true;
                  });
                  locationData.onCameraMove(position);
                },
                onMapCreated: onCreated,
                onCameraIdle:() {
                  setState(() {
                    _locating=false;
                  });
                  locationData.getMoveCamer();
                },
              ),
            ),


            Center(
              child: Container(
                height: 50,
                margin:const EdgeInsets.only(bottom: 40),
                child: Image.asset('assets/images/marker.png'),
              ),
            ),

            const Center(
              child: SpinKitPulse(
                color: Colors.lightBlue,
                size: 100.0,
              ),
            ),

            Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      _locating ? LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ):Container(),

                  TextButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.location_searching,color: Theme.of(context).primaryColor,),
                      label:Text(_locating ? 'Locating....' :locationData.selectedAdress.featureName,overflow:TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Text(locationData.selectedAdress.addressLine),
                  ),

                      const SizedBox(height: 25,),


                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width-40,//40 is padding from both sides
                          child: AbsorbPointer(
                            absorbing: _locating ? true:false,
                            child: MaterialButton(
                              child: const Text('Save Location',style: TextStyle(color: Colors.white),),
                              color: _locating ? Colors.grey:Colors.lightBlue,
                                onPressed:(){

                                locationData.saveLoc();

                                  upDateAd({
                                    'id':'$userID',
                                    'address':'${locationData.selectedAdress.addressLine}',
                                    'lon':'${locationData.longitude}',
                                    'lat':'${locationData.latitude}',


                                  },context);


                                },
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
