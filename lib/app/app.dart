import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../data/repositories/repositories.dart';
import '../utils/constants.dart' as constants;
import '../utils/themes.dart';
import '../view/view.dart';

class InvestuCateMeApp extends StatelessWidget {
  const InvestuCateMeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(
        authRepository: AuthRepository(),
        appUserRepository: AppUserRepository(),
      )..add(const CheckLoggedIn()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: constants.title,
        themeMode: ThemeMode.system,
        theme: theme,
        darkTheme: ThemeData.dark(),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (_, state) {
            if (state.status == AuthStatus.authtenticationError) {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text(state.errorMessage!),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Ok'),
                      )
                    ],
                  );
                },
              );
            }
          },
          builder: (_, state) {
            return Navigator(
              pages: [
                if (state.status == AuthStatus.authenticated)
                  MaterialPage(
                    child: HomePage(),
                  )
                else if (state.status == AuthStatus.unAuthenticated)
                  MaterialPage(
                    child: LoginPage(),
                  )
                else
                  MaterialPage(
                    child: LoadingPage(),
                  )
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          },
        ),
      ),
    );
  }
}
