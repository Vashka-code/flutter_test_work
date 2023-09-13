import 'dart:math';

class LoginRepository {
  Future<void> login() async {
    try {
      await Future<bool>.delayed(
          const Duration(seconds: 2), () => Random().nextBool());
    } catch (e) {
      throw Exception('login failed');
    }
  }
}
