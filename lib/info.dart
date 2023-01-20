import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class info extends StatelessWidget {
  const info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      openwhatsapp() async{
      var whatsapp ="+917200238871";
      var whatsappURl_android =Uri.parse("whatsapp://send?phone="+whatsapp+"&text= ");
      if( await canLaunchUrl(whatsappURl_android)) {
        await launchUrl(whatsappURl_android);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));

      }
    }
    launchmsg() async
    {
      var url=Uri.parse('sms:+91 7200238871?body=');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    launchCaller() async {
        var url = Uri.parse("tel:+917200238871");
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image.asset('images/appleicon.webp'
              ),
              ],
            ),

          Column(
            children: [
              Text("GPA Calculator",
                style:TextStyle(
                  fontSize:22,
                  color: Colors.red,
                ),
            ),
          Text("version 2.0",
            style: TextStyle(
              fontSize:18,
              color: Colors.red,
            ),
          ),
            ],
          ),
          Text("GPA calculator was created to help engineering students calculate their GPA(Grade Point Average) and CGPA(Cumulative Grade Point Average).\n Is Calculating your college GPA and CGPA troublesome?...Not sure if your calculation was right?...Want to double check your CGPA before filling out an important application?...No longer do you have to wait to receive your report card to be sure... Try our app to ease your calculations and store the results for future reference.",
            style: TextStyle(
              fontSize:18,
            ),
          ),
          Row(
            children: [
              Text("Contacts:  ",
              style:TextStyle(
                fontSize:18,
              ),
              ),
              IconButton(onPressed: () async{
                await openwhatsapp();
              }, icon: Icon(Icons.whatsapp_sharp,color: Colors.green,)),
              IconButton(onPressed: () async{
               await launchCaller();
              },
                  icon: Icon(Icons.contact_page_sharp,color: Colors.blue,)),
              IconButton(onPressed: ()
              async {
                await launchmsg();
              }, icon: Icon(Icons.message_sharp,color: Colors.blue,)),
            ],
          ),
        ],
      ),
    );
  }
}
