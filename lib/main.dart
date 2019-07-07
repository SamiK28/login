import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './signupp.dart';

List<DocumentSnapshot> documents = [];
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
  String pno, pwd;
  // Future<Null> login() async {
  //   final QuerySnapshot result =
  //       await notesCollectionRef.where('phone', isEqualTo: pno).getDocuments();
  //   documents = result.documents;

  //   documents.length == 0
  //       ? show1(context)
  //       : checkpass()
  //           ? Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => New2()),
  //             )
  //           : show2(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey.shade700,
        ),
        body: Builder(
          builder: (context) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: TextField(
                      onChanged: (v) {
                        pno = v;
                        pno = '+91' + pno;
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: TextField(
                      onChanged: (v) {
                        pwd = v;
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
                        onPressed: () async {
                          final QuerySnapshot result = await notesCollectionRef
                              .where('phone', isEqualTo: pno)
                              .getDocuments();
                          documents = result.documents;

                          documents.length == 0
                              ? show1(context)
                              : checkpass()
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => New2()),
                                    )
                                  : show2(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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
            );
          },
        ));
  }

  void show1(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No such ID exists'),
      duration: Duration(seconds: 4),
    ));
  }

  void show2(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Wrong Password'),
      duration: Duration(seconds: 4),
    ));
  }

  bool checkpass() {
    print(documents[0].data);
    return documents[0].data["password"].toString() == pwd ? true : false;
  }
}

class New2 extends StatefulWidget {
  @override
  _New2State createState() => _New2State();
}

class _New2State extends State<New2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}
