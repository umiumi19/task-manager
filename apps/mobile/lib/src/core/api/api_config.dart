/// API のベース URL。launch の --dart-define=apiBaseUrl=... で上書き可能。
String get apiBaseUrl =>
    const String.fromEnvironment(
      'apiBaseUrl',
      defaultValue: 'http://localhost:9999',
    );
