import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './profile_screen.dart';
import './models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users;

  @override
  void initState() {
    _fetchUsers();
    super.initState();
  }

  _fetchUsers() async {
    await Dio().get('https://api.github.com/users')
      .then((response) {
        setState(() {
          users = response.data.map<User>((json) => User.fromJson(json)).toList();
        });
      })
      .catchError((error) {
        print(error.response.data);
      });
  }

  Widget _body(BuildContext context) {
    if (users == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, i) {
        return UserTile(user: users[i]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub App'),
      ),
      body: _body(context),
    );
  }
}

class UserTile extends StatelessWidget {
  final User user;

  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        child: Image.network(user.avatar, width: 36.0,),
        borderRadius: BorderRadius.circular(24.0),
      ),
      title: Text(user.username),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(username: user.username,))
        );
      },
    );
  }
}
