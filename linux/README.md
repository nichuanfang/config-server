# linux常见指令

## 命令输出数据筛选

* 命令:

```Shell script
<command1> | grep <condition> | grep -v grep |awk '{print $<num>}' | xargs <command2>
```

* 参数说明:

```text
    command1: 被筛选的输出指令
    
    condition: 筛选的条件,按行进行筛选

    num: num默认从1开始

    command2: 新指令
```

* 指令解释:
  
```text
    grep -v grep: 过滤掉grep本身的进程,如果command1非进程输出,可不选

    awk '{print $<num>}': 按列进行筛选

    xargs <command2>: 通过之前的`stdout`作为`stdin`参数代入到新指令中
```
