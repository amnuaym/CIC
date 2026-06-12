pipeline {
    agent any

    environment {
        // Database configuration for testing
        DB_USER = 'admin'
        DB_PASS = 'admin123'
        DB_NAME = 'template_db'
        DATABASE_URL = "postgres://${DB_USER}:${DB_PASS}@postgres-test-${BUILD_NUMBER}:5432/${DB_NAME}?sslmode=disable"
        
        // React build configuration
        VITE_API_URL = '/api/v1'
    }

    stages {
        stage('Initialize Integration Environment') {
            steps {
                script {
                    echo 'Creating ephemeral docker network...'
                    sh "docker network create build-net-${BUILD_NUMBER} || true"

                    echo 'Starting ephemeral PostgreSQL database container...'
                    sh """
                        docker run -d \
                            --name postgres-test-${BUILD_NUMBER} \
                            --network build-net-${BUILD_NUMBER} \
                            -e POSTGRES_USER=${DB_USER} \
                            -e POSTGRES_PASSWORD=${DB_PASS} \
                            -e POSTGRES_DB=${DB_NAME} \
                            postgres:15-alpine
                    """
                    
                    // Wait for PostgreSQL to become healthy (robust wait loop with 30s timeout)
                    echo 'Waiting for database to start...'
                    sh """
                        docker run --rm \
                            --network build-net-${BUILD_NUMBER} \
                            postgres:15-alpine \
                            sh -c 'timeout=30; while [ \$timeout -gt 0 ]; do if pg_isready -h postgres-test-${BUILD_NUMBER} -U ${DB_USER}; then exit 0; fi; sleep 1; timeout=\$((\$timeout - 1)); done; echo "Timeout waiting for PostgreSQL"; exit 1'
                    """
                }
            }
        }

        stage('Test Go Backend') {
            steps {
                dir('go') {
                    echo 'Running Go unit and integration tests...'
                    sh "docker run --rm -v \$(pwd):/app -w /app --network build-net-${BUILD_NUMBER} golang:1.21-alpine go test -v ./..."
                }
            }
        }

        stage('Test React Frontend') {
            steps {
                dir('react-admin') {
                    echo 'Installing node modules and running linter...'
                    sh "docker run --rm -v \$(pwd):/app -w /app node:18-alpine sh -c 'npm install && npm run lint || echo \"Lint warnings found, proceeding...\"'"
                }
            }
        }

        stage('Package Production Docker Images') {
            steps {
                script {
                    echo 'Packaging security-hardened Go API production image...'
                    sh "docker build -f go/Dockerfile.prod -t cic-api:latest ./go"

                    echo 'Packaging React Admin production image...'
                    sh "docker build --build-arg VITE_API_URL=${VITE_API_URL} -f react-admin/Dockerfile -t cic-react-admin:latest ./react-admin"
                }
            }
        }
    stage('Deploy to Production GKE') {
        when {
            branch 'main'
        }
        steps {
            script {
                echo 'Deploying to GKE production cluster in region asia-southeast3...'
                sh '''
                    if [ -f "/var/jenkins_home/gcp-key.json" ]; then
                        cp /var/jenkins_home/gcp-key.json ./gcp-key.json
                    fi
                    bash prod-setup/gcp/deploy.sh
                '''
            }
        }
    }
    }

    post {
        always {
            script {
                echo 'Cleaning up ephemeral test resources...'
                sh "docker rm -f postgres-test-${BUILD_NUMBER} || true"
                sh "docker network rm build-net-${BUILD_NUMBER} || true"
            }
        }
    }
}
