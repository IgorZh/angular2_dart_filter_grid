class Column<T>{
  String name, title;

  Column(this.name, this.title, this.getValue, this.comparer, this.filter);

  Function getValue;

  Function comparer;

  Function filter;
}