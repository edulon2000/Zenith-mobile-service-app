import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserService userService;

  ProfileBloc({required this.userService}) : super(ProfileInitial()) {
    on<ProfileFetchRequested>((event, emit) async {
      emit(ProfileLoadInProgress());
      try {
        final user = await userService.getMyProfile();
        emit(ProfileLoadSuccess(user));
      } catch (e) {
        emit(ProfileLoadFailure(e.toString()));
      }
    });
  }
}