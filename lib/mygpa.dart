
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class my_gpa extends StatefulWidget {

  List<Map>pdata;
  my_gpa({Key? key,required this.pdata}) : super(key: key);
  @override
  State<my_gpa> createState() => _my_gpaState(data:pdata);
}

class _my_gpaState extends State<my_gpa> {
  var gw=<Widget>[];
  late List<Map>data;
  _my_gpaState({required this.data});
  @override
  void initState()
  {
    super.initState();
    data.forEach((row) {
        gw.add(
         Text("Name:"+row['name']+"          CGPA:"+row['gpa'].toString()+"      Total credit:"+row['credit'].toString())
        );  
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My GPAs"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        },
        ),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: gw,
      ),
    );
  }
}
