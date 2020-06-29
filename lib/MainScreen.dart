import 'dart:async';
import 'dart:io';
import 'package:gotoflutter/MenuPreviewHome.dart';
import 'package:shake/shake.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'MenuPreview.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';


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

  Widget giveLockScreenPreview(String imageUrl){
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network(imageUrl,fit: BoxFit.cover,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Airtel",style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  ),
                  Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 10,
                  ),
                  Icon(
                    Icons.battery_std,
                    size: 10,
                      color: Colors.white,
                  ),
                ],
              ),
              Text("6:40",style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 25,
              ),),
              Text("Monday,29 June",style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
              ),),
              Spacer(),
              Text("Press Home to unlock",style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
              ),),
            ],
          )
        ],
      ),
    );
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
      Container(
      height: MediaQuery.of(context).size.height,
      width:MediaQuery.of(context).size.width,
      child: Image(
      fit: BoxFit.cover,
      image: NetworkImage("${imageLinks[index]}"),
      ),
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
        Align(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${index+1}",style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(bottom: 20),
          ),
          alignment: Alignment.bottomCenter,
        ),
        Row(
          children: <Widget>[
            InkWell(
              child:
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width*0.5,
              ),
              onLongPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MenuPreview(imageUrl: imageLinks[index],)));
              },
              onDoubleTap: (){
                _onImagDownloadButtonPressed(imageLinks[index]);
              },
            ),
            InkWell(
              child:
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width*0.5,
              ),
              onLongPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MenuPreviewHome(imageUrl: imageLinks[index],)));
              },
              onDoubleTap: (){
                _onImagDownloadButtonPressed(imageLinks[index]);
              },
            ),
          ],
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
