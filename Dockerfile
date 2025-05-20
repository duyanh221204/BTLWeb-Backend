FROM python:3.12-slim

# 1. Không buffer Python output để log realtime
ENV PYTHONUNBUFFERED=1

# 2. Tạo thư mục làm việc
WORKDIR /app

# 3. Copy file dependencies trước để tận dụng cache
COPY requirements.txt .

# 4. Update pip và cài Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# 5. Copy toàn bộ source code vào container
COPY . .

# 6. Expose port (Railway sẽ map biến $PORT tự động)
EXPOSE 8000

# 7. Khởi động FastAPI với Uvicorn, dùng $PORT nếu có
CMD ["sh", "-c", "PORT_VAL=${PORT#None}; uvicorn main:app --host 0.0.0.0 --port ${PORT_VAL:-8000}"]
