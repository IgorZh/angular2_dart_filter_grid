import 'src/get_value_typedef.dart';

class FilterRequest<T, TR> {
  Set<TR> values;
  GetValue<T, TR> getValue;

  FilterRequest(this.getValue, this.values);
}