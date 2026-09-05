import '../Repositories/citizen_kyc_status_repository.dart';

class CitizenEkycStatusUseCase {
  final GetCitizenEKYCStatusRepository repository;

  CitizenEkycStatusUseCase({
    required this.repository});

  Future<bool> fetchEKYCStatus(){
    return repository.fetchEKYCStatus();
  }
}