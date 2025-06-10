#!/bin/bash

echo "🚀 Starting Local Development Environment..."

# Copy local environment file
if [ -f .env.local ]; then
    cp .env.local .env
    echo "✅ Local environment file loaded"
else
    echo "⚠️  .env.local not found, using defaults"
fi

# Create directories if they don't exist
mkdir -p docker/nginx docker/php docker/mysql

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose.yml -f docker-compose.local.yml down

# Build and start containers
echo "🔨 Building and starting containers..."
docker-compose -f docker-compose.yml -f docker-compose.local.yml up -d --build

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 10

# Check if containers are running
echo "📊 Container Status:"
docker-compose -f docker-compose.yml -f docker-compose.local.yml ps

# Check if application is accessible
echo ""
echo "🌐 Application should be available at:"
echo "   📱 Web: http://localhost:8080"
echo "   🗄️  Database: localhost:3307"
echo ""
echo "📋 Database Connection Details:"
echo "   Host: localhost"
echo "   Port: 3307"
echo "   Database: myapp_db_local"
echo "   Username: myapp_user"
echo "   Password: myapp_password"
echo ""
echo "✅ Local development environment is ready!"