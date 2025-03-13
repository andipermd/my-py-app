# Gunakan image Python resmi sebagai base image
FROM python:3.9-slim

# Install library sistem yang diperlukan
RUN apt-get update && apt-get install -y \
    libexpat1 \
    libgdal-dev \
    gdal-bin \
    libgeos-dev \
    libproj-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory di dalam container
WORKDIR /app

# Copy requirements.txt ke working directory
COPY requirements.txt .

# Install dependensi Python
RUN pip install --no-cache-dir -r requirements.txt

# Copy seluruh kode aplikasi ke working directory
COPY . .

# Expose port yang digunakan aplikasi
EXPOSE 8000

# Command untuk menjalankan aplikasi
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]