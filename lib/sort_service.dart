import 'dart:math';

import 'package:angular2/core.dart';
import 'sort_request.dart';

@Injectable()
class SortService<T> {

  void sort(List<SortRequest<T, dynamic>> sortRequest, List<T> rows) {
    rows.sort((a, b) => _compare(a, b, sortRequest));
  }

  int _compare(a, b, List<SortRequest> sortRequest) {
    var compare = 0;
    var power = pow(10, sortRequest.length);

    for (var sort in sortRequest) {
      int tmp;
      var aVal = sort.getValue(a),
          bVal = sort.getValue(b);

      if (aVal == null)
        tmp = -1;
      else if (bVal == null)
        tmp = 1;
      else
        tmp = aVal.compareTo(bVal);

      compare += sort.direction * power * tmp;

      power ~/= 10;
    }
    return compare;
  }
}
