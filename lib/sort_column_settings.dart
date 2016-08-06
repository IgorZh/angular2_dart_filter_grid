import 'column_settings.dart';
import 'src/comparable.dart';

class SortColumnSettings<T> extends ColumnSettings with ComparableExt  {
  SortColumnSettings(String name, String title, GetValue<T> getValue, Comparator<T> compareAsc, Comparator<T> compareDesc) : super(name, title, getValue) {
    this.compareAsc = compareAsc;
    this.compareDesc = compareDesc;
  }
}