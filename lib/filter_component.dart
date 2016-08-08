import 'dart:async';

import 'package:angular2/core.dart';

import 'filter_service.dart';
import 'filter_column_settings.dart';
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
  List<FilterColumnSettings> filterColumnSettings;

  List rows;
  final List<FilterLine> filterLines;
  final Map<String, List> appliedFilters;

  FilterComponent(this._filterService)
        : filterLines = new List<FilterLine>(),
          appliedFilters = new Map<String, List>();




  void toggleFilter(String lineName, FilterOption option) {
    option.checked = !option.checked;

    _updateFilterLines();
  }

  void _createFilterLines (){
    // тут бы очень помогла функция distinct, тогда это было бы оформлено в виде лямбд, но я ее не обрнаружил ;(
    for (FilterColumnSettings filterColumnSetting in filterColumnSettings) {
      var filterLine = new FilterLine(filterColumnSetting.name);
      var appliedFilter = appliedFilters[filterColumnSetting.name];

      filterLines.add(filterLine);

      for (var row in rows) {
        var value = filterColumnSetting.getValue(row);

        if (filterLine.values.any((FilterOption o) => o.value == value))
          continue;

        filterLine.values.add(new FilterOption(
            value,
            rows.where((r) => filterColumnSetting.filter(r, value)).length
            //appliedFilter != null && appliedFilter.any((f) => f == value)
        ));
      }
    }
  }

  void _updateFilterLines (){
    var f = new Map.fromIterable(filterLines,
        key: (FilterLine item) => item.name,
        value: (FilterLine item) => item.getAppliedFilters().map((FilterOption l) => l.value));
    _filterService.applyFilters(f, filterColumnSettings);

    for (FilterLine filterLine in filterLines) {
      var filterColumnSetting = filterColumnSettings.firstWhere((setting) => setting.name == filterLine.name);

      for (FilterOption option in filterLine.values) {
        var value = option.value;

        option.filtered = rows.where((r) => filterColumnSetting.filter(r, value)).length;
      }
    }
  }


  Future<List> ngOnInit() async {
    rows = await _filterService.getUsers();

    _createFilterLines();
  }
}
