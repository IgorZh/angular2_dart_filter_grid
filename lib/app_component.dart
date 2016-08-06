import 'package:angular2/core.dart';

import 'grid_component.dart';
import 'user_service.dart';
import 'dart:async';
import 'user.dart';
import 'filter_column_settings.dart';

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
      new FilterColumnSettings<User>('gender', 'Gender', (User user) => user.gender, (User a, String b) => a.gender == b),
      new FilterColumnSettings<User>('department', 'Department', (User user) => user.department, (User a, String b) => a.department == b),
      new FilterColumnSettings<User>('city', 'City', (User user) => user.address.city, (User a, String b) => a.address.city == b)
   ];

   void ngOnInit() {
      users = _userService.getUsers();
   }
}