import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const platform = const MethodChannel('flutter.ios.functions/logout');

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Home Screen"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("Warning"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                platform.invokeMethod("logout");
                              },
                              child: const Text('Are you sure you want to logout?',
                              style: TextStyle(
                                color: Colors.blue
                              ),),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            )
                          ],
                        );
                      }
                  );
                },
              )
            ],
          ),
          body: Container(),
        )
    );
  }
}