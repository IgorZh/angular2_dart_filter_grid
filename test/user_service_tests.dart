import 'dart:async';

import "package:test/test.dart";

import 'package:angular2_dart_filter_grid/mock_users.dart';
import 'package:angular2_dart_filter_grid/user_service.dart';


void main() {
  test("UserService.getUsers() read json", () async {
    mockUsers = [{
      "id": "573f358cbd70b5b843a2d624",
      "age": "ew",
      "gender": "male",
      "department": "Backend",
      "address": {
        "city": "Moscow",
        "street": "Fayette Street 923"
      }
    }];

    var users = await new UserService().getUsers();

    expect(users.length, equals(1));
  });
}