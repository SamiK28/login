import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './signupp.dart';

void main() => runApp(MaterialApp(
      title: 'login',
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pno,pwd;


  Future<Null> login()async{
    final QuerySnapshot result =
        await notesCollectionRef.where('phone', isEqualTo: pno).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if () {
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: TextField(
                onChanged: (v){
                  pno=v;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Phone Number",
                  labelText: "Phone Number",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: TextField(
                onChanged: (v){
                  pwd=v;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Password",
                  labelText: "Password",
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: 125,
                child: OutlineButton(
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  color: Colors.white,
                  borderSide: BorderSide(color: Colors.green),
                  highlightedBorderColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  textColor: Colors.green,
                  highlightColor: Colors.grey.shade300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: 125,
                child: OutlineButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => New()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  color: Colors.white,
                  borderSide: BorderSide(color: Colors.red),
                  highlightedBorderColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  textColor: Colors.red,
                  highlightColor: Colors.grey.shade300,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
