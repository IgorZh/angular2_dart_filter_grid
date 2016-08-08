import 'dart:async';

import 'package:angular2/core.dart';

import 'user.dart';
import 'mock_users.dart';


@Injectable()
class DataService {
  //TODO: тут бы json на соответсвие схеме проверить
  Future<List<User>> getUsers() async =>
      mockUsers.map((json) => new User.fromJson(json)).toList();
}
