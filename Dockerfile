FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV UV_PROJECT_ENVIRONMENT=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app

RUN python -m venv /opt/venv
RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY src ./src

ENV PYTHONPATH=/app/src

EXPOSE 8005

ENTRYPOINT ["python", "/app/src/mcp_server_box.py"]
CMD ["--transport", "http", "--host", "0.0.0.0", "--port", "8005"]
