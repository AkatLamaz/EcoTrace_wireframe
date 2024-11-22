import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_tutorial2/services/user_service.dart';

@GenerateMocks([http.Client, UserService])
void main() {}