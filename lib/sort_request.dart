import 'src/get_value_typedef.dart';

class SortRequest<T, TR>{
  int direction;
  GetValue<T, TR> getValue;

  SortRequest(this.getValue, this.direction);
}