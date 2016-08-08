import 'package:angular2/core.dart';

import 'column_settings.dart';
import 'sort_order.dart';

@Injectable()
class SortService {
  List<ColumnSettings> sortColumnSettings;

  final Map<String, SortOrder> appliedSorters;

  SortService()
      : appliedSorters = new Map<String, SortOrder>() {}

  void init(List<ColumnSettings> sortColumnSettings) {
    this.sortColumnSettings = sortColumnSettings;

    for (var sortColumnSetting in sortColumnSettings) {
      appliedSorters[sortColumnSetting.name] = SortOrder.none;
    }
  }

  void toggleSort(String columnName) {
    int index = appliedSorters[columnName].index;
    int newIndex = (index + 1) % 3;

    appliedSorters[columnName] = SortOrder.values[newIndex];
  }

  void applySort(List rows) {
    rows.sort(compare);
  }

  int compare(a, b) {
    var compare = 0;
    var power = 10 ^ appliedSorters.length;
    for (var key in appliedSorters.keys) {
      var column = sortColumnSettings.firstWhere((column) =>
      column.name == key);

      var directional;
      switch (appliedSorters[key]) {
        case SortOrder.asc:
          directional = 1;
          break;
        case SortOrder.desc:
          directional = -1;
          break;
        default:
          directional = 0;
      }

      compare += directional * power * column.getValue(a).compareTo(column.getValue(b));
      power /= 10;
    }
    return compare;
  }

}
