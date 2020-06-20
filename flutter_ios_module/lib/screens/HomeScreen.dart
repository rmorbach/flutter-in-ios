import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = const MethodChannel('flutter.ios.functions/login');
  String _username = "";

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((MethodCall methodCall) {
      print("#### method called ${methodCall.method} arguments: ${methodCall.arguments} #### ");
        switch (methodCall.method) {
          case "setUsername":
            setState(() {
              _username = methodCall.arguments;
            });
            break;
          default: break;
        }
        return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_username == null || _username.isEmpty) {
      _getUsername();
    }
    return Container(
        color: Colors.blue,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Home Screen"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("Warning"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await platform.invokeMethod("logout");
                                setState(() {
                                  _username = "";
                                });
                              },
                              child: const Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            )
                          ],
                        );
                      });
                },
              )
            ],
          ),
          body: Center(
            child: Container(
              child: getGreetingsWidget(),
            ),
          ),
        ));
  }

  _getUsername() {
    platform.invokeMethod("getUsername").then((result) {
      if (result == null) {
        return;
      }
      setState(() {
        _username = result;
      });
    }).catchError((error) {
      print("Error in flutter $error");
    });
  }

  Widget getGreetingsWidget() {
    if (_username.trim().isEmpty) {
      return Container();
    }
    return Text(
      "Welcome $_username",
      style: TextStyle(fontSize: 20, color: Colors.black),
    );
  }
}
