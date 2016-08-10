import 'dart:async';

import 'package:angular2/core.dart';

import 'mock_users.dart';

typedef S ItemFromJsonCreator<S>(Map<String, dynamic> json);

@Injectable()
class DataService<T> {

  ItemFromJsonCreator<T> creator;

  //TODO: тут бы json на соответсвие схеме проверить
  Future<List<T>> getUsers() async =>
      mockUsers.map((json) => creator(json)).toList() as List<T>;

  DataService(this.creator);
}
