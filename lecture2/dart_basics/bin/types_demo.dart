/// 变量、内置类型、字符串插值与空安全四件套演示。
void typesDemo() {
  // 1. 变量声明：var 类型推断 / 显式类型 / final / const
  var title = '第一次作业'; // 推断为 String，之后不能再赋 int
  int year = 2026;
  double score = 92.5;
  final now = DateTime.now(); // final：运行时确定一次
  const pi = 3.14159; // const：编译期常量
  print('title=$title, year=$year, score=$score, pi=$pi');
  print('now 是运行时值: ${now.year} 年');

  // 2. 字符串插值：变量用 $，表达式用 ${}
  String name = '李华';
  print('你好，$name，成绩${score + 5}');

  // 3. 空安全四件套（用入参避免分析器提前推断出具体值）
  showNullable(null);
  showNullable('hu');

  // 4. late：承诺使用前必赋值
  late String token;
  token = 'abc123';
  print('token=$token');

  // 5. 翻车点验证：if (name) 是编译错误，字符串不能当布尔用
  if (name.isNotEmpty) {
    print('name 非空（必须用 bool 表达式）');
  }
}

/// 模拟从外部读取的可空值（分析器无法推断，用于演示 ! 空断言）。
String? readNickname(bool hasValue) => hasValue ? 'hu' : null;

/// 演示可空类型的四种处理：?. ?? ! 与默认值。
void showNullable(String? nickname) {
  print(nickname?.length); // ?. 安全调用：null 短路
  print(nickname ?? '未填写'); // ?? 空则取默认值
  if (nickname != null) {
    print(nickname.length); // 判空后类型提升为非空
  }
  // ! 空断言：对无法类型提升的表达式断言非空（为 null 会运行时抛错，慎用）
  print(readNickname(true)!.length);
}
