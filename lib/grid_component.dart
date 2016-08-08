import 'dart:async';
import 'dart:math';

import 'package:angular2/core.dart';

import 'user.dart';
import 'filter_service.dart';
import 'column_settings.dart';

@Component(
    selector: 'i-grid',
    templateUrl: 'grid_component.html',
    styleUrls: const ['grid_component.css']
  )
class GridComponent implements OnInit{
  final FilterService _filterService;
  final appliedSorters = new Map<String, int>();

  List rows;

  @Input()
  List<ColumnSettings> columnSettings;

  GridComponent(this._filterService);

  void onSort(ColumnSettings<User> column) {
    var direction = appliedSorters[column.name];

    if(direction == null) appliedSorters[column.name] = 1;
    if(direction == -1) appliedSorters.remove(column.name);
    if(direction == 1) appliedSorters[column.name] = -1;

    rows.sort(_compare);
  }

  int _compare(a, b) {
    var compare = 0;
    var power = pow(10, appliedSorters.length);

    for (var colName in appliedSorters.keys) {
      var column = columnSettings.firstWhere((column) => column.name == colName);
      var direction = appliedSorters[colName];

      compare += direction * power * column.getValue(a).compareTo(column.getValue(b));

      power ~/= 10;
    }
    return compare;
  }

  Future<List> ngOnInit() async {
    rows = await _filterService.getUsers();
  }
}