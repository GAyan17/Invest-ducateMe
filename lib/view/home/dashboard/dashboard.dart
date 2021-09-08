import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../data/models/models.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key, required this.appUser}) : super(key: key);
  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: [
                Text(
                  'Total Money: \$ ${appUser.totalMoney}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Invested: ${appUser.invested}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Current Value: ${appUser.currentValue}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if (appUser.currentValue >= appUser.invested)
                      Text(
                        'Profit: ${appUser.profit}',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    else
                      Text(
                        'Loss ${appUser.loss}',
                        style: Theme.of(context).textTheme.headline6,
                      )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            'Investments',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.investTransactions.length,
              itemBuilder: (_, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: ListTile(
                    title: Text(state.investTransactions[index].name),
                    leading: Text(state.investTransactions[index].symbol),
                    trailing: Text(state.investTransactions[index].tokens
                        .toStringAsPrecision(8)),
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
