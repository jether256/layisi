import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/advertPro.dart';
import 'package:layisi/screens/product_details.dart';

import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/admodel.dart';


class MyAdsScreen extends StatefulWidget {
  static const  String id='my ads';

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {



  @override
  void initState(){
    super.initState();
    showProducts();
    getPref();
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


  String _address='';

  // late  List products=[];
  // showProducts() async{
  //
  //
  //
  //
  //   var isCacheExist = await APICacheManager().isAPICacheKeyExist("MyAdverts");
  //
  //   if(!isCacheExist) {
  //     var response = await http.post(
  //         Uri.parse("https://jetherk.000webhostapp.com/api/getMyAds.php"),
  //         headers: {"Accept": "headers/json"},
  //         body: {'user_id': '$userID'});
  //
  //     if (response.statusCode == 200) {
  //
  //
  //       APICacheDBModel cacheDBModel= APICacheDBModel(key:"MyAdverts", syncData:response.body);
  //       await APICacheManager().addCacheData(cacheDBModel);
  //
  //       var jsonData = json.decode(response.body);
  //
  //       setState(() {
  //         products = jsonData;
  //       });
  //       print(jsonData);
  //       return jsonData;
  //     }
  //
  //
  //   }else{
  //
  //     var cacheData=await APICacheManager().getCacheData("MyAdverts");
  //     print("Cache:hit");
  //
  //     var jsonDataa=json.decode(cacheData.syncData);
  //
  //     setState((){
  //       products=jsonDataa;
  //
  //     });
  //     print(jsonDataa);
  //     return jsonDataa;
  //   }
  //
  // }




  List<AdvertModel> products = [];
  showProducts() async  {


    var isCacheExist = await APICacheManager().isAPICacheKeyExist("Adverts");

    if(!isCacheExist) {

      var response = await http.post(
          Uri.parse("https://layisikla.000webhostapp.com/api/getMyAds.php"),
          headers: {"Accept": "headers/json"},
          body: {'user_id': '$userID'});

      if (response.statusCode == 200) {

        APICacheDBModel cacheDBModel= APICacheDBModel(key:"Adverts", syncData:response.body);
        await APICacheManager().addCacheData(cacheDBModel);

        // If the call to the server was successful, parse the JSON
        List<dynamic> values=[];
        values = json.decode(response.body);
        if(values.isNotEmpty){
          for(int i=0;i<values.length;i++){
            if(values[i]!=null){
              Map<String,dynamic> map=values[i];
              products .add(AdvertModel.fromJson(map));
            }
          }
        }
        return products;

      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load adverts');
      }

    }else{

      var cacheData=await APICacheManager().getCacheData("Adverts");
      print("Cache:hit");

      List<dynamic> values=[];
      values = json.decode(cacheData.syncData);
      if(values.isNotEmpty){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            products .add(AdvertModel.fromJson(map));
          }
        }
      }
      return products;


    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.deepOrangeAccent,
        elevation: 0.0,
        title: const Text('My Ads',style: TextStyle(color: Colors.white),),
      ),
      body:Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child:Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child:FutureBuilder<dynamic>(
          future:showProducts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

            if (snapshot.hasData) {


              if(snapshot.data.length == 0) {
                return Center(
                  child: Column(
                    children: const [
                      Center(child: Text('You have no ads')),
                    ],
                  ),
                );
              }


              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: GridView.builder(
                        gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2/3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
                        ),
                        itemCount:products.length,
                        itemBuilder: (BuildContext context, int index) {

                          final x = products[index];

                          return  Pro(
                            proID:x.ID,
                            userID:x.user_id,
                            categoryID:x.category,
                            subID:x.subcategory,
                            image:'https://layisikla.000webhostapp.com/api/adz/${x.image}',
                            img1: 'https://layisikla.000webhostapp.com/api/adz/${x.img1}',
                            img2:'https://layisikla.000webhostapp.com/api/adz/${x.img2}',
                            img3: 'https://layisikla.000webhostapp.com/api/adz/${x.img3}',
                            img4:'https://layisikla.000webhostapp.com/api/adz/${x.img3}',
                            type:x.type,
                            rand:x.random,
                            nem:x.name,
                            phon:x.phone,
                            brand:x.brand,
                            year:x.year,
                            price:x.price,
                            fuel:x.fuel,
                            trans:x.trans,
                            km:x.km,
                            owners:x.owners,
                            title:x.title,
                            bed:x.bedrooms,
                            bath:x.bathrooms,
                            fun:x.fun,
                            con:x.con,
                            sq:x.sqft,
                            cap:x.carpet,
                            flo:x.floors,
                            crip:x.crip,
                            adu:x.adu,
                            lon:x.lon,
                            lat:x.lat,
                            noti:x.noti,
                            date1:x.date,
                            joe:x.ad,


                          );


                        }),
                  ),
                ],
              );

            }else{
              return Padding(
                padding: const EdgeInsets.only(left: 140,right:140 ),
                child: Center(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
              );
            }





          },
        ),
      ),
    ),
    );
  }
}

class Pro extends StatefulWidget {

  final String proID;
  final String userID;
  final String categoryID;
  final String subID;
  final String image;
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String type;
  final String rand;
  final String nem;
  final String phon;
  final String year;
  final String price;
  final String fuel;
  final String trans;
  final String km;
  final String owners;
  final String title;
  final String bed;
  final String bath;
  final String fun;
  final String con;
  final String sq;
  final String cap;
  final String flo;
  final String crip;
  final String adu;
  final String lon;
  final String lat;
  final String noti;
  final String date1;
  final String brand;
  final String joe;


  Pro ({ required this.proID, required this.userID, required this.categoryID, required this.subID, required this.image, required this.img1, required this.img2, required this.img3, required this.img4, required this.type, required this.year, required this.price, required this.fuel, required this.trans, required this.km, required this.owners, required this.bed, required this.bath, required this.fun, required this.con, required this.sq, required this.cap, required this.flo, required this.crip, required this.adu, required this.date1, required this.title, required this.brand, required this.rand, required this.nem, required this.phon, required this.joe,required this.lon, required this.lat,required this.noti});

  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<Pro> {
  @override
  Widget build(BuildContext context) {

    final _advertsProvider=Provider.of<AdvertsProvider>(context);

    final _format=NumberFormat('##,###,###,##0');
    var jay=int.parse(widget.price);
    var _km=int.parse(widget.km);
    String forma='\Shs ${_format.format(jay)}';
    String kilo=_format.format(_km);

    return InkWell(
      onTap: (){



        _advertsProvider.getselectedAdvert(
            widget.proID,widget.userID,widget.categoryID,widget.subID,widget.image,
            widget.img1,widget.img2,widget.img3,widget.img4,
            widget.rand,widget.nem,widget.phon,widget.brand,widget.type,widget.year,widget.price,widget.fuel,widget.trans,
            widget.km,widget.owners,widget.title,widget.bed,widget.bath,widget.fun,widget.con,widget.sq,widget.cap,widget.flo,
            widget.crip,widget.adu,widget.lon,widget.lat,widget.noti,widget.joe,widget.date1
        );


        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ProductDetails(proID:widget.proID,userID:widget.userID,categoryID:widget.categoryID,subID:widget.subID,image:widget.image,img1:widget.img1,img2:widget.img2,img3:widget.img3,img4:widget.img4,type:widget.type,year:widget.year,price:widget.price,fuel:widget.fuel,trans:widget.trans,km:widget.km,owners:widget.owners,bed:widget.bed,bath:widget.bath,fun:widget.fun,con:widget.con,sq:widget.sq,cap:widget.cap,flo:widget.flo,crip:widget.crip,adu:widget.adu,date1:widget.date1,title:widget.title,brand:widget.brand,rand:widget.rand,nem:widget.nem,phon:widget.phon,joe:widget.joe,lat:widget.lat,lon:widget.lon,noti:widget.noti),
          ),
        );



      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 100,
                          child:CachedNetworkImage(
                            imageUrl: widget.image,fit: BoxFit.cover,
                            //placeholder: (context, url) =>,
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(forma,style: const TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.title,maxLines: 1,overflow:TextOverflow.ellipsis,),

                        widget.categoryID == '14' ?
                        Text('${widget.year} -$kilo km') :const Text(''),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      widget.adu == '0' ?
                      Text(''):
                      const Icon(Icons.location_pin,size: 14,color:Colors.black38),
                      Flexible(child: Text(widget.adu,maxLines: 1,overflow:TextOverflow.ellipsis,)),
                    ],
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
