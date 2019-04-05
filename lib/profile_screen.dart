import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './models/user.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  ProfileScreen({this.username});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(username: username);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String username;
  User user;

  _ProfileScreenState({this.username});

  @override
  void initState() {
    _fetchUser();
    super.initState();
  }

  _fetchUser() async {
    await Dio().get('https://api.github.com/users/$username')
      .then((response) {
        setState(() {
          user = User.fromJson(response.data);
        });
      });
  }

  Widget _body(BuildContext context) {
    if (user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(12.0),),
            ClipRRect(
              child: Image.network(user.avatar, width: 150.0,),
              borderRadius: BorderRadius.circular(75.0),
            ),
            Padding(padding: EdgeInsets.all(12.0),),
            Text(user.name, style: TextStyle(fontSize: 24.0),),
            Padding(padding: EdgeInsets.all(12.0),),
            Text(user.bio, textAlign: TextAlign.center,),
            Card(
              margin: EdgeInsets.all(12.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Followers: ${user.followers}'),
                    Text('Following: ${user.following}'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: _body(context),
    );
  }
}

