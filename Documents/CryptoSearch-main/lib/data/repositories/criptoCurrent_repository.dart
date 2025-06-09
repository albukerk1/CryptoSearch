import 'package:order_manager/data/datasources/core/data_source.dart';
import 'package:order_manager/domain/entities/core/http_response_entity.dart';
import 'package:order_manager/domain/entities/cripto/cripto_entity.dart';

abstract interface class ICryptoCurrentRepository {
  Future<List<CriptoEntity>> getCryptoCurrentAsync(String symbol);
}

final class CryptoCurrentRepository implements ICryptoCurrentRepository {
  final IRemoteDataSource _remoteDataSource;

  const CryptoCurrentRepository(this._remoteDataSource);

  @override
  Future<List<CriptoEntity>> getCryptoCurrentAsync(String symbol) async {
    
  final baseUrl = _remoteDataSource.environment?.criptoCurrent ?? '';
  final criptoUrl = '$baseUrl$symbol'; 

  final HttpResponseEntity? httpResponse = await _remoteDataSource.get(criptoUrl);
  if (httpResponse == null || httpResponse.data == null) {
    // Retorna lista vazia se não teve resposta válida
    return [];
  }

  final List<CriptoEntity> criptoList = [];

  final Map<String, dynamic> dataMap = httpResponse.data['data'] as Map<String, dynamic>;

  dataMap.forEach((key, value) {
    final List<dynamic> criptoArray = value as List<dynamic>;
    for (final cripto in criptoArray) {
      final CriptoEntity criptoEntity = CriptoEntity.fromJson(cripto);
      criptoList.add(criptoEntity);
    }
  });

  print('criptoList: $criptoList');
  return criptoList;
}

}
