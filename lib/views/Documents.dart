import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwssales/helper/authenticate.dart';
import 'package:cwssales/home.dart';
import 'package:cwssales/services/auth.dart';
import 'package:cwssales/views/Proposals.dart';
import 'package:cwssales/views/addlistdocument.dart';
import 'package:flutter/material.dart';
import 'postdetaildocument.dart';

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot2;
  CollectionReference collectionReference =
      Firestore.instance.collection("Document");
  Color gradientStart = Colors.blueAccent[700];
  Color gradientEnd = Colors.lightBlue[500];
  passData(DocumentSnapshot snap) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) => PostDetailDocument(
          snapshot2: snap,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot2 = datasnapshot.documents;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Documents",
            style:
                TextStyle(fontSize: 28, decoration: TextDecoration.underline),
          ),
          elevation: 5,
          backgroundColor: Colors.deepPurple[600],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProposalList()),
                );
              },
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Image.asset(
                        'images/logo.png',
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Sign Out",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(
                Icons.exit_to_app,
                size: 30,
              ),
              onTap: () {
                AuthService().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
            ),
            Divider(
              height: 15,
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                "Demo Projects",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            Divider(
              height: 15,
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                "Proposal",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Proposals()));
              },
            ),
            Divider(
              height: 15,
              color: Colors.black,
            ),
            Container(
//              padding: new EdgeInsets.symmetric(vertical: 20.0),
//              margin: EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                      trailing: Icon(Icons.people),
//                      leading: Icon(Icons.contacts),
                      title: Text(
                        "Contact",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      title: Text(
                        "+91-7080855524\n"
                            "cs@cwsservices.co.in",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 15,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: const FractionalOffset(0.5, 0.0),
          end: const FractionalOffset(0.0, 0.5),
          stops: [0.0, 1.0],
        )),
        child: ListView.builder(
          itemCount: snapshot2.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Colors.transparent.withOpacity(0.1),
              margin: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: Text(
                        (snapshot2[index].data["title"][0]).toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              passData(snapshot2[index]);
                            },
                            child: Text(
                              snapshot2[index].data["title"],
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
