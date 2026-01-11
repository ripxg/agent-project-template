#!/bin/bash
# agent-helpers.sh
# Helper scripts for agent operations

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Register agent session
agent_register() {
  local AGENT_TYPE=$1
  local CAPABILITIES=$2
  local AGENT_ID="${AGENT_TYPE}-$(date +%Y%m%d-%H%M)"
  local TIMESTAMP=$(date -Iseconds)
  
  # Add to manifest
  echo "| $AGENT_ID | $AGENT_TYPE | active | $TIMESTAMP | none | $CAPABILITIES |" >> docs/agents/manifest.md
  
  echo -e "${GREEN}✓ Agent registered: $AGENT_ID${NC}"
  echo -e "${YELLOW}→ Next: Log session start in activity.md${NC}"
  echo ""
  echo "Run: log_activity $AGENT_ID session-start N/A \"Session started for [purpose]\""
}

# Log activity
log_activity() {
  local AGENT_ID=$1
  local ACTION=$2
  local TARGET=$3
  local DETAILS=$4
  local TIMESTAMP=$(date +%H:%M:%S)
  
  # Get current date heading
  local DATE_HEADING="## $(date +%Y-%m-%d)"
  
  # Check if date heading exists, add if not
  if ! grep -q "$DATE_HEADING" docs/agents/activity.md; then
    echo -e "\n$DATE_HEADING\n" >> docs/agents/activity.md
  fi
  
  # Add log entry
  cat >> docs/agents/activity.md << EOF

### $TIMESTAMP - $AGENT_ID
- **Action**: $ACTION
- **Target**: $TARGET
- **Details**: $DETAILS
- **Related**: 
EOF
  
  echo -e "${GREEN}✓ Activity logged${NC}"
}

# Acquire file lock
lock_file() {
  local FILE=$1
  local AGENT_ID=$2
  local TASK=$3
  local REASON=$4
  local TIMESTAMP=$(date -Iseconds)
  
  # Check if already locked
  if grep -q "^| $FILE " docs/agents/locks.md 2>/dev/null; then
    echo -e "${RED}✗ ERROR: File is already locked!${NC}"
    grep "^| $FILE " docs/agents/locks.md
    return 1
  fi
  
  # Add lock entry
  # Find the table and insert before the closing line
  local TEMP_FILE=$(mktemp)
  local IN_TABLE=0
  
  while IFS= read -r line; do
    echo "$line" >> "$TEMP_FILE"
    if [[ "$line" == "| File Path | Locked By | Locked At | Task ID | Reason |" ]]; then
      IN_TABLE=1
    elif [[ $IN_TABLE -eq 1 && "$line" == "|-----------|-----------|-----------|---------|--------|" ]]; then
      echo "| $FILE | $AGENT_ID | $TIMESTAMP | $TASK | $REASON |" >> "$TEMP_FILE"
      IN_TABLE=0
    fi
  done < docs/agents/locks.md
  
  mv "$TEMP_FILE" docs/agents/locks.md
  
  # Commit lock
  git add docs/agents/locks.md
  git commit -m "Lock: $FILE for $TASK" -q
  
  echo -e "${GREEN}✓ File locked: $FILE${NC}"
  echo -e "${YELLOW}→ Remember to release lock after committing changes${NC}"
}

# Release file lock
unlock_file() {
  local FILE=$1
  
  # Check if file is locked
  if ! grep -q "^| $FILE " docs/agents/locks.md 2>/dev/null; then
    echo -e "${YELLOW}⚠ File is not locked: $FILE${NC}"
    return 0
  fi
  
  # Remove lock entry
  local TEMP_FILE=$(mktemp)
  grep -v "^| $FILE " docs/agents/locks.md > "$TEMP_FILE"
  mv "$TEMP_FILE" docs/agents/locks.md
  
  # Commit unlock
  git add docs/agents/locks.md
  git commit -m "Unlock: $FILE" -q
  
  echo -e "${GREEN}✓ File unlocked: $FILE${NC}"
}

# Show active locks
show_locks() {
  echo -e "${YELLOW}Active file locks:${NC}"
  echo ""
  
  if grep -q "^|.*|.*|.*|.*|.*|$" docs/agents/locks.md 2>/dev/null; then
    grep "^| [^|]" docs/agents/locks.md | grep -v "^| File Path"
    
    if [ $? -ne 0 ]; then
      echo -e "${GREEN}No active locks${NC}"
    fi
  else
    echo -e "${GREEN}No active locks${NC}"
  fi
}

# Create handoff document
create_handoff() {
  local TASK_ID=$1
  local FROM_AGENT=$2
  local TO_AGENT=$3
  local HANDOFF_FILE="docs/agents/handoffs/${TASK_ID}-${FROM_AGENT}-to-${TO_AGENT}.md"
  
  # Copy template
  cp docs/agents/handoffs/_TEMPLATE.md "$HANDOFF_FILE"
  
  echo -e "${GREEN}✓ Handoff document created: $HANDOFF_FILE${NC}"
  echo -e "${YELLOW}→ Please edit the file and fill in all sections${NC}"
  echo ""
  echo "When complete:"
  echo "  1. Update task status to ReadyForHandoff"
  echo "  2. Log handoff initiation in activity.md"
  echo "  3. Update manifest (task=none, status=idle)"
}

# Update manifest status
update_manifest_status() {
  local AGENT_ID=$1
  local NEW_STATUS=$2
  
  # Update the status column for this agent
  local TEMP_FILE=$(mktemp)
  
  awk -v agent="$AGENT_ID" -v status="$NEW_STATUS" '
    BEGIN { FS="|"; OFS="|" }
    $2 ~ agent { $4 = " " status " " }
    { print }
  ' docs/agents/manifest.md > "$TEMP_FILE"
  
  mv "$TEMP_FILE" docs/agents/manifest.md
  
  echo -e "${GREEN}✓ Manifest updated: $AGENT_ID → $NEW_STATUS${NC}"
}

# Update manifest task
update_manifest_task() {
  local AGENT_ID=$1
  local TASK=$2
  
  # Update the task column for this agent
  local TEMP_FILE=$(mktemp)
  
  awk -v agent="$AGENT_ID" -v task="$TASK" '
    BEGIN { FS="|"; OFS="|" }
    $2 ~ agent { $5 = " " task " " }
    { print }
  ' docs/agents/manifest.md > "$TEMP_FILE"
  
  mv "$TEMP_FILE" docs/agents/manifest.md
  
  echo -e "${GREEN}✓ Manifest updated: $AGENT_ID task → $TASK${NC}"
}

# Check for stale locks (>1 hour)
check_stale_locks() {
  echo -e "${YELLOW}Checking for stale locks (>1 hour)...${NC}"
  echo ""
  
  local NOW=$(date +%s)
  local STALE_FOUND=0
  
  while IFS='|' read -r file locked_by locked_at task reason; do
    # Skip header and separator
    if [[ "$file" == *"File Path"* ]] || [[ "$file" == *"---"* ]]; then
      continue
    fi
    
    # Parse timestamp
    local LOCK_TIME=$(date -d "${locked_at// /}" +%s 2>/dev/null)
    
    if [ ! -z "$LOCK_TIME" ]; then
      local AGE=$((NOW - LOCK_TIME))
      
      # If older than 1 hour (3600 seconds)
      if [ $AGE -gt 3600 ]; then
        STALE_FOUND=1
        local HOURS=$((AGE / 3600))
        echo -e "${RED}⚠ STALE LOCK: $file${NC}"
        echo "  Locked by: $locked_by"
        echo "  Age: $HOURS hours"
        echo "  Task: $task"
        echo ""
      fi
    fi
  done < docs/agents/locks.md
  
  if [ $STALE_FOUND -eq 0 ]; then
    echo -e "${GREEN}✓ No stale locks found${NC}"
  fi
}

# Check for pending handoffs (>24 hours)
check_pending_handoffs() {
  echo -e "${YELLOW}Checking for pending handoffs (>24 hours)...${NC}"
  echo ""
  
  local PENDING_FOUND=0
  
  for handoff_file in docs/agents/handoffs/*.md; do
    # Skip template
    if [[ "$handoff_file" == *"_TEMPLATE"* ]]; then
      continue
    fi
    
    # Check if file exists
    if [ ! -f "$handoff_file" ]; then
      continue
    fi
    
    # Check if status is pending
    if grep -q "^\*\*Status\*\*: pending" "$handoff_file"; then
      # Get file modification time
      local MOD_TIME=$(stat -c %Y "$handoff_file" 2>/dev/null || stat -f %m "$handoff_file" 2>/dev/null)
      local NOW=$(date +%s)
      local AGE=$((NOW - MOD_TIME))
      
      # If older than 24 hours
      if [ $AGE -gt 86400 ]; then
        PENDING_FOUND=1
        local DAYS=$((AGE / 86400))
        echo -e "${RED}⚠ PENDING HANDOFF: $(basename $handoff_file)${NC}"
        echo "  Age: $DAYS days"
        echo ""
      fi
    fi
  done
  
  if [ $PENDING_FOUND -eq 0 ]; then
    echo -e "${GREEN}✓ No stale handoffs found${NC}"
  fi
}

# Help function
agent_help() {
  echo -e "${GREEN}Agent Helper Commands${NC}"
  echo ""
  echo "  agent_register [type] \"[capabilities]\""
  echo "    Register a new agent session"
  echo ""
  echo "  log_activity [agent-id] [action] [target] \"[details]\""
  echo "    Log an activity"
  echo ""
  echo "  lock_file [file] [agent-id] [task] \"[reason]\""
  echo "    Acquire a file lock"
  echo ""
  echo "  unlock_file [file]"
  echo "    Release a file lock"
  echo ""
  echo "  show_locks"
  echo "    Display all active locks"
  echo ""
  echo "  create_handoff [task-id] [from-agent] [to-agent]"
  echo "    Create a new handoff document"
  echo ""
  echo "  update_manifest_status [agent-id] [status]"
  echo "    Update agent status in manifest"
  echo ""
  echo "  update_manifest_task [agent-id] [task]"
  echo "    Update agent's current task"
  echo ""
  echo "  check_stale_locks"
  echo "    Find locks older than 1 hour"
  echo ""
  echo "  check_pending_handoffs"
  echo "    Find handoffs pending >24 hours"
  echo ""
  echo "Examples:"
  echo "  agent_register claude \"planning,research,docs\""
  echo "  log_activity claude-20250111-1430 session-start N/A \"Starting session\""
  echo "  lock_file src/api/users.ts cursor-20250111-0900 PBI-5-3 \"Implementing endpoints\""
}

# Export functions
export -f agent_register
export -f log_activity
export -f lock_file
export -f unlock_file
export -f show_locks
export -f create_handoff
export -f update_manifest_status
export -f update_manifest_task
export -f check_stale_locks
export -f check_pending_handoffs
export -f agent_help

echo -e "${GREEN}Agent helpers loaded. Run 'agent_help' for usage.${NC}"
