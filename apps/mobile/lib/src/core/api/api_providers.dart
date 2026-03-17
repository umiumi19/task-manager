import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_client.dart';
import '../../features/auth/application/auth_providers.dart';

final apiDioProvider = Provider<Dio>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  return createApiDio(auth);
});
