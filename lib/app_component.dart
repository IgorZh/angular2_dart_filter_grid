import 'package:angular2/core.dart';

import 'grid_component.dart';
import 'user_service.dart';
import 'dart:async';
import 'user.dart';

@Component(
      selector: 'my-app',
      templateUrl: 'app_component.html',
      directives: const [GridComponent],
      providers: const [UserService]
   )
class AppComponent implements OnInit {
   final UserService _userService;

   AppComponent(this._userService);

   List<User> users;

   Future<Null> ngOnInit() async {
      users = await _userService.getUsers();
   }
}