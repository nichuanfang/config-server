# linux常见指令

## 命令输出数据筛选

* 命令:

```Shell script
<command1> | grep <condition> | grep -v grep |awk '{print $<num>}' | xargs <command2>
```

* 参数说明:

```text
command1: 被筛选的输出指令

condition: 筛选的条件

num: num默认从1开始

command2: 新指令
```

* 指令解释:
  
```text
grep <condition>: 按行进行筛选

grep -v grep: 过滤掉grep本身的进程,如果command1非进程输出,可不选

awk '{print $<num>}': 按列进行筛选,空格分割

xargs <command2>: 通过之前的stdout作为stdin参数代入到新指令中
```

## 后台运行

* 命令

```bash
nohup <command> 1>/dev/null 2>$1 &
```
* 参数说明

```bash
command: 需要后台运行的命令
```
* 指令解释

```text
nohup: 不弹窗

1>/dev/null: 将标准输出重定向到linux中的黑洞中

2>$1: 将错误信息重定向到标准输出中

$: 后台运行
```
