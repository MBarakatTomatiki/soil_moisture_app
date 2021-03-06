/*
* Plant Class
* This class contains the 24 hr values of moisture of a plant in any day
*/
class Plant {
  // * Plant name
  String _label = 'Plant';

  // * List containing the values of moisture for every hour
  List<num> _values;

  // * Moisture of last hour/ latest hour
  num _latestVal;

  // * Unit to be displayed alongside the value
  final String _unit = '%';

  // * Moisture percentage above which the plant is assumed to have sufficient moisture
  final double _moreThanNormal = 0.75;
  // * Moisture percentage below which the plant is assumed to have low moisture
  final double _critMoisture = 0.35;

  // * Determines if 'this' plant (or any given moisture value) is low or not
  bool isCritical([double check]) {
    check = check ?? this.getLastValue;
    return (check <= _critMoisture);
  }

  // * Determines if 'this' plant (or any given moisture value) is sufficient or not
  bool isMoreThanNormal([double check]) {
    check = check ?? this.getLastValue;
    return (check >= _moreThanNormal);
  }

  Plant(this._values);

  // * Creates object with all values given(used in fetching total data)
  Plant.createElement(this._label, this._values);

  // * Creates object with only the latest value given(used in fetching current data)
  Plant.createLatest(this._label, this._latestVal);

  String get getLabel => _label;
  List<num> get getAllValues => _values;
  num get getLastValue => (this._values == null) ? _latestVal : _values.last;
  String get getUnit => this._unit;
}
