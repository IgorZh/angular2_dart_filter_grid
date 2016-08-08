import 'dart:async';

import 'package:angular2/core.dart';

import 'user.dart';
import 'filter_service.dart';
import 'sort_service.dart';
import 'filter_column_settings.dart';
import 'column_settings.dart';
import 'sort_order.dart';

@Component(
    selector: 'i-grid',
    templateUrl: 'grid_component.html',
    styleUrls: const ['grid_component.css'],
    providers: const [SortService]
  )
class GridComponent implements OnInit{
  final FilterService _filterService;
  final SortService _sortService;
  Map<String, SortOrder> appliedSorters;

  final sortOrder = SortOrder;

  @Input()
  List<FilterColumnSettings> filterColumnSettings;
  @Input()
  List<ColumnSettings> columnSettings;

  GridComponent(this._filterService, this._sortService)
    : appliedSorters = new Map<String, SortOrder>();

  List rows;

  void onSort(ColumnSettings<User> col) {
    _sortService.toggleSort(col.name);
    _sortService.applySort(rows);
    appliedSorters = _sortService.appliedSorters;
  }

  void onFiltered() {
    rows = _filterService.filteredRows;
  }

  Future<List> ngOnInit() async {
    rows = await _filterService.getUsers();
    _sortService.init(columnSettings);
    appliedSorters = _sortService.appliedSorters;
  }
}