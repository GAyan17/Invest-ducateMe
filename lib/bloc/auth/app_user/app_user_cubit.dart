import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit({required AppUserRepository appUserRepository})
      : _appUserRepository = appUserRepository,
        super(AuthuserInitial());

  final AppUserRepository _appUserRepository;

  Future<void> updateUser(String id, AppUser appUser) async {
    await _appUserRepository.updateUser(id, appUser);
  }
}
