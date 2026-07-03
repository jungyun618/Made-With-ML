## Workers
ray는 여러 cpu나 GPU에 일을 할당하기 때문에 그 worker들의 수와 각 작업에 그들을 몇 개씩 할당할지를 지정해주는게 필요하다.
코드의 앞부분에 이를 확인하는 코드가 있다.

여기서는 CPU 4개, GPU 0개 환경이다. (AWS 서버 t3.xlarge이다.)

아래에서 이를 그대로 설정해줄 수 있다. (기본 세팅은 GPU 1개가 있는 세팅)
resources_per_worker를 1 이상으로 지정하면 한 작업당 여러 worker가 붙는다.

근데 그대로 돌리면 갑자기 이상한 소리를 한다.
>WARNING insufficient_resources_manager.py:163 -- Ignore this message if the cluster is autoscaling. Training has not started in the last 60 seconds. This could be due to the cluster not having enough resources available. You asked for 5.0 CPUs and 0 GPUs, but the cluster only has 4.0 CPUs and 0 GPUs available. Stop the training and adjust the required resources (e.g. via the `ScalingConfig` or `resources_per_trial`, or `num_workers` for rllib), or add more resources to your cluster.

너 worker가 4개 밖에 없는데 왜 5개라고 말했냐고 경고를 띄운다.

원인은 Head Node이다.<br>
Ray Train은 연산을 수행할 때, 분산 학습을 지휘하는 Head Node (Driver 프로세스)에게 기본적으로 CPU 1개를 무조건 먼저 상납(할당)하도록 설계되어 있습니다.<br>
즉, 전체 필요한 CPU 계산 공식은 다음과 같습니다.

$$\text{필요 CPU 총합} = \text{대장(Head) 배정량 (기본 1개)} + (\text{num workers} \times \text{resources per worker})$$

즉, 설정을 CPU 4개, GPU 0개로 했지만, 실제로는 Head가 1개를 기본으로 가져가며 5개가 필요해진 것이다.
위에서 3으로 바꿔주면 해결된다.
