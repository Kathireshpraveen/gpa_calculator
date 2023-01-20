import 'package:flutter/material.dart';
import 'package:gpa_calculator/database.dart';
import 'gpa_calc.dart';
import 'info.dart';
import 'mygpa.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPA CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: home_page(),
    );
  }
}

class home_page extends StatelessWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPA CALCULATOR"),
        actions: [
          IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>info()));
          },
              icon: Icon(Icons.info_outline_rounded)
          ),
        ],
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                  'images/boy.jpeg',
                   width: 150,
                   height: 150,
              ),
              Image.asset('images/girl.jpeg',
                width: 150,
                height:150,
              ),
            ],
          ),
          Flexible(
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>gpa()));
                  },
                      child: Text('GPA CALCI'),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(60),
                      ),
                  ),
                ElevatedButton(onPressed: (){},
                     child: Text('CGPA CALCI'),
                      style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(60),
                ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () async{
                  var data=await dbhelper.getdata();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>my_gpa(pdata:data)));
                },
                  child: Text('MY GPA'),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(60),
                  ),
                ),
                ElevatedButton(onPressed: (){},
                  child: Text('MY CGPA'),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(60),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



