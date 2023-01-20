
import 'package:flutter/material.dart';

class cgpa extends StatefulWidget {
  const cgpa({Key? key}) : super(key: key);

  @override
  State<cgpa> createState() => _cgpaState();
}

class _cgpaState extends State<cgpa> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text("CGPA Calculation"),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        ],
      ),
    );
  }
}
Set<Widget> first()
{
  List<String> no_s=['1','2','3','4','5','6','7','8','9','10','11','12'];
  String? ns='1';
  var sc = <Widget>[];
  return {
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
                  print(res);
                });
              },
            ),
            Text(ns!),
          ],
        ),
      ),
    ),
  };
}