#!/bin/bash

echo "🚀 Deploying to Production..."

# Check if production environment file exists
if [ ! -f .env.prod ]; then
    echo "❌ Error: .env.prod file not found!"
    echo "Please create .env.prod with your production settings"
    exit 1
fi

# Copy production environment file
cp .env.prod .env
echo "✅ Production environment file loaded"

# Pull latest code from git
echo "📥 Pulling latest code from git..."
git pull origin master

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose.yml -f docker-compose.prod.yml down

# Build and start containers in production mode
echo "🔨 Building and starting production containers..."
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 15

# Check if containers are running
echo "📊 Container Status:"
docker-compose -f docker-compose.yml -f docker-compose.prod.yml ps

# Cleanup old images
echo "🧹 Cleaning up old Docker images..."
docker image prune -f

echo ""
echo "✅ Production deployment complete!"
echo "🌐 Application should be available at your domain"
echo ""
echo "📋 To check logs:"
echo "   docker-compose -f docker-compose.yml -f docker-compose.prod.yml logs"
echo ""
echo "📋 To check status:"
echo "   docker-compose -f docker-compose.yml -f docker-compose.prod.yml ps"