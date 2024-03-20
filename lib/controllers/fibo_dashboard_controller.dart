import 'package:flutter/material.dart';

class FibonacciDashBoardController extends ChangeNotifier {
  BigInt fibonacciValue = BigInt.zero;
  TextEditingController posistionController = TextEditingController();
  void calculateFibonacci(String value) {
    int position = int.tryParse(value) ?? 0;
    BigInt fib = fibonacci(position);
    fibonacciValue = fib;
    notifyListeners();
  }

  BigInt fibonacci(int n) {
    if (n <= 0) return BigInt.zero;
    if (n == 1) return BigInt.one;

    BigInt a = BigInt.zero;
    BigInt b = BigInt.one;

    for (int i = 2; i <= n; i++) {
      BigInt temp = a + b;
      a = b;
      b = temp;
    }

    return b;
  }
}
