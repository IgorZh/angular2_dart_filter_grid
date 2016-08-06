import 'column_settings.dart';
import 'src/filterable.dart';

class FilterColumnSettings<T> extends ColumnSettings with Filterable {
  FilterColumnSettings(String name, String title, GetValue<T> getValue, Filter<T> filter) : super(name, title, getValue) {
    this.filter = filter;
  }
}
