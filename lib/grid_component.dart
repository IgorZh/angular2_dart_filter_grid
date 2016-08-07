import 'dart:async';

import 'package:angular2/core.dart';

import 'sort_column_settings.dart';
import 'user.dart';
import 'filter_component.dart';
import 'filter_service.dart';
import 'sort_service.dart';
import 'filter_column_settings.dart';
import 'column_settings.dart';
import 'sort_order.dart';

@Component(
    selector: 'i-grid',
    templateUrl: 'grid_component.html',
    styleUrls: const ['grid_component.css'],
    directives: const [FilterComponent],
    providers: const [FilterService, SortService]
  )
class GridComponent implements OnInit{
  final FilterService _filterService;
  final SortService _sortService;
  Map<String, SortOrder> appliedSorters;

  final sortOrder = SortOrder;

  @Input()
  Future<List> input;
  @Input()
  List<FilterColumnSettings> filterColumnSettings;
  @Input()
  List<ColumnSettings> columnSettings;

  GridComponent(this._filterService, this._sortService)
    : appliedSorters = new Map<String, SortOrder>();

  List rows;

  void onSort(SortColumnSettings<User> col) {
    _sortService.toggleSort(col.name);
    _sortService.applySort(rows);
    appliedSorters = _sortService.appliedSorters;
  }

  void onFiltered() {
    rows = _filterService.filteredRows;
  }

  Future<List> ngOnInit() async {
    _filterService.init(input, filterColumnSettings);
    _sortService.init(columnSettings);
    appliedSorters = _sortService.appliedSorters;
    rows = await input;
  }
}