import 'dart:async';

import 'package:angular2/core.dart';
import 'filter_column_settings.dart';

@Injectable()
class FilterService {
  List rows;
  List filteredRows;
  List<FilterColumnSettings> filterColumnSettings;

  final Map<String, List> appliedFilters;

  FilterService()
    : appliedFilters = new Map<String, List>(){}

  Future init(Future<List> input, List<FilterColumnSettings> filterColumnSettings) async {
    rows = await input;
    filteredRows = await input;

    this.filterColumnSettings = filterColumnSettings;

    for (var filterColumnSetting in filterColumnSettings)
    {
      appliedFilters[filterColumnSetting.name] = new List();
    }
  }

  void toggleFilter(bool checked, String columnName, value)  {
    var checkedValues = appliedFilters[columnName];

    checked ? checkedValues.remove(value) : checkedValues.add(value);
    appliedFilters[columnName] = checkedValues;

    _applyFilters();
  }

  void _applyFilters(){
    var query = rows;
    for (var key in appliedFilters.keys)
    {
      var column = filterColumnSettings.firstWhere((column) => column.name == key);
      for (var value in appliedFilters[key])
      {
        print(value);
        query = query.where((i) => column.filter(i, value));
      }
    }
    filteredRows = query.toList();
    print(filteredRows.length);
  }

}
