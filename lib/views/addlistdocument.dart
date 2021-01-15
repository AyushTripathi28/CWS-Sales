import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cwssales/helper/helperfunctions.dart';
import 'package:cwssales/services/db4document.dart';
import 'package:cwssales/views/Documents.dart';
import 'package:cwssales/widgets/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddProposalList extends StatefulWidget {
  @override
  _AddProposalListState createState() => _AddProposalListState();
}

class _AddProposalListState extends State<AddProposalList> {
  File _image;
  String link;
  TextEditingController titleEditingController = new TextEditingController();
  TextEditingController linkEditingController = new TextEditingController();
  TextEditingController descEditingController = new TextEditingController();
  DbDocument dbMethod = new DbDocument();
  Color gradientStart = Colors.lightBlue[700];
  Color gradientEnd = Colors.blueAccent;

  dataInput() async {
    Map<String, dynamic> inputDataMap = {
      "desc": descEditingController.text,
      "link": link,
      "title": titleEditingController.text
    };
    dbMethod.inputDataInfo(inputDataMap);
    HelperFunctions.saveUserNameSharedPreference(titleEditingController.text);
    HelperFunctions.saveUserEmailSharedPreference(link);
    HelperFunctions.saveUserNameSharedPreference(descEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    //---------------------------------------doc upload-----------------
    Future getImage() async {
//      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      File file = await FilePicker.getFile();
      setState(() {
        _image = file;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      final String url = await firebaseStorageRef.getDownloadURL();
      link=url;
      setState(() {
        print(link);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(link)));
      });
    }
    //-----------------------------------------------------------------

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Input new list",
          style: TextStyle(fontSize: 38, decoration: TextDecoration.underline),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0, 1.0],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: titleEditingController,
                  style: simpleTextStyle(),
                  decoration: InputDecoration(
                    hintText: "Title of project",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
//                TextFormField(
//                  style: simpleTextStyle(),
//                  controller: linkEditingController,
//                  decoration: InputDecoration(
//                    hintText: "Link of project",
//                    enabledBorder: OutlineInputBorder(
//                      borderSide: BorderSide(color: Colors.white38, width: 2),
//                    ),
//                    focusedBorder: OutlineInputBorder(
//                      borderSide: BorderSide(color: Colors.white, width: 3.5),
//                    ),
//                  ),
//                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
//                        height: 60.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Color(0xff476cfb),
                            onPressed: () {
                              getImage();
                            },
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            child: Text(
                              'upload',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                          RaisedButton(
                            color: Color(0xff476cfb),
                            onPressed: () {
                              uploadPic(context);
                            },
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  style: simpleTextStyle(),
                  controller: descEditingController,
                  decoration: InputDecoration(
                    hintText: "Description of project",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if(link==null ){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("wait!!! file is uploading..."),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("OK"),
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    }
                    else{
                      if( titleEditingController.text=="" || descEditingController.text=="" ){
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Input any one detail about docs"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("OK"),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      }else{
                        dataInput();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => Documents()));
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff2A75AC),
                            const Color(0xff007C),
                            const Color(0xff2A75AC)
                          ],
                        )),
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(
                      "Add to List",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
