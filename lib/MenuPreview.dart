import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MenuPreview extends StatefulWidget {
  String imageUrl;
  MenuPreview({this.imageUrl});
  @override
  _MenuPreviewState createState() => _MenuPreviewState();
}

class _MenuPreviewState extends State<MenuPreview> {

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(imageUrl,fit: BoxFit.cover,),
            ),
            Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Align(
                      alignment:Alignment.center,
                      child: Text("6:40",style: GoogleFonts.nanumGothic(
                        color: Colors.white,
                        fontSize: 70,
                      ),),
                    ),
                  ),
                  Text("Monday,29 June",style: GoogleFonts.nanumGothic(
                    color: Colors.white,
                    fontSize: 25,
                  ),),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Text("Swipe up to unlock",style: GoogleFonts.nanumGothic(
                      color: Colors.white,
                      fontSize: 13,
                    ),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
