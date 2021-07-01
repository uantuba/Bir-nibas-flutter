import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'Pageone.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchTextController = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _userDetails.clear(); //removing previous data
    getUserDetails(); //updating new data

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('User Details'),
        backgroundColor: Colors.indigoAccent,
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Colors.indigoAccent,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                elevation: 8.0,
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: searchTextController,
                    decoration: new InputDecoration(
                        hintText: 'Search Here', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      searchTextController.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 ||
                searchTextController.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: new ListTile(
                    leading: new CircleAvatar(
                      backgroundImage: new NetworkImage(
                        _searchResult[i].profileUrl,
                      ),
                    ),
                    title: new Text(_searchResult[i].firstName ),
                     subtitle: new Text(_searchResult[i].lastName),
                  ),
                );
              },
            )
                : new ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: new ListTile(
                      leading: new CircleAvatar(
                        backgroundImage: new NetworkImage(
                          _userDetails[index].profileUrl,
                        ),
                      ),
                      title: new Text(_userDetails[index].firstName),
                       subtitle: new Text ( _userDetails[index].lastName),
                     onTap: (){
                        Route route =
                            MaterialPageRoute(builder: (context)=> Pageone());
                        Navigator.push(context, route);
                     },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.firstName.toLowerCase().contains(text) ||
          userDetail.lastName.toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://jsonplaceholder.typicode.com/users';

class UserDetails {
  final int id;
  final String firstName, lastName, profileUrl;

  UserDetails(
      {this.id,
        this.firstName,
        this.lastName,
        this.profileUrl =
        'http://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png'});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      firstName: json['username'],
      lastName: json['email'],
    );
  }
}
