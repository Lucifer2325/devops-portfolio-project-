# Changelog

## [Unreleased]
### Added
- Added `README.md` with project overview and local build instructions.
- Added `docs/ci-pipeline.md` for pipeline documentation and log troubleshooting.
- Added `docs/deployment.md` for Kubernetes and Terraform deployment guidance.
- Added `app/test_app.py` with unit tests for the Flask app.
- Added `app/__init__.py` to support the application package.
- Enhanced `.github/workflows/deploy.yml` to install dependencies, run tests, capture `build.log`, and upload artifacts.

### Updated
- Updated CI workflow to include dependency install and test stages.
