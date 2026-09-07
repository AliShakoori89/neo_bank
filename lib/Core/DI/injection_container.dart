import 'package:get_it/get_it.dart';
import '../../Features/Statement_Page/Data/Data_Sources/statement_data_sources.dart';
import '../../Features/Statement_Page/Data/Repositories/statement_repository_impl.dart';
import '../../Features/Statement_Page/Domain/Repositories/statement_repository.dart';
import '../../Features/Statement_Page/Domain/UseCases/fetch_statement_filtered_use_case.dart';
import '../../Features/Statement_Page/Domain/UseCases/fetch_statement_use_case.dart';
import '../../Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import '../Network/dio_client.dart';

final sl = GetIt.instance;

void setupDependencies() {

  sl.registerLazySingleton<DioClient>(
        () => DioClient(),
  );

  // Data Source
  sl.registerLazySingleton<StatementDataSources>(
        () => StatementDataSources(dio: sl<DioClient>().dio
        ),
  );

  // Repository
  sl.registerLazySingleton<StatementRepository>(
        () => StatementRepositoryImpl(
      statementDataSources: sl<StatementDataSources>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<FetchStatementUseCase>(
        () => FetchStatementUseCase(
      repository: sl<StatementRepository>(),
    ),
  );

  sl.registerLazySingleton<FetchStatementFilteredUseCase>(
        () => FetchStatementFilteredUseCase(
      repository: sl<StatementRepository>(),
    ),
  );

  // Bloc
  sl.registerFactory<StatementBloc>(
        () => StatementBloc(
      sl<FetchStatementFilteredUseCase>(),
      sl<FetchStatementUseCase>(),
    ),
  );
}