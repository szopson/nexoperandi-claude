#!/bin/bash
# NexOperandi Claude Bootstrap v2.0
# Run this script on any new machine to set up Claude Code with NexOperandi skills

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}NexOperandi Claude Bootstrap v2.0${NC}"
echo "=================================="

# Determine repo directory (where this script lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$SCRIPT_DIR"
CLAUDE_DIR="$HOME/.claude"

echo -e "\n${YELLOW}Repo directory:${NC} $REPO_DIR"
echo -e "${YELLOW}Claude directory:${NC} $CLAUDE_DIR"

# Create Claude directories if they don't exist
echo -e "\n→ Creating Claude directories..."
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/agents"

# Link skills
echo -e "\n→ Linking NexOperandi skills..."
for skill_dir in "$REPO_DIR"/skills/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        target="$CLAUDE_DIR/skills/nexo-$skill_name"

        # Remove existing symlink if present
        if [ -L "$target" ]; then
            rm "$target"
        fi

        ln -sfn "$skill_dir" "$target"
        echo -e "  ${GREEN}✓${NC} nexo-$skill_name"
    fi
done

# Link commands
echo -e "\n→ Linking NexOperandi commands..."
for command_file in "$REPO_DIR"/commands/*.md; do
    if [ -f "$command_file" ]; then
        command_name=$(basename "$command_file")
        target="$CLAUDE_DIR/commands/nexo-$command_name"

        # Remove existing symlink if present
        if [ -L "$target" ]; then
            rm "$target"
        fi

        ln -sfn "$command_file" "$target"
        echo -e "  ${GREEN}✓${NC} nexo-$command_name"
    fi
done

# Link agents
echo -e "\n→ Linking NexOperandi agents..."
for agent_file in "$REPO_DIR"/agents/*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file")
        target="$CLAUDE_DIR/agents/nexo-$agent_name"

        # Remove existing symlink if present
        if [ -L "$target" ]; then
            rm "$target"
        fi

        ln -sfn "$agent_file" "$target"
        echo -e "  ${GREEN}✓${NC} nexo-$agent_name"
    fi
done

# Link CLAUDE.md if it exists
if [ -f "$REPO_DIR/CLAUDE.md" ]; then
    echo -e "\n→ Linking CLAUDE.md..."
    target="$CLAUDE_DIR/CLAUDE.md"

    if [ -L "$target" ]; then
        rm "$target"
    fi

    ln -sfn "$REPO_DIR/CLAUDE.md" "$target"
    echo -e "  ${GREEN}✓${NC} CLAUDE.md"
fi

# Verify installation
echo -e "\n→ Verifying installation..."
echo -e "\nSkills installed:"
ls -la "$CLAUDE_DIR/skills/" 2>/dev/null | grep "nexo-" || echo "  (none found)"

echo -e "\nCommands installed:"
ls -la "$CLAUDE_DIR/commands/" 2>/dev/null | grep "nexo-" || echo "  (none found)"

echo -e "\nAgents installed:"
ls -la "$CLAUDE_DIR/agents/" 2>/dev/null | grep "nexo-" || echo "  (none found)"

echo -e "\n${GREEN}✓ Bootstrap complete!${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo "1. Run: claude"
echo "2. Login: /login"
echo "3. Check skills: /skills"
echo "4. (VPS only) Enable Remote Control: /config → Enable Remote Control → true"

# Check Claude Code version
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "unknown")
    echo -e "\n${YELLOW}Claude Code version:${NC} $CLAUDE_VERSION"
else
    echo -e "\n${RED}Warning:${NC} Claude Code CLI not found. Install with:"
    echo "  npm install -g @anthropic-ai/claude-code"
fi
