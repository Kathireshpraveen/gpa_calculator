import 'package:flutter/material.dart';
import 'database.dart';
class cgpa_calc extends StatefulWidget {
  const cgpa_calc({Key? key}) : super(key: key);

  @override
  State<cgpa_calc> createState() => _cgpa_calcState();
}

class _cgpa_calcState extends State<cgpa_calc> {
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
    );
  }
}

