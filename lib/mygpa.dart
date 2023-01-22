import 'database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class my_gpa extends StatefulWidget {
  my_gpa({Key? key}) : super(key: key);
  @override
  State<my_gpa> createState() => _my_gpaState();
}

class _my_gpaState extends State<my_gpa> {
  var gw=<Widget>[];
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  Future<List<Widget>> getdata() async
  {
    gw=[];
    int no=1;
    var data=await dbhelper.getdata();
    data.forEach((row) {
      gw.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(" "),
              Text(no.toString()+".  "+row['name'],
                style: TextStyle(
                  fontSize:20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("   Credit : "+row['credit'].toString(),

                  ),
                  SizedBox(
                    width: 260,
                  ),
                  TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: Text(" EDIT ")),
                ],
              ),
              Row(
                children: [
                  Text("   GPA : "+row['gpa'].toStringAsFixed(3)),
                  SizedBox(
                    width: 245,
                  ),
                  TextButton(onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context)=>AlertDialog(
                      title: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    content:Text("Are you Sure?"),
                    actions: [
                      TextButton(onPressed: (){
                          Navigator.pop(context);
                      }, child: Text("NO")),
                      TextButton(onPressed: ()async
                      {
                        Navigator.pop(context);
                        await dbhelper.delete(row['id']);
                          getdata().then((result) {
                            setState(() {
                              gw=result;
                            });
                        });
                      },
                          child: Text("YES")),
                    ],
                    )
                    );
                  }
                  ,style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  ),

                  child: Text("REMOVE")),
                  ],
                  ),
                  Row(
                  children: [
                  Text(" "),
                  SizedBox(
                  width: 200,
                  ),
                  TextButton(onPressed: (
                  ){},style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                      child: Text("ADD TO CGPA CALCULATION"),

                    ),
                  ]
              ),

            ],
          )
      );
      gw.add(
        Padding(
          padding:EdgeInsets.symmetric(horizontal:1.0),
          child:Container(
            height:1.0,
            width:1600.0,
            color:Colors.black12,
          ),
        ),
      );
      no++;

    }
    );
    return gw;
  }
  @override
  void initState()
  {
    super.initState();
    getdata().then((result) {
      setState(() {
        gw=result;
      });
    });
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
        actions: [
          IconButton(onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context)=>AlertDialog(
                title: Text(
                  "New Item",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                content:Container(
                  height: 150,
                  child: Column(
                  children: [
                    TextField(
                      controller: t1,
                      decoration: InputDecoration(
                          hintText: 'Name:',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: t2,
                      decoration: InputDecoration(
                          hintText: 'Credits:',
                          floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                    ),
                    TextField(
                      controller: t3,
                      decoration: InputDecoration(
                          hintText: 'GPA:',
                          floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                    ),
                  ],
              ),
                ),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("CANCEL")),
                TextButton(onPressed: () async {
                  Navigator.pop(context);
                  await dbhelper.instance.add(name_gpa(t1.text,double.parse(t3.text),int.parse(t2.text)));
                  getdata().then((result) {
                    setState(() {
                      gw=result;
                    });
                  });

                }, child: Text("Add")),
              ],
              ),
            );
          },
              icon: Icon(Icons.add)
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: gw,
        ),
      ),
    );
  }
}
