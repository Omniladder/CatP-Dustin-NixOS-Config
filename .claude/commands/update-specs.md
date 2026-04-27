---
description: Regenerate system-specs.md from current NixOS configuration
---

Please regenerate the system-specs.md file by reading all the NixOS configuration files in the flakes directory and creating a comprehensive system specification document.

After regenerating:
1. Show a git diff of what changed in system-specs.md
2. Clear the needs-specs-update marker file if it exists
3. Provide a summary of what was updated

Make sure to include:
- All hardware configuration
- Window manager and desktop environment details
- All installed packages and applications
- Development tools and languages
- Themes and styling
- System services
- All configuration locations
