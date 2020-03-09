import 'package:taxi_assist/constants/route_names.dart';
import 'package:taxi_assist/locator.dart';
import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/service/navigation_service.dart';
import 'package:taxi_assist/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(ActivityViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
