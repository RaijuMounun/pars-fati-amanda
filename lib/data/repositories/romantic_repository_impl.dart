import 'package:parsfatiamanda/domain/entities/romantic_step.dart';
import 'package:parsfatiamanda/domain/repositories/romantic_repository.dart';
import 'package:parsfatiamanda/data/datasources/local_romantic_data_source.dart';

class RomanticRepositoryImpl implements RomanticRepository {
  final LocalRomanticDataSource localDataSource; // DIP (Abstraction)

  RomanticRepositoryImpl({required this.localDataSource});

  @override
  Future<RomanticStep> getNextStep(int currentStepIndex) async {
    // Repository, DataSource'tan veriyi alır ve Entity'ye çevirir.
    // Bu projede çevirim DataSource içinde yapıldığı için işimiz kolay.
    try {
      return await localDataSource.getStep(currentStepIndex);
    } catch (e) {
      // Hata yönetimi (örneğin son adıma ulaşıldı hatası)
      rethrow;
    }
  }
}
