import 'dart:async';


import 'dart:core';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:layisi/crypt/encrypt.dart';
import 'package:layisi/model/pop_up_model.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/advertPro.dart';
import 'package:layisi/shared/sharedpref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class ChartConversations extends StatefulWidget {


  final  String chatID;
  ChartConversations({required this.chatID});

 @override
  _ChartConversationsState createState() => _ChartConversationsState();
}

class _ChartConversationsState extends State<ChartConversations> {


  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;



  // StreamController<List> _streamController = StreamController<List>.broadcast();
  // late Timer _timer;

  @override
  void initState() {

     flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
     var and=const AndroidInitializationSettings('assets/images/logo.png');
    var ios= const IOSInitializationSettings();
     var initiliaze=InitializationSettings(android: and,iOS: ios);
     flutterLocalNotificationsPlugin.initialize(initiliaze,onSelectNotification:onSelectNotification);

    getPref();
    //Check the server every 5 seconds
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) => getData());

  }


  @override
  void didChangeDependencies() {
    final _advertsProvider = Provider.of<AdvertsProvider>(context);
    showMessages(_advertsProvider);

    super.didChangeDependencies();
  }


  // @override
  // void dispose() {
  //   //cancel the timer
  //   if (_timer.isActive) _timer.cancel();
  //
  //   super.dispose();
  // }

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


  onSelectNotification( payload){

    if(payload !=''){
      debugPrint("Notification:"+payload);
    }

}

showNotifications() async{
    var android=const AndroidNotificationDetails('channelId', 'channelName');
    var ios=const IOSNotificationDetails();
    var platform=NotificationDetails(android: android,iOS: ios);
    flutterLocalNotificationsPlugin.show(0,'Layisi Notification', chatMessageController.text, platform,payload: 'some details');
}


  // Future getData() async {
  //
  //   String chatroomId='${widget.userID}.${id1}.${widget.proID}';
  //
  //   var response = await http.post(
  //       Uri.parse("https://manjether.000webhostapp.com/layisi/message.php"),
  //       headers: {"Accept": "headers/json"}, body: {
  //     // "sellerID": widget.nem, //seller
  //     // "buyerID": name1, //buyer
  //     "chatRoomId":chatroomId,
  //     // "product_id":widget.proID,
  //   });
  //   List data = json.decode(response.body);
  //
  //
  //
  //   //Add your data to stream
  //   _streamController.add(data);
  //
  //
  //
  // }


  late List mess = [];

  showMessages(AdvertsProvider advertsProvider) async {
      var response = await http.post(
          Uri.parse("https://layisikla.000webhostapp.com/api/showmess.php"),
          headers: {"Accept": "headers/json"}, body: {
        "chatRoomId":widget.chatID,
      });

      if (response.statusCode == 200) {


        var jsonData= json.decode(response.body);
        //var jsonData= json.decode(decryp(response.body));
        //var jsonData= jsonDecode(decryp(response.body));

        setState(() {
          mess =jsonData;
        });
        print(jsonData);
        return jsonData;
      }



  }


  bool _send = false;
  final _format = NumberFormat('##,###,###,##0');

  //late Stream chatMessageStream;
  var chatMessageController = TextEditingController();
  final CustomPopupMenuController _controller = CustomPopupMenuController();



  //var today = DateTime.now().microsecondsSinceEpoch.toString();


  sendMessage(AdvertsProvider advertsProvider) async {

    if (chatMessageController.text.isNotEmpty) {
      EasyLoading.show(status: 'Sending');



      var response = await http.post(
          Uri.parse('https://layisikla.000webhostapp.com/api/sendmess.php'),
          body: {
            "chatRoomId":encryp(widget.chatID),
            "lastChat":encryp(chatMessageController.text) ,
            "sellerID":encryp(advertsProvider.UserID) , //seller
            "sellerName":encryp( advertsProvider.Name), //seller
            "buyerID":encryp('$userID') , //buyer
            "buyerName":encryp('$name') , //buyer
            "product_id":encryp(advertsProvider.Random) ,
            "crip":encryp(advertsProvider.Crip) ,
            "product_image": advertsProvider.Image,
            "price":encryp(advertsProvider.Price) ,
            "title":encryp(advertsProvider.Title) ,
            "lastChatTime": DateTime.now().microsecondsSinceEpoch.toString(),
          });

      if (response.statusCode == 200) {
        showNotifications();
        EasyLoading.showSuccess('Message sent');
      } else {
        EasyLoading.showError('Message failed to send');
      }

      chatMessageController.clear();
    }
  }

//String _priceFormatted() {
// var _price = int.parse();
// var _formattedPrice = _format.format(_price);
// return _formattedPrice;


  late List<PopUpModel> menuItems = [
    PopUpModel('Delete Chat', Icons.delete_outline),
    PopUpModel('Mark as Sold', Icons.done_all),
  ];


  //delete Chat
  Future<void> deleteChat(m) async {
    var response = await http.post(
        Uri.parse("https://layisikla.000webhostapp.com/api/deleteChat.php"),
        headers: {"Accept": "headers/json"}, body: {
      "chatRoomId":m,
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


    final _advertsProvider=Provider.of<AdvertsProvider>(context);


    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [

          IconButton(icon: const Icon(Icons.call),onPressed: (){
            launch('tel:${_advertsProvider.Phone}');
          },),
          CustomPopupMenu(
            child: Container(
              child: const Icon(Icons.more_vert_sharp, color: Colors.white),
              padding: const EdgeInsets.all(20),
            ),
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: const Color(0xFF4C4C4C),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: menuItems
                        .map(
                          (item) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {

                          if(item.title=='Delete Chat'){
                            deleteChat(widget.chatID);
                            _controller.hideMenu();
                          }
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                item.icon,
                                size: 15,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: Colors.white,
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
        ],
        shape:const Border(bottom:BorderSide(color:Colors.grey),),
      ),
      body: SingleChildScrollView(

        child: FutureBuilder<dynamic>(
            future:showMessages(_advertsProvider),
            //initialData: [],
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              if (snapshot.hasData) {
                if(snapshot.data!.length == 0){
                  return Center(
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
                  );
                }else {
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount:mess.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:( context, index) {

                        

                        String sentBy=mess[index]['buyerID'];//me e.g name1
                        String me=mess[index]['sellerID'];//product owner e.g widget.userID

                        String lastChatDate;
                        var _date=DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(int.parse(mess[index]['lastChatTime'])));
                        var _today=DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch));

                        if(_date==_today){
                          lastChatDate= DateFormat('hh:mm').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(mess[index]['lastChatTime'])));
                        }else{
                          lastChatDate=_date.toString();
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),


                          child:Column(
                            children: [


                              ChatBubble(
                                // alignment:sentBy==me ? Alignment.centerLeft:Alignment.centerRight,
                                backGroundColor: sentBy==me ? Theme.of(context).primaryColor:Colors.grey,
                                child:Text(mess[index]['lastChat'],style: TextStyle(color:sentBy==me ?Colors.white:Colors.grey.shade300,fontSize: 12),) ,
                                clipper: ChatBubbleClipper2(
                                    type: BubbleType.sendBubble,
                                ),
                              ),

                              Align(
                                alignment:sentBy==me ? Alignment.centerLeft:Alignment.centerRight,
                                child: Text(lastChatDate,style: const TextStyle(fontSize: 12),),
                              ),
                            ],
                          ),
                        );


                      }),
                ) ;
                 }
              } else {
                return Container();
              }
            }

        ),
      ),
      bottomSheet:  Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade700,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      controller: chatMessageController,
                      style: const TextStyle(color:Colors.grey),
                      decoration:const InputDecoration(
                          hintText: 'Type Message',
                          hintStyle: TextStyle(color:Colors.grey),
                          border: InputBorder.none
                      ),

                      onChanged: (value){
                        if(value.isNotEmpty){

                          setState(() {
                            _send=true;
                          });

                        }else{


                          setState(() {
                            _send=false;
                          });

                        }
                      },

                      onSubmitted: (value){
                        //u can send message by pressing enter
                        if(value.length>0){
                          sendMessage(_advertsProvider);
                        }
                      },


                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child:IconButton(
                        onPressed: () {
                          sendMessage(_advertsProvider);
                        }, icon:const Icon(Icons.send,color:Colors.deepOrangeAccent),

                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),

      ),
    );
  }



}


