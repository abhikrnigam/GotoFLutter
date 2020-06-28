import 'dart:async';

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:shake/shake.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:permission_handler/permission_handler.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  final controller=PageController(initialPage: 1);
  var _apiKey="poQ_WjtiPkvuKyPlMtnBDVwGew_yHTRHfNCwR6tkixU";
  int page=1;

  Future getImages() async{
    http.Response response=await http.get("https://api.unsplash.com/photos?page=$page&client_id=$_apiKey");
    List responseData=jsonDecode(response.body);
    return responseData;

  }



  void _onImagDownloadButtonPressed(String url) async {
    var filePath;

    try {
      var response = await http.get('$url');
      filePath =
      await ImagePickerSaver.saveFile(fileData: response.bodyBytes).then((
          value) =>
      {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Image Saved to Gallery", style: GoogleFonts.poppins(
            color: Colors.white,
          ),),))
      });
    }catch(e){
      print(e);
    }

  }





  void shakeEffect(){
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
     setState(() {
       print("Shaked");
       page++;
     });
    });
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
   shakeEffect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder:(context)
          {
            return Container(
      child: Stack(
      children:<Widget>[
      FutureBuilder(
      future: getImages(),
      builder: (context,snapshot){
      if(!snapshot.hasData){
      return Center(
      child: CircularProgressIndicator(backgroundColor: Colors.white,),
      );
      }
      else{
      List imageLinks=[];
      List owners=[];
      for(int i=0;i<10;i++){
      imageLinks.add(snapshot.data[i]["urls"]["regular"]);
      owners.add(snapshot.data[i]["user"]["name"]);
      }
      return PageView.builder(
      controller: controller,
      itemCount: imageLinks.length,
      itemBuilder: (context,index){
      return Stack(
      children: <Widget>[
      GestureDetector(
        child: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        child: Image(
        fit: BoxFit.cover,
        image: NetworkImage("${imageLinks[index]}"),
        ),
        ),
        onDoubleTap: (){
          _onImagDownloadButtonPressed(imageLinks[index]);
        },
      ),
      Align(
      alignment: Alignment.topLeft,
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical:50.0,horizontal: 20.0),
      child: Container(
      decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
      "${owners[index]}",style: GoogleFonts.poppins(
      color: Colors.white
      ),
      ),
      ),
      ),
      ),
      ),

      ],
      );
      });
      }
      },
      ),
      ],
      ),
      );
      },
      ),
    );
  }
}
