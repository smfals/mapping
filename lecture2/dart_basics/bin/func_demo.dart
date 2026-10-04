/// 函数演示：普通声明、箭头简写、命名参数与默认值。
int add(int a, int b) {
  return a + b;
}

// 箭头函数：单表达式简写
int add2(int a, int b) => a + b;

// 命名参数：required 必填，其余可给默认值或可空
void enroll({required String name, int age = 18, String? className}) {
  final cls = className ?? '未分班';
  print('enroll: name=$name, age=$age, className=$cls');
}

// 位置可选参数：方括号，可省略
String greet(String name, [String? title]) {
  return title == null ? '你好，$name' : '你好，$title$name';
}

void funcDemo() {
  print('add(2, 3)=${add(2, 3)}');
  print('add2(2, 3)=${add2(2, 3)}');

  enroll(name: '李华', className: '2班'); // 命名参数任意顺序
  enroll(name: '王五', age: 20); // className 缺省为 null

  print(greet('张三'));
  print(greet('张三', '同学'));

  // 函数是一等公民：可赋给变量
  final fn = add2;
  print('fn(10, 20)=${fn(10, 20)}');
}
