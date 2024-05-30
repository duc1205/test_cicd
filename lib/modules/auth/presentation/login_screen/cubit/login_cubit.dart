import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase;
  LoginCubit({
    required this.loginUseCase,
  }) : super(const _Initial());

  Future<void> handleLogin() async {
    emit(_Loading());
    final loginResp = await loginUseCase.login();
    loginResp.fold(
      (l) => emit(_Error(l)),
      (r) async {
        final getUserInfoResp = await loginUseCase.getUserInfo();
        getUserInfoResp.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success()),
        );
      },
    );
  }
}
