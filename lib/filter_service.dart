import 'dart:async';

import 'package:angular2/core.dart';

import 'column_settings.dart';
import 'user.dart';
import 'data_service.dart';

@Injectable()
class FilterService extends DataService{
  List<User> rows;
  List<User> filteredRows;

  Future<List<User>> getUsers() async {
    if(filteredRows == null)
      filteredRows = await super.getUsers();

    rows = new List<User>.from(filteredRows);
    return filteredRows;
  }

  void applyFilters(Map<String, List> appliedFilters, List<ColumnSettings> filterColumnSettings){
    var query = rows;

    for (var key in appliedFilters.keys)
    {

      var column = filterColumnSettings.firstWhere((column) => column.name == key);
      for (var value in appliedFilters[key])
      {
        print(value);
        query = query.where((i) => column.getValue(i) == value);
      }
    }

    filteredRows.removeWhere((User r) => !query.any((User q) => q.id == r.id));
    filteredRows.addAll(query.where((User q) => !filteredRows.any((User r) => r.id == q.id)));
  }

}
