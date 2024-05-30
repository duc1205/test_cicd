import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../../../services/auth/auth_service.dart';
import '../../domain/usecases/login_usecase.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        loginUseCase: GetIt.I<LoginUseCase>(),
      ),
      child: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Navigate to the next screen
            }
            if (state.isError) {
              // Show error message
            }
          },
          builder: (context, state) {
            return state.maybeMap(
              success: (_) {
                return StreamBuilder<UserInfo?>(
                  stream: GetIt.I<AuthService>().userInfoStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(data?.name ?? ''),
                        Image.network(data?.avatar ?? ''),
                      ],
                    );
                  },
                );
              },
              loading: (_) => const CircularProgressIndicator(),
              orElse: () => TextButton(
                onPressed: () => context.read<LoginCubit>().handleLogin(),
                child: const Text(
                  'Click',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
