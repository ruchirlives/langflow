FROM python:3.10.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 user

USER user

ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    PYTHONUNBUFFERED=1

WORKDIR $HOME/app

COPY --chown=user:user . $HOME/app

RUN pip install --no-cache-dir --user "langflow>=0.5.0"

CMD ["python", "-m", "langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
