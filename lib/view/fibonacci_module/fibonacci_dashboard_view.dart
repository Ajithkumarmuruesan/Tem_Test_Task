import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:tem_assessment_firebase/controllers/fibo_dashboard_controller.dart';

class FibonacciDashboardView extends StatelessWidget {
  const FibonacciDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FibonacciDashBoardController>(
        builder: (context, controller, _) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFFf5eded),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Fibonacci',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            TextField(
              controller: controller.posistionController,
              decoration: InputDecoration(
                labelText: 'Enter a position',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: controller.calculateFibonacci,
            ),
            // SizedBox(height: 20),
            Text(
              'Fibonacci posotion value : ${controller.fibonacciValue}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ));
    });
  }
}
