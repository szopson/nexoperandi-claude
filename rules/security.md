# Security Rules — NexOperandi

## Credentials Management

### Never commit secrets
- API keys
- Database passwords
- OAuth tokens
- Private keys

### Use environment variables
```bash
# .env (never commit this file)
DATABASE_URL=postgresql://user:pass@host:5432/db
ANTHROPIC_API_KEY=sk-xxx
TELEGRAM_BOT_TOKEN=xxx

# .env.example (commit this)
DATABASE_URL=postgresql://user:pass@host:5432/db
ANTHROPIC_API_KEY=your-key-here
TELEGRAM_BOT_TOKEN=your-token-here
```

### Use n8n credential store
- Store API keys in n8n's credential manager
- Reference by credential name, not value
- Rotate credentials regularly

## API Security

### Authentication
```python
# Always require auth for sensitive endpoints
from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer

security = HTTPBearer()

@app.get("/api/leads")
async def get_leads(token: str = Depends(security)):
    if not verify_token(token):
        raise HTTPException(status_code=401)
    return leads
```

### Rate Limiting
```python
# Protect public endpoints
from slowapi import Limiter

limiter = Limiter(key_func=get_remote_address)

@app.post("/api/webhook")
@limiter.limit("10/minute")
async def webhook(request: Request):
    pass
```

### Input Validation
```python
# Always validate input
from pydantic import BaseModel, validator, EmailStr

class LeadCreate(BaseModel):
    email: EmailStr
    phone: str

    @validator('phone')
    def validate_phone(cls, v):
        # Strip non-numeric, validate format
        cleaned = re.sub(r'\D', '', v)
        if len(cleaned) < 9:
            raise ValueError('Invalid phone number')
        return cleaned
```

## Data Protection

### Personal Data (GDPR)
- Minimize data collection
- Document data processing purpose
- Implement data deletion on request
- Encrypt sensitive data at rest

### Database
```sql
-- Use parameterized queries
-- NEVER do this:
SELECT * FROM leads WHERE email = '{user_input}'

-- Always do this:
SELECT * FROM leads WHERE email = $1
```

## Infrastructure Security

### Docker
```dockerfile
# Don't run as root
USER nonroot

# Don't expose unnecessary ports
EXPOSE 8000

# Use specific versions
FROM python:3.11-slim
```

### SSH
- Use key-based authentication only
- Disable password login
- Use non-standard port
- Enable fail2ban

### Traefik
- Force HTTPS
- Use Let's Encrypt certificates
- Configure security headers

```yaml
# traefik.yml
http:
  middlewares:
    security-headers:
      headers:
        stsSeconds: 31536000
        stsIncludeSubdomains: true
        contentTypeNosniff: true
        frameDeny: true
```

## Webhook Security

### Verify signatures
```python
import hmac
import hashlib

def verify_webhook(payload: bytes, signature: str, secret: str) -> bool:
    expected = hmac.new(
        secret.encode(),
        payload,
        hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(signature, expected)
```

### Use HTTPS only
- Never accept webhooks over HTTP
- Validate SSL certificates

## Logging

### Do log
- Authentication attempts
- API errors
- Security events
- Access to sensitive resources

### Don't log
- Passwords
- API keys
- Personal data
- Full request/response bodies with PII

```python
# Good
logger.info(f"Lead created: id={lead.id}")

# Bad
logger.info(f"Lead created: {lead.dict()}")  # May contain PII
```

## Incident Response

1. **Detect** — Monitor logs and alerts
2. **Contain** — Revoke compromised credentials
3. **Eradicate** — Fix the vulnerability
4. **Recover** — Restore normal operation
5. **Learn** — Post-mortem and prevention

## Checklist

Before deploying:
- [ ] No secrets in code
- [ ] Environment variables configured
- [ ] HTTPS enabled
- [ ] Authentication required
- [ ] Input validation in place
- [ ] Rate limiting configured
- [ ] Logging enabled (without PII)
- [ ] Error messages don't leak internals
