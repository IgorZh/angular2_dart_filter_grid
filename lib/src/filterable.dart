typedef bool Filter<T>(T a, Object b);

class Filterable {
  Filter filter;
}