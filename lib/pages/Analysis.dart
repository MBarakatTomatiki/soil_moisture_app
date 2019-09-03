import 'package:flutter/material.dart';
import 'package:soil_moisture_app/ui/colors.dart';
import 'dart:math' as math;

import 'package:soil_moisture_app/ui/plant_tile.dart'; //! Remove this when refresh implemented

var rnd = math.Random(69); //! Remove this when refresh implemented

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int _counter = 0;
  int count = 11; //* Dummy count, remove when implemented
  // * Dummy pull to refresh implemented, remove when done
  Future<void> dummyWait() {
    return Future.delayed(Duration(seconds: 4), null);
  }

  Future<Null> _refresh() {
    return dummyWait().then((_) {
      setState(() => _counter = rnd.nextInt(101));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              children: [
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            '$_counter%',
                            style: Theme.of(context).textTheme.display3,
                          ),
                        ),
                        Text(
                          'Today',
                          style: Theme.of(context).textTheme.body2,
                        ),
                        Spacer(),
                        Text(
                          'Weather',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Card(
                        child: Container(
                          child: Placeholder(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: null,
                        ),
                        Text(
                          'Sun, 1 Sep',
                          style: Theme.of(context).textTheme.body2.copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: null,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: count,
                  itemBuilder: (context, count) {
                    return PlantTile(
                      label: 'Plant $count',
                      percent: (_counter == 0)
                          ? 0.15
                          : rnd.nextInt(_counter) /
                              _counter, //* dummy values, remove when implemented
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
