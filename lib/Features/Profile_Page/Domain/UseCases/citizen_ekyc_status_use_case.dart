import 'package:injectable/injectable.dart';
import '../Repositories/citizen_kyc_status_repository.dart';

@lazySingleton
class CitizenEkycStatusUseCase {
  final GetCitizenEKYCStatusRepository repository;

  CitizenEkycStatusUseCase({
    required this.repository});

  Future<bool> fetchEKYCStatus(){
    return repository.fetchEKYCStatus();
  }
}