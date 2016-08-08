import 'dart:async';

import 'package:angular2/core.dart';

import 'filter_service.dart';
import 'column_settings.dart';
import 'filter_line.dart';
import 'filter_option.dart';

@Component(
    selector: 'i-filter',
    templateUrl: 'filter_component.html',
    styleUrls: const ['filter_component.css']
)
class FilterComponent implements OnInit {
  final FilterService _filterService;

  @Input()
  List<ColumnSettings> filterColumnSettings;

  List rows;
  final filterLines = new List<FilterLine>();

  FilterComponent(this._filterService);

  void toggleFilter(String lineName, FilterOption option) {
    option.checked = !option.checked;

    _updateFilterLines();
  }

  void _createFilterLines (){
    // тут бы очень помогла функция distinct, тогда это было бы оформлено в виде лямбд, но я ее не обрнаружил ;(
    for (ColumnSettings filterColumnSetting in filterColumnSettings) {
      var filterLine = new FilterLine(filterColumnSetting.name);

      filterLines.add(filterLine);

      for (var row in rows) {
        var value = filterColumnSetting.getValue(row);

        if (filterLine.values.any((FilterOption o) => o.value == value))
          continue;

        filterLine.values.add(new FilterOption(
            value,
            rows.where((r) => filterColumnSetting.getValue(r) == value).length
        ));
      }
    }
  }

  void _updateFilterLines (){
    var f = new Map<String, List>.fromIterable(filterLines,
        key: (FilterLine item) => item.name,
        value: (FilterLine item) => item.getAppliedFilters().map((FilterOption l) => l.value).toList());
    _filterService.applyFilters(f, filterColumnSettings);

    for (FilterLine filterLine in filterLines) {
      var filterColumnSetting = filterColumnSettings.firstWhere((setting) => setting.name == filterLine.name);

      for (FilterOption option in filterLine.values) {
        var value = option.value;

        option.filtered = rows.where((r) => filterColumnSetting.getValue(r) == value).length;
      }
    }
  }


  Future<List> ngOnInit() async {
    rows = await _filterService.getUsers();

    _createFilterLines();
  }
}
