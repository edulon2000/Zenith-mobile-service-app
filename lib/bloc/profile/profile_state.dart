part of 'profile_bloc.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoadInProgress extends ProfileState {}
final class ProfileLoadSuccess extends ProfileState {
  final UserModel user;
  ProfileLoadSuccess(this.user);
}
final class ProfileLoadFailure extends ProfileState {
  final String error;
  ProfileLoadFailure(this.error);
}