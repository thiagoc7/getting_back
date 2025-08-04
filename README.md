# Getting Back

A Rails application for managing books and chapters.

## Development Setup

### Prerequisites
- Docker and Docker Compose
- VS Code with Dev Containers extension

### Getting Started
1. Clone the repository
2. Open in VS Code
3. When prompted, click "Reopen in Container"
4. Wait for the container to build and dependencies to install

## System Tests

This project is configured to run system tests using Selenium with Chrome/Chromium headless.

### Running System Tests
```bash
# Run all system tests
bundle exec rails test:system

# Run specific system test file
bundle exec rails test test/system/books_test.rb

# Run specific test
bundle exec rails test test/system/books_test.rb:26
```

### Configuration
The project uses:
- Chromium (browser)
- ChromeDriver (Selenium driver)
- Xvfb (virtual X server for headless mode)

All dependencies are automatically installed in the dev container.

For more details, see [SYSTEM_TESTS.md](SYSTEM_TESTS.md).

## CI/CD

This project uses GitHub Actions for CI and Render for CD.

### CI (GitHub Actions)
- Runs on Pull Requests and pushes to `main`/`develop`
- Security scanning with Brakeman
- Code linting with RuboCop
- Unit, integration, and system tests
- SQLite for development and test environments

### CD (Render)
- Automatic deployment after CI passes
- PostgreSQL database
- Production environment

For detailed CI/CD documentation, see [CI_CD.md](CI_CD.md).

## Development

### Running the Application
```bash
bin/dev
```

### Running Tests
```bash
# Unit tests
bundle exec rails test

# System tests
bundle exec rails test:system

# All tests
bundle exec rails test
```

### Database
```bash
# Setup database
bundle exec rails db:setup

# Run migrations
bundle exec rails db:migrate
```

## Features

- Book management
- Chapter management
- Theme switching
- Responsive design with Tailwind CSS
- Hotwire for dynamic interactions

## Tech Stack

- Ruby on Rails 8.0.2
- Ruby 3.3.8
- SQLite (development/test)
- PostgreSQL (production)
- Tailwind CSS
- Hotwire (Turbo + Stimulus)
- Selenium (system tests)
- GitHub Actions (CI)
- Render (CD)
