class FilterOption<T> {
  T value;
  int filtered;
  bool checked = false;

  FilterOption(this.value, this.filtered);
}