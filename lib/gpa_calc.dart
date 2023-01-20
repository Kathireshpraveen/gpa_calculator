import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class gpa extends StatefulWidget {
  const gpa({Key? key}) : super(key: key);

  @override
  State<gpa> createState() => _gpaState();
}

class _gpaState extends State<gpa> {
  final name=TextEditingController();
  @override
  void dispose()
  {
    name.dispose();
    super.dispose();
  }
  @override
  var sc = <Widget>[];
  List<String> no_s=['0','1','2','3','4','5','6','7','8','9','10','11','12'];
  List<String>grade=['O','O','O','O','O','O','O','O','O','O','O','O'];
  List<int>credit=[0,0,0,0,0,0,0,0,0,0,0,0];
  List<String> g=['O','A+','A','B+','B','C','RA','SA'];
  var gp={'O':10,'A+':9,'A':8,'B+':7,'B':6,'C':5,'RA':0,'SA':0};
  List<String>cre=['0','1','2','3','4','5','6','7','9','10'];
  String? ns='0';
  int totalc=0;
  int i=1;
  double result=0;
  Widget build(BuildContext context) {
    void reset()
    {
      //print("call");
      sc=[];
      for(var i=1;i<=int.parse(ns!);i++)
      {
        sc.add(
            const SizedBox.square(
              dimension: 20,
            ));
        sc.add(
          Container(
            height: 60,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.red,
                  width: 5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(90.0))
            ),
            child: Center(
              child: Row(
                children: [
                  Text(" "+i.toString()+"  Credit:  "+credit[i-1].toString(),
                    style: TextStyle(
                      fontSize:22,
                    ),
                  ),
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    items: cre.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged:(String? res){
                      setState(() {
                        print(res);
                        print(credit[i-1]);
                        credit[i-1]=int.parse(res!);
                        reset();
                      });
                    },
                  ),

                  Text("   Grade: "+grade[i-1],
                    style: TextStyle(
                      fontSize:22,
                    ),
                  ),
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    items: g.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged:(String? res){
                      setState(() {
                        print(res!);
                        grade[i-1]=res;
                        reset();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text("GPA Calculation"),

      ),
      body: 
      SingleChildScrollView(
        child: Column
          (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox.square(
              dimension: 20,
            ),
            Container(
              height: 60,
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red,
                    width: 5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(90.0))
              ),
              child: Center(
                child: Row(
                  children: [
                    const Text("Enter the number of Subjects:",
                    style: TextStyle(
                      fontSize:22,
                    ),
                  ),
                    DropdownButton<String>(
                      icon: Icon(Icons.add),
                      items: no_s.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged:(String? res){
                          setState(() {
                            ns=res!;
                            reset();
                          });
                     },
                   ),
                    Text(ns!,
                      style: TextStyle(
                      fontSize:22,
                    ),
                    ),
                  ],
                ),
              ),
              ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:sc,
              ),
            ),
            const SizedBox.square(
              dimension: 30,
            ),
            ElevatedButton(onPressed: (){
              double res=0;
              int tc=0;
              for(i=0;i<int.parse(ns!);i++)
              {
                  res=res+credit[i]*gp[grade[i]]!;
                  tc=tc+credit[i];
              }
              res=res/tc;
              totalc=tc;
              result=res;
              print(res);
             showDialog(
                 context: context,
                 builder: (BuildContext context)=>AlertDialog(
                   title: Text("GPA"),
                   content: Text("Your GPA is:"+res.toString()+"\n\nTotal credit:"+tc.toString()),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context)=>AlertDialog(
                            content: TextField(
                              controller: name,
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child:Text("CANCEL"),
                              ),
                              TextButton(onPressed: () async {
                                  await dbhelper.instance.add(name_gpa(name.text,result,totalc));
                                  Navigator.pop(context);
                              }, child: Text("SAVE")),
                            ],
                          ),
                      );
                    },
                        child: Text("SAVE AND CLOSE"),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                        },
                        child: Text("CLOSE"),
                    ),
                  ],
                 ),
             );
            },
              child: Text('CALCULATE'),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
