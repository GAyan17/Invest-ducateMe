import 'package:flutter/material.dart';

import '../../../data/models/models.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key, required this.appUser}) : super(key: key);
  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8.0,
        ),
        Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: [
                Text(
                  'Total Money: ${appUser.totalMoney}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Invested: ${appUser.invested}'),
                    Text('Current Value: ${appUser.currentValue}'),
                    if (appUser.currentValue >= appUser.invested)
                      Text('Profit: ${appUser.profit}')
                    else
                      Text('Loss ${appUser.loss}')
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
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.topCenter,
          child: const Text('Investments'),
        )
      ],
    );
  }
}
