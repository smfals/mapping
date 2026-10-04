/// 运算符与控制流演示：整除、分支、循环。
String gradeOf(int score) {
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';
}

void flowDemo() {
  // / 结果为 double，~/ 为整除
  print('7 / 2 = ${7 / 2}'); // 3.5
  print('7 ~/ 2 = ${7 ~/ 2}'); // 3

  // if/else 分级器
  for (final s in [95, 83, 60, 41]) {
    print('score=$s -> ${gradeOf(s)}');
  }

  // switch 表达式（Dart 3）
  String level = switch (95) {
    >= 90 => 'A',
    >= 60 => 'B',
    _ => 'C',
  };
  print('switch 表达式: 95 -> $level');

  // for-in 遍历
  for (final i in [1, 2, 3]) {
    print('第$i题');
  }

  // while 与 break/continue
  var n = 0;
  while (true) {
    n++;
    if (n == 2) continue; // 跳过 2
    if (n > 3) break;
    print('while n=$n');
  }
}
