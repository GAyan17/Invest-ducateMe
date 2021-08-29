import 'package:flutter/material.dart';
import 'package:invest_educate/data/models/models.dart';

class BuyCurrency extends StatelessWidget {
  final CryptoCurrency cryptoCurrency;
  const BuyCurrency({Key? key, required this.cryptoCurrency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          cryptoCurrency.name,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 10.0,
        ),
        //TODO: Add two input fields.
      ],
    );
  }
}
