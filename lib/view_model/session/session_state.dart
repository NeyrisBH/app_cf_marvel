import 'dart:developer';

import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/repository/session_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../locator.dart';
import '../../model/session_model.dart';

part 'session_state.g.dart';

class SessionState = SessionStateBase with _$SessionState;

abstract class SessionStateBase with Store {
  late MainState main;

  SessionStateBase({required  this.main});

  final SessionRepoImpl _sessionRepoImpl = sl<SessionRepoImpl>();
  @observable
  Observable<SessionModel?> session = Observable(null);

  @observable
  Observable<bool> loading = Observable(false);

  @observable
  Observable<bool> hasSession = Observable(false);
  @action
  Future login(String email,String password)async{
    loading.value = true;
    SessionModel sessionModel = await _sessionRepoImpl.login(email, password);
    session.value = sessionModel;
    loading.value = false;
  }

  Future _fetchSession()async{
    SessionModel? sessionModel = await _sessionRepoImpl.getSession();
    session.value = sessionModel;
    await main.userState.fetchUser();
    hasSession.value = true;
    }

  Future<String> getAccessToke()async{
    if(isInvalidAccessToken()){
      if (kDebugMode) {
        print("Token invalido");
      }
      await refreshAccessToke();
    }

    return session.value!.accessToken;
  }

  isInvalidAccessToken(){
    return DateTime.now().isAfter(DateTime.parse(session.value!.expireTime));
  }

  refreshAccessToke()async{
    SessionModel sessionModel = await _sessionRepoImpl.refreshAccessToken(session.value!.id,session.value!.refreshToken);
    session.value = sessionModel;
    }

  closeSession()async{
    bool isCloseSession = await _sessionRepoImpl.closeSession();

    if(isCloseSession){
      session.value = null;
      hasSession.value=false;
    }

  }

  Future<void>init()async{
    try{
      await Future.wait([_fetchSession(),]);
    }catch(error){
      log("error $error");
    }
  }
}