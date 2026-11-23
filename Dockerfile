# Hola-Calendar on Railway: upstream Ray-hola/Hola-Calendar (MIT) built from its own Dockerfile recipe at commit
# 829d578 (Nov 16, 2026; upstream publishes no server image or release tags). Application unmodified.
# Railway layer: listens on 8080, SQLite on the /data volume, Secure session cookie + HTTPS origin, and on first boot
# railway/start.py sets the seeded superadmin password from HOLA_ADMIN_PASSWORD (upstream writes random passwords to
# a file inside the volume, which Railway users cannot read).
FROM alpine/git:v2.49.1 AS src
RUN git clone https://github.com/Ray-hola/Hola-Calendar /src && cd /src && git checkout 829d578ace5b2b5a6ea5ba7a378df67627109743

FROM python:3.12-slim
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/hola-calendar"
ENV PYTHONUNBUFFERED=1 \
    WORK_CALENDAR_HOST=0.0.0.0 \
    WORK_CALENDAR_PORT=8080 \
    WORK_CALENDAR_DB=/data/work-calendar.sqlite3 \
    WORK_CALENDAR_SECURE_COOKIE=1
WORKDIR /app
RUN pip install --no-cache-dir tzdata
COPY --from=src /src/server.py /src/agent_workspace.py /src/assistant_privacy.py /src/app.js /src/i18n.js /src/index.html /src/styles.css ./
COPY railway/start.py /railway-start.py
EXPOSE 8080
CMD ["python", "/railway-start.py"]
