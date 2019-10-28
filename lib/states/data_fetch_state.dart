import 'package:flutter/material.dart';
import 'package:soil_moisture_app/data/all_data.dart';
import 'package:soil_moisture_app/utils/date_func.dart';

// * utils import
import 'package:soil_moisture_app/utils/json_post_get.dart';

class DataState with ChangeNotifier {
  Future latestData;
  Future totalData;
  Future thresholdData;
  bool isCurrentDataGot;
  bool isTotalDataGot;
  DataState() {
    this.latestData = fetchLatestData().then((_) {
      this.isCurrentDataGot = true;
      notifyListeners();
      this.totalData = fetchTotalData().then((_) {
        this.isTotalDataGot = true;
        notifyListeners();
      }, onError: ((_) {
        this.isTotalDataGot = false;
        notifyListeners();
      }));
      this.thresholdData = fetchThresholdData();
    }, onError: (_) {
      this.isCurrentDataGot = false;
      this.isTotalDataGot = false;
      notifyListeners();
    });
  }
  Future<void> refreshLatestData() async {
    this.isCurrentDataGot = null;
    latestData = fetchLatestData();
    await latestData.then((_) {
      this.isCurrentDataGot = true;
      notifyListeners();
      if (isNow()) {
        totalData = fetchTotalData();
        notifyListeners();
      }
    }, onError: ((_) {
      this.isCurrentDataGot = false;
      if (nowPlantList != null && nowPlantList.isEmpty) {
        notifyListeners();
      }
    }));
  }

  Future<void> refreshTotalData() async {
    this.isTotalDataGot = null;
    notifyListeners();
    totalData = fetchTotalData();
    await totalData.then((_) {
      this.isTotalDataGot = true;
      notifyListeners();
      if (isNow()) {
        latestData = fetchLatestData();
        notifyListeners();
      }
    }, onError: ((_) {
      this.isTotalDataGot = false;
      if (plantList != null && plantList.isEmpty) {
        notifyListeners();
      }
    }));
  }
}
