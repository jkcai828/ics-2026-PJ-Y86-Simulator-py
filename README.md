# Y86-64 Simulator (Python 框架)

## 简介

在本实验中，你将实现一个 Y86-64 指令集 CPU 模拟器。此仓库中，我们在 `cpu.py` 中已经为你搭建好了文件解析器（Parser）和主循环骨架。你的任务是补全各个执行阶段的核心数据通路逻辑。

```bash
.
├─ test/           # 测试指令文件 (.yo 机器码文件)
├─ answer/         # 指令执行的标准结果快照 (.json)
├─ test.py         # 自动化评测脚本：运行模拟器 + 严格比对结果
└─ cpu.py          # 你需要完善的模拟器源代码
```

## 测试方法

请确保在 Python 3 环境下运行。使用以下命令进行自动化测试与评分：

```bash
python test.py --bin "python cpu.py"
```

如果你只想测试单个文件以观察输出格式，可以使用标准输入重定向：
```bash
python cpu.py < test/abs-asum-cmov.yo
```

---

## 实验任务

为了通过所有测试用例，你需要在 `cpu.py` 相应的 `TODO` 处实现以下 Y86-64 核心指令集的逻辑：

- **数据传送指令**：`irmovq`, `rrmovq`, `mrmovq`, `rmmovq`
- **条件传送指令**：`cmovXX` (包括 `cmovle`, `cmovl`, `cmove`, `cmovne`, `cmovge`, `cmovg`)
- **算术与逻辑运算指令 (`OPq`)**：`addq`, `subq`, `andq`, `xorq`（需正确更新 `ZF`, `SF`, `OF` 条件码）
- **分支与跳转指令**：`jmp` (无条件跳转) 以及 `jXX` (条件跳转，如 `je`, `jne`, `jle` 等)
- **函数调用与栈操作**：`pushq`, `popq`, `call`, `ret`
- **系统控制**：`halt`, `nop`

完成后请把仓库链接提交至 E-Learning 平台。

你需要另行准备用于汇报的演示文稿，并单独提交到 E-Learning 平台的另一个作业上。

## 本实现说明

`cpu.py` 按照 Y86-64 顺序处理器的五个数据通路阶段实现：取指、译码、执行、访存、写回，并在每条指令结束时更新 PC。寄存器和内存内部统一保存为 64 位无符号值，输出快照时转换为有符号补码表示，以保持与评测器的 JSON 格式一致。

已覆盖框架要求的全部指令：

- `halt`、`nop`
- `rrmovq`/`cmovXX`、`irmovq`、`rmmovq`、`mrmovq`
- `addq`、`subq`、`andq`、`xorq`，以及 `ZF/SF/OF` 条件码
- `jmp`/`jXX`
- `call`、`ret`、`pushq`、`popq`

同时实现了指令编码和 `ifun` 合法性检查、内存越界检测、非法指令状态（`INS`）、地址错误状态（`ADR`），以及 `popq %rsp` 时由内存值覆盖栈指针的 Y86 语义。

## 复现与验收

无需第三方 Python 包，Python 3.8+ 即可运行：

```bash
./test.sh
# 或
python3 test.py --bin "python3 cpu.py"
```

当前仓库中的 21 个公开测试全部通过，基准分为 `60.00 / 60.00`。单个程序可用以下命令观察完整状态轨迹：

```bash
python3 cpu.py < test/abs-asum-cmov.yo
```
