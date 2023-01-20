
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpa_calculator/database.dart';

class mygpa extends StatelessWidget {
  const mygpa({Key? key}) : super(key: key);

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
      body:Center(
        child: FutureBuilder<List<name_gpa>>(
          future: dbhelper.instance.get(),
          builder: (BuildContext context,AsyncSnapshot<List<name_gpa>>snapshot){
           if(!snapshot.hasData)
           {
             return Center(child: Text('Loading'));
           }
           return ListView(
             children: snapshot.data!.map((name_gpa)
             {
               return Center(
               child: ListTile(
                title: Text(name_gpa.name!+name_gpa.gpa!.toString()),
               ),
               );
             },
             ).toList(),
           );
          },
        ),
      ),
    );
  }
}
