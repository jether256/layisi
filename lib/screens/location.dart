

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:layisi/screenslogged/main_sc.dart';
import 'package:layisi/shared/sharedpref.dart';



import 'package:location/location.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';


class LocationL extends StatefulWidget {

  static const  String id='location';

  // final bool locationChanging;
  //
  // LocationL({ required this.locationChanging});

  @override
  _LocationLState createState() => _LocationLState();
}



class _LocationLState extends State<LocationL> {
    String id1 = "";
   String name1 ="";
   String email1="";
   String number1="";
   String password1="";
   String pic1 ="";
   String loco1 ="";
   String address1="" ;
   String city1="";
   String country1="";
   String status1="";



  String ? countryValue = "";
  String ? stateValue = "";
  String ? cityValue = "";
  String ? address = "";

  bool _loading=true;

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  late String _address;
  late String manualAddress;
  late String point;
  late String latitude;
  late String longitude;
    final _scaffoldKey = GlobalKey<ScaffoldState>();





    Future<LocationData?> getLocation() async {//we get current location deatails here

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }


    
      _locationData = await location.getLocation();

    final coordinates = Coordinates(_locationData.latitude,_locationData.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var  first = addresses.first;

    setState(() {
      _address=first.addressLine!;
      countryValue=first.countryName!;
      stateValue=first.adminArea!;
      cityValue=first.subLocality!;


    });
    
    //print(_locationData);



        return _locationData;
  }




    Future  <void> upDateAd(Map<String, dynamic> map, BuildContext context) async {

      var response=await http.post(Uri.parse('https://layisikla.000webhostapp.com/api/updatelo.php'),body: map);
      var result = json.decode(response.body);

      if(response.statusCode==200){


        if(result=="Success") {

          Navigator.pushNamed(context, MainScreenLogged.id);

          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => MainScreenLogged(locationData: _locationData),),);

        }else{

          const snackBar =
          SnackBar(content: Text("location didnt update,Try again 😑"));
          _scaffoldKey.currentState!.showSnackBar(snackBar);

        }

      }else{


      }

      //result is a list of maps, which contains $db_data that was echoed
      print(result); //print the first row of the column 'col1'

    }





 Future  <void> updateUser(Map<String, dynamic> map, BuildContext context) async{


    var response=await http.post(Uri.parse('https://layisikla.000webhostapp.com/api/update.php'),body: map);
    var result = json.decode(response.body);

    if(response.statusCode==200){


      if(result=="Success") {

        Navigator.pushNamed(context, MainScreenLogged.id);


        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => MainScreenLogged(locationData: _locationData),),);
      }else{

        const snackBar =
        SnackBar(content: Text("location didnt update,Try again 😑"));
        _scaffoldKey.currentState!.showSnackBar(snackBar);

      }

    }else{


    }

    //result is a list of maps, which contains $db_data that was echoed
    print(result); //print the first row of the column 'col1'

  }


  void londa() {

      showAdu().then((value){
        if (value == "0") {
          setState(() {
            _loading=false;

          });

        }else{
          setState(() {
            _loading=true;
          });
          Navigator.pushReplacementNamed(context, MainScreenLogged.id);
          //Navigator.pushNamed(context,MainScreenLogged.id);

        }

      });
      
      
      
    }

    List adu = [];
    Future showAdu() async {
      var response = await http.post(
          Uri.parse("https://layisikla.000webhostapp.com/api/ad.php"),
          headers: {"Accept": "headers/json"},body:{'id':'$id1'});
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        setState(() {
          adu = jsonData;
        });
        print(jsonData);
        return jsonData;
      }
    }


    @override
  void initState() {

    super.initState();

    showAdu();

    Future id = SharedPreference().getUserId();
    id.then((data) async {
      id1 = data;
      print(id1);
    });

    Future name= SharedPreference().getUserName();
    name.then((data) async {
      name1= data;
      print(name1);
    });


    Future email = SharedPreference().getUserEmail();
    email.then((data) async {
      email1 = data;
      print(email1);
    });

    Future num= SharedPreference().getUserNumber();
    num.then((data) async {
      number1= data;
      print(number1);
    });


    Future pass = SharedPreference().getUserPass();
    pass.then((data) async {
      password1 = data;
      print(password1);
    });

    Future image= SharedPreference().getUserPic();
    image.then((data) async {
      pic1= data;
      print(pic1);
    });

    // Future loco= SharedPreference().getUserLoc();
    // loco.then((data) async {
    //   loco1= data;
    //   print(loco1);
    // });

    Future ad = SharedPreference().getUserAdd();
    ad.then((data) async {
      address1 = data;
      print(address1);
    });

    Future cit= SharedPreference().getUserCity();
    cit.then((data) async {
      city1= data;
      print(city1);
    });


    Future count = SharedPreference().getUserCountry();
    count.then((data) async {
      country1 = data;
      print(country1);
    });

    Future tatus= SharedPreference().getUserCity();
    tatus.then((data) async {
      status1= data;
      print(status1);
    });

    // next();
  }


    // void next() {
    //
    //
    //   Future locationstatus = SharedPreference().getUserAdd();
    //
    //   locationstatus.then((data) {
    //
    //     if (data == "0") {
    //
    //       setState(() {
    //         _loading=false;
    //       });
    //
    //
    //
    //     } else {
    //
    //       setState(() {
    //         _loading=true;
    //       });
    //
    //
    //       Navigator.push(context, MaterialPageRoute(
    //         builder: (context) => MainScreenLogged(locationData: _locationData),),);
    //
    //
    //     }
    //   });
    // }


  @override
  Widget build(BuildContext context) {


        londa();

  
  




    ProgressDialog pd = ProgressDialog(
      context: context,
    );



    showBottomScreen(context){

      getLocation().then((location){

      if(location != null){

          //only after fetch location only bottom screen will open
        pd.close();
        showModalBottomSheet(
            isScrollControlled: true,
            enableDrag: true,
           
            context:context,
            builder: (context){

              return Column(

                children: [

                  const SizedBox(
                    height: 26,
                  ),
                  AppBar(
                    automaticallyImplyLeading: false,
                    iconTheme: const IconThemeData(
                      color:Colors.white,
                    ),
                    elevation: 1,
                    backgroundColor: Colors.deepOrangeAccent,
                    title: Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon:const Icon(Icons.clear),
                        ),
                        const SizedBox(height: 20,),
                        const Text('Location',style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Search city ,area or neighbourhood',
                            hintStyle: TextStyle(color: Colors.grey),
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: (){

                      //save address
                      pd.show(max: 100, msg: 'Fetching Location...');
                      getLocation().then((value){

                        if(value !=null){


                          upDateAd({
                            'id':'$id1',
                          'address':_address,
                          },context);
                          pd.close();
                        }

                      });

                    },
                    horizontalTitleGap: 0.0,
                    leading: const Icon(Icons.my_location,color: Colors.deepOrangeAccent,),
                    title: const Text('Use current location',style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold),
                    ),
                    subtitle:  Text(
                      location ==  null ? 'Fetching location':_address,style: const TextStyle(fontSize: 12),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade300,
                    child:const Padding(
                      padding: EdgeInsets.only(left: 10,bottom: 4,top: 4),
                      child: Text('Choose City',style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  //we will use packadge to select country state and city



                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: CSCPicker(
                      layout: Layout.vertical,
                      dropdownDecoration: const BoxDecoration(shape: BoxShape.rectangle,),
                      defaultCountry: DefaultCountry.Uganda,
                      showCities: true,
                      showStates: true,
                      flagState: CountryFlag.DISABLE,
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged:(value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged:(value) {
                        setState(() {
                          cityValue = value;
                          manualAddress=' $cityValue , $stateValue,$countryValue';
                        });
                        //send address to  database

                        if(value !=null){
                          updateUser({


                            'id':'$id1',
                            'address':manualAddress,
                            'state':stateValue,
                            'city':cityValue,
                            'country':countryValue,
                          },context);
                        }




                        //print(_address);
                      },
                    ),
                  ),

                ],
              );

            });





      }else{
          pd.close();
      }

    });

  }




    return Scaffold(
        backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body:Column(
               children: [
          Image.asset('assets/images/location.png',height: 200,),
          const SizedBox(height: 20,),
          const Text('Where do you want \n to buy/sell products',
          textAlign:TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrangeAccent,
            fontSize: 25,
          ),),
          const SizedBox(height: 10,),
          const Text('To enjoy all what we offer you \n we need to know where to look for them.',
            textAlign:TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrangeAccent,
              fontSize: 12,
            ),),
          const SizedBox(height: 30,),

       _loading ? Column(
         children: const [
           CircularProgressIndicator(),
           SizedBox(height: 0.8,),
           Text('Finding Location.....'),
         ],
       ) :Column(
           children: [

             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
               child: Row(
                 children: [
                   Expanded(
                     child:_loading ? Center(child: CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                     )) :ElevatedButton.icon(
                         style: ButtonStyle(
                           backgroundColor:MaterialStateProperty.all<Color>(
                               Theme.of(context).primaryColor),
                         ),
                         onPressed: ()  async {


                           //
                           // setState(() {
                           //   _loading=true;
                           // });

                           // SharedPreference().setLoggedIn(false);
                           // Navigator.pushReplacement(context,
                           //     MaterialPageRoute(builder: (BuildContext ctx) =>  const MainScreen()) );

                           pd.show(max: 100, msg: 'Fetching Location...');
                           getLocation().then((value){

                             if(value !=null){


                               upDateAd({
                                 'id':'$id1',
                                 'address':_address,
                               },context);
                               pd.close();
                             }

                           });


                         },
                         icon: const Icon(CupertinoIcons.location_fill),
                         label:const Padding(
                           padding: EdgeInsets.only(top: 15,bottom: 15),
                           child: Text('Around me'),
                         )
                     ),

                   ),

                 ],

               ),
             ),
             InkWell(
               onTap: ()
               {
                 pd.show(max: 100, msg: 'Fetching Location...');
                 showBottomScreen(context);
               }
               ,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   decoration: const BoxDecoration(
                       border: Border(bottom: BorderSide(width: 2),)
                   ),
                   child: const Text('Set location manually',
                     style: TextStyle(
                       color: Colors.deepOrangeAccent,
                       fontSize: 20,
                     ),),
                 ),
               ),
             ),


           ],
         ),



        ],
      ),

    );
  }




}
