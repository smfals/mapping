# AI 对拍练习记录（第 1 轮）

- 日期：2026-10-04
- 方式：TraeCode 出题（指定范围：空安全、命名参数、整除）→ 本人先手写答案 → TraeCode 生成参考答案与讲解 → 逐题复核，记录分歧。

---

## 第 1 题（空安全 · 预测输出）

```dart
void main() {
  String? a;
  print(a?.length);
  print(a ?? '空');
  a = 'dart';
  print(a!.length);
}
```

**本人手写答案**：`null`、`空`、`4`
**参考答案**：`null`、`空`、`4`
**讲解**：`?.` 遇 null 短路返回 null；`??` 左为 null 取右值；`a` 已赋值后 `!` 断言成立。
**复核结论**：一致。

## 第 2 题（空安全 · 找错误）

```dart
void main() {
  late String token;
  print(token);
}
```

**本人手写答案**：运行时抛错，因为 late 变量没赋值就用。
**参考答案**：运行时抛出 `LateInitializationError`（运行时类型名为 `LateError`）。`late` 是"承诺使用前赋值"，违约在运行时暴露。
**实际运行验证**：顶层 late 变量确实抛 `LateError`；**但新版 Dart（3.13）对"局部 late 变量"更严格**——`late String token; print(token);` 写在 main 里直接是**编译错误**（`Late variable 'token' without initializer is definitely unassigned`），根本运行不起来。这一点与参考答案的描述有出入，已通过实测确认：题目代码按局部变量理解时答案应为"编译错误"。
**复核结论**：部分分歧，已实测澄清（局部=编译错误，顶层/字段=运行时 LateError）。

## 第 3 题（命名参数 · 判断能否通过编译）

```dart
void enroll({required String name, int age = 18}) {}
void main() {
  enroll(age: 20);
}
```

**本人手写答案**：不能，少了 name。
**参考答案**：编译错误——`The named parameter 'name' is required`。`required` 标记的命名参数调用时必须提供；`age` 有默认值 18 可省略。
**复核结论**：一致。

## 第 4 题（整除 · 预测输出）

```dart
void main() {
  print(7 / 2);
  print(7 ~/ 2);
  print(7 % 2);
}
```

**本人手写答案（初稿）**：`3.5`、`3.5`、`1`
**参考答案**：`3.5`、`3`、`1`
**讲解**：`/` 在 Dart 中永远返回 double（即使整除）；`~/` 才是整数商；`%` 取余。
**复核结论**：**有分歧**——我把 `~/` 的输出也写成了 3.5，复核后确认整数除法结果向零取整为 3。已记入进度报告"问题与调试"节。

## 第 5 题（综合 · 预测输出）

```dart
String greet(String name, [String? title]) => title ?? '你好，$name';
void main() {
  print(greet('张三'));
  print(greet('张三', '同学'));
}
```

**本人手写答案**：`你好，张三`、`同学`
**参考答案**：`你好，张三`、`同学`
**讲解**：位置可选参数省略时为 null，`??` 回退到默认文案；传入 `'同学'` 时原样返回。
**复核结论**：一致。

---

## 汇总

| 题号 | 知识点 | 本人答案 | 是否正确 |
|---|---|---|---|
| 1 | 空安全 ?. ?? ! | null / 空 / 4 | ✔ |
| 2 | late 未初始化 | 运行时抛错 | 部分正确（局部 late 实为编译错误，实测澄清）|
| 3 | required 命名参数 | 编译错误 | ✔ |
| 4 | / 与 ~/ 区别 | 3.5 / 3.5 / 1 | ✘（复核后更正为 3.5 / 3 / 1）|
| 5 | 可选位置参数 + ?? | 你好，张三 / 同学 | ✔ |

正确率 4/5，分歧 2 处（第 2 题 late 语义细分、第 4 题整除 `~/`），均已通过参考答案与实际运行验证更正。
