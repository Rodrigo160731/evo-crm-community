# =============================================================================
# Evo AI — Stack de Aplicação
# =============================================================================
# Configure estas variáveis no painel do Dokploy antes de subir o stack.
# As variáveis de banco e Redis devem ser IDÊNTICAS às do stack de Infra.
#
# Para gerar segredos:
#   SECRET_KEY_BASE / JWT_SECRET_KEY / DOORKEEPER_JWT_SECRET_KEY:
#     openssl rand -hex 64
#   ENCRYPTION_KEY:
#     openssl rand -base64 32
#   EVOAI_CRM_API_TOKEN / BOT_RUNTIME_SECRET / AI_PROCESSOR_API_KEY:
#     uuidgen  ou  openssl rand -hex 32
# =============================================================================

# ── Banco de Dados (deve coincidir com o stack Infra) ─────────────────────────
POSTGRES_DATABASE=evo_community
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=troque_por_senha_forte

# ── Redis (deve coincidir com o stack Infra) ──────────────────────────────────
REDIS_PASSWORD=troque_por_senha_forte

# ── Rails ─────────────────────────────────────────────────────────────────────
RAILS_ENV=production
RAILS_MAX_THREADS=5
RAILS_LOG_TO_STDOUT=true
LOG_LEVEL=info

# ── Segredos compartilhados ───────────────────────────────────────────────────
# Devem ser IGUAIS em todos os serviços que os utilizam
SECRET_KEY_BASE=GERE_COM_openssl_rand_hex_64
JWT_SECRET_KEY=GERE_COM_openssl_rand_hex_64
ENCRYPTION_KEY=GERE_COM_openssl_rand_base64_32
EVOAI_CRM_API_TOKEN=GERE_COM_uuidgen

# ── Doorkeeper OAuth2 (Auth Service) ─────────────────────────────────────────
DOORKEEPER_JWT_SECRET_KEY=GERE_COM_openssl_rand_hex_64
DOORKEEPER_JWT_ALGORITHM=hs256
DOORKEEPER_JWT_ISS=evo-auth-service
DOORKEEPER_JWT_AUD=[]
MFA_ISSUER=EvoAI

# ── URLs públicas (usadas pelos serviços e pelo browser) ─────────────────────
# Aponte para o domínio/proxy que o Dokploy expõe para cada serviço
FRONTEND_URL=https://app.seudominio.com
BACKEND_URL=https://crm.seudominio.com
CORS_ORIGINS=https://app.seudominio.com

# ── Frontend — BUILD-TIME (variáveis VITE_* são embutidas na build) ───────────
# Devem ser as URLs públicas acessadas pelo browser do usuário
VITE_APP_ENV=production
VITE_API_URL=https://crm.seudominio.com
VITE_AUTH_API_URL=https://auth.seudominio.com
VITE_WS_URL=https://crm.seudominio.com
VITE_EVOAI_API_URL=https://core.seudominio.com
VITE_AGENT_PROCESSOR_URL=https://processor.seudominio.com
VITE_TINYMCE_API_KEY=no-api-key

# ── SMTP / E-mail ─────────────────────────────────────────────────────────────
# Para desenvolvimento com Mailhog: SMTP_ADDRESS=mailhog, SMTP_PORT=1025
SMTP_ADDRESS=mailhog
SMTP_PORT=1025
SMTP_DOMAIN=seudominio.com
SMTP_AUTHENTICATION=plain
SMTP_ENABLE_STARTTLS_AUTO=false
SMTP_USERNAME=
SMTP_PASSWORD=
MAILER_SENDER_EMAIL=noreply@seudominio.com

# ── Bot Runtime ───────────────────────────────────────────────────────────────
BOT_RUNTIME_SECRET=GERE_COM_openssl_rand_hex_32
AI_PROCESSOR_API_KEY=GERE_COM_openssl_rand_hex_32
AI_CALL_TIMEOUT_SECONDS=30

# ── Core Service ──────────────────────────────────────────────────────────────
DB_SSLMODE=disable
DB_MAX_IDLE_CONNS=10
DB_MAX_OPEN_CONNS=100
DB_CONN_MAX_LIFETIME=1h
DB_CONN_MAX_IDLE_TIME=30m
JWT_ALGORITHM=HS256
AI_PROCESSOR_VERSION=v1

# ── Processor Service ─────────────────────────────────────────────────────────
REDIS_DB=0
REDIS_SSL=false
REDIS_KEY_PREFIX=a2a:
REDIS_TTL=3600
TOOLS_CACHE_ENABLED=true
TOOLS_CACHE_TTL=3600
DEBUG=false

# ── CRM ───────────────────────────────────────────────────────────────────────
ENABLE_ACCOUNT_SIGNUP=true
DISABLE_TELEMETRY=true

# ── Portas externas (host) ────────────────────────────────────────────────────
# Altere aqui no Dokploy para evitar conflito com outras stacks no mesmo host.
# As portas internas dos containers são fixas e não mudam.
# Referência das portas internas:
#   evo-auth      → 3001
#   evo-crm       → 3000
#   evo-core      → 5555
#   evo-processor → 8000
#   evo-frontend  → 80 (nginx)
AUTH_EXTERNAL_PORT=3001
CRM_EXTERNAL_PORT=3000
CORE_EXTERNAL_PORT=5555
PROCESSOR_EXTERNAL_PORT=8000
FRONTEND_EXTERNAL_PORT=5173
