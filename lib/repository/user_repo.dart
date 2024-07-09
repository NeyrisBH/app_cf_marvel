import 'package:app_cf_marvel/data/remote/api.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';
import '../model/user_model.dart';

abstract class UserRepo{
  Future<UserModel>getUser(String accessToken);
}

class UserRepoImpl extends UserRepo{
  final Api _api = sl<Api>();
  @override
  Future<UserModel> getUser(String accessToken) async{
    var jsonResponse = await _api.get("/userinfo",accessToken: accessToken);
    if (kDebugMode) {
      print("jsonResponse user $jsonResponse");
    }
    return UserModel.toObject(jsonResponse);
  }
}