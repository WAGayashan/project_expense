import 'dart:math';
import 'package:flutter_application_1/models/cost_model.dart';
import 'package:flutter_application_1/models/type_model.dart';

final rand = Random();

final List<double> weeklySpending = [
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
];

_generateExpenses() {
  List<CostModel> costModel = [
    CostModel(name: 'Item 0', cost: rand.nextDouble() * 100),
    CostModel(name: 'Item 1', cost: rand.nextDouble() * 500),
    CostModel(name: 'Item 2', cost: rand.nextDouble() * 500),
    CostModel(name: 'Item 3', cost: rand.nextDouble() * 100),
    CostModel(name: 'Item 4', cost: rand.nextDouble() * 500),
    CostModel(name: 'Item 5', cost: rand.nextDouble() * 400),
  ];
  return costModel;
}

List<TypeModel> typeNames = [
  TypeModel(name: 'House', maxAmount: 30000, expenses: _generateExpenses()),
  TypeModel(name: 'Groceries', maxAmount: 5000, expenses: _generateExpenses()),
  TypeModel(name: 'Food', maxAmount: 5000, expenses: _generateExpenses()),
  TypeModel(name: 'Utilities', maxAmount: 4000, expenses: _generateExpenses()),
  TypeModel(name: 'Entertainment', maxAmount: 2000, expenses: _generateExpenses()),
  TypeModel(name: 'Transport', maxAmount: 3000, expenses: _generateExpenses()),
];
