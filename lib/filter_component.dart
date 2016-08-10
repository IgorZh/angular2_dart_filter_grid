import 'package:angular2/core.dart';

import 'src/isnull_or_empty_pipe.dart';
import 'column_settings.dart';
import 'filter_line.dart';
import 'filter_option.dart';
import 'filter_request.dart';

@Component(
    selector: 'i-filter',
    templateUrl: 'filter_component.html',
    styleUrls: const ['filter_component.css'],
    pipes: const [IsNullOrEmptyPipe]
)
class FilterComponent<T> implements OnInit, OnChanges, DoCheck {
  @Input() List<ColumnSettings<T, dynamic>> filterColumnSettings;
  @Input() List<T> rows;

  @Output() final filtered = new EventEmitter<
      List<FilterRequest<T, dynamic>>>();

  final filterLines = new List<FilterLine>();

  void toggleFilter(FilterOption option) {
    option.checked = !option.checked;

    var filterRequest = filterColumnSettings
        .map((filterColumn) =>
    new FilterRequest(
        filterColumn.getValue,
        filterLines
            .firstWhere((line) => line.name == filterColumn.name)
            .getAppliedFilters().map((FilterOption l) => l.value)
            .toSet())
    ).toList() as List<FilterRequest<T, dynamic>>;

    filtered.add(filterRequest);
  }

  ngDoCheck() {
    if (!filterLines.isEmpty)
      _updateFilterLines();
  }

  ngOnChanges(Map<String, SimpleChange> changes) {
    if (filterLines.isEmpty)
      _createFilterLines();
  }

  ngOnInit() {
    filterColumnSettings = filterColumnSettings
        .where((filterColumn) => filterColumn.isFilter)
        .toList();
  }

  void _createFilterLines() {
    if (rows == null) return;

    filterLines.addAll(filterColumnSettings.map((column) {
      var line = new FilterLine(column.name, column.title);

      line.values = rows
          .map((row) => column.getValue(row))
          .toSet()
          .map((value) =>
      new FilterOption(value, _getFilteredCount(column, value)))
          .toList() as List<FilterOption>;

      return line;
    }).toList() as List<FilterLine>);
  }

  void _updateFilterLines() {
    for (var filterLine in filterLines) {
      var filterColumnSetting = filterColumnSettings.firstWhere((
          setting) => setting.name == filterLine.name);

      for (FilterOption option in filterLine.values) {
        option.filtered = _getFilteredCount(filterColumnSetting, option.value);
      }
    }
  }

  int _getFilteredCount(ColumnSettings filterColumnSetting, value) =>
      rows.where((r) => filterColumnSetting.getValue(r) == value)
          .length;
}
