import 'package:angular2/core.dart';

import 'sort_column_settings.dart';
import 'sort_order.dart';

@Injectable()
class SortService {
  List<SortColumnSettings> sortColumnSettings;

  final Map<String, SortOrder> appliedSorters;

  SortService()
      : appliedSorters = new Map<String, SortOrder>() {}

  void init(List<SortColumnSettings> sortColumnSettings) {
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
    for (var key in appliedSorters.keys) {
      var column = sortColumnSettings.firstWhere((column) =>
        column.name == key);

      SortOrder sortOrder = appliedSorters[key];
      if(sortOrder != SortOrder.none)
        sortOrder == SortOrder.asc ? rows.sort(column.compareAsc) : rows.sort(column.compareDesc);
    }
    //if(compare != null)
  }

}
