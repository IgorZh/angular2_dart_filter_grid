import 'address.dart';

class User {
  final String id;
  String name;
  int age;
  String gender;
  String department;
  Address address;

  User(this.id);

  // TODO: зачем указывать generic парметры у Map? фабрика ли это?
  factory User.fromJson(Map<String, dynamic> userJson){
    final user = new User(userJson['id']);

    user.name = userJson['name'];
    user.age = userJson['age'];
    user.gender = userJson['gender'];
    user.department = userJson['department'];
    user.address = new Address.fromJson(userJson['address']);

    return user;
  }
}
