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
  Future<List> input;
  @Input()
  List<FilterColumnSettings> filterColumnSettings;

  @Output()
  EventEmitter onFiltered = new EventEmitter();

  List rows;
  final List<FilterLine> filterLines;

  FilterComponent(this._filterService)
        : filterLines = new List<FilterLine>(){}

  void getFilterColumns() {
    filterLines.clear();

    // тут бы очень помогла функция distinct, тогда это было бы оформлено в виде лямбд, но я ее не обрнаружил ;(
    for (FilterColumnSettings filterColumnSetting in filterColumnSettings) {
      var filterLine = new FilterLine(filterColumnSetting.name);
      var appliedFilter = _filterService.appliedFilters[filterColumnSetting.name];

      filterLines.add(filterLine);

      for (var row in rows) {
        var value = filterColumnSetting.getValue(row);

        if (filterLine.values.any((FilterOption o) => o.value == value))
          continue;

        filterLine.values.add(new FilterOption(
            value,
            rows.where((r) => filterColumnSetting.filter(r, value)).length,
            appliedFilter != null && appliedFilter.any((f) => f == value)
        ));
      }
    }
  }

  Future<List> ngOnInit() async {
    rows = await input;
    getFilterColumns();
  }

  void onClick(bool checked, String columnName, value) {
    _filterService.toggleFilter(checked, columnName, value);

    rows = _filterService.filteredRows;
    getFilterColumns();
    onFiltered.emit(value);
  }
}
