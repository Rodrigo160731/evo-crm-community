# =============================================================================
# Evo AI — Stack de Aplicação (dokploy)
# =============================================================================
# Configure estas variáveis no painel do Dokploy antes de subir o stack.
# As variáveis de banco e Redis devem ser IDÊNTICAS às do stack de Infra.
#
# Para gerar segredos:
#   SECRET_KEY_BASE / JWT_SECRET_KEY / DOORKEEPER_JWT_SECRET_KEY:
#     openssl rand -hex 64
#   ENCRYPTION_KEY (32 bytes base64 URL-safe):
#     openssl rand -base64 32
#   EVOAI_CRM_API_TOKEN / BOT_RUNTIME_SECRET / AI_PROCESSOR_API_KEY:
#     uuidgen  ou  openssl rand -hex 32
# =============================================================================

# ── Banco de Dados (deve coincidir com o stack Infra) ─────────────────────────
POSTGRES_DATABASE=evo_community
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=troque_por_senha_forte

# ── Redis (deve coincidir com o stack Infra) ──────────────────────────────────
# REDIS_URL: usado pelos serviços Rails (auth, crm) e bot-runtime
# REDIS_PASSWORD: usado individualmente pelo CRM (Redis::Config) e pelo processor
REDIS_PASSWORD=troque_por_senha_forte

# ── Rails ─────────────────────────────────────────────────────────────────────
RAILS_ENV=production
RAILS_MAX_THREADS=5
RAILS_LOG_TO_STDOUT=true
LOG_LEVEL=info
SIDEKIQ_CONCURRENCY=10

# ── Segredos compartilhados ───────────────────────────────────────────────────
# Devem ser IGUAIS em todos os serviços que os utilizam
SECRET_KEY_BASE=GERE_COM_openssl_rand_hex_64
JWT_SECRET_KEY=GERE_COM_openssl_rand_hex_64
# ENCRYPTION_KEY: compartilhado entre core-service e processor
ENCRYPTION_KEY=GERE_COM_openssl_rand_base64_32
# EVOAI_CRM_API_TOKEN: token de autenticação entre serviços (auth → crm, processor → crm)
EVOAI_CRM_API_TOKEN=GERE_COM_uuidgen

# ── Doorkeeper OAuth2 (Auth Service) ─────────────────────────────────────────
# Carregado no initializer do Rails — necessário tanto no app quanto no sidekiq
DOORKEEPER_JWT_SECRET_KEY=GERE_COM_openssl_rand_hex_64
DOORKEEPER_JWT_ALGORITHM=hs256
DOORKEEPER_JWT_ISS=evo-auth-service
DOORKEEPER_JWT_AUD=[]
MFA_ISSUER=EvoAI

# ── URLs públicas (proxy/domínio exposto pelo Dokploy) ────────────────────────
# FRONTEND_URL: usado por auth e crm para CORS, links de e-mail, OAuth callbacks
FRONTEND_URL=https://app.seudominio.com
# BACKEND_URL: usado pelo CRM para gerar URLs de ActiveStorage e rotas de API
BACKEND_URL=https://crm.seudominio.com
# CORS_ORIGINS: lista separada por vírgula das origens permitidas
CORS_ORIGINS=https://app.seudominio.com

# ── Frontend — BUILD-TIME (variáveis VITE_* são embutidas na build) ───────────
# Devem ser as URLs públicas acessadas pelo browser do usuário final
VITE_APP_ENV=production
VITE_API_URL=https://crm.seudominio.com
VITE_AUTH_API_URL=https://auth.seudominio.com
# VITE_WS_URL: URL do WebSocket (normalmente igual ao VITE_API_URL)
VITE_WS_URL=https://crm.seudominio.com
VITE_EVOAI_API_URL=https://core.seudominio.com
VITE_AGENT_PROCESSOR_URL=https://processor.seudominio.com
# VITE_TINYMCE_API_KEY: chave do editor TinyMCE (deixar como no-api-key se não usar CDN pago)
VITE_TINYMCE_API_KEY=no-api-key

# ── SMTP / E-mail ─────────────────────────────────────────────────────────────
# Usado por auth e crm (fila de mailers no Sidekiq)
# Para Mailhog (stack infra): SMTP_ADDRESS=mailhog, SMTP_PORT=1025
SMTP_ADDRESS=mailhog
SMTP_PORT=1025
SMTP_DOMAIN=seudominio.com
SMTP_AUTHENTICATION=plain
SMTP_ENABLE_STARTTLS_AUTO=false
SMTP_USERNAME=
SMTP_PASSWORD=
MAILER_SENDER_EMAIL=noreply@seudominio.com

# ── Bot Runtime ───────────────────────────────────────────────────────────────
# LISTEN_ADDR: endereço de escuta interno (não alterar — porta externa é AI_PROCESSOR_API_KEY)
LISTEN_ADDR=0.0.0.0:8080
BOT_RUNTIME_SECRET=GERE_COM_openssl_rand_hex_32
AI_PROCESSOR_API_KEY=GERE_COM_openssl_rand_hex_32
AI_CALL_TIMEOUT_SECONDS=30

# ── Core Service (Go) ─────────────────────────────────────────────────────────
# DB_* usados pelo core — separados das variáveis POSTGRES_* do Rails
DB_SSLMODE=disable
DB_MAX_IDLE_CONNS=10
DB_MAX_OPEN_CONNS=100
DB_CONN_MAX_LIFETIME=1h
DB_CONN_MAX_IDLE_TIME=30m
JWT_ALGORITHM=HS256
AI_PROCESSOR_VERSION=v1

# ── Processor Service (Python / FastAPI) ─────────────────────────────────────
# Redis individual (o processor usa variáveis separadas, não REDIS_URL)
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_DB=0
REDIS_SSL=false
REDIS_KEY_PREFIX=a2a:
REDIS_TTL=3600
# Cache de ferramentas
TOOLS_CACHE_ENABLED=true
TOOLS_CACHE_TTL=3600
# Metadados da API (visíveis no Swagger do processor)
API_TITLE=Agent Processor Community
API_DESCRIPTION=Agent Processor Community for Evo AI
API_VERSION=1.0.0
ORGANIZATION_NAME=Evo AI
ORGANIZATION_URL=https://evoai.evoapicloud.com
# JWT do processor (gerado internamente se não definido, mas recomendado fixar)
JWT_EXPIRATION_TIME=3600
HOST=0.0.0.0
PORT=8000
DEBUG=false
APP_URL=https://processor.seudominio.com

# ── CRM específico ────────────────────────────────────────────────────────────
ENABLE_ACCOUNT_SIGNUP=true
DISABLE_TELEMETRY=true
ENABLE_PUSH_RELAY_SERVER=true
ENABLE_INBOX_EVENTS=true
LOG_SIZE=500
# ACTIVE_STORAGE_SERVICE: backend de storage do Rails (local ou s3 ou gcs ou azure)
ACTIVE_STORAGE_SERVICE=local

# ── Portas externas (host) ────────────────────────────────────────────────────
# Mude aqui no Dokploy para evitar conflito com outras stacks no mesmo host.
# As portas internas dos containers são fixas e não mudam.
#   evo-auth      → 3001 (interna)
#   evo-crm       → 3000 (interna)
#   evo-core      → 5555 (interna)
#   evo-processor → 8000 (interna)
#   evo-frontend  → 80/nginx (interna)
AUTH_EXTERNAL_PORT=3001
CRM_EXTERNAL_PORT=3000
CORE_EXTERNAL_PORT=5555
PROCESSOR_EXTERNAL_PORT=8000
FRONTEND_EXTERNAL_PORT=5173

# =============================================================================
# OPCIONAL — Storage em nuvem (padrão: filesystem local)
# =============================================================================
# Usado por auth (ACTIVE_STORAGE_SERVICE) e crm para uploads de arquivos.
# Descomente e configure o provedor desejado.

# ACTIVE_STORAGE_SERVICE=local

# # AWS S3
# STORAGE_BUCKET_NAME=
# STORAGE_ACCESS_KEY_ID=
# STORAGE_SECRET_ACCESS_KEY=
# STORAGE_REGION=
# STORAGE_ENDPOINT=

# # Google Cloud Storage (CRM)
# GCS_PROJECT=
# GCS_BUCKET=
# GCS_CREDENTIALS=

# # Azure Blob Storage (CRM)
# AZURE_STORAGE_ACCOUNT_NAME=
# AZURE_STORAGE_ACCESS_KEY=
# AZURE_STORAGE_CONTAINER=

# =============================================================================
# OPCIONAL — Artifacts do Processor (MinIO / S3-compatible)
# =============================================================================
# Usado pelo processor para armazenar arquivos e áudios gerados por agentes.

# ARTIFACT_SERVICE_TYPE=minio
# ARTIFACT_ENDPOINT=localhost:9000
# ARTIFACT_ACCESS_KEY=minioadmin
# ARTIFACT_SECRET_KEY=minioadmin
# ARTIFACT_SECURE=false
# ARTIFACT_REGION=us-east-1
# ARTIFACT_SPEECH_BUCKET=speech
# ARTIFACT_FILES_BUCKET=files
# ARTIFACT_AUTO_CREATE_BUCKETS=true

# =============================================================================
# OPCIONAL — Memória de agentes (Processor)
# =============================================================================
# MEMORY_SERVICE_TYPE=http
# MEMORY_ENABLED=true
# MEMORY_MAX_RESULTS=10

# =============================================================================
# OPCIONAL — Canais sociais (Auth / CRM)
# =============================================================================

# # Google OAuth (login social no auth)
# GOOGLE_OAUTH_CLIENT_ID=
# GOOGLE_OAUTH_CLIENT_SECRET=

# # Facebook Messenger (CRM)
# FB_VERIFY_TOKEN=evolution
# FACEBOOK_API_VERSION=v23.0
# FB_APP_SECRET=
# FB_APP_ID=

# # WhatsApp Cloud API (CRM)
# WP_APP_ID=
# WP_VERIFY_TOKEN=evolution
# WP_APP_SECRET=
# WP_WHATSAPP_CONFIG_ID=
# WP_API_VERSION=v23.0

# # Twitter / X (CRM)
# TWITTER_APP_ID=
# TWITTER_CONSUMER_KEY=
# TWITTER_CONSUMER_SECRET=
# TWITTER_ENVIRONMENT=

# # Slack (CRM)
# SLACK_CLIENT_ID=
# SLACK_CLIENT_SECRET=

# =============================================================================
# OPCIONAL — Observabilidade / APM
# =============================================================================
# Usado pelo auth, crm e processor.

# # OpenTelemetry (qualquer provider compatível)
# OTEL_TRACES_ENABLED=true
# OTEL_SERVICE_NAME=evo-crm
# OTEL_EXPORTER_OTLP_ENDPOINT=https://cloud.langfuse.com/api/public/otel

# # Langfuse (rastreamento de agentes no processor)
# LANGFUSE_PUBLIC_KEY=
# LANGFUSE_SECRET_KEY=

# # Sentry
# SENTRY_DSN=

# # Datadog
# DD_TRACE_AGENT_URL=

# # New Relic
# NEW_RELIC_LICENSE_KEY=
# NEW_RELIC_APP_NAME=

# # Resend (e-mail transacional alternativo ao SMTP)
# RESEND_API_KEY=
# RESEND_API_SECRET=

