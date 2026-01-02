class DockerTemplates {
  // DOCKERFILE FOR FLUTTER WEB
  static String generateDockerfile() {
    return '''
# Stage 1: Build the Flutter web app
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the web app
RUN flutter build web --release --web-renderer canvaskit

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy built web app from build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
''';
  }

  // NGINX CONFIGURATION
  static String generateNginxConfig() {
    return r'''
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss application/json application/javascript;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Cache static assets
    location ~* \\.(?:css|js|jpg|jpeg|gif|png|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Main app route
    location / {
        try_files \$uri \$uri/ /index.html;
    }

    # Handle 404
    error_page 404 /index.html;
}
''';
  }

  // DOCKER COMPOSE FOR DEVELOPMENT
  static String generateDockerCompose(String projectName) {
    return '''
version: '3.8'

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: ${projectName}_web
    ports:
      - "80:80"
    restart: unless-stopped
    networks:
      - app-network

  # Optional: Add development hot-reload service
  dev:
    image: ghcr.io/cirruslabs/flutter:stable
    container_name: ${projectName}_dev
    working_dir: /app
    volumes:
      - .:/app
      - flutter_pub_cache:/root/.pub-cache
    ports:
      - "8080:8080"
    command: flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
    networks:
      - app-network
    profiles:
      - dev

volumes:
  flutter_pub_cache:

networks:
  app-network:
    driver: bridge
''';
  }

  // DOCKER COMPOSE FOR PRODUCTION WITH REDIS & POSTGRES
  static String generateDockerComposeProduction(String projectName) {
    return '''
version: '3.8'

services:
  # Flutter Web App
  web:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: ${projectName}_web
    ports:
      - "80:80"
    restart: unless-stopped
    depends_on:
      - postgres
      - redis
    environment:
      - NODE_ENV=production
    networks:
      - app-network

  # PostgreSQL Database
  postgres:
    image: postgres:16-alpine
    container_name: ${projectName}_postgres
    environment:
      POSTGRES_DB: ${projectName}_db
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: your_secure_password_here
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    restart: unless-stopped
    networks:
      - app-network

  # Redis Cache
  redis:
    image: redis:7-alpine
    container_name: ${projectName}_redis
    ports:
      - "6379:6379"
    restart: unless-stopped
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes
    networks:
      - app-network

  # pgAdmin (Database Management)
  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: ${projectName}_pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@example.com
      PGADMIN_DEFAULT_PASSWORD: admin
    ports:
      - "5050:80"
    restart: unless-stopped
    depends_on:
      - postgres
    networks:
      - app-network
    profiles:
      - tools

volumes:
  postgres_data:
  redis_data:

networks:
  app-network:
    driver: bridge
''';
  }

  // .DOCKERIGNORE
  static String generateDockerignore() {
    return '''
# Flutter/Dart
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
.ios/
.android/
.idea/
*.iml

# Git
.git/
.gitignore
.github/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Documentation
README.md
CHANGELOG.md
docs/

# Tests
test/
coverage/

# Environment files
.env
.env.*
!.env.example

# Build artifacts
*.apk
*.aab
*.ipa

# Node modules (if any)
node_modules/
''';
  }

  // MAKEFILE FOR DOCKER COMMANDS
  static String generateMakefile(String projectName) {
    return '''
.PHONY: help build run stop clean dev logs restart

# Default target
help:
\t@echo "Available commands:"
\t@echo "  make build     - Build Docker image"
\t@echo "  make run       - Run production containers"
\t@echo "  make dev       - Run development server with hot reload"
\t@echo "  make stop      - Stop all containers"
\t@echo "  make clean     - Remove containers and images"
\t@echo "  make logs      - Show container logs"
\t@echo "  make restart   - Restart containers"
\t@echo "  make shell     - Open shell in web container"
\t@echo "  make db-shell  - Open PostgreSQL shell"

# Build Docker image
build:
\t@echo "Building Docker image..."
\tdocker-compose build

# Run production containers
run:
\t@echo "Starting production containers..."
\tdocker-compose up -d

# Run development server
dev:
\t@echo "Starting development server..."
\tdocker-compose --profile dev up dev

# Stop all containers
stop:
\t@echo "Stopping containers..."
\tdocker-compose down

# Clean up containers and images
clean:
\t@echo "Cleaning up..."
\tdocker-compose down -v
\tdocker system prune -f

# Show logs
logs:
\tdocker-compose logs -f

# Restart containers
restart:
\t@echo "Restarting containers..."
\tdocker-compose restart

# Open shell in web container
shell:
\tdocker exec -it ${projectName}_web sh

# Open PostgreSQL shell
db-shell:
\tdocker exec -it ${projectName}_postgres psql -U postgres -d ${projectName}_db

# Run flutter pub get
pub-get:
\tdocker-compose run --rm web flutter pub get

# Build web release
build-web:
\tdocker-compose run --rm web flutter build web --release
''';
  }

  // README FOR DOCKER SETUP
  static String generateDockerReadme(String projectName) {
    return '''
# Docker Setup for $projectName

This project includes Docker configuration for easy deployment and development.

## 🚀 Quick Start

### Prerequisites
- Docker (v20.10+)
- Docker Compose (v2.0+)

### Production Deployment

1. **Build the Docker image:**
   \`\`\`bash
   make build
   # OR
   docker-compose build
   \`\`\`

2. **Run the application:**
   \`\`\`bash
   make run
   # OR
   docker-compose up -d
   \`\`\`

3. **Access the app:**
   - Web App: http://localhost
   - pgAdmin (if enabled): http://localhost:5050

### Development Mode

For hot-reload during development:

\`\`\`bash
make dev
# OR
docker-compose --profile dev up dev
\`\`\`

Access at: http://localhost:8080

## 📋 Available Commands

| Command | Description |
|---------|-------------|
| \`make build\` | Build Docker image |
| \`make run\` | Start production containers |
| \`make dev\` | Start development server with hot-reload |
| \`make stop\` | Stop all containers |
| \`make clean\` | Remove containers and volumes |
| \`make logs\` | View container logs |
| \`make restart\` | Restart all containers |
| \`make shell\` | Open shell in web container |
| \`make db-shell\` | Open PostgreSQL shell |

## 🏗️ Architecture

### Production Stack
- **Web**: Flutter web app served by Nginx
- **PostgreSQL**: Database (optional)
- **Redis**: Caching layer (optional)
- **pgAdmin**: Database management UI (optional)

### File Structure
\`\`\`
.
├── Dockerfile              # Multi-stage build for Flutter web
├── docker-compose.yml      # Production services
├── nginx.conf             # Nginx configuration
├── .dockerignore          # Files to exclude from Docker build
├── Makefile               # Convenience commands
└── DOCKER.md              # This file
\`\`\`

## 🔧 Configuration

### Environment Variables

Create a \`.env\` file in the project root:

\`\`\`env
# Database
POSTGRES_DB=${projectName}_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_secure_password

# Redis
REDIS_PASSWORD=your_redis_password

# App
NODE_ENV=production
\`\`\`

### Ports

Default port mappings:
- Web App: 80
- PostgreSQL: 5432
- Redis: 6379
- pgAdmin: 5050 (dev profile)
- Dev Server: 8080 (dev profile)

To change ports, edit \`docker-compose.yml\`.

## 🛠️ Troubleshooting

### Container won't start
\`\`\`bash
# Check logs
make logs

# Restart containers
make restart
\`\`\`

### Clean rebuild
\`\`\`bash
# Remove everything and rebuild
make clean
make build
make run
\`\`\`

### Database connection issues
\`\`\`bash
# Check if PostgreSQL is running
docker ps

# Access database shell
make db-shell
\`\`\`

### Permission issues
\`\`\`bash
# Fix volume permissions
sudo chown -R \$USER:\$USER .
\`\`\`

## 📦 Building for Different Platforms

### Web Only (Current Setup)
Already configured! Just use \`make build\`.

### Android/iOS
For mobile deployments, use Flutter's native build tools:
\`\`\`bash
flutter build apk --release        # Android
flutter build ios --release         # iOS
flutter build appbundle --release   # Android App Bundle
\`\`\`

## 🔐 Security Notes

1. **Change default passwords** in \`.env\` and \`docker-compose.yml\`
2. **Use secrets** for production (Docker Swarm or Kubernetes)
3. **Enable HTTPS** with Let's Encrypt or similar
4. **Restrict database access** to internal network only
5. **Regular updates** - keep base images updated

## 🚀 Deployment

### Deploy to Cloud

**Docker Hub:**
\`\`\`bash
docker tag ${projectName}_web your-username/${projectName}:latest
docker push your-username/${projectName}:latest
\`\`\`

**AWS ECS, Google Cloud Run, or Azure:**
Follow their respective documentation for container deployment.

## 📝 Notes

- The production build uses Nginx for optimal performance
- Static assets are cached for 1 year
- Gzip compression is enabled for better performance
- Development mode mounts the source code for hot-reload
- Database and Redis data persist in Docker volumes

## 🤝 Contributing

When adding new services, update:
1. \`docker-compose.yml\`
2. This README
3. Network configuration if needed

---

For more information, visit the [Flutter Docker documentation](https://flutter.dev/docs/deployment/web).
''';
  }

  // GITHUB ACTIONS WORKFLOW FOR DOCKER
  static String generateGithubActionsDocker(String projectName) {
    return '''
name: Docker Build and Deploy

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: \${{ github.repository }}

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Container Registry
        uses: docker/login-action@v3
        with:
          registry: \${{ env.REGISTRY }}
          username: \${{ github.actor }}
          password: \${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: \${{ env.REGISTRY }}/\${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=sha

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: \${{ steps.meta.outputs.tags }}
          labels: \${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
      - name: Deploy to production
        run: |
          echo "Add your deployment commands here"
          # Example: SSH to server and pull/restart containers
          # ssh user@server "cd /app && docker-compose pull && docker-compose up -d"
''';
  }
}
