import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwssales/helper/authenticate.dart';
import 'package:cwssales/views/Documents.dart';
import 'package:cwssales/views/Proposals.dart';
import 'package:cwssales/views/add_list.dart';
import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'views/PostDetailsPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: cancel_subscriptions
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("List");

  Color gradientStart = Colors.blueAccent[700];
  Color gradientEnd = Colors.lightBlue[500];

  passData(DocumentSnapshot snap) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) => PostDetails(
          snapshot: snap,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Project",
            style:
                TextStyle(fontSize: 25, decoration: TextDecoration.underline),
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
                  MaterialPageRoute(builder: (context) => AddList()),
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
                "Proposals",
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
            ListTile(
              title: Text(
                "Documents",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Documents()));
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
          itemCount: snapshot.length,
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
                        (snapshot[index].data["title"][0]).toUpperCase(),
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
                              passData(snapshot[index]);
                            },
                            child: Text(
                              snapshot[index].data["title"],
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
