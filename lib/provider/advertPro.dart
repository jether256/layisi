import 'package:flutter/material.dart';


class AdvertsProvider with ChangeNotifier{


  late String ID;
  late String UserID;
  late String CatID;
  late String SUbID;
  late String Image;
  late String Image1;
  late String Image2;
  late String Image3;
  late String Image4;
  late String Random;
  late String Name;
  late String Phone;
  late String Brand;
  late String Type;
  late String Year;
  late String Price;
  late String Fuel;
  late String Trans;
  late String Km;
  late String Owners;
  late String Title;
  late String Bed;
  late String Bath;
  late String Fun;
  late String Con;
  late String Sq;
  late String Carpet;
  late String Flo;
  late String Crip;
  late String Adu;
  late String Lon;
  late String Lat;
  late String Noti;
  late String ADS;
  late String Date;


  getselectedAdvert(id,userid,catid,subid,image,image1,image2,
      image3,image4,random,name,phone,brand,type,year,price,
      fuel,trans,km,owner,title,bed,bath,fun,con,sq,carpet,flo,crip,adu,lon,lat,noti,ads,date){
    ID=id;
    UserID=userid;
    CatID=catid;
    SUbID=subid;
    Image=image;
    Image1=image1;
    Image2=image2;
    Image3=image3;
    Image4=image4;
    Random=random;
    Name=name;
    Phone=phone;
    Brand=brand;
    Type=type;
    Year=year;
    Price=price;
    Fuel=fuel;
    Trans=trans;
    Km=km;
    Owners=owner;
    Title=title;
    Bed=bed;
    Bath=bath;
    Fun=fun;
    Con=con;
    Sq=sq;
    Carpet=carpet;
    Flo=flo;
    Crip=crip;
    Adu=adu;
    Lon=lon;
    Lat=lat;
    ADS=ads;
    Date=date;
    notifyListeners();
  }

}