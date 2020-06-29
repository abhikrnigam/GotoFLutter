import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MenuPreviewHome extends StatefulWidget {
  String imageUrl;
  MenuPreviewHome({this.imageUrl});
  @override
  _MenuPreviewHomeState createState() => _MenuPreviewHomeState();
}

class _MenuPreviewHomeState extends State<MenuPreviewHome> {
  String imageUrl;

  void setImageUrl(){
    imageUrl=widget.imageUrl;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setImageUrl();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage("$imageUrl"),
            ),
          ),
          Column(
            children: <Widget>[
              Spacer(flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppIcon(imageName: "images/Clock_2x.png",iconTitle: "Clock",),
                  AppIcon(imageName: "images/ibooks.png",iconTitle: "iBooks",),
                  AppIcon(imageName: "images/Mail_2x.png",iconTitle: "Mail",),
                  AppIcon(imageName: "images/news.png",iconTitle: "News",),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppIcon(imageName: "images/Phone_2x.png",iconTitle: "Phone"),
                  AppIcon(imageName: "images/Photos_2x.png",iconTitle: "Photos"),
                  AppIcon(imageName: "images/Podcast_2x.png",iconTitle: "Podcast",),
                  AppIcon(imageName: "images/Settings_2x.png",iconTitle: "Settings",),
                ],
              ),

              Spacer(flex: 9,),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.12,
                  margin: EdgeInsets.only(top: 100,bottom: 20,right: 15,left: 15),
                  decoration: BoxDecoration(
                    color: Color(0xffb8afae),
                    borderRadius: BorderRadius.circular(20)
                    ),
                  child: Container(
                    padding: EdgeInsets.only(top: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppIcon(imageName: "images/Phone_2x.png",),
                          AppIcon(imageName: "images/Settings_2x.png"),
                          AppIcon(imageName: "images/Photos_2x.png"),
                          AppIcon(imageName: "images/Mail_2x.png"),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
        ),
        ),
      );
  }
}

class AppIcon extends StatelessWidget {
  String imageName;
  String iconTitle;
  AppIcon({this.imageName,this.iconTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5,),
        height: MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.20,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image(
              fit: BoxFit.contain,
            image: AssetImage("$imageName"),
            ),
            iconTitle!=null?Padding(
              padding: const EdgeInsets.only(top:8.0),
              child:Text("$iconTitle",style: GoogleFonts.nanumGothic(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600
              ),),
            ):Container(),
          ],
        ),
    );
  }
}
