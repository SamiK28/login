import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';

Firestore db = Firestore.instance;
CollectionReference notesCollectionRef = db.collection('users');

class New extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  String name, no, pass, cpass, wel = 'Welcome', verificationId, smsCode;
  bool check = false, smscheck = false, uc = false;

  Future<Null> verify() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context);
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
      print('verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: no,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 3),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                  signIn();
                },
              )
            ],
          );
        });
  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    //final AuthCredential credential = PhoneAuthProvider.getCredential( verificationId: verificationId, smsCode: smsCode, );
    final FirebaseUser user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser currentUser =
        await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        smscheck = true;
      });
    });
  }

  Future<Null> store(BuildContext context) async {
    final QuerySnapshot result =
        await notesCollectionRef.where('phone', isEqualTo: no).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;

    if (documents.length == 0) {
      notesCollectionRef
          .document()
          .setData({'phone': no, 'name': name, 'password': pass});
    } else {
      wel = 'user exists';
      uc = true;
    }
  }

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
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: TextField(
                  onChanged: (v) {
                    name = v;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    hintText: "Enter Your Name",
                    labelText: "Name",
                  ),
                  // obscureText: true,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  onChanged: (v) {
                    no = v;
                    no = '+91' + no;
                  },
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    hintText: "Enter Phone Number",
                    labelText: "Phone Number",
                  ),
                  // obscureText: true,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: TextField(
                  onChanged: (v) {
                    pass = v;
                  },
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    hintText: "Enter Password",
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: TextField(
                  onChanged: (v) {
                    check = pass == v ? true : false;
                    cpass = v;
                  },
                  decoration: InputDecoration(

                      //border: OutlineInputBorder(),
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      errorText:
                          !check ? 'Please enter the correct password!' : null),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 120,
                      child: RaisedButton(
                        onPressed: () async {
                          if (cpass == pass && smscheck) {
                            store(context);
                            uc
                                ? await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: Icon(Icons.warning),
                                        content: Text("User Already Exists",textAlign: TextAlign.center,),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.pop(context);
                                              
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Navigator.pop(context);
                                
                            
                          }
                        },
                        child: Text('Submit'),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: smscheck ? Text('Veriied') : Text('Verify Phone Number'),
        onPressed: () {
          smscheck ? null : verify();
        },
        icon: smscheck ? Icon(Icons.verified_user) : Icon(Icons.sim_card_alert),
      ),
    );
  }
}
