import 'package:flutter/material.dart';

class SubBalDashBoardController extends ChangeNotifier {
  TextEditingController balStringController = TextEditingController();
  List<String> result = [];

  List<String> getBalancedSubstrings(String S) {
    result = [];
    bool isBalanced(String substring) {
      var charCount =
          substring.split('').fold<Map<String, int>>({}, (map, char) {
        map[char] = (map[char] ?? 0) + 1;
        return map;
      });
      return charCount.keys.length == 2 &&
          charCount.values.first == charCount.values.last;
    }

    void findBalSubXtring(int start, String current) {
      if (start >= S.length) {
        if (isBalanced(current) &&
            (result.isEmpty || current.length > result[0].length)) {
          result = [current];
        } else if (isBalanced(current) && current.length == result[0].length) {
          result.add(current);
        }
        return;
      }
      findBalSubXtring(start + 1, current + S[start]);
      findBalSubXtring(start + 1, current);
    }

    notifyListeners();

      findBalSubXtring(0, "");
    return result;
  }
}
