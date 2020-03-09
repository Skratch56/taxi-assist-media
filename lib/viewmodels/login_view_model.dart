import 'package:taxi_assist/constants/route_names.dart';
import 'package:taxi_assist/locator.dart';
import 'package:taxi_assist/models/user.dart';
import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/service/dialog_service.dart';
import 'package:taxi_assist/service/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
         User user = _authenticationService.currentUser;

         user.userRole == 'User' ? _navigationService.navigateTo(HomeViewRoute) : _navigationService.navigateTo(ActivityViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
