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

    return fibonacciRecur(n, BigInt.zero, BigInt.one);
  }

  BigInt fibonacciRecur(int n, BigInt a, BigInt b) {
    if (n == 0) return a;
    if (n == 1) return b;
    return fibonacciRecur(n - 1, b, a + b);
  }

  //   BigInt a = BigInt.zero;
  //   BigInt b = BigInt.one;

  //   for (int i = 2; i <= n; i++) {
  //     BigInt temp = a + b;
  //     a = b;
  //     b = temp;
  //   }

  //   return b;
  // }
}
