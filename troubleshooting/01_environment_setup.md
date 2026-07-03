## Python version
madewithml은 python 3.10 버전을 요구한다.
pyenv 또는 가상환경에서의 버전 지정을 하지 않으면 requirements.txt의 라이브러리들이 호환되지 않아 계속해서 오류가 발생한다.<br><br>  




## library version
일반적으로 requirements.txt에서 버전들이 지정되어있고, 
```
python3 -m pip install -r requirements.txt
```
위의 명령어를 통해서 해당 버전 라이브러리들을 설치하게 된다.
하지만 모든 라이브러리가 requirements에 담겨있지는 않다. 이런 경우 **'알아서'** 버전을 설치하게 되는데, 이게 멀쩡한 버전이 아닐 때도 많다.<br>


내가 마주한 오류들은 아래와 같다.
>#setuptool 문제<br>
RayTaskError(ModuleNotFoundError): ray::_get_reader() (pid=6412, ip=10.0.10.213)
File "/workspaces/Made-With-ML/madewithml/venv/lib/python3.10/site-packages/ray/data/read_api.py", line 2348, in _get_reader
reader = ds.create_reader(**kwargs)
File "/workspaces/Made-With-ML/madewithml/venv/lib/python3.10/site-packages/ray/data/datasource/file_based_datasource.py", line 256, in create_reader
return _FileBasedDatasourceReader(self, **kwargs)
File "/workspaces/Made-With-ML/madewithml/venv/lib/python3.10/site-packages/ray/data/datasource/file_based_datasource.py", line 476, in init
_check_pyarrow_version()
File "/workspaces/Made-With-ML/madewithml/venv/lib/python3.10/site-packages/ray/data/_internal/util.py", line 78, in _check_pyarrow_version
from pkg_resources._vendor.packaging.version import parse as parse_version
ModuleNotFoundError: No module named 'pkg_resources._vendor'
  <br>
  
>#protobuf 문제<br>
ImportError: cannot import name 'service' from 'google.protobuf' (/workspaces/Made-With-ML/madewithml/venv/lib/python3.10/site-packages/google/protobuf/init.py)
  <br>

>#numpy 문제<br>
ValueError: numpy.dtype size changed, may indicate binary incompatibility. Expected 96 from C header, got 88 from PyObject****
* numpy는 ValueError인데 무슨 상관인가 싶겠지만, 기존에는 88개의 PyObject를 받던 기능이 96개를 받아야한다며 오류를 일으켰다.<br><br>

### old_version file
<img width="448" height="44" alt="image" src="https://github.com/user-attachments/assets/f8e9fafb-54d2-4d98-8918-68e45d7af885" />
현재 내가 수정한 requirements.txt 파일의 일부이다.
원래는 아래와 같이 air로 한꺼번에 가져오게 되는데
```
ray[air]==2.7.0
```

문제는 air가 2.7.0부턴 삭제되었다. 그러니까 requirements를 사진에서처럼 따로 명시해서 다 불러주어야 오류가 일어나지 않는다.
