import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileUpdateScreen extends StatefulWidget {
  static const  String id='pfo';

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  String _manaya='';
  String _simu='';
  String _mailo='';

  final _formKey=GlobalKey<FormState>();
  final _nName=TextEditingController();
  final _contNum=TextEditingController();
  final _ema=TextEditingController();


  @override
  void initState() {
    getProf();
    getPref();

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

  String? loke;
  getProf() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loke = sharedPreferences.getString(PrefInfo.ID);


    String? loco=sharedPreferences.getString('name');
    String? ade=sharedPreferences.getString('email');
    String? nu=sharedPreferences.getString('number');

    setState(() {


      _nName.text=loco!;
      _ema.text=ade!;
      _contNum.text=nu!;
    });
  }



  @override
  Widget build(BuildContext context) {

    final _authData = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(color: Colors.white,fontSize: 16),),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [


        ],

      ),
      body:Form(
          key: _formKey,
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                TextFormField(
                    controller: _nName,
                    decoration: const InputDecoration(
                        label: Text('Name'),
                        labelStyle:TextStyle(color:Colors.grey),
                        contentPadding: EdgeInsets.zero
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Name';

                      }
                    }
                ),

                const SizedBox(height: 40,),

                TextFormField(
                    controller: _contNum,
                    decoration: const InputDecoration(
                        label: Text('Phone Number'),
                        labelStyle:TextStyle(color:Colors.grey),
                        contentPadding: EdgeInsets.zero
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Phone Number';

                      }
                    }
                ),

                const SizedBox(height: 40,),

                TextFormField(
                    controller: _ema,
                    decoration: const InputDecoration(
                        label: Text('Email'),
                        labelStyle:TextStyle(color:Colors.grey),
                        contentPadding: EdgeInsets.zero
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Email';

                      }
                    }
                ),


              ],
            ),
          )),
      bottomSheet: InkWell(
        onTap: ()
        async {

          if(_formKey.currentState!.validate()){

            _authData.saveUserData();
            EasyLoading.show(status: 'Updating  status');

            var response=await http.post(Uri.parse('https://layisikla.000webhostapp.com/api/owner/editProfile.php'),

                body:{
                  "id":"$userID",
                  "name":_nName.text,
                  "num":_contNum.text,
                  "email":_ema.text,
                });



            if(response.statusCode==200){

              EasyLoading.showSuccess('Profile Edited');

            }else{

              EasyLoading.showError('Failed to Edit Profile');
            }



          }




        },
        child: Container(
          width: double.infinity,
          height:56 ,
          color:Colors.deepOrangeAccent,
          child: const Center(child: Text('Update',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
        ),
      ),
    );
  }
}
