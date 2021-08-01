import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_educate/view/view.dart';

import '../../bloc/bloc.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CryptoCurrency> cryptoCurrencies;

  @override
  void initState() {
    super.initState();
  }

  Future<List<CryptoCurrency>> getCurrencies() async {
    var cryptoCurrencyRepository = CryptoCurrencyRepository();
    return await cryptoCurrencyRepository.getListing();
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
              body: TabBarView(children: [
                FutureBuilder<List<CryptoCurrency>>(
                  future: getCurrencies(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ExploreList(cryptoCurrencies: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
                const Center(
                  child: Text('DashBoard'),
                )
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

class ExploreList extends StatefulWidget {
  const ExploreList({Key? key, required this.cryptoCurrencies})
      : super(key: key);

  final List<CryptoCurrency> cryptoCurrencies;

  @override
  _ExploreListState createState() => _ExploreListState();
}

class _ExploreListState extends State<ExploreList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cryptoCurrencies.length,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            leading: Text(widget.cryptoCurrencies[index].symbol),
            title: Text(widget.cryptoCurrencies[index].name),
            trailing: Text(
                '${widget.cryptoCurrencies[index].qoutePriceUSD.toStringAsFixed(4)} USD'),
          ),
        );
      },
    );
  }
}
