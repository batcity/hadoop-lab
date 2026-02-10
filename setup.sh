#!/usr/bin/env bash

set -e

echo "Setting up Hadoop Lab environment (macOS)"

# -----------------------------
# Check Homebrew
# -----------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew not found."
  echo "👉 Install Homebrew first: https://brew.sh"
  exit 1
fi

# -----------------------------
# Check Java (>= 8)
# -----------------------------
if ! command -v java >/dev/null 2>&1; then
  echo "❌ Java not found."
  echo "👉 Install Java 8 or higher before continuing."
  exit 1
fi

JAVA_VERSION_OUTPUT=$(java -version 2>&1)
JAVA_MAJOR_VERSION=$(echo "$JAVA_VERSION_OUTPUT" | awk -F[\".] '/version/ {print $2}')

if [ "$JAVA_MAJOR_VERSION" -lt 8 ]; then
  echo "❌ Java version too old."
  echo "$JAVA_VERSION_OUTPUT"
  echo "👉 Install Java 8 or higher."
  exit 1
fi

JAVA_HOME_PATH=$(/usr/libexec/java_home 2>/dev/null)

echo "✅ Java OK"
echo "$JAVA_VERSION_OUTPUT"

# -----------------------------
# Install Hadoop
# -----------------------------
if ! command -v hadoop >/dev/null 2>&1; then
  echo "🐘 Installing Hadoop..."
  
  # FIX: Check for yarn conflict
  if brew list yarn >/dev/null 2>&1; then
    echo "⚠️  Temporary unlinking 'yarn' to avoid conflict with Hadoop..."
    brew unlink yarn
  fi

  brew install hadoop

  # Optional: Re-link yarn if you need it for JS development
  if brew list yarn >/dev/null 2>&1; then
    echo "🔗 Re-linking 'yarn'..."
    brew link yarn || echo "⚠️  Could not re-link yarn. You may need to run 'brew link --overwrite yarn' later."
  fi
else
  echo "✅ Hadoop already installed"
fi

# -----------------------------
# Persist environment variables
# -----------------------------
SHELL_RC="$HOME/.zshrc"

echo ""
echo "📝 Configuring environment variables in $SHELL_RC"

grep -qxF "export JAVA_HOME=$JAVA_HOME_PATH" "$SHELL_RC" || \
  echo "export JAVA_HOME=$JAVA_HOME_PATH" >> "$SHELL_RC"

grep -qxF "export HADOOP_HOME=$HADOOP_HOME_PATH" "$SHELL_RC" || \
  echo "export HADOOP_HOME=$HADOOP_HOME_PATH" >> "$SHELL_RC"

grep -qxF 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' "$SHELL_RC" || \
  echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> "$SHELL_RC"

# -----------------------------
# Reload shell config so JAVA_HOME, HADOOP_HOME, and PATH
# are available in the current terminal session
# -----------------------------
echo ""
echo "⚡ Reloading shell configuration..."
# shellcheck disable=SC1090
source "$SHELL_RC"

# -----------------------------
# Verify installation
# -----------------------------
echo ""
echo "🔍 Verifying setup..."

echo "JAVA_HOME=$JAVA_HOME"
java -version

echo ""
echo "HADOOP_HOME=$HADOOP_HOME"
hadoop version

echo ""
echo "Setup complete!"
