abstract interface class IEnvironmentHelper {
  String? get criptoCurrent;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  String get _urlBase => 'https://pro-api.coinmarketcap.com/v2';

  @override
  String? get criptoCurrent => '$_urlBase/cryptocurrency/quotes/latest?symbol=';
}
