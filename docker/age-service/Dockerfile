FROM python:3.11

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgl1 \
        libglib2.0-0 \
        build-essential \
        cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3535

# age_service.py is bind-mounted via docker-compose
CMD ["python", "age_service.py"]
