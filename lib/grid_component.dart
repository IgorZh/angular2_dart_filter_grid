import 'dart:async';

import 'package:angular2/core.dart';

import 'src/isnull_or_empty_pipe.dart';

import 'filter_service.dart';
import 'column_settings.dart';
import 'data_service.dart';
import 'user_service.dart';
import 'filter_component.dart';
import 'filter_request.dart';
import 'sort_request.dart';
import 'sort_service.dart';

@Component(
    selector: 'i-grid',
    templateUrl: 'grid_component.html',
    styleUrls: const ['grid_component.css'],
    pipes: const [IsNullOrEmptyPipe],
    directives: const [FilterComponent],
    providers: const [
      const Provider(DataService, useClass: UserService),
      FilterService,
      SortService
    ]
)
class GridComponent implements OnInit {
  final DataService _dataService;
  final FilterService _filterService;
  final SortService _sortService;

  final appliedSorters = new Map<String, int>();
  List rows;
  List allRows;

  @Input()
  List<ColumnSettings> columnSettings;
  List<ColumnSettings> showedColumns;

  GridComponent(this._dataService,
      this._filterService,
      this._sortService);

  void onSort(ColumnSettings column) {
    var direction = appliedSorters[column.name];

    if (direction == null) appliedSorters[column.name] = 1;
    if (direction == -1) appliedSorters.remove(column.name);
    if (direction == 1) appliedSorters[column.name] = -1;

    _sortService.sort(_createSortRequest(), rows);
  }

  void onFiltered(List<FilterRequest> filterRequest) {
    print(filterRequest.length);
    _filterService.applyFilters(filterRequest, rows, allRows);
    _sortService.sort(_createSortRequest(), rows);
  }

  Future ngOnInit() async {
    showedColumns = columnSettings.where((column) => column.isShow);

    rows = await _dataService.getUsers();
    allRows = new List.from(rows);
  }

  List<SortRequest> _createSortRequest() {
    var sortRequest = new List<SortRequest>();

    for (var key in appliedSorters.keys) {
      var column = columnSettings.firstWhere((column) => column.name == key);
      sortRequest.add(new SortRequest(column.getValue, appliedSorters[key]));
    }
    return sortRequest;
  }
}