import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../data/repositories/repositories.dart';
import '../view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Welcome ${state.user!.name}'),
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: 'Explore',
                    ),
                    Tab(
                      text: 'Dashboard',
                    ),
                  ],
                ),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      child: Text('Header'),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.purple, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Tweets'),
                      onTap: () {
                        print('Tweets');
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              body: TabBarView(children: [
                BlocProvider(
                  create: (context) => CryptoCurrencyCubit(
                      repository: CryptoCurrencyRepository()),
                  child: Explore(),
                ),
                DashBoard(appUser: state.user!),
              ]),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }
}
