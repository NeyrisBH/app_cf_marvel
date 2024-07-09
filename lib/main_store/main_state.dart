import 'package:mobx/mobx.dart';

import '../view_model/session/session_state.dart';
import '../view_model/user/user_state.dart';

part 'main_state.g.dart';

class MainState = MainStateBase with _$MainState;

abstract class MainStateBase with Store {
  late SessionState sessionState;
  late UserState userState;
  MainStateBase(){
    sessionState = SessionState(main: this as MainState);
    userState = UserState(main: this as MainState);
  }
}