# 进度报告2（第4周·Dart语言基础一）

- 仓库地址：https://github.com/smfals/mapping （本文件位于 `lecture2/progress.md`）
- 配套案例工程：`lecture2/dart_basics`

## 一、任务理解

本次作业要完成第 2 课"Dart 语言基础一"的案例复现：用 `dart create` 创建纯 Dart 工程 dart_basics，填充变量与类型（含空安全四件套）、函数（命名参数/箭头函数）、运算符与控制流三组示例并保证 `dart run` 全部输出正确、无编译告警；每步做一次规范 Git 提交（≥3 次）；再与 TraeCode 完成一轮"AI 出题、我作答、AI 批改、我复核"的对拍练习（范围：空安全、命名参数、整除），分歧要记录。

验收标准：
1. `dart run` 输出正确且 `dart analyze` 无任何告警；
2. 仓库有 ≥3 次规范提交（feat/docs 前缀）；
3. 对拍练习 5 题有本人答案、参考答案与复核结论；
4. 能口头解释 `??` 与 `!` 的区别：`??` 是"左为 null 时取右值"的安全兜底，永不抛错；`!` 是"我断言它非 null"的强制解包，若实际为 null 会在运行时抛错——前者安全，后者慎用。

## 二、环境与工具

| 项目 | 版本/说明 |
|---|---|
| OS | Windows 11 (10.0.26200) |
| Dart SDK | 3.13.4 (stable) |
| Flutter | 3.41.3（本次未用到 UI，仅共用 SDK）|
| AI 工具 | TraeCode（Trae CN，内置大模型） |
| 运行目标 | 控制台（纯 Dart，无 Web/模拟器依赖） |
| 包镜像 | PUB_HOSTED_URL=https://pub.flutter-io.cn |

## 三、过程记录（时间线）

1. `git clone https://github.com/smfals/mapping.git D:\mapping`（空仓库）；
2. `dart create dart_basics` 于 `lecture2/` 下 → 首次 `pub get` 因终端沙箱权限失败，沙箱外重跑成功 → **提交1** `feat: dart create dart_basics`；
3. 新建 `bin/types_demo.dart`、`bin/func_demo.dart`、`bin/flow_demo.dart`，改写 `bin/dart_basics.dart` 统一调用；
4. `dart analyze` 发现 2 个告警（dead_code、unnecessary_non_null_assertion），重构空安全演示为函数入参形式消除告警；
5. `dart analyze` → `No issues found!`，`dart run` 输出全部正确 → **提交2** `feat: types/func/flow demos all pass`；
6. 对拍练习：AI 出 5 题 → 手写答案 → AI 给参考答案 → 逐题复核，发现 2 处分歧并实测澄清 → 记录于 `lecture2/docs/ai_quiz_round1.md` → **提交3** `docs: ai quiz round 1 records`；
7. 截图证据采集（dart run 输出、git log）→ 填写本报告 → **提交4** `docs: lecture2 progress report`；
8. `git push origin main`。

## 四、关键代码

### 4.1 空安全四件套（本人编写，AI 协助消除告警）

```dart
String? readNickname(bool hasValue) => hasValue ? 'hu' : null;

void showNullable(String? nickname) {
  print(nickname?.length);      // ?. 安全调用：null 则短路返回 null
  print(nickname ?? '未填写');   // ?? 左侧为 null 时取右侧默认值
  if (nickname != null) {
    print(nickname.length);     // 判空后类型提升为 String，可直接用
  }
  print(readNickname(true)!.length); // ! 空断言：对无法提升的表达式强制解包
}
```

逐行解释：`String?` 声明可空类型；`?.` 在接收者为 null 时整条表达式短路为 null；`??` 提供兜底值；`if` 判空触发 Dart 的类型提升（type promotion），之后按非空用；`!` 用在分析器无法提升的场景（函数返回值），为 null 会运行时抛 `TypeError`。
**验证方式**：`dart run` 输出 `null / 未填写 / 2 / 2`，与预期一致；`dart analyze` 无告警。

### 4.2 命名参数函数（本人编写）

```dart
void enroll({required String name, int age = 18, String? className}) {
  final cls = className ?? '未分班';
  print('enroll: name=$name, age=$age, className=$cls');
}
// 调用：enroll(name: '李华', className: '2班'); enroll(name: '王五', age: 20);
```

解释：`{}` 内为命名参数，`required` 必填（漏传是编译错误），`age` 有默认值，`className` 可空可省略；这是 Flutter 组件构造函数的统一风格。
**验证方式**：输出 `name=李华, age=18, className=2班` 与 `name=王五, age=20, className=未分班`。

### 4.3 整除与分级器（本人编写，AI 对拍题同源）

```dart
print(7 / 2);   // 3.5  —— / 永远返回 double
print(7 ~/ 2);  // 3    —— ~/ 才是整数商

String gradeOf(int score) {
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';
}
```

解释：`/` 与 `~/` 的区别是本次最高频失分点；`gradeOf` 演示条件必须为 bool 的 if 链。
**验证方式**：对拍第 4 题我初稿把 `7 ~/ 2` 错答为 3.5，运行后更正为 3。

## 五、检查点结果

- `dart analyze`：**No issues found!**（截图 01 上半部）
- `dart run`：三组示例输出全部正确（截图 01 下半部）
- 空安全改写练习：`!` 用在 null 上会抛错（对拍第 2 题实测）；`??` 与 `!` 区别可口头解释（见第一节验收标准第 4 条）
- Git 提交：4 次规范提交（截图 02）

## 六、问题与调试

**问题1（真实）**：首次 `dart create` 后 `pub get` 报 `拒绝访问`（沙箱限制写入 Pub 缓存目录）。定位：错误信息含 `_temp\dir` 路径与 errno=5，确认是权限而非网络问题。解决：在沙箱外重跑 `dart pub get`，48 个依赖安装成功。

**问题2（真实）**：`dart analyze` 报 `dead_code` 与 `unnecessary_non_null_assertion` 两个告警——原写法里 `nickname` 先为 null 再立即赋值，分析器能推断出确定值，导致 `?.` 分支成死代码、`!` 多余。解决：把演示重构为函数入参 `showNullable(String? nickname)`，分析器无法推断入参，语义保留且告警清零。收获：空安全演示要"骗过"流程分析才有教学意义。

**问题3（对拍分歧）**：局部 `late` 变量未初始化，在新版 Dart（3.13）是**编译错误**而非运行时 `LateError`（仅顶层/字段 late 才运行时抛）。通过 `quiz_verify.dart` 实测澄清并记录。

## 七、AI 使用记录（TraeCode 使用清单）

| 用途 | 指令摘要 | 输出 | 本人验证方式 |
|---|---|---|---|
| 环境诊断 | "解决打不开模拟器的问题"（第1课遗留） | 定位缺 NDK r28c，从腾讯云镜像离线下载安装 | 模拟器跑通计数器应用并截图 |
| 镜像配置 | "帮我配置国内镜像源" | Gradle 双文件加阿里云镜像、确认 Flutter 系统级镜像 | `--refresh-dependencies` 日志确认走 aliyun，构建 17s 通过 |
| 对拍出题 | "基于空安全、命名参数、整除出 5 道预测输出题" | 5 题 + 参考答案 + 讲解 | 手写答案逐题比对，分歧 2 处实测澄清 |
| 告警修复 | "消除 dead_code / unnecessary_non_null_assertion" | 重构为入参演示的建议与代码 | `dart analyze` 复查 No issues found |
| 报告撰写 | "按十节模板生成进度报告" | 本文件初稿 | 对照检查点逐项核对数据与截图 |

## 八、证据截图

1. **screenshots/01_dart_run_output.png**：`dart analyze` 显示 "No issues found!"，`dart run` 三组示例完整输出；
2. **screenshots/02_git_log.png**：`git log --oneline` 显示 4 次规范提交，`git remote -v` 指向 smfals/mapping；
3. **screenshots/03_environment.png**：Dart 3.13.4 / Flutter 版本环境信息。

## 九、自评

| 要求 | 完成情况 |
|---|---|
| dart_basics 完整复现（15） | ✔ 三组示例 + main 统一调用，输出正确 |
| 检查点：无告警/输出正确/能解释 ??与!（5） | ✔ 全部满足 |
| Git 规范：≥3 次规范提交（5） | ✔ 4 次，feat/docs 前缀 |
| 报告记录完整（5） | ✔ 十节齐全，对拍分歧已记录 |

## 十、一句话收获与下一步计划

**收获**：Dart 的空安全不是语法负担而是编译器契约——`?.`/`??` 把 null 处理变成显式选择，`!` 是把责任揽到自己身上的声明，能不用就不用。

**遗留问题**：switch 模式匹配只接触了表达式形式，解构与守卫待练；`late` 在局部/顶层行为差异需再巩固。
**预习要点（第3课）**：集合 List/Map/Set 的常用操作与遍历、函数作为回调参数传递、泛型基础。
