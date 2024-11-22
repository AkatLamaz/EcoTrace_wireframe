import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_tutorial2/services/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_web_tutorial2/pages/settings/settings.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('SettingsController', () {
    late SettingsController controller;
    late MockUserService mockUserService;

    setUp(() {
      Get.testMode = true;
      mockUserService = MockUserService();
      Get.put<UserService>(mockUserService);
      controller = Get.put(SettingsController());
    });

    test('validation works correctly', () async {
      when(mockUserService.getUserProfile()).thenAnswer(
        (_) async => {
          'name': '',
          'email': '',
          'phone': '',
          'gender': '',
        },
      );

      controller.updateName('A' * 51);
      expect(controller.name.value, '');

      controller.updateEmail('invalid-email');
      expect(controller.email.value, '');

      controller.updatePhone('abc123');
      expect(controller.phone.value, '');
    });

    tearDown(() {
      Get.reset();
    });
  });
}
