#AGENTS.md

## 当需要使用编程能力解决问题的时候,务必使用**uv+python**
* python 3.11
* 以当前工作目录作为项目根目录
* uv init --python 3.11 .
* uv add 添加依赖
* 编写 python script
* uv run script.py

## SOP编写流程
### 确认{path}: 比如abc.t1.abc 表示 ./abc/t1/abc.py
### 如果任务已经进行中，选择在原基础上继续
### IPO, 确认input,output: 都是json类型
### 编程规范
* class使用中文
* docs 是测试用例的input
### 示例代码
```python
from pocket import Node,Flow,build_mermaid,EXEC

import time

class 内容总结(Node):
    def prep(self, shared):
        return shared.get("data","")

    def exec(self, prep_res):
        if not prep_res:
            return "Empty file content"

        time.sleep(2)

        prompt = f"Summarize this text in 10 words: {prep_res}"
        summary = prompt #call_llm(prompt)  # might fail
        return summary

    def exec_fallback(self, prep_res, exc):
        # Provide a simple fallback instead of crashing
        return "There was an error processing your request."

    def post(self, shared, prep_res, exec_res):
        shared["answer"] = exec_res
        # Return "default" by not returning


def pocketflow(shared,headers={},doc=False):

    summarize_node = 内容总结(max_retries=3)

    flow = summarize_node

    docs = {"data":"content"}

    return EXEC(flow,docs,shared,doc)
```
### 测试用例,注意替换path和input
uv run python -c "path = 'SOP.node';import sys, os; sys.path.append(os.getcwd()); from importlib import reload, import_module; agt = import_module(path); reload(agt); print(agt.pocketflow(input, {}))"

### 在根目录生成完整用例报告:{path}.tdd.md
