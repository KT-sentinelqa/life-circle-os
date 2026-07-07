# Stage 1: Build & Dependencies
FROM python:3.11-slim AS builder

WORKDIR /app
COPY requirements.txt .

# Install dependencies into a virtualenv
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Production Runtime
FROM python:3.11-slim

# Create a non-root user (Security Best Practice)
RUN groupadd -r lifecircle && useradd -r -g lifecircle appuser

WORKDIR /app

# Copy virtualenv from builder
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code
COPY . .

# Change ownership to non-root user
RUN chown -R appuser:lifecircle /app
USER appuser

# Expose FastAPI port
EXPOSE 8000

# Run Uvicorn without root privileges
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]
