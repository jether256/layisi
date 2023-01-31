

import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:layisi/categorieslogged/kato.dart';
import 'package:layisi/crypt/encrypt.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/advertPro.dart';
import 'package:layisi/screens/product.dart';
import 'package:layisi/screens/product_details.dart';
import 'package:layisi/widgets/banner.dart';
import 'package:layisi/widgets/customapp.dart';
import 'package:intl/intl.dart';

import 'package:location_platform_interface/location_platform_interface.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenLo extends StatefulWidget {

  static const  String id='main-screen-logged';

   // final LocationData locationData;
   //
   //
   // HomeScreenLo({ required this.locationData});

  @override
  _HomeScreenLoState createState() => _HomeScreenLoState();
}

class _HomeScreenLoState extends State<HomeScreenLo> {

  String address='uganda';

 bool isSeen=true;


  @override
  void initState(){
    super.initState();
    showProducts();
    getTotalUnseenNotification();
    getPref();
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
      dialogText: 'Please update the app from' +status.localVersion + 'to' +status.storeVersion,
      dismissAction: (){
          SystemNavigator.pop();
      },
    updateButtonText: 'Lets update',
    );

    print("DEVICE:" + status.localVersion);
    print("STORE:" + status.storeVersion);

  }



  String? userID, name, email, num, pass, pic, lon, lat, ad, city, country,
      status, log, create;

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



  var total;
  getTotalUnseenNotification() async {

    var response = await http.post(
        Uri.parse("https://layisikla.000webhostapp.com/api/noti.php"),
        headers: {"Accept": "headers/json"}, body: {
      "name": '$name',
    });

    if (response.statusCode == 200) {
      setState(() {
        total=response.body;
      });


    }

    print(total);
    return total;

    }


  late  List searchList=[];
  showProducts() async{

      var response = await http.get(Uri.parse("https://layisikla.000webhostapp.com/api/getAllAds.php"),headers:{"Accept":"headers/json"});
      if(response.statusCode ==200){

        var jsonData=json.decode(response.body);

       for(var i=0;i<jsonData.length;i++){
         searchList.add(jsonData[i]['type']);
         searchList.add(jsonData[i]['year']);
         searchList.add(jsonData[i]['price']);
         searchList.add(jsonData[i]['trans']);
         searchList.add(jsonData[i]['title']);
         searchList.add(jsonData[i]['crip']);
         searchList.add(jsonData[i]['adu']);
         searchList.add(jsonData[i]['ad']);
         searchList.add(jsonData[i]['brand']);
       }
        print(searchList);
        //return jsonData;

      }

    }






  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child:SafeArea(child: CustomAppBar()),
      ),

        body: SingleChildScrollView(
          physics: const ScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
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
                              onTap: (){
                                showSearch(context: context, delegate:SearchAds(list:searchList));
                              },
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
                      isSeen ?  Badge(
                        badgeColor: Colors.grey,
                          badgeContent: Text('$total',style: const TextStyle(color: Colors.white),),
                            child: const Icon(Icons.notifications_active,color:Colors.deepOrangeAccent,),
                        ): Badge(
                        badgeContent:const Text('0',style: TextStyle(color: Colors.white),),
                        child: const Icon(Icons.notifications_none,color:Colors.deepOrangeAccent,),
                      ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12,8,12,8),
                  child: Column(
                    children:   const [
                       //
                       // Bann(),
                      CategoryLo(),
                    ],
                  ),
                ),

                const SizedBox(height: 10,),

               ProductList(),





              ],
            ),
          ),
        ),
    );
  }
}

class SearchAds extends SearchDelegate<String>{

  List<dynamic> list;
  SearchAds({required this.list});

  showAllProducts() async{

    var response = await http.post(
        Uri.parse('https://layisikla.000webhostapp.com/api/search.php'),
        body: {
          "search":query,
        });
    if(response.statusCode ==200){
      var jsonData=json.decode(response.body);
      return jsonData;

    }

  }


  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
          onPressed:(){
            query="";
            showSuggestions(context);

          },
          icon:const Icon(Icons.close),
      )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(onPressed:(){
      close(context,"");
    },icon:const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {


    final _advertsProvider=Provider.of<AdvertsProvider>(context);

    return FutureBuilder<dynamic>(
        future: showAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                var lists=snapshot.data[index];

                          final _format=NumberFormat('##,###,##0');
                        var _price=int.parse(lists['price']);//convert to int
                String _formattedPrice='\Shs ${_format.format(_price)}';


                //
                // var date=DateTime.DateTime.fromMicrosecondsSinceEpoch(lists['date']);
                // var _date=DateFormat.yMMM().format(date);


              return InkWell(
                onTap: (){

                  _advertsProvider.getselectedAdvert(
                      lists['ID'],lists['user_id'],lists['category'],lists['subcategory'],lists['image'],
                      lists['img1'],lists['img2'],lists['img3'],lists['img4'],
                      lists['random'],lists['name'],lists['phone'],lists['brand'],lists['type'],lists['year'],lists['price'],lists['fuel'],lists['trans'],
                      lists['km'],lists['owners'],lists['title'],lists['bedrooms'],lists['bathrooms'],lists['fun'],lists['con'],lists['sqft'],lists['carpet'],lists['floors'],
                      lists['crip'],lists['adu'],lists['lon'],lists['lat'],lists['noti'],lists['ad'],lists['date']
                  );



                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ProductDetails(proID: lists['ID'],userID:lists['user_id'],categoryID:lists['category'],subID:lists['subcategory'],
                          image:lists['image'],img1:lists['img1'],img2:lists['img2'],img3:lists['img3'],img4:lists['img4'],
                          type:lists['type'],year:lists['year'],price:lists['price'],fuel:lists['fuel'],trans:lists['trans'],
                          km:lists['km'],owners:lists['owners'],bed:lists['bedrooms'],bath:lists['bathrooms'],fun:lists['fun'],
                          con:lists['con'],sq:lists['sqft'],cap:lists['carpet'],flo:lists['floors'],
                          crip: lists['crip'],adu:lists['adu'],date1:lists['date'],title:lists['title'],
                          brand:lists['brand'],rand: lists['random'],nem:lists['name'],phon:lists['phone'],joe:lists['ad'],lat:lists['lat'],lon:lists['lon'],noti:lists['noti']),
                    ),
                  );
                },
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 120,
                            child:CachedNetworkImage(
                              imageUrl:'https://layisikla.000webhostapp.com/api/adz/${lists['image']}',fit: BoxFit.cover,
                              //placeholder: (context, url) =>,
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_formattedPrice,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  Text(lists['title']),
                                ],
                      ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Posted At:${lists['date']}'),
                                  ],
                                ),


                            ],
                          )
                        ],

                      ),
                    ),
                  ),

                ),
              );
            });
          }else{
            return Column(
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }

          });

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    var listData=query.isEmpty ? list:list.where((element) => element.toLowerCase().contains(query)).toList();

    return listData.isEmpty ? const Center(child: Text('No Data Found'),):ListView.builder(
      itemCount: listData.length,
        itemBuilder:(context,index){
          return  ListTile(
            onTap: (){
              query=listData[index];
              showResults(context);
            },
            title:Text(listData[index]),
          );
        }
    );
  }

}