import 'filter_option.dart';

class FilterLine {
  final String name, title;
  List<FilterOption> values;

  FilterLine(this.name, this.title)
      : values = new List<FilterOption>();

  List getAppliedFilters() {
    return values.where((v) => v.checked).toList();
  }
}
