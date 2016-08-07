import 'package:angular2/core.dart';

import 'grid_component.dart';
import 'user_service.dart';
import 'dart:async';
import 'user.dart';
import 'filter_column_settings.dart';
import 'sort_column_settings.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [GridComponent],
    providers: const [UserService]
)
class AppComponent implements OnInit {
  final UserService _userService;

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

  List<SortColumnSettings<User>> sortColumnSettings = [
    new SortColumnSettings<User>('name',
        'Name',
        (User user) => user.name,
        (User a, User b) => a.name.compareTo(b.name),
        (User a, User b) => b.name.compareTo(a.name)
    ),
    new SortColumnSettings<User>(
        'age', 'Age', (User user) => user.age, (User a, User b) =>
        a.age.compareTo(b.age), (User a, User b) => b.age.compareTo(a.age)),
    new SortColumnSettings<User>(
        'gender', 'Gender', (User user) => user.gender, (User a, User b) =>
        a.gender.compareTo(b.gender), (User a, User b) =>
        b.gender.compareTo(a.gender)),
    new SortColumnSettings<User>(
        'department', 'Department', (User user) => user.department, (User a,
        User b) => a.department.compareTo(b.department), (User a, User b) =>
        b.department.compareTo(a.department)),
    new SortColumnSettings<User>(
        'address', 'Address', (User user) => '${user.address.city}, ${user
        .address.street}', (User a, User b) =>
        (a.address.city + a.address.street).compareTo(b.address.city + b.address.street),
        (User a, User b) => (b.address.city + b.address.street).compareTo(a.address.city + a.address.street))
  ];

  void ngOnInit() {
    users = _userService.getUsers();
  }
}