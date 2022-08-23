import 'package:assignment_5/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class LoginEvent{}


class SetInitialEvent extends LoginEvent{}
class GetUserDataEvent extends LoginEvent{
  final UserLogin userLogin;
  GetUserDataEvent(this.userLogin);
}