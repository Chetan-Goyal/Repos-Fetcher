import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final localAuth = LocalAuthentication();

  Future<bool> isBiometricPresent() async {
    return await localAuth.canCheckBiometrics &&
        await localAuth.isDeviceSupported();
  }

  Future<bool> isConfirmed(
      {String message = "Please Authenticate to use our services"}) async {
    bool didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate to get Jake\'s Repos List',
    );
    return didAuthenticate;
  }
}
