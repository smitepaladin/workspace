import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("URL Launcer"),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            String urlLocation = "www.naver.com";
            launchURL(urlLocation);
          },
          child: Text(
            "Naver Link",
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
              decoration : TextDecoration.underline,
              decorationColor: Colors.blue
            ),
          ),
        ),
      ),
    );
  }// build

  // -- functions --
  launchURL(urlLocation)async{
    Uri url = Uri.parse("http://$urlLocation");
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }else{
      throw 'Could not launch $url';
    }
  }

}//class