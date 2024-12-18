// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SessionState on SessionStateBase, Store {
  late final _$sessionAtom =
      Atom(name: 'SessionStateBase.session', context: context);

  @override
  Observable<SessionModel?> get session {
    _$sessionAtom.reportRead();
    return super.session;
  }

  @override
  set session(Observable<SessionModel?> value) {
    _$sessionAtom.reportWrite(value, super.session, () {
      super.session = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'SessionStateBase.loading', context: context);

  @override
  Observable<bool> get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(Observable<bool> value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$hasSessionAtom =
      Atom(name: 'SessionStateBase.hasSession', context: context);

  @override
  Observable<bool> get hasSession {
    _$hasSessionAtom.reportRead();
    return super.hasSession;
  }

  @override
  set hasSession(Observable<bool> value) {
    _$hasSessionAtom.reportWrite(value, super.hasSession, () {
      super.hasSession = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('SessionStateBase.login', context: context);

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  @override
  String toString() {
    return '''
session: ${session},
loading: ${loading},
hasSession: ${hasSession}
    ''';
  }
}
