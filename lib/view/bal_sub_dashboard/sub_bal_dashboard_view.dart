import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tem_assessment_firebase/controllers/sub_bal_dashboard_controller.dart';

class SubBalDashBoardView extends StatelessWidget {
  const SubBalDashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubBalDashBoardController>(
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
                    'Find Balanced String',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            TextField(
              controller: controller.balStringController,
              decoration: InputDecoration(
                labelText: 'Enter a String',
              ),
              keyboardType: TextInputType.text,
              onSubmitted: (value) {
                controller.getBalancedSubstrings(value);
              },
            ),
            // SizedBox(height: 20),
            Text(
              'Balanced substring value : ${controller.result}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ));
    });
  }
}
