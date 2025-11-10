import 'package:get_it/get_it.dart';
import 'data/datasources/local_romantic_data_source.dart';
import 'data/repositories/romantic_repository_impl.dart';
import 'domain/repositories/romantic_repository.dart';
import 'domain/usecases/get_next_step.dart';
import 'presentation/cubit/romantic_cubit.dart';
import 'data/datasources/music_player_service.dart';

// GetIt'in Singleton örneği
final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // ----------------------------------------------------
  // 1. PRESENTATION KATMANI (Cubit)
  // ----------------------------------------------------
  sl.registerFactory(
    () => RomanticCubit(
      sl(), // UseCase bağımlılığını otomatik çeker
      sl(), // MusicPlayerService bağımlılığını otomatik çeker
    ),
  );

  // ----------------------------------------------------
  // 2. DOMAIN KATMANI (UseCases)
  // ----------------------------------------------------
  sl.registerLazySingleton(
    () => GetNextStep(
      sl(), // Repository bağımlılığını otomatik çeker
    ),
  );

  // ----------------------------------------------------
  // 3. DATA KATMANI (Repository & DataSource)
  // ----------------------------------------------------
  // Repository (Abstract Interface'i concrete implementasyon ile bağlıyoruz)
  sl.registerLazySingleton<RomanticRepository>(
    () => RomanticRepositoryImpl(
      localDataSource: sl(), // DataSource bağımlılığını çeker
    ),
  );

  // ----------------------------------------------------
  // 4. SERVİSLER (Music)
  // ----------------------------------------------------
  // Singleton olarak kaydediyoruz, çünkü tüm uygulamada tek bir player olmalı.
  sl.registerLazySingleton(() => MusicPlayerService());

  // Data Sources
  sl.registerLazySingleton(() => LocalRomanticDataSource());
}
