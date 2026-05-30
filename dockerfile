# 1. Made With ML 환경과 호환되는 Python 베이스 이미지 선택 (3.10 버전 사용)
FROM python:3.10-slim

# 2. 컨테이너 내부 작업 디렉토리 설정
WORKDIR /workspaces/Made-With-ML

# 3. 코드 구동 및 레이 훈련에 필요한 리눅스 필수 패키지 설치
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 4. 프로젝트의 requirements.txt를 먼저 복사 (캐싱 활용)
COPY requirements.txt .

# 5. pip 최신화 및 패키지 설치 (의존성 꼬임 방지)(용량 극최적화)
RUN pip install --no-cache-dir --upgrade pip setuptools==69.5.1 packaging==24.0 && \
    pip install --no-cache-dir --no-compile -r requirements.txt && \
    rm -rf /root/.cache/pip

# 6. 현재 프로젝트 폴더의 전체 소스코드(madewithml 폴더 등)를 복사
COPY . .

# 7. 기본 실행 명령어 (우선 컨테이너가 바로 꺼지지 않고 대기하도록 설정)
CMD ["bash"]