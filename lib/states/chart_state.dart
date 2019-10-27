import 'package:flutter/material.dart';

// * External Packages import
import 'package:provider/provider.dart';

// * Data import
import 'package:soil_moisture_app/data/all_data.dart';

// * State import
import 'package:soil_moisture_app/states/selected_card_state.dart';

class ChartState with ChangeNotifier {
  dynamic chart;
  String measure;
  ChartState() {
    this.measure = 'Moisture';
  }
  dynamic get getChart => this.chart;
  dynamic get getMeasure => this.measure;
  changeChart(BuildContext context, String newMeasure) {
    this.measure = newMeasure;
    switch (this.measure) {
      case 'Humidity':
        chart = dayHumid;
        break;
      case 'Light':
        chart = dayLight;
        break;
      case 'Temperature':
        chart = dayTemp;
        break;
      case 'Moisture':
        chart = plantList[Provider.of<SelectedCardState>(context).selCard];
    }
    notifyListeners();
  }
}
