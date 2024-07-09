import 'package:app_cf_marvel/view_model/comics/comics_state.dart';
import 'package:mobx/mobx.dart';

import '../view_model/session/session_state.dart';
import '../view_model/user/user_state.dart';

part 'main_state.g.dart';

class MainState = MainStateBase with _$MainState;

abstract class MainStateBase with Store {
  late SessionState sessionState;
  late UserState userState;
  late ComicsState comicsState;
  MainStateBase(){
    sessionState = SessionState(main: this as MainState);
    userState = UserState(main: this as MainState);
    comicsState = ComicsState(main: this as MainState);
  }
}