import 'package:flutter/material.dart';

class Pageone extends StatefulWidget{
  _PageoneState createState() => _PageoneState();
}
class _PageoneState extends State<Pageone>{
  TextEditingController nameController = TextEditingController();
  TextEditingController nameControllersec = TextEditingController();
  TextEditingController nameControllerlast = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Form'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Firstname',
                      hintText: 'Enter Firstname',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: nameControllersec,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Lastname',
                      hintText: 'Enter Lastname',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: nameControllerlast,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Userame',
                      hintText: 'Enter Username',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Save'),
                  onPressed: (){
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Alert Message"),
                          // Retrieve the text which the user has entered by
                          // using the TextEditingController.
                          content: Text(nameControllerlast.text),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            )
        )
    );
  }
}