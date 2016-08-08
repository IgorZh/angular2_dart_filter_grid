import 'package:angular2/core.dart';

import 'grid_component.dart';
import 'filter_component.dart';
import 'filter_service.dart';
import 'dart:async';
import 'user.dart';
import 'filter_column_settings.dart';
import 'column_settings.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [GridComponent, FilterComponent],
    providers: const [FilterService]
)
class AppComponent implements OnInit {
  final FilterService _userService;

  AppComponent(this._userService);

  Future<List<User>> users;

  List<FilterColumnSettings<User>> filterColumnSettings = [
    new FilterColumnSettings<User>(
        'gender', 'Gender', (User user) => user.gender, (User a, String b) => a
        .gender == b),
    new FilterColumnSettings<User>(
        'department', 'Department', (User user) => user.department, (User a,
        String b) => a.department == b),
    new FilterColumnSettings<User>(
        'city', 'City', (User user) => user.address.city, (User a,
        String b) => a.address.city == b)
  ];

  List<ColumnSettings<User>> sortColumnSettings = [
    new ColumnSettings<User>(
        'name',
        'Name',
        (User user) => user.name),
    new ColumnSettings<User>(
        'age',
        'Age',
        (User user) => user.age),
    new ColumnSettings<User>(
        'gender',
        'Gender',
        (User user) => user.gender),
    new ColumnSettings<User>(
        'department',
        'Department',
        (User user) => user.department),
    new ColumnSettings<User>(
        'address',
        'Address',
        (User user) => '${user.address.city}, ${user.address.street}')
  ];

  void ngOnInit() {
    users = _userService.getUsers();
  }
}