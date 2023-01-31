import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import '../provider/rotation.dart';


class ProductList extends StatefulWidget {




  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {



  @override
  void initState(){
    super.initState();
    showProducts();
    getPref();
  }

bool _isLiked=false;





  late  List products=[];
  //List<AdvertModel> products = [];
  showProducts() async {
    var response = await http.get(
        Uri.parse("https://layisikla.000webhostapp.com/api/getAllAds.php"),
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        products = jsonData;
      });
      print(jsonData);
      return jsonData;
    }
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





  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white10,
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
                      Center(child: Text('No Ads for now')),
                                    ],
                  ),
                );
              }



              return Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(
                      height: 56,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Fresh Recommendations',style: TextStyle(fontWeight: FontWeight.bold),),
                      )),


                  GridView.builder(
                    shrinkWrap: true,
                      physics:const ScrollPhysics(),
                      gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2/3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                      ),
                      itemCount:products.length,
                      itemBuilder: (BuildContext context, int index) {

                        //final x = products[index];

                        return  Pro(
                          proID:products[index]['ID'],
                          userID:products[index]['user_id'],
                          categoryID:products[index]['category'],
                          subID:products[index]['subcategory'],
                          image:'https://layisikla.000webhostapp.com/api/adz/${products[index]['image']}',
                          img1: 'https://layisikla.000webhostapp.com/api/adz/${products[index]['img1']}',
                          img2:'https://layisikla.000webhostapp.com/api/adz/${products[index]['img2']}',
                          img3: 'https://layisikla.000webhostapp.com/api/adz/${products[index]['img3']}',
                          img4:'https://layisikla.000webhostapp.com/api/adz/${products[index]['img4']}',
                          type:products[index]['type'],
                          rand:products[index]['random'],
                          nem:products[index]['name'],
                          phon:products[index]['phone'],
                          brand:products[index]['brand'],
                          year:products[index]['year'],
                          price:products[index]['price'],
                          fuel:products[index]['fuel'],
                          trans:products[index]['trans'],
                          km:products[index]['km'],
                          owners:products[index]['owners'],
                          title:products[index]['title'],
                          bed:products[index]['bedrooms'],
                          bath:products[index]['bathrooms'],
                          fun:products[index]['fun'],
                          con:products[index]['con'],
                          sq:products[index]['sqft'],
                          cap:products[index]['carpet'],
                          flo:products[index]['floors'],
                          crip:products[index]['crip'],
                          adu:products[index]['adu'],
                          lon:products[index]['lon'],
                          lat:products[index]['lat'],
                          noti:products[index]['noti'],
                          date1:products[index]['ad'],
                          joe:products[index]['date'],



                        );

                      }),
                ],
              );

            }else{
              return   Padding(
                padding: const EdgeInsets.only(left: 140,right:140 ),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  backgroundColor: Colors.grey.shade100,
                ),
              );
            }





          },
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
  final String rand;
  final String nem;
  final String phon;
  final String type;
  final String brand;
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
  final String joe;


  Pro ({ required this.proID, required this.userID, required this.categoryID, required this.subID, required this.image, required this.img1, required this.img2, required this.img3, required this.img4, required this.type, required this.year, required this.price, required this.fuel, required this.trans, required this.km, required this.owners, required this.bed, required this.bath, required this.fun, required this.con, required this.sq, required this.cap, required this.flo, required this.crip, required this.adu, required this.date1, required this.title, required this.brand, required this.rand,required this.nem, required this.phon, required this.joe,required this.lon, required this.lat,required this.noti});

  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<Pro> {


  @override
  void initState(){
    super.initState();

    getPref();
  }

  bool _isLiked=false;


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





   favor() async{
     EasyLoading.show(status: 'Saving');
     var response = await http.post(
         Uri.parse('https://jetherk.000webhostapp.com/api/favor.php'),
         body: {
           'favor_id':'$userID',
           'IDi':widget.proID,
           'user_id': widget.userID,
           'category':widget.categoryID,
           'subcategory':widget.subID,
           'image':widget.image,
           'img1':widget.img1,
           'img2':widget.img2,
           'img3':widget.img3,
           'img4':widget.img4,
           'random':widget.rand,
           'name':widget.nem,
           'phone':widget.phon,
           'brand':widget.brand,
           'type':widget.type,
           'year':widget.year,
           'price':widget.price,
           'fuel':widget.fuel,
           'trans':widget.trans,
           'km':widget.km,
           'owners':widget.owners,
           'title':widget.type,
           'bedrooms':widget.bed,
           'bathrooms':widget.bath,
           'fun':widget.fun,
           'con':widget.con,
           'sqft':widget.sq,
           'carpet':widget.cap,
           'floors':widget.flo,
           'crip':widget.crip,
           'adu':widget.adu,
           'lon':widget.lon,
           'lat':widget.lat,
           'noti':widget.noti,
           'date':widget.date1,
         });


    if (response.statusCode == 200) {
      var userData = json.decode(response.body);

      EasyLoading.showSuccess('Saved...');

      print(userData);

    }else{
      EasyLoading.showError('Failed to Save');

    }


  }



  @override
  Widget build(BuildContext context) {

    final _advertsProvider=Provider.of<AdvertsProvider>(context);
    final _imagesProvider=Provider.of<ImagesProvider>(context);


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


        // _imagesProvider. getselectedImagess(
        //     widget.image, widget.img1,widget.img2,widget.img3,widget.img4
        // );

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                        Text('${widget.year} -$kilo km') :Text(''),
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
              //
              // Positioned(
              //   right: 0.0,
              //     child: InkWell(
              //       onTap: ()
              //       {
              //         favor();
              //       },
              //       child: IconButton(
              //         icon: Icon(_isLiked ? Icons.favorite:Icons.favorite_border),
              //         color: _isLiked ? Colors.red:Colors.black,
              //         onPressed: () {
              //           setState(() {
              //             _isLiked=!_isLiked;
              //           });
              //
              //         },
              //       ),
              //     ),
              //     ),

            ],
          ),
        ),
      ),
    );
  }





}
