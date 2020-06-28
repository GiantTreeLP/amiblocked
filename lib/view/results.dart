import 'package:amiblocked/data/blocked.dart';
import 'package:flutter/material.dart';

class ResultCards extends StatelessWidget {
  final BlockedResult result;
  final String search;
  final bool searching;

  ResultCards({Key key,
    @required this.result,
    @required this.search,
    @required this.searching})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (searching) {
      child = CircularProgressIndicator(
        value: null,
      );
    } else if (this.result != null) {
      if (this.result.blocked == true) {
        child = Placeholder(color: Colors.red.shade900);
      } else if (this.result.note != null) {
        child = Placeholder(color: Colors.yellow.shade900);
      } else {
        child = Placeholder(color: Colors.green.shade900);
      }
    } else if(this.search?.isNotEmpty ?? false) {
      child = Text(
        "No result for $search.",
        style: Theme.of(context).textTheme.headline5,
      );
    } else {
      child = Text(
        "Begin searching",
        style: Theme.of(context).textTheme.headline4,
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: child,
    );
  }
}
