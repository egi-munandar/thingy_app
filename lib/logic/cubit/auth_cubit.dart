import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thingy_app/logic/repository/auth_repo.dart';
import 'package:thingy_app/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void emitAuthUser(UserModel userModel) => emit(AuthUser(user: userModel));
  void emitLogout() => emit(AuthLoggedOut());
  Future<void> logoutApp() async {
    const storage = FlutterSecureStorage();
    await AuthRepo().logout().then((_) async {
      await storage.delete(key: 'user');
      emit(AuthLoggedOut());
    }).catchError((er) async {
      if (er.toString() == "401" || er.toString() == "User data not found") {
        await storage.delete(key: 'user');
        emit(AuthLoggedOut());
      } else {
        throw er.toString();
      }
    });
  }
}
