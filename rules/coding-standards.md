# Coding Standards — NexOperandi

## General Principles

1. **Simplicity first** — Choose the simplest solution that works
2. **Consistency** — Follow existing patterns in the codebase
3. **Readability** — Code is read more than written
4. **Documentation** — Document why, not what

## Technology Stack

### Backend
- **Primary:** FastAPI (Python 3.11+)
- **Database:** PostgreSQL
- **Cache:** Redis (when needed)
- **Queue:** n8n workflows or Celery

### Frontend
- **Framework:** Next.js / React
- **Styling:** Tailwind CSS
- **State:** React Query for server state

### Infrastructure
- **Containers:** Docker + Docker Compose
- **Reverse proxy:** Traefik
- **Hosting:** Hostinger VPS

## Code Style

### Python
```python
# Use type hints
def process_lead(lead_id: int, data: dict) -> Lead:
    pass

# Use dataclasses or Pydantic for models
from pydantic import BaseModel

class LeadCreate(BaseModel):
    name: str
    email: str
    phone: str | None = None

# Async by default for I/O operations
async def fetch_clinic_data(url: str) -> dict:
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        return response.json()
```

### TypeScript/JavaScript
```typescript
// Use TypeScript for all new code
interface Lead {
  id: string;
  name: string;
  email: string;
  score: number;
}

// Use const for functions
const processLead = async (leadId: string): Promise<Lead> => {
  // ...
};

// Destructure props
const LeadCard = ({ lead, onSelect }: LeadCardProps) => {
  // ...
};
```

## File Organization

```
project/
├── src/
│   ├── api/           # API routes
│   ├── services/      # Business logic
│   ├── models/        # Data models
│   ├── utils/         # Utility functions
│   └── config/        # Configuration
├── tests/
├── docker/
└── scripts/
```

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files | snake_case | `lead_service.py` |
| Classes | PascalCase | `LeadProcessor` |
| Functions | snake_case | `process_lead()` |
| Constants | UPPER_SNAKE | `MAX_RETRIES` |
| Variables | snake_case | `lead_count` |

## Git Practices

### Commit Messages
```
type(scope): short description

[optional body]

Types: feat, fix, docs, style, refactor, test, chore
```

Examples:
- `feat(leads): add lead scoring algorithm`
- `fix(api): handle missing phone number`
- `docs(readme): update installation steps`

### Branching
- `main` — production-ready code
- `develop` — integration branch
- `feature/xxx` — new features
- `fix/xxx` — bug fixes

## Error Handling

```python
# Be specific with exceptions
try:
    lead = await fetch_lead(lead_id)
except LeadNotFoundError:
    raise HTTPException(status_code=404, detail="Lead not found")
except ExternalAPIError as e:
    logger.error(f"External API failed: {e}")
    raise HTTPException(status_code=502, detail="External service unavailable")
```

## Testing

- Write tests for business logic
- Use pytest for Python, Jest for TypeScript
- Aim for >80% coverage on critical paths
- Mock external services

```python
# tests/test_lead_service.py
async def test_score_lead_high_quality():
    lead = Lead(name="Klinika Premium", reviews=150, rating=4.8)
    score = await score_lead(lead)
    assert score >= 80
```

## Security

See `rules/security.md` for security-specific guidelines.
