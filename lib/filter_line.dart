import 'filter_option.dart';

class FilterLine {
  final String name;
  List<FilterOption> values;

  FilterLine(this.name){
    values = new List<FilterOption>();
  }

  List getAppliedFilters(){
    return values.where((v) => v.checked).toList();
  }
}
