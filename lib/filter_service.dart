import 'package:angular2/core.dart';

import 'filter_request.dart';

@Injectable()
class FilterService<T> {
  void applyFilters(List<FilterRequest<T, dynamic>> filterRequest,
      List<T> filteringRows,
      List<T> allRows) {
    for (var filter in filterRequest) {
      for (var value in filter.values) {
        allRows = allRows.where((i) => filter.getValue(i) == value);
      }
    }

    filteringRows.removeWhere((row) => !allRows
        .any((baseRow) => baseRow == row));

    filteringRows.addAll(allRows
        .where((baseRow) => !filteringRows.any((row) => row == baseRow)));
  }
}
