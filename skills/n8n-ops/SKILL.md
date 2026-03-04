---
name: n8n-ops
description: Manage n8n workflows for NexOperandi automation. Use for creating, debugging, and monitoring n8n workflows, webhooks, and integrations.
---

# n8n-ops Skill — NexOperandi

## Quick Start

Manage n8n workflows for NexOperandi's automation infrastructure.

**What I can help with:**
- Creating new workflows
- Debugging existing workflows
- Setting up webhooks
- Monitoring workflow execution
- Integrating with external services

## n8n Instance

- **URL:** https://n8n.srv1108737.hstgr.cloud
- **Status:** Self-hosted on Hostinger VPS
- **Database:** PostgreSQL (Docker)

## Active Workflows

### 1. Content Agent (Scheduled)
- **Trigger:** Cron - Mon/Wed/Fri 8:00 CET
- **Action:** Generate LinkedIn post via Claude API
- **Output:** Schedule via Postiz MCP

### 2. Lead Research Agent (Scheduled)
- **Trigger:** Cron - Daily 9:00 CET
- **Action:** Scrape new clinics, qualify leads
- **Output:** Add to Notion, send Telegram summary

### 3. Daily Briefing Agent (Scheduled)
- **Trigger:** Cron - Daily 7:30 CET
- **Action:** Aggregate Gmail, calendar, leads
- **Output:** Send Telegram briefing

### 4. Monitor Agent (Scheduled)
- **Trigger:** Cron - Hourly
- **Action:** Health check all services
- **Output:** Alert on Telegram if issues

## Workflow Templates

### Basic Webhook Workflow
```json
{
  "name": "Webhook Template",
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "path": "your-endpoint",
        "responseMode": "responseNode"
      }
    },
    {
      "name": "Process",
      "type": "n8n-nodes-base.set",
      "parameters": {
        "values": {
          "string": [
            {"name": "status", "value": "processed"}
          ]
        }
      }
    },
    {
      "name": "Respond",
      "type": "n8n-nodes-base.respondToWebhook",
      "parameters": {
        "responseBody": "={{ $json }}"
      }
    }
  ]
}
```

### Claude API Integration
```json
{
  "name": "HTTP Request to Claude",
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "method": "POST",
    "url": "https://api.anthropic.com/v1/messages",
    "headers": {
      "x-api-key": "={{ $credentials.anthropicApi.apiKey }}",
      "anthropic-version": "2023-06-01",
      "content-type": "application/json"
    },
    "body": {
      "model": "claude-sonnet-4-20250514",
      "max_tokens": 1024,
      "messages": [
        {"role": "user", "content": "Your prompt here"}
      ]
    }
  }
}
```

## Common Operations

### Create New Workflow
1. Log into n8n dashboard
2. Click "Add Workflow"
3. Add trigger node (Webhook, Cron, or Manual)
4. Build logic with action nodes
5. Test with sample data
6. Activate workflow

### Debug Failing Workflow
1. Check execution history
2. Identify failing node
3. Inspect input/output data
4. Check credentials
5. Test node individually
6. Fix and re-test

### Monitor Workflow Status
```
Check via:
1. n8n dashboard > Executions
2. Monitor Agent Telegram alerts
3. PostgreSQL logs: docker logs n8n-postgres
```

## Integrations

| Service | Node Type | Status |
|---------|-----------|--------|
| Claude API | HTTP Request | Active |
| Telegram | Telegram node | Active |
| Google Sheets | Google Sheets | Configured |
| Gmail | Gmail node | Configured |
| Notion | HTTP Request | Configured |
| Postiz | HTTP Request | To configure |
| VAPI | Webhook | To configure |

## Troubleshooting

### Workflow Not Triggering
- Check if workflow is active (toggle on)
- Verify cron schedule syntax
- Check timezone settings
- Review execution history for errors

### Credential Errors
- Verify API keys are current
- Check credential scope/permissions
- Re-authenticate OAuth connections
- Test with simple request first

### Timeout Issues
- Increase timeout in node settings
- Split large operations into chunks
- Use pagination for large datasets
- Consider async execution

## Best Practices

1. **Naming:** Use descriptive workflow names with prefix (e.g., `nexo-lead-research`)
2. **Error handling:** Always add error workflow or try/catch
3. **Logging:** Use Set node to log key steps
4. **Testing:** Test with manual trigger before activating cron
5. **Backup:** Export workflow JSON before major changes
6. **Credentials:** Use n8n credentials, not hardcoded values
