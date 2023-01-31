
import 'dart:async';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:layisi/model/pop_up_model.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/advertPro.dart';
import 'package:layisi/screens/chart_convo.dart';
import 'package:layisi/shared/sharedpref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreenLo extends StatefulWidget {





  @override
  _ChatScreenLoState createState() => _ChatScreenLoState();
}

class _ChatScreenLoState extends State<ChatScreenLo> {

  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    getPref();
  }

  @override
  void didChangeDependencies() {
    final _advertsProvider = Provider.of<AdvertsProvider>(context);
    showMessages(_advertsProvider);
    super.didChangeDependencies();
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

  String timeee = DateTime.now().microsecondsSinceEpoch.toString();

//single product with last message
  late List mess = [];
  showMessages(AdvertsProvider advertsProvider) async {



    var isCacheExist = await APICacheManager().isAPICacheKeyExist("MesLast");
    if(!isCacheExist){


      var response = await http.post(
        Uri.parse(
            "https://layisikla.000webhostapp.com/api/getAllPersonalMess.php"),
        headers: {"Accept": "headers/json"}, body: {
        "seller_id": advertsProvider.UserID,
      "buyer_id": userID,
      // "product_id":advertsProvider.Random,
    });

    if (response.statusCode == 200) {



      APICacheDBModel cacheDBModel= APICacheDBModel(key:"MesLast", syncData:response.body);
      await APICacheManager().addCacheData(cacheDBModel);

      var jsonData = json.decode(response.body);



        setState(() {
          mess = jsonData;
        });




      print(jsonData);
      return jsonData;
    }



    }else{

      var cacheData=await APICacheManager().getCacheData("MesLast");
      print("Cache:hit");

      var jsonDataa=json.decode(cacheData.syncData);

      setState((){
        mess=jsonDataa;

      });
      print(jsonDataa);
      return jsonDataa;
    }


  }


  late List<PopUpModel> menuItems = [
    PopUpModel('Delete Chat', Icons.delete_outline),
    PopUpModel('Mark as Sold', Icons.done_all),
  ];

  //getAllSell.php
  //getAllBuy.php

  //delete Chat
  Future<void> deleteChat(m) async {
    var response = await http.post(
        Uri.parse("https://layisikla.000webhostapp.com/api/deleteChat.php"),
        headers: {"Accept": "headers/json"}, body: {
      "chatRoomId": m,
    });

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);

      if (userData == "yeah") {
        EasyLoading.showSuccess('Message Deleted');
      } else {
        EasyLoading.showError('Message Deletion Failed..');

        print(userData);
      }
    }
  }

    @override
    Widget build(BuildContext context) {
      final _advertsProvider = Provider.of<AdvertsProvider>(context);

      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepOrangeAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Chats', style: TextStyle(color: Colors.white,),),
        ),
        body: Container(
          child: FutureBuilder<dynamic>(
              future: showMessages(_advertsProvider),
              //initialData: [],
              builder: (BuildContext context,
                  AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            const Text('No Chats Started Yet',style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            ElevatedButton(
                                onPressed: ()
                                {

                                },
                                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor)),
                                child:const Text('Contact Seller')
                            ),

                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: mess.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          String lastChatDate;
                          var _date = DateFormat.yMMMd().format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  int.parse(
                                      mess[index]['lastChatTime'])));
                          var _today = DateFormat.yMMMd().format(
                              DateTime.fromMicrosecondsSinceEpoch(DateTime
                                  .now()
                                  .microsecondsSinceEpoch));

                          if (_date == _today) {
                            lastChatDate = 'Today';
                          } else {
                            lastChatDate = _date.toString();
                          }

                          return Container(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChartConversations(
                                                  chatID: mess[index]['chatRoomId'],)
                                        )
                                    );
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      child: CachedNetworkImage(
                                        imageUrl: mess[index]['product_image'],
                                        fit: BoxFit.cover,
                                        //placeholder: (context, url) =>,
                                        errorWidget: (context, url,
                                            error) =>
                                        const Icon(Icons.error),
                                      ),
                                    ),
                                    title: Text(mess[index]['title']),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [

                                        Text(mess[index]['crip'],
                                          maxLines: 1,),
                                        if(mess[index]['lastChat'] != '')
                                          Text(mess[index]['lastChat'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 10),),


                                      ],
                                    ),
                                    trailing: CustomPopupMenu(
                                      child: Container(
                                        child: const Icon(
                                            Icons.more_vert_sharp,
                                            color: Colors.black),
                                        padding: const EdgeInsets.all(20),
                                      ),
                                      menuBuilder: () =>
                                          ClipRRect(
                                            borderRadius: BorderRadius
                                                .circular(5),
                                            child: Container(
                                              color: const Color(
                                                  0xFF4C4C4C),
                                              child: IntrinsicWidth(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .stretch,
                                                  children: menuItems
                                                      .map(
                                                        (item) =>
                                                        GestureDetector(
                                                          behavior: HitTestBehavior
                                                              .translucent,
                                                          onTap: () {
                                                            if (item
                                                                .title ==
                                                                'Delete Chat') {
                                                              deleteChat(
                                                                  mess[index]['chatRoomId']);
                                                              _controller
                                                                  .hideMenu();
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  item
                                                                      .icon,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        left: 10),
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical: 10),
                                                                    child: Text(
                                                                      item
                                                                          .title,
                                                                      style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                  )
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                      pressType: PressType.singleClick,
                                      verticalMargin: -10,
                                      controller: _controller,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10.0,
                                  top: 10.0,
                                  child: Text(lastChatDate),
                                ),
                              ],
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                          );
                        });
                  }
                } else {
                  return Container();
                }
              }

          ),

        ),
      );
    }
  }



