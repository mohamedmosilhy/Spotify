// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:spotify/domain/entities/auth/user.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileInfoLoaded({
    required this.userEntity,
  });
}

class ProfileInfoFailure extends ProfileInfoState {}
