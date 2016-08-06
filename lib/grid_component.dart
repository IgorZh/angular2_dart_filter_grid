import 'package:angular2/core.dart';

import 'column.dart';
import 'user.dart';

@Component(
    selector: 'i-grid',
    templateUrl: 'grid_component.html',
    styleUrls: const ['grid_component.css']
  )
class GridComponent {
  @Input()
  List<Map> rows;

  List<Column> columns = [
    new Column<User>('name', 'Name', (User user) => user.name, (User a, User b) => a.name.compareTo(b.name), (User a, String b) => a.name == b),
    new Column('age', 'Age', (User user) => user.age, (User a, User b) => a.age.compareTo(b.age), (User a, int b) => a.age == b),
    //new Column('gender', 'Gender'),
    //new Column('department', 'department'),
    //new Column('address', 'Address', (User user) => '${user.address.city} ${user.address.street}')
  ];

  void onSort(Column<User> col) {
    rows.sort(col.comparer);
  }

  void onFilter(Column<User> col, value) {
    rows = rows.where((user) => col.filter(user, value));
  }
}