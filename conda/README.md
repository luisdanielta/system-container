## Minconda Maintainer
This setup allows maintaining a persistent Miniconda installation inside a Docker volume using a lightweight Alpine-based container. It enables manual updates, shared environments, and reuse across multiple containers.

### Usage Guide
1. Create the Docker Volume
```bash
docker volume create conda_app
```

2. Build the Maintainer Image
```bash
docker build -t minconda:local .
```

3. Run the maintainer
```bash
docker run -it --rm -v conda_app:/opt/conda minconda:local
```

### Debug or Inspect
You can explore or test the environment using:
```bash
docker run --rm -it -v conda_app:/opt/conda ubuntu:20.04
```
Inside the container:
```bash
source /opt/conda/etc/profile.d/conda.sh
```

This copies the Conda installation to the volume and sets required permissions. Explore the install log and Conda version here.

#### Components
- Dockerfile: Multistage build (Miniconda → Alpine), versioned by ARG, mounts /opt/conda.

- `entrypoint.sh`: Applies `.condarc`, fixes permissions.

- `.condarc`: Static config for environments and package cache in /opt/conda.

## Docker Compose for CI/CD Integration
The included `docker-compose.yml` defines a service that prepares the `conda_app` volume during CI or setup pipelines.

### Use in CI Pipelines
- Define the `conda_app` volume in your infrastructure or CI cache.
- Run `docker-compose up --build` during setup to prepare environments.
- Consume the volume from other build/test containers.

This image is designed to act as a file maintainer for `/opt/conda`, enabling environment persistence across containerized workflows in both development and CI/CD pipelines.