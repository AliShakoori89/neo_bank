import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Data/Model/profile_model.dart';

enum ProfileStatus { initial, success, error, loading }

extension ProfileStatusX on ProfileStatus {
  bool get isInitial => this == ProfileStatus.initial;
  bool get isSuccess => this == ProfileStatus.success;
  bool get isError => this == ProfileStatus.error;
  bool get isLoading => this == ProfileStatus.loading;
}

class ProfileState extends Equatable {
  const ProfileState({required this.status, required this.profileFields});

  static ProfileState initial() => ProfileState(
    status: ProfileStatus.initial,
    profileFields: ProfileModel(),
  );

  final ProfileStatus status;
  final ProfileModel? profileFields;

  @override
  List<Object?> get props => [status, profileFields];

  ProfileState copyWith({ProfileStatus? status, ProfileModel? profileFields}) {
    return ProfileState(
      status: status ?? this.status,
      profileFields: profileFields ?? this.profileFields,
    );
  }
}
