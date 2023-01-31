import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:layisi/map/map.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/auth.dart';
import 'package:layisi/provider/locationPro.dart';
import 'package:layisi/screens/mainscreen.adrt.dart';
import 'package:layisi/screens/myads.dart';
import 'package:layisi/screenslogged/profileup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';
import 'ianative.dart';
import 'pacakages.dart';


class AccountLogged extends StatefulWidget {
  const AccountLogged({Key? key}) : super(key: key);

  @override
  _AccountLoggedState createState() => _AccountLoggedState();
}

class _AccountLoggedState extends State<AccountLogged> {


  String _location='';
  String _adress='';

  @override
  void initState() {
    getPref();
    getLoc();


    super.initState();
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

    Navigator.pushReplacementNamed(context, MainScreen.id);
  }


  String? loke;
  getLoc() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loke = sharedPreferences.getString(PrefInfo.ID);


    String? loco=sharedPreferences.getString('location');
    String? ade=sharedPreferences.getString('address');
    setState(() {
      _location=loco!;
      _adress=ade!;
    });
  }



  @override
  Widget build(BuildContext context) {

    final _userDetails=Provider.of<AuthProvider>(context);
    final locationData=Provider.of<LocationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(color: Colors.white,fontSize: 16),),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [


        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
            children:[

              Container(
                color: Colors.white,
                child:const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('My Account',style:TextStyle(fontWeight:FontWeight.bold)),
                ),

              ),

              Stack(
                children: [
                  Container(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children:  [
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.lightBlue,
                                child: Text('J',style:TextStyle(fontSize:50,color: Colors.white),),

                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              Container(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    const Text('Update your Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white),),

                                    const Text(' Email',style: TextStyle(fontSize: 14,color:Colors.white),),

                                    Text('$num',style: const TextStyle(fontSize: 14,color:Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          ListTile(
                            tileColor: Colors.white,
                            leading:const Icon(IconlyLight.location,color: Colors.redAccent,),

                            title:  Text(_location ==null ?'':_location,style: const TextStyle(color: Colors.white),),
                            subtitle: Text(_adress== null ? '':_adress,maxLines: 1,style: const TextStyle(color: Colors.white),),
                            trailing:OutlinedButton(
                                onPressed:() {

                                  EasyLoading.show(status: 'Please wait...');
                                  locationData.getCurrentPosition();
                                  if(locationData.permissionAllowed==true){
                                    EasyLoading.dismiss();

                                    Navigator.pushReplacementNamed(context, Mapma.id);

                                    //Navigator.pushReplacementNamed(context,  Mapma.id);
                                  }else{
                                    EasyLoading.dismiss();

                                    print('Permission not allowed');
                                  }


                                },
                                child:const Text('Change',style:TextStyle(color:Colors.white),)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                      right: 10.0,
                      top: 10.0,
                      child:IconButton(onPressed:()
                      {

                        //Navigator.pushReplacementNamed(context, ProfileUpdateScreen.id);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  ProfileUpdateScreen(),
                            )
                        );


                      },
                          icon:const Icon(Icons.edit,color: Colors.white,))
                  )
                ],
              ),

               ListTile(leading: const Icon(Icons.history),
                horizontalTitleGap: 2,
                title: InkWell(
                  onTap: (){


                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  MyAdsScreen(),
                        )
                    );

                  },
                    child: const Text('My Ads')),
              ),

              const Divider(),

              ListTile(leading: const Icon(Icons.bolt_sharp),
                horizontalTitleGap: 2,
                title: InkWell(
                    onTap: (){


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const InActive() ,
                          )
                      );

                    },
                    child: const Text('In Active Ads')),
              ),

              const Divider(),

              ListTile(leading: const Icon(Icons.discount),
                horizontalTitleGap: 2,
                title: InkWell(
                    onTap: (){


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const Pacakagess() ,
                          )
                      );

                    },
                    child: const Text('Packages')),
              ),

              const Divider(),

              const ListTile(leading: Icon(Icons.comment_bank_outlined),
                horizontalTitleGap: 2,
                title: Text('My Ratings & Reviews'),),


              const Divider(),

              const ListTile(leading: Icon(Icons.notifications),
                horizontalTitleGap: 2,
                title: Text('Notifications'),),

              const Divider(),

               ListTile(leading: const Icon(Icons.pages_outlined),
                horizontalTitleGap: 2,
                title: InkWell(
                  onTap: ()
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const AboutUs() ,
                        )
                    );
                  },
                    child: const Text('About Us')),
              ),

              const Divider(),

              ListTile(leading: const Icon(Icons.power_settings_new),
                horizontalTitleGap: 2,
                onTap: (){
                signOut();

                },
                title: const Text('Log Out'),),

            ]
        ),
      ),
    );
  }
}
