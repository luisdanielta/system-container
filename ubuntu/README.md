## Ubuntu custom image with conda_app volume

### 2. Building the Base Environment
The base image `ubuntu:local`, which contains system management logic, must be built:

```bash
docker build -t ubuntu:local .
```
