typedef dynamic GetValue<T>(T a);

class ColumnSettings<T>{
  String name, title;

  ColumnSettings(this.name, this.title, this.getValue);

  GetValue<T> getValue;
}