#!/usr/bin/env bash

set -e

echo "Setting up Hadoop Lab environment inside the repository"

# -----------------------------
# Check Java (>= 8)
# -----------------------------
if ! command -v java >/dev/null 2>&1; then
  echo "❌ Java not found."
  echo "👉 Please install Java 8 or higher before continuing."
  exit 1
fi

JAVA_VERSION_OUTPUT=$(java -version 2>&1)
JAVA_MAJOR_VERSION=$(echo "$JAVA_VERSION_OUTPUT" | awk -F[\".] '/version/ {print $2}')

if [ -z "$JAVA_MAJOR_VERSION" ]; then
  JAVA_MAJOR_VERSION=$(echo "$JAVA_VERSION_OUTPUT" | head -n 1 | awk -F'"' '{print $2}' | cut -d'.' -f1)
fi

if [ "$JAVA_MAJOR_VERSION" -lt 8 ]; then
  echo "❌ Java version too old."
  echo "$JAVA_VERSION_OUTPUT"
  exit 1
fi

JAVA_HOME_PATH=$(/usr/libexec/java_home 2>/dev/null || echo "/usr/local/opt/openjdk")
echo "✅ Java OK: Version $JAVA_MAJOR_VERSION detected."

# -----------------------------
# Setup Local Repo Directories
# -----------------------------
# Gets the absolute path of the directory where this script lives (your repo root)
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
TARGET_DIR="$REPO_DIR/dev-env"
HADOOP_FOLDER="$TARGET_DIR/hadoop"

# -----------------------------
# Update .gitignore
# -----------------------------
GITIGNORE="$REPO_DIR/.gitignore"
touch "$GITIGNORE"
if ! grep -q "^dev-env/" "$GITIGNORE"; then
  echo "" >> "$GITIGNORE"
  echo "# Local Hadoop installation binaries" >> "$GITIGNORE"
  echo "dev-env/" >> "$GITIGNORE"
  echo "✅ Added dev-env/ to .gitignore"
fi

# -----------------------------
# Download & Install Hadoop Locally
# -----------------------------
if [ ! -d "$HADOOP_FOLDER" ]; then
  echo "🐘 Downloading Apache Hadoop 3.4.0 into repo..."
  mkdir -p "$TARGET_DIR"
  
  curl -L https://archive.apache.org/dist/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz -o /tmp/hadoop-3.4.0.tar.gz
  
  echo "📦 Extracting Hadoop..."
  tar -xzvf /tmp/hadoop-3.4.0.tar.gz -C "$TARGET_DIR"
  mv "$TARGET_DIR/hadoop-3.4.0" "$HADOOP_FOLDER"
  rm /tmp/hadoop-3.4.0.tar.gz
  echo "✅ Hadoop binaries isolated in $HADOOP_FOLDER"
else
  echo "✅ Hadoop is already installed in $HADOOP_FOLDER"
fi

# -----------------------------
# Persist environment variables
# -----------------------------
SHELL_RC="$HOME/.zshrc"

echo ""
echo "Configuring environment variables in $SHELL_RC"

# Clean up any old configurations
sed -i '' '/export HADOOP_HOME=/d' "$SHELL_RC" 2>/dev/null || true
sed -i '' '/export PATH=\$PATH:\$HADOOP_HOME/d' "$SHELL_RC" 2>/dev/null || true

# Append fresh configurations pointing to the repo folder
grep -qxF "export JAVA_HOME=$JAVA_HOME_PATH" "$SHELL_RC" || \
  echo "export JAVA_HOME=$JAVA_HOME_PATH" >> "$SHELL_RC"

echo "export HADOOP_HOME=$HADOOP_FOLDER" >> "$SHELL_RC"
echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> "$SHELL_RC"

# -----------------------------
# Verify installation
# -----------------------------
echo ""
echo "Verification Setup..."
echo "----------------------------------------"
export JAVA_HOME="$JAVA_HOME_PATH"
export HADOOP_HOME="$HADOOP_FOLDER"
export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin"

hadoop version | head -n 2

echo "----------------------------------------"
echo "🎉 Setup complete! Run 'source ~/.zshrc' to refresh your terminal windows."