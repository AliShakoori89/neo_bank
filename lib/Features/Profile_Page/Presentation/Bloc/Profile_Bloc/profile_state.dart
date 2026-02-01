import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, success, error, loading }

extension ProfileStatusX on ProfileStatus {
  bool get isInitial => this == ProfileStatus.initial;
  bool get isSuccess => this == ProfileStatus.success;
  bool get isError => this == ProfileStatus.error;
  bool get isLoading => this == ProfileStatus.loading;
}

class ProfileState extends Equatable {
  const ProfileState({required this.status, this.userName, this.mobileNumber});

  static ProfileState initial() => ProfileState(
    status: ProfileStatus.initial,
    userName: '',
    mobileNumber: '',
  );

  final ProfileStatus status;
  final String? userName;
  final String? mobileNumber;

  @override
  List<Object?> get props => [status, userName, mobileNumber];

  ProfileState copyWith({
    ProfileStatus? status,
    String? userName,
    String? mobileNumber,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }
}
