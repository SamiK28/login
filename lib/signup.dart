import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController phonecontroller = new TextEditingController();
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: phonecontroller,
            onSubmitted: (text){
              check=text.length!=10?true:false;
              return null;
            },

            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone, color: Colors.grey),
              hintText: '9810903862',
              labelText: 'Phone Number',
              errorText: check?'Invalid':null,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
          ),
        ),
      ),
    );
  }

  validate(String text) {
    return text.length!=10?'Inavild':null;
  }
}
