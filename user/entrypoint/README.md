### Entry Point - Data
Initially, the `entrypoint:local` image is built as the orchestration entry point:

```bash
docker build -t entrypoint:local .
```

### **1. `create-user.sh`**
This script runs during the image build and performs the following:

* Creates a custom group and user based on defined UID and GID.
* Configures passwordless sudo privileges.
* Assigns ownership and permissions to the user’s home directory.
* Sets this user as the default execution context.
