import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // * For SystemChrome

// * external packages import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// * ui import
import 'package:soil_moisture_app/ui/build_theme.dart';
import 'package:soil_moisture_app/ui/colors.dart';

// * utils import
import 'package:soil_moisture_app/utils/displayError.dart';
import 'package:soil_moisture_app/utils/gettingJson.dart';

// * Pages Import
import 'pages/Analysis.dart';
import 'pages/Overview.dart';
import 'pages/ThresholdPump.dart';

void main() async {
  String title = 'Soif';
  runApp(MaterialApp(
    title: title,
    debugShowCheckedModeBanner: false,
    home: Home(title),
    theme: buildLightTheme(),
  ));
}

class Home extends StatefulWidget {
  final String title;
  Home(this.title);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future _totalData;

  void initState() {
    // * Makes the future(builder) run only once at startup
    _totalData = fetchTotalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _totalData,
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: appPrimaryColor,
            body: NoInternet(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return DefaultTabController(
            length: 2,
            child: Tabs(widget.title),
          );
        } else {
          return Scaffold(
            backgroundColor: appPrimaryColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class Tabs extends StatelessWidget {
  final String title;
  Tabs(this.title);

  final List<Widget> _children = [
    Overview(),
    Analysis(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, //top bar color
      systemNavigationBarColor: Colors.black, //bottom bar color

      statusBarIconBrightness: Brightness.light, //top icon color
      systemNavigationBarIconBrightness: Brightness.light, //bottom icons color
    ));
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.all(6.0),
          child: Image.asset('./assets/images/Soif_sk.png'),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.slidersH),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ThresholdPump())),
            tooltip: 'Pump Threshold Control',
          )
        ],
      ),
      body: TabBarView(
        children: _children,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: TabBar(
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.remove_red_eye),
            text: 'Overview',
          ),
          Tab(
            icon: Icon(Icons.linear_scale),
            text: 'Analysis',
          )
        ],
        labelColor: appPrimaryLightColor,
        unselectedLabelColor: appSecondaryDarkColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: appSecondaryLightColor,
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }
}
