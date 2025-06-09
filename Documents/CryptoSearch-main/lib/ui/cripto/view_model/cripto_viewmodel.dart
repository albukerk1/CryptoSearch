import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/data/repositories/criptoCurrent_repository.dart';
import 'package:order_manager/domain/entities/core/request_state_entity.dart';
import 'package:order_manager/domain/entities/cripto/cripto_entity.dart';

final class CriptoViewMOdel extends Cubit<IRequestState<List<CriptoEntity>>> {
  final ICryptoCurrentRepository _repository;

  CriptoViewMOdel(this._repository) : super(const RequestInitiationState());

  void onGetCripto(String criptoSearch) async {
    try {
      _emitter(RequestProcessingState());

      final List<CriptoEntity> data;
      
      if (criptoSearch.isNotEmpty) {
        data = await _repository.getCryptoCurrentAsync(criptoSearch);
      } else {
        data = await _repository.getCryptoCurrentAsync(
          'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO',
        );
      }

      print('cripto data: $data');

      _emitter(RequestCompletedState(value: data));
    } catch (error) {
      _emitter(RequestErrorState(error: error));
    }
  }

  void _emitter(IRequestState<List<CriptoEntity>> state) {
    if (isClosed) return;
    emit(state);
  }
}
