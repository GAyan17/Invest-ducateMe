import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final double totalMoney;
  final double invested;
  final double proft;
  final double loss;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.totalMoney = 1000.0,
    this.invested = 0.0,
    this.proft = 0.0,
    this.loss = 0.0,
  });

  static AppUser fromDocument(Map<String, dynamic> data) => AppUser(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        totalMoney: data['total_money'],
        invested: data['invested'],
        proft: data['profit'],
        loss: data['loss'],
      );

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'total_money': totalMoney,
      'invested': invested,
      'profit': proft,
      'loss': loss,
    };
  }

  @override
  List<Object?> get props => [id, name, email];
}
