import 'dart:async';
import 'dart:ui';

import 'package:amiblocked/data/blocked.dart';
import 'package:amiblocked/view/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

const httpSuccess = 200;
const emptyResponse = 'null';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Am I blocked?',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        accentColor: Colors.tealAccent,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: "Am I blocked?",
      ),
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
  Timer _debounce;
  BlockedResult _response;
  String _searchString;

  void _onSearchChanged(String input) {
    input = input.trim();
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }
    if (input.isNotEmpty) {
      _debounce = Timer(const Duration(milliseconds: 400), () async {
        final response = await post("/api/v1/find", body: {"search": input});
        final result = parseResult(
            response.statusCode == httpSuccess ? response.body : emptyResponse);
        setState(() {
          _response = result;
          _searchString = input;
        });
      });
    }
    setState(() {
      _response = null;
      _searchString = input;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Figure out whether or not you are blocked by me!",
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Search for your username or Discord ID:',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Container(
                      width: 512.0,
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        autofocus: true,
                        onChanged: _onSearchChanged,
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Username or Discord ID',
                        ),
                      ),
                    ),
                    ResultCards(
                      result: _response,
                      search: _searchString,
                      searching: _debounce?.isActive ?? false,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
