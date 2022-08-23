import 'package:assignment_5/models/user_model.dart';

class RegisterEvent{}


class SetInitialRegisterEvent extends RegisterEvent{}
class GetUserDataEvent extends RegisterEvent {
  final UserRegister userRegister;
  GetUserDataEvent(this.userRegister);
}
