import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final num totalMoney;
  final num invested;
  final num currentValue;
  final num profit;
  final num loss;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.totalMoney = 1000.0,
    this.invested = 0.0,
    this.currentValue = 0.0,
    this.profit = 0.0,
    this.loss = 0.0,
  });

  factory AppUser.fromDocument(Map<String, dynamic> data) => AppUser(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        totalMoney: data['total_money'],
        invested: data['invested'],
        currentValue: data['current_value'],
        profit: data['profit'],
        loss: data['loss'],
      );

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'total_money': totalMoney,
      'invested': invested,
      'current_value': currentValue,
      'profit': profit,
      'loss': loss,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        totalMoney,
        invested,
        currentValue,
        profit,
        loss,
      ];
}
