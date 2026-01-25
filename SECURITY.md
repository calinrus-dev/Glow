# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in Glow, please report it responsibly.

**DO NOT** create a public GitHub issue for security vulnerabilities.

### How to Report

1. **Email:** Send details to security@glow.app (or contact via Discord DM to project maintainers)
2. **Include:**
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- **Initial response:** Within 48-72 hours
- **Status updates:** Every 5-7 days until resolution
- **Fix timeline:** Depends on severity (critical issues prioritized)
- **Credit:** Security researchers will be credited (unless they prefer anonymity)

### Scope

Security reports should relate to:

- Authentication/authorization flaws
- Data exposure vulnerabilities
- Code injection vulnerabilities
- Dependency vulnerabilities with direct impact
- Infrastructure security issues

### Out of Scope

- Social engineering attacks
- Denial of service (DoS) attacks
- Issues in third-party dependencies without direct exploitability
- UI/UX bugs without security impact

---

## Supported Versions

Glow is currently in active development. Security updates will be applied to:

| Version | Supported          |
| ------- | ------------------ |
| main    | :white_check_mark: |

Once public releases begin, this table will be updated.

---

## Security Best Practices

When contributing to Glow:

- Never commit credentials, API keys, or secrets
- Use environment variables for sensitive configuration
- Follow secure coding practices (input validation, output encoding)
- Keep dependencies updated
- Review code for security implications before submitting PRs

---

**Thank you for helping keep Glow secure.**
