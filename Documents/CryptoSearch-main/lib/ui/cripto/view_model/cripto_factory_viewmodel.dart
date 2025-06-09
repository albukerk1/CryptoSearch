import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/data/datasources/core/data_source_factory.dart';
import 'package:order_manager/data/repositories/criptoCurrent_repository.dart';
import 'package:order_manager/ui/cripto/view_model/cripto_viewmodel.dart';

final class CriptoFactoryViewmodel implements IFactoryViewModel<CriptoViewMOdel> {
  @override
  CriptoViewMOdel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final ICryptoCurrentRepository cryptoCurrentRepository = CryptoCurrentRepository(remoteDataSource);
    return CriptoViewMOdel(cryptoCurrentRepository);
  }

  @override
  void dispose(BuildContext context, CriptoViewMOdel viewModel) {
    viewModel.close();
  }
  
}