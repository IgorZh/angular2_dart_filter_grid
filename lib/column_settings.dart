import 'src/get_value_typedef.dart';

class ColumnSettings<T, TR> {
  final String name, title;

  ColumnSettings(this.name,
      this.title,
      this.getValue,
      [bool isFilter, bool isShow]) {
    this.isFilter = isFilter ?? false;
    this.isShow = isShow ?? true;
  }

  GetValue<T, TR> getValue;

  bool isFilter, isShow;
}