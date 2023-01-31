import 'dart:async';
import 'dart:core';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/advertPro.dart';
import 'package:layisi/provider/chart.dart';
import 'package:layisi/screens/report.dart';
import 'package:layisi/shared/sharedpref.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:url_launcher/url_launcher.dart';
import 'chart_convo.dart';

class ProductDetails extends StatefulWidget {


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

  ProductDetails({ required this.proID, required this.userID, required this.categoryID, required this.subID, required this.image, required this.img1, required this.img2, required this.img3, required this.img4, required this.type, required this.year, required this.price, required this.fuel, required this.trans, required this.km, required this.owners, required this.bed, required this.bath, required this.fun, required this.con, required this.sq, required this.cap, required this.flo, required this.crip, required this.adu, required this.date1, required this.title, required this.brand, required this.rand, required this.nem, required this.phon, required this.joe, required this.lon, required this.lat, required this.noti,});


  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  late GoogleMapController _controller;


  String id1 = "";
  String name1 = "";
  String  phone1 = "";





bool _loading=true;

int _index=0;

final _formated= NumberFormat();

  @override
  void initState() {

    getPref();


    late List photos;

    Timer(Duration(seconds: 2),(){

      setState(() {
        _loading=false;
      });

    });
    super.initState();
  }



  ///preferences
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



  late List photos=[
  '${widget.image}',
  '${widget.img1}',
  '${widget.img2}',
  '${widget.img3}',
  '${widget.img4}'
];

  _mapLauncher(String lat, String lon) async{
    final availableMaps = await launcher.MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: launcher.Coords(double.parse(lat),double.parse(lon)),
      title: "Seller Location is Here",
    );


  }


  _callSeller(String s){
    launch(s);
  }

  @override
  Widget build(BuildContext context) {
    
    var _price=int.parse(widget.price);
    String price=_formated.format(_price);

    var _km=int.parse(widget.km);
    String km=_formated.format(_km);

     var data=DateTime.fromMicrosecondsSinceEpoch(int.parse(widget.date1));
     var _formatedDAte=DateFormat.yMMMd().format(data);


    final _advertsProvider = Provider.of<AdvertsProvider>(context);

    final _roomProvider=Provider.of<ChartRoomProvider>(context);
    String _chatroomId = '${_advertsProvider.UserID}.${userID}.${_advertsProvider.Random}';
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [

          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.white,
            ), onPressed: () async {

            await FlutterShare.share(
                title: widget.title,
                text: widget.crip,
                linkUrl: 'https://flutter.dev/',
                chooserTitle: 'Layisi Share'
            );

          },
          ),



        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  color: Colors.grey.shade300,
                  child: _loading ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        ),
                        const SizedBox(height:10,),

                        const Text('Loading you Ad..'),

                      ],
                    ),
                  ):
                  Stack(
                    children: [
                      Center(
                        child: PhotoView(
                          backgroundDecoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          imageProvider:NetworkImage(photos[_index]),
                        ),
                      ),

                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount:photos.length ,
                              itemBuilder:( context, index){

                                return    Positioned(
                                          bottom: 0.0,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                _index=index;
                                              });
                                            },
                                            child: Container(
                                                  width: 60,
                                                  height: 60,

                                            child: Image.network(photos[index]),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(

                                                  color: Theme.of(context).primaryColor
                                                ),
                                              ),
                                                 ),
                                          ),
                                            );

                          }),
                        ),
                      ),
                    ],
                  ),


                ),

              _loading ?  Container() :Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.title.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
                        //cars
                        if(widget.categoryID=='14')
                          Text('(${widget.year})'),

                      ],
                    ),

                    const SizedBox(height: 30,),
                    Text('\Shs $price',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                    const SizedBox(height: 10,),

                    //cars
                    if(widget.categoryID=='14')
                      Container(
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.filter_alt_outlined,size: 12,),
                                      const SizedBox(width: 10,),
                                      Text(widget.fuel,style: TextStyle(fontSize: 12),),

                                    ],

                                  ),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.av_timer_outlined,size: 12,),
                                      const SizedBox(width: 10,),
                                      Text(km,style: TextStyle(fontSize: 12),),

                                    ],

                                  ),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.account_tree_outlined,size: 12,),
                                      const SizedBox(width: 10,),
                                      Text(widget.trans,style: TextStyle(fontSize: 12),),

                                    ],

                                  ),
                                ],
                              ),

                              Divider(color: Colors.grey,),

                              Padding(
                                padding: const EdgeInsets.only(left: 12,right: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(CupertinoIcons.person,size: 12,),
                                        const SizedBox(width: 10,),
                                        Text(widget.owners,style: const TextStyle(fontSize: 12),),

                                      ],

                                    ),
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      child: Container(
                                        child: AbsorbPointer(
                                          absorbing: true,//disable button
                                          child: TextButton.icon(onPressed: (){},
                                              style: const ButtonStyle(alignment: Alignment.center),
                                              icon:Icon(Icons.location_on_rounded,size: 12,color: Colors.deepOrangeAccent.shade700,),
                                              label:Flexible(child: Text(widget.adu=='0' ? '':widget.adu,maxLines: 1,
                                              style: const TextStyle(color: Colors.black),))),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Post Date',style: TextStyle(fontSize: 12),),
                                          //Text(widget.date1,style: TextStyle(fontSize: 12),),
                                          Text(_formatedDAte,style: const TextStyle(fontSize: 12),),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              )

                            ],
                          ),
                        ),

                      ),




                    //desc
                    const SizedBox(height: 10,),
                    const Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade300,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(widget.crip),
                                  const SizedBox(height: 10,),
                                  //car n phone
                                    if( widget.categoryID=='14' || widget.subID=='11')
                                    Text(widget.brand),

                                  // phone accessories,tablets,rent n sell
                                  if( widget.subID=='12' ||
                                      widget.subID=='13'||
                                      widget.subID=='2'||
                                      widget.subID=='3'
                                  )
                                    Text('Type:${widget.type}'),

                                //rent n sell
                                if( widget.subID=='2' ||
                                widget.subID=='3')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('BedRooms:${widget.bed}'),
                                      Text('BathRooms:${widget.bath}'),
                                      Text('Furnishing:${widget.fun}'),
                                      Text('Construction status:${widget.con}'),
                                      Text('Total Floors:${widget.flo}'),


                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  Text('Posted at:${widget.date1}'),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                            const Divider(color: Colors.grey,),

                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 40,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue.shade300,
                            radius: 38,
                            child: Icon(CupertinoIcons.person_alt,
                            size: 60,
                            color: Colors.red.shade300,),
                          ),

                        ),
                        const SizedBox(height: 10,),

                        Expanded(
                            child: ListTile(
                                title: Text(widget.nem,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              subtitle: const Text('See Profile',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),),
                              trailing: IconButton(icon:const Icon(Icons.arrow_forward_ios,size: 12,), onPressed: () {  },),
                            ),
                        )
                      ],

                    ),

                    const Text('Posted At',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    const SizedBox(height: 10,),

                    Container(
                      height: 200,
                      color: Colors.grey.shade300,
                      child:  Stack(
                        children: [
                          Center(
                            child:GoogleMap(
                                initialCameraPosition:CameraPosition(
                                    target:LatLng(double.parse(widget.lat),double.parse(widget.lon)),
                                  zoom: 15,
                                ),
                              mapType: MapType.normal,
                              onMapCreated: (GoogleMapController controller){

                                  setState(() {
                                    _controller=controller;
                                  });

                              },
                            ),
                          ),
                          const Center(child: Icon(Icons.location_on,size: 35,),),
                          const Center(child: CircleAvatar(radius: 60,backgroundColor:Colors.black12,),),

                          Positioned(
                            right: 0.0,

                            child:Material(
                              elevation: 4,
                              shape: Border.all(color: Colors.grey.shade300),
                              child: IconButton(
                                  onPressed:()
                                  {
                                    //launch location in google maps
                                    _mapLauncher(widget.lat,widget.lon);
                                  },
                                  icon:const Icon(Icons.alt_route_outlined),
                              ),
                            ),

                          )
                        ],
                      ),

                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: Text('AD ID ${widget.rand}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),

                        TextButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  const Report(),
                              ),
                            );


                          },
                          child: const Text('REPORT THIS AD',style: TextStyle(color: Colors.blue),
                          ),),
                      ],
                    ),

                    const SizedBox(height: 80,),
                  ],
                ),
              ),


              ],
            ),
          ),
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: widget.userID==userID ? Row(
            children: [
              //seller should not be able to create a chat room
              //only user can click the chat button

              Expanded(
                  child:NeumorphicButton(
                    onPressed: (){

                    },
                    style: const NeumorphicStyle(color:Colors.deepOrangeAccent),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.edit,size: 16,color: Colors.white,),
                          Text('Edit Product',style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  )),

            ],
          ):Row(
            children: [
              //seller should not be able to create a chat room
              //only user can click the chat button

              Expanded(
                  child:NeumorphicButton(
                    onPressed: (){


                      _roomProvider.selectedChat(_chatroomId);


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ChartConversations(chatID:_chatroomId)
                          )
                      );

                    },
                style: const NeumorphicStyle(color:Colors.deepOrangeAccent),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(CupertinoIcons.chat_bubble,size: 16,color: Colors.white,),
                      Text('Chat',style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              )),
               const SizedBox(width: 20,),
              Expanded(child:NeumorphicButton(
                onPressed: (){

                  launch('tel:${widget.phon}');
                },
                style: const NeumorphicStyle(color:Colors.deepOrangeAccent),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(CupertinoIcons.phone,size: 16,color: Colors.white,),
                      Text('Call',style: TextStyle(color: Colors.white),),
                    ],

                  ),
                ),
              )),
              const SizedBox(width: 20,),
            ],
          ),
        ),
      ),

    );
  }
}

