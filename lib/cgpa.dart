import 'dart:ui';

import 'package:flutter/material.dart';
import 'database.dart';
class cgpa_calc extends StatefulWidget {
  const cgpa_calc({Key? key}) : super(key: key);

  @override
  State<cgpa_calc> createState() => _cgpa_calcState();
}

class _cgpa_calcState extends State<cgpa_calc> {
  List<String> no_s=['0','1','2','3','4','5','6','7','8','9','10','11','12'];
  List<TextEditingController>tcg= [];
  List<TextEditingController>tcc= [];
  String ns="0";
  List<Widget>sc=[];
  void reset()
  {
    sc=[];
      for(var i=1;i<=int.parse(ns);i++)
      {
        tcg.add(TextEditingController());
        tcc.add(TextEditingController());
        sc.add(
            const SizedBox.square(
              dimension: 20,
            ));
        sc.add(
            Container(
              height: 100,
              width: (WidgetsBinding.instance.window.physicalSize.width*0.27),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red,
                    width: 5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0))
              ),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  Text(i.toString()),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextField(
                      controller: tcg[i-1],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'GPA:',
                          floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextField(
                      controller: tcc[i-1],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Credit:',
                          floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      }
  }
  @override
  var options=["View GPA","View CGPA"];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "CGPA Calculation"
        ),
        actions: [
          DropdownButton<String>(
            underline: SizedBox(),
            icon: Icon(Icons.more_vert_outlined,
              color: Colors.white,
            ),
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged:(String? res) async {
                if(res=="View GPA")
                {
                  List <Widget> w=[];
                  var data=await dbhelper.getdata();
                  data.forEach((row)
                  {
                    w.add(
                      Text("\nName: "+row['name']+"\nCredits: "+row['credit'].toString()+"\nGPA: "+row['gpa'].toString())
                    );
                  }
                  );
                  showDialog(context: context, builder: (BuildContext context)=>
                      AlertDialog(
                        title: Text("MY GPAs"),
                        content: SingleChildScrollView(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: w,
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                                },
                              child: Text("CLOSE"),
                          )
                        ],
                        )
                  );
                }
            },
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const SizedBox.square(
          dimension: 20,
        ),
          Container(
            height: 50,
            width:  (WidgetsBinding.instance.window.physicalSize.width*0.3),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.red,
                  width: 5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30.0))
            ),
            child: Center(
              child: Row(
                children: [
                  Text("  Enter the number of Semsester:  ",
                    style: TextStyle(
                      fontSize:WidgetsBinding.instance.window.physicalSize.width*0.0150111111111,
                    ),
                  ),
                  Text(ns,
                    style: TextStyle(
                      fontSize:WidgetsBinding.instance.window.physicalSize.width*0.0150111111111,
                    ),
                  ),
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    items: no_s.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged:(String? res){
                      setState(() {
                        ns=res!;
                        print(ns);
                        reset();
                      });
                    },
                  ),

                ],
              ),
            ),
          ),

            Column(
                children:sc,
          ),
            const SizedBox.square(
                dimension: 20,
              ),
          ElevatedButton(onPressed:()
          {
            int c=0;
            double gp=0;
                for(int i=0;i<int.parse(ns);i++)
                {
                  gp+=double.parse(tcg[i].text)*double.parse(tcc[i].text);
                  c+=int.parse(tcc[i].text);
                }
                gp=gp/c;
                print(gp);
          },
            child: Text('CALCULATE'),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(50),
            ),
          )
          ],
        ),
      ),
    );
  }
}

