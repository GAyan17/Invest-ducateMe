import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:invest_educate/view/home/explore/buy_currency.dart';

import '../../../bloc/bloc.dart';
import '../../../data/models/models.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoCurrencyCubit, CryptoCurrencyState>(
      builder: (context, state) {
        if (state is CryptoCurrenciesFetched) {
          return ExploreList(cryptoCurrencies: state.currencies);
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

class ExploreList extends StatelessWidget {
  const ExploreList({Key? key, required this.cryptoCurrencies})
      : super(key: key);

  final List<CryptoCurrency> cryptoCurrencies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoCurrencies.length,
      itemBuilder: (_, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                label: 'Buy',
                icon: Icons.money_rounded,
                onPressed: (context) {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return BuyCurrency(
                          cryptoCurrency: cryptoCurrencies[index]);
                    },
                  );
                },
              )
            ],
          ),
          child: Card(
            child: ListTile(
              leading: Text(cryptoCurrencies[index].symbol),
              title: Text(cryptoCurrencies[index].name),
              trailing: Text(
                  '${cryptoCurrencies[index].qoutePriceUSD.toStringAsFixed(4)} USD'),
              minVerticalPadding: 8.0,
              onTap: () {
                //TODO: add further logic
                print('Currency Tapped');
              },
            ),
          ),
        );
      },
    );
  }
}
