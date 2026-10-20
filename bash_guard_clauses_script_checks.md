# Common Bash Guard Clauses & Script Checks

A reference collection of essential validation snippets and guard clauses to include at the top of shell scripts to ensure they execute under the correct conditions.

---

## 1. Privilege & Environment Checks

### Root / Privilege Check
Ensures the script is either run with root privileges or strictly *not* run as root.

**Require Root:**
```bash
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (or with sudo)." >&2
    exit 1
fi
```

**Prevent Root:**
```bash
if [ "$EUID" -eq 0 ]; then
    echo "Error: Do not run this script as root." >&2
    exit 1
fi
```

---

### Bash Version Check
Ensures the script is running under a supported version of Bash (e.g., version 4+ for associative arrays).

```bash
if (( BASH_VERSINFO[0] < 4 )); then
    echo "Error: This script requires Bash version 4 or higher (detected: $BASH_VERSION)." >&2
    exit 1
fi
```

---

### Operating System / Platform Check
Restricts execution to specific operating systems.

```bash
OS="$(uname -s)"
if [ "$OS" != "Linux" ]; then
    echo "Error: This script only supports Linux (detected: $OS)." >&2
    exit 1
fi
```

---

### CPU Architecture Check
Verifies CPU architecture before running architecture-specific code or downloading binaries.

```bash
ARCH="$(uname -m)"
if [ "$ARCH" != "x86_64" ] && [ "$ARCH" != "aarch64" ]; then
    echo "Error: Unsupported CPU architecture: $ARCH" >&2
    exit 1
fi
```

---

### Containerized Environment Check
Detects whether the script is executing inside a Docker container.

**Require Docker:**
```bash
if [ ! -f /.dockerenv ]; then
    echo "Error: This script must be run inside a Docker container." >&2
    exit 1
fi
```

**Prevent Docker:**
```bash
if [ -f /.dockerenv ]; then
    echo "Error: Do not run this script inside a container." >&2
    exit 1
fi
```

---

## 2. Dependencies & Tooling

### Dependency / Command Availability Check
Loops through required CLI tools and checks if they are installed in `$PATH`.

```bash
REQUIRED_TOOLS=("curl" "jq" "git")
for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        echo "Error: Required tool '$tool' is not installed." >&2
        exit 1
    fi
done
```

---

## 3. Script Input & Environment Variables

### Argument Count Check
Validates that the user passed the expected number of arguments.

```bash
# Expects exactly 2 arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_dir> <destination_dir>" >&2
    exit 1
fi
```

---

### Environment Variable Check
Ensures required environment variables are set before proceeding.

```bash
if [ -z "${API_KEY:-}" ]; then
    echo "Error: API_KEY environment variable is not set." >&2
    exit 1
fi
```

---

## 4. Execution State & System Conditions

### Interactive vs. Non-Interactive Check
Determines if stdin is attached to a terminal (`tty`).

```bash
if [ ! -t 0 ]; then
    echo "Error: This script requires an interactive terminal." >&2
    exit 1
fi
```

---

### Single Instance / Lock File Check
Prevents concurrent execution of the same script using a temporary lock file.

```bash
LOCKFILE="/tmp/my_script.lock"

if [ -e "$LOCKFILE" ]; then
    echo "Error: Another instance of this script is already running." >&2
    exit 1
fi

# Create lockfile and ensure cleanup on exit
touch "$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT
```

---

### Minimum Free Disk Space Check
Verifies available disk space on a partition before starting large downloads or writes.

```bash
# Check if /var/log has at least 500,000 KB (500 MB) free
REQUIRED_SPACE=500000
AVAILABLE_SPACE=$(df /var/log | awk 'NR==2 {print $4}')

if [ "$AVAILABLE_SPACE" -lt "$REQUIRED_SPACE" ]; then
    echo "Error: Insufficient disk space. At least 500MB required." >&2
    exit 1
fi
```

---

### File Read/Write Permission Check
Checks file existence and write permissions prior to executing file modifications.

```bash
TARGET_FILE="/etc/myapp/config.conf"

if [ ! -w "$TARGET_FILE" ]; then
    echo "Error: Cannot write to $TARGET_FILE (check permissions)." >&2
    exit 1
fi
```

---

### Network & Port Availability Checks

#### Internet Connectivity Check
Verifies connectivity to a external server/IP address.

```bash
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    echo "Error: No active internet connection detected." >&2
    exit 1
fi
```

---

#### Port Availability Check
Checks if a local TCP port is already in use using `nc` or `ss`.

```bash
PORT=8080
if command -v nc &> /dev/null && nc -z localhost "$PORT" 2>/dev/null; then
    echo "Error: Port $PORT is already in use." >&2
    exit 1
elif command -v ss &> /dev/null && ss -tuln | grep -q ":$PORT "; then
    echo "Error: Port $PORT is already in use." >&2
    exit 1
fi
```

---

## 5. User Interface & Display Checks

### Terminal Size Check
Verifies that the terminal window meets minimum width and height requirements (useful for TUI applications).

```bash
MIN_COLS=80
MIN_ROWS=24

COLUMNS=$(tput cols)
ROWS=$(tput lines)

if [ "$COLUMNS" -lt "$MIN_COLS" ] || [ "$ROWS" -lt "$MIN_ROWS" ]; then
    echo "Error: Terminal window is too small. Minimum size is ${MIN_COLS}x${MIN_ROWS}." >&2
    exit 1
fi
```