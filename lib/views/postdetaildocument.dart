import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailDocument extends StatefulWidget {
  final DocumentSnapshot snapshot2;
  PostDetailDocument({this.snapshot2});
  @override
  _PostDetailDocumentState createState() => _PostDetailDocumentState();
}

class _PostDetailDocumentState extends State<PostDetailDocument> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(fontSize: 38, decoration: TextDecoration.underline),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Card(
        color: Colors.white,
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    child: Text(
                      (widget.snapshot2.data["title"][0]).toUpperCase(),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    (widget.snapshot2.data["title"]).toUpperCase(),
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.all(5),
                height: 30,
                child: Text(
                  "Link of project:- \n",
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: MaterialButton(
                highlightColor: Colors.blue,
                color: Colors.deepPurple,
                padding: EdgeInsets.all(10.0),
                elevation: 8,
                highlightElevation: 2,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  if (await canLaunch(widget.snapshot2.data["link"])) {
                    await launch(widget.snapshot2.data["link"]);
                  }
                },
                child: Text(
                  "Link",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.all(5),
                height: 35,
                child: Text(
                  "Description of project:- \n",
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                )),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.all(7),
              child: Text(
                widget.snapshot2.data["desc"],
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
