"insecure-registries": ["127.0.0.1:5000"]

### Using the Local Docker Registry
alias dpush='bash -c "docker tag \$1 localhost:5000/\$1 && docker push localhost:5000/\$1" bash'

#### Tag and Push the Image to Local Registry
docker tag ubuntu:local localhost:5000/ubuntu:local
docker push localhost:5000/ubuntu:local