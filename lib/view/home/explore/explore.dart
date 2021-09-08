import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../bloc/bloc.dart';
import '../../../data/models/models.dart';
import 'buy_currency.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: cryptoCurrencies.length,
        itemBuilder: (_, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  label: 'Buy',
                  icon: Icons.money_rounded,
                  onPressed: (_) {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return BuyCurrency(
                          cryptoCurrency: cryptoCurrencies[index],
                          transactionCubit: context.read<TransactionCubit>(),
                        );
                      },
                    );
                  },
                )
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                leading: Text(cryptoCurrencies[index].symbol),
                title: Text(cryptoCurrencies[index].name),
                trailing: Text(
                    '${cryptoCurrencies[index].qoutePriceUSD.toStringAsFixed(4)} USD'),
                minVerticalPadding: 8.0,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return BuyCurrency(
                        cryptoCurrency: cryptoCurrencies[index],
                        transactionCubit: context.read<TransactionCubit>(),
                      );
                    },
                  );
                  print('Currency Tapped');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
