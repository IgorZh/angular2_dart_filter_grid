import 'package:angular2/core.dart';

import 'grid_component.dart';
import 'filter_component.dart';
import 'filter_service.dart';
import 'dart:async';
import 'user.dart';
import 'column_settings.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [GridComponent, FilterComponent],
    providers: const [FilterService]
)
class AppComponent implements OnInit {
  final FilterService _userService;

  List<ColumnSettings<User>> sortColumnSettings;
  List<ColumnSettings<User>> filterColumnSettings;
  Future<List<User>> users;

  AppComponent(this._userService);

  void _componentSettings(){
    sortColumnSettings = <ColumnSettings<User>>[
      new ColumnSettings<User>(
          'name',
          'Name',
          (user) => user.name),
      new ColumnSettings<User>(
          'age',
          'Age',
          (user) => user.age),
      new ColumnSettings<User>(
          'gender',
          'Gender',
          (user) => user.gender),
      new ColumnSettings<User>(
          'department',
          'Department',
          (user) => user.department),
      new ColumnSettings<User>(
          'address',
          'Address',
          (user) => user.address)
    ];

    filterColumnSettings = new List<ColumnSettings<User>>.from(sortColumnSettings
        .where((column) => ['gender', 'department'].contains(column.name)));
    filterColumnSettings.add(new ColumnSettings<User>(
        'city',
        'City',
        (user) => user.address.city));
  }

  void ngOnInit() {
    users = _userService.getUsers();
    _componentSettings();
  }
}