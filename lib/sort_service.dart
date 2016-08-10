import 'package:angular2/core.dart';
import 'sort_request.dart';

@Injectable()
class SortService<T> {

  void sort(List<SortRequest<T, dynamic>> sortRequest, List<T> rows) {
    rows.sort((a, b) => _compare(a, b, sortRequest));
  }

  int _compare(a, b, List<SortRequest> sortRequest) {
    var compare = 0;

    for (var sort in sortRequest) {
      var aVal = sort.getValue(a) ?? '',
          bVal = sort.getValue(b) ?? '';

      compare = sort.direction * aVal.compareTo(bVal);

      if(compare != 0)
        return compare;
    }
    return compare;
  }
}
