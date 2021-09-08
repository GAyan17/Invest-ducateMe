import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../data/models/models.dart';

class BuyCurrency extends StatefulWidget {
  final CryptoCurrency cryptoCurrency;
  final TransactionCubit transactionCubit;

  const BuyCurrency(
      {Key? key, required this.cryptoCurrency, required this.transactionCubit})
      : super(key: key);

  @override
  _BuyCurrencyState createState() => _BuyCurrencyState();
}

class _BuyCurrencyState extends State<BuyCurrency> {
  num tokens = 0;
  num amount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.cryptoCurrency.name,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Percent Change in 1h: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              widget.cryptoCurrency.percentChange1h.toStringAsPrecision(6),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Percent Change in 24h: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              widget.cryptoCurrency.percentChange24h.toStringAsPrecision(6),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Percent Change in 7d: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              widget.cryptoCurrency.percentChange7d.toStringAsPrecision(6),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Amount you have: ',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              '\$ ${context.read<AuthBloc>().currentUser.totalMoney}',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                labelText: 'Money Invest in Dollars',
                icon: const Icon(Icons.monetization_on),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  amount = num.parse(value);
                  tokens = amount / widget.cryptoCurrency.qoutePriceUSD;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tokens: ',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              '$tokens',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
            onPressed: tokens > 0
                ? () async {
                    await widget.transactionCubit.createInvestTransaction(
                        InvestTransaction(
                            id: 'IV${DateTime.now().microsecondsSinceEpoch.toString()}${widget.cryptoCurrency.symbol}',
                            cmpId: widget.cryptoCurrency.id,
                            symbol: widget.cryptoCurrency.symbol,
                            name: widget.cryptoCurrency.name,
                            amountSpend: amount,
                            tokenAmount: widget.cryptoCurrency.qoutePriceUSD,
                            tokens: tokens,
                            timeStamp: DateTime.now()));
                    var appUser = context.read<AuthBloc>().currentUser;
                    context.read<AppUserCubit>().updateUser(
                        appUser.id,
                        appUser.copyWith(
                            totalMoney: appUser.totalMoney - amount));
                    Navigator.of(context).pop();
                  }
                : null,
            child: const Text('Buy'))
      ],
    );
  }
}
