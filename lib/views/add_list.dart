import 'package:cwssales/helper/helperfunctions.dart';
import 'package:cwssales/home.dart';
import 'package:cwssales/services/db2.dart';
import 'package:cwssales/widgets/widget.dart';
import 'package:flutter/material.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  TextEditingController titleEditingController = new TextEditingController();
  TextEditingController linkEditingController = new TextEditingController();
  TextEditingController descEditingController = new TextEditingController();
  DbMethod dbMethods = new DbMethod();
  Color gradientStart = Colors.lightBlue[700];
  Color gradientEnd = Colors.blueAccent;
  dataInput() async {
    Map<String, dynamic> inputDataMap = {
      "desc": descEditingController.text,
      "link": linkEditingController.text,
      "title": titleEditingController.text
    };
    dbMethods.inputDataInfo(inputDataMap);
    HelperFunctions.saveUserNameSharedPreference(titleEditingController.text);
    HelperFunctions.saveUserEmailSharedPreference(linkEditingController.text);
    HelperFunctions.saveUserNameSharedPreference(descEditingController.text);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
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
                TextFormField(
                  style: simpleTextStyle(),
                  controller: linkEditingController,
                  decoration: InputDecoration(
                    hintText: "Link of project",
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
                  onTap: (){
                    if(descEditingController.text== "" || titleEditingController.text=="" || linkEditingController.text=="" ){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Input at least one field"),
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
                          context, MaterialPageRoute(builder: (context) => Home()));
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
