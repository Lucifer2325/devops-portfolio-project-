# DevOps Portfolio Project - Automation Scripts

This directory contains convenient scripts to automate local development, testing, and Docker operations.

## 📋 Available Scripts

### 1. **run-local.sh** (Linux/macOS)
Complete local development and testing workflow.

**What it does:**
- ✅ Checks for Python, pip, and Git
- ✅ Creates Python virtual environment
- ✅ Installs dependencies from `requirements.txt`
- ✅ Runs unit tests
- ✅ (Optional) Builds Docker image
- ✅ Starts Flask development server on `http://localhost:5000`

**Usage:**
```bash
chmod +x run-local.sh
./run-local.sh
```

**What to expect:**
```
═══════════════════════════════════════════════════
► Step 0: Pre-flight Checks
═══════════════════════════════════════════════════
✓ Python 3 found: Python 3.11.x
✓ pip found: pip 23.x
✓ Git found: git version 2.x

[... continues through all steps ...]

✓ All unit tests passed ✓

╔════════════════════════════════════════════════════════════╗
║          DevOps Portfolio Project - Flask Server           ║
║                                                            ║
║  🌐 Web Interface: http://localhost:5000/                 ║
║  📊 API Status:    http://localhost:5000/api/status       ║
║                                                            ║
║  Press CTRL+C to stop the server                          ║
╚════════════════════════════════════════════════════════════╝

 * Running on http://0.0.0.0:5000
```

---

### 2. **run-local.bat** (Windows)
Complete local development and testing workflow for Windows.

**Usage:**
```bash
run-local.bat
```

Or double-click the file in File Explorer.

**Features:**
- Same functionality as `run-local.sh` for Windows
- Color-coded terminal output
- Interactive Docker build option

---

### 3. **run-tests.sh** (Linux/macOS)
Standalone test runner without starting the server.

**What it does:**
- ✅ Creates/activates virtual environment
- ✅ Installs dependencies
- ✅ Runs all unit tests
- ✅ Shows test summary

**Usage:**
```bash
chmod +x run-tests.sh
./run-tests.sh
```

**Expected output:**
```
═══════════════════════════════════════════════════
► Step 3: Running Unit Tests
═══════════════════════════════════════════════════
test_homepage_renders (test_app.AppTestCase) ... ok
test_status_endpoint (test_app.AppTestCase) ... ok

Ran 2 tests in 0.005s
OK

✓ All unit tests passed! ✓
```

---

### 4. **run-docker-local.sh** (Linux/macOS)
Build and run Docker image locally.

**What it does:**
- ✅ Checks Docker installation
- ✅ Builds Docker image: `devops-app:local`
- ✅ Checks for existing containers
- ✅ Runs container on `http://localhost:5000`

**Usage:**
```bash
chmod +x run-docker-local.sh
./run-docker-local.sh
```

**Features:**
- Automatic cleanup of old containers
- Container removal prompts
- Live terminal output from container

---

## 🚀 Quick Start Guide

### Option 1: Full Local Development (Recommended for first-time setup)
```bash
# Linux/macOS
./run-local.sh

# Windows
run-local.bat
```

### Option 2: Just Run Tests
```bash
./run-tests.sh
```

### Option 3: Docker Development
```bash
./run-docker-local.sh
```

---

## 📝 Workflow Examples

### Example 1: Develop & Test Locally
```bash
./run-local.sh
# Make changes to app.py
# Press CTRL+C to stop
# Restart with ./run-local.sh to see changes
```

### Example 2: Run Tests Only
```bash
./run-tests.sh
# If all tests pass:
# ✓ You're ready to push to GitHub
# → GitHub Actions will run the full CI/CD pipeline
```

### Example 3: Test Docker Build
```bash
./run-docker-local.sh
# Container runs on localhost:5000
# Test with: curl http://localhost:5000/api/status
```

---

## 📊 Testing Endpoints

Once the app is running, test these endpoints:

### Homepage
```bash
curl http://localhost:5000/
```
**Response:** HTML page with "DevOps Pipeline Control Center"

### API Status
```bash
curl http://localhost:5000/api/status
```
**Response:**
```json
{
  "status": "Healthy",
  "timestamp": "2026-06-17T14:30:45.123456",
  "hostname": "your-machine-name",
  "message": "DevOps Pipeline is fully functional!"
}
```

---

## 🔧 Troubleshooting

### Python not found
```bash
# Install Python 3.11+
# macOS: brew install python3
# Ubuntu/Debian: sudo apt-get install python3 python3-venv
# Windows: Download from python.org
```

### Permission Denied (Linux/macOS)
```bash
chmod +x run-local.sh
chmod +x run-tests.sh
chmod +x run-docker-local.sh
```

### Virtual Environment Issues
```bash
# Manually recreate:
rm -rf app/.venv
python3 -m venv app/.venv
source app/.venv/bin/activate
pip install -r app/requirements.txt
```

### Docker Issues
```bash
# Check if Docker is running
docker ps

# If not running:
# macOS: Open Docker Desktop
# Linux: sudo systemctl start docker
# Windows: Open Docker Desktop
```

### Port 5000 Already in Use
```bash
# Find process using port 5000
lsof -i :5000

# Kill process (replace PID)
kill -9 <PID>

# Or use different port by editing app.py line 21
```

---

## 🎯 CI/CD Integration

These scripts are for **local development**. For production CI/CD:
- GitHub Actions uses `.github/workflows/deploy.yml`
- The workflow runs tests automatically on push to `main`
- Check the Actions tab in your GitHub repo for results

---

## 📦 Environment Variables

### Docker Container
The Docker container automatically uses:
- `FLASK_APP=app.py`
- `FLASK_ENV=production`
- Port: `5000`

### Local Development
Scripts use system Python and environment defaults.

---

## 🧹 Cleanup

### Remove Virtual Environment
```bash
rm -rf app/.venv
```

### Remove Docker Image
```bash
docker rmi devops-app:local
```

### Remove Docker Container
```bash
docker rm devops-app-container
```

---

## 📞 Support

If scripts fail:
1. Check `.venv/` and `build.log` for error messages
2. Ensure all prerequisites are installed (Python 3.11+, pip, Docker)
3. Run with verbose output to debug
4. Check GitHub Actions logs for CI/CD workflow failures

---

**Happy coding! 🚀**
