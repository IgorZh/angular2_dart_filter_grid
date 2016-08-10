import 'package:angular2/core.dart';

import 'user.dart';
import 'address.dart';
import 'column_settings.dart';
import 'grid_component.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [GridComponent]
)
class AppComponent implements OnInit {
  List<ColumnSettings<User, dynamic>> columnSettings;

  void ngOnInit() => _componentSettings();

  void _componentSettings() {
    columnSettings = <ColumnSettings<User, dynamic>>[
      new ColumnSettings<User, String>(
          'name',
          'Name',
          (user) => user.name),
      new ColumnSettings<User, int>(
          'age',
          'Age',
          (user) => user.age),
      new ColumnSettings<User, String>(
          'gender',
          'Gender',
          (user) => user.gender,
          true),
      new ColumnSettings<User, String>(
          'department',
          'Department',
          (user) => user.department,
          true),
      new ColumnSettings<User, Address>(
          'address',
          'Address',
          (user) => user.address),
      new ColumnSettings<User, String>(
          'city',
          'City',
          (user) => user.address.city,
          true,
          false)
    ];
  }
}