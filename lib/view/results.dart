import 'package:amiblocked/data/blocked.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultCards extends StatelessWidget {
  final BlockedResult result;
  final String search;
  final bool searching;

  ResultCards(
      {Key key,
      @required this.result,
      @required this.search,
      @required this.searching})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (searching) {
      child = const CircularProgressIndicator(
        value: null,
      );
    } else if (this.result != null) {
      const cardConstraints = const BoxConstraints(
        minWidth: 480,
        maxWidth: 720,
        minHeight: 120,
      );
      const padding = const EdgeInsets.all(16.0);
      if (this.result.blocked == true) {
        child = Card(
          color: Colors.red.shade900,
          child: Container(
            constraints: cardConstraints,
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Found you: ${result.username} (${result.snowflake})",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "You are blocked!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Divider(),
                Text(
                  "Blocked at: ${DateFormat.yMMMMd().add_jms().format(result.blockedAt)}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                if (this.result.note.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Note attached: ",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          result.note,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                  )
                else
                  Text(
                    "No note attached!",
                    style: Theme.of(context).textTheme.headline6,
                  )
              ],
            ),
          ),
        );
      } else if (this.result.note.isNotEmpty) {
        child = Card(
          color: Colors.yellow.shade900,
          child: Container(
            constraints: cardConstraints,
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Found you: ${result.username} (${result.snowflake})",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "You are not blocked, but you have a note attached to you!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Note attached: ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        result.note,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        child = Card(
          color: Colors.green.shade900,
          child: Container(
            constraints: cardConstraints,
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "I can't find you: ${result.username} (${result.snowflake})",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Divider(),
                Text(
                  "You are not blocked and you have no note attached to you!",
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
          ),
        );
      }
    } else if (this.search?.isNotEmpty ?? false) {
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
      padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: child,
    );
  }
}
