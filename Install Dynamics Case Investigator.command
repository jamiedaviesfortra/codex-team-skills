#!/bin/zsh
set -u

REPO_URL="https://github.com/jamiedaviesfortra/codex-team-skills.git"
INSTALL_DIR="$HOME/codex-team-skills"
SKILLS_DIR="$HOME/.codex/skills"
SKILL_NAME="dynamics-case-investigator"
SKILL_SOURCE="$INSTALL_DIR/$SKILL_NAME"
SKILL_LINK="$SKILLS_DIR/$SKILL_NAME"

SHAREPOINT_URL="https://helpsystemsllc.sharepoint.com/sites/Teams-CustomerEngagement/Shared%20Documents/Codex%20Case%20Investigation%20Logs"
TEAM_FOLDER_NAME="DEPT - Customer Engagement - Codex Case Investigation Logs"
TEAM_LOG_FILE_NAME="case-investigations.csv"

CSV_HEADER="Run Date,Agent,Case Number,Customer,Product,Similar Cases Found,Jira Records Found,Confidence,Recommended Action,Time Saved Estimate,Agent Rating,Outcome,Notes"

print_header() {
  echo ""
  echo "=============================================="
  echo "Dynamics Case Investigator setup"
  echo "=============================================="
}

info() {
  echo "[INFO] $1" >&2
}

warn() {
  echo "[WARN] $1" >&2
}

fail() {
  echo "[ERROR] $1" >&2
  echo "" >&2
  echo "Setup did not complete. You can rerun this installer after fixing the issue." >&2
  echo "Press Return to close this window." >&2
  read -r _
  exit 1
}

find_team_log_file() {
  local roots=(
    "$HOME/Library/CloudStorage"
    "$HOME/OneDrive - Fortra"
    "$HOME/OneDrive-Fortra"
    "$HOME"
  )

  local root
  for root in "${roots[@]}"; do
    if [[ -d "$root" ]]; then
      find "$root" \
        -path "*/$TEAM_FOLDER_NAME/$TEAM_LOG_FILE_NAME" \
        -type f \
        -print \
        -quit 2>/dev/null
    fi
  done
}

find_team_folder() {
  local roots=(
    "$HOME/Library/CloudStorage"
    "$HOME/OneDrive - Fortra"
    "$HOME/OneDrive-Fortra"
    "$HOME"
  )

  local root
  for root in "${roots[@]}"; do
    if [[ -d "$root" ]]; then
      find "$root" \
        -name "$TEAM_FOLDER_NAME" \
        -type d \
        -print \
        -quit 2>/dev/null
    fi
  done
}

set_env_var() {
  local file="$1"
  local log_path="$2"
  local temp_file

  touch "$file" || fail "Could not update $file"
  temp_file="$(mktemp)" || fail "Could not create temporary file"

  grep -v '^export CODEX_CASE_LOG_FILE=' "$file" > "$temp_file" 2>/dev/null || true
  printf 'export CODEX_CASE_LOG_FILE="%s"\n' "$log_path" >> "$temp_file"
  mv "$temp_file" "$file" || fail "Could not save $file"
}

install_or_update_repo() {
  if ! command -v git >/dev/null 2>&1; then
    fail "Git is not installed or not available in PATH."
  fi

  if [[ -d "$INSTALL_DIR/.git" ]]; then
    info "Updating existing repo at $INSTALL_DIR"
    git -C "$INSTALL_DIR" pull --ff-only || fail "Could not update $INSTALL_DIR"
  elif [[ -e "$INSTALL_DIR" ]]; then
    fail "$INSTALL_DIR already exists but is not a Git repo. Rename it or remove it, then rerun this installer."
  else
    info "Cloning team skills repo to $INSTALL_DIR"
    git clone "$REPO_URL" "$INSTALL_DIR" || fail "Could not clone $REPO_URL"
  fi
}

install_skill_link() {
  mkdir -p "$SKILLS_DIR" || fail "Could not create $SKILLS_DIR"

  if [[ ! -d "$SKILL_SOURCE" ]]; then
    fail "Skill folder was not found at $SKILL_SOURCE"
  fi

  if [[ -L "$SKILL_LINK" ]]; then
    info "Replacing existing skill symlink"
    rm "$SKILL_LINK" || fail "Could not replace existing symlink at $SKILL_LINK"
  elif [[ -e "$SKILL_LINK" ]]; then
    local backup="$SKILL_LINK.backup.$(date +%Y%m%d%H%M%S)"
    warn "Existing local skill found. Moving it to $backup"
    mv "$SKILL_LINK" "$backup" || fail "Could not back up existing skill at $SKILL_LINK"
  fi

  ln -s "$SKILL_SOURCE" "$SKILL_LINK" || fail "Could not link skill into $SKILLS_DIR"
  info "Skill installed at $SKILL_LINK"
}

prepare_team_log_file() {
  local log_path
  log_path="$(find_team_log_file | head -n 1)"

  if [[ -n "$log_path" ]]; then
    echo "$log_path"
    return 0
  fi

  info "Opening SharePoint folder. Click Sync and allow Microsoft OneDrive to open."
  open "$SHAREPOINT_URL" >/dev/null 2>&1 || warn "Could not open SharePoint automatically."
  echo "" >&2
  echo "After OneDrive finishes syncing the folder, press Return here to continue." >&2
  read -r _

  log_path="$(find_team_log_file | head -n 1)"
  if [[ -n "$log_path" ]]; then
    echo "$log_path"
    return 0
  fi

  local team_folder
  team_folder="$(find_team_folder | head -n 1)"
  if [[ -n "$team_folder" ]]; then
    log_path="$team_folder/$TEAM_LOG_FILE_NAME"
    info "Creating $TEAM_LOG_FILE_NAME in synced team folder."
    printf '%s\n' "$CSV_HEADER" > "$log_path" || fail "Could not create $log_path"
    echo "$log_path"
    return 0
  fi

  fail "Could not find the synced SharePoint folder. Confirm OneDrive is signed in and the folder has synced, then rerun this installer."
}

validate_logging_script() {
  local script_path="$SKILL_SOURCE/scripts/append_case_log.py"
  if [[ ! -f "$script_path" ]]; then
    fail "Logging script not found at $script_path"
  fi

  python3 "$script_path" --help >/dev/null || fail "Logging script validation failed."
}

main() {
  print_header

  install_or_update_repo
  install_skill_link

  local log_path
  log_path="$(prepare_team_log_file)"

  set_env_var "$HOME/.zshenv" "$log_path"
  set_env_var "$HOME/.zshrc" "$log_path"
  validate_logging_script

  echo ""
  echo "Setup complete."
  echo ""
  echo "Skill:"
  echo "$SKILL_LINK"
  echo ""
  echo "Team log file:"
  echo "$log_path"
  echo ""
  echo "Next step: restart Codex, then use:"
  echo "Use \$dynamics-case-investigator to review CAS-0010812184"
  echo ""
  echo "Press Return to close this window."
  read -r _
}

main
