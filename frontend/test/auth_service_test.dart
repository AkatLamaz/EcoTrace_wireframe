import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_tutorial2/services/auth_service.dart';
import 'package:flutter_web_tutorial2/constants/endpoints.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';
import 'dart:convert';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('AuthService', () {
    late AuthService authService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      authService = AuthService();
    });

    test('successful login returns user data', () async {
      final responseData = {
        'token': 'fake_token',
        'user': {'email': 'test@example.com'}
      };

      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async =>
          http.Response(json.encode(responseData), 200));

      final result = await authService.login('test@example.com', 'password123');
      
      expect(result['token'], 'fake_token');
      expect(result['user']['email'], 'test@example.com');
    });

    test('failed login throws exception', () async {
      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async =>
          http.Response(json.encode({'message': 'Invalid credentials'}), 401));

      expect(
        () => authService.login('test@example.com', 'wrongpassword'),
        throwsException,
      );
    });

    tearDown(() {
      Get.reset();
    });
  });
}
