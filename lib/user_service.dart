import 'data_service.dart';
import 'user.dart';

class UserService extends DataService<User>{
  UserService() : super((json)=> new User.fromJson(json));
}