conda config --set auto_activate_base false


conda install -c conda-forge jupyterlab


jupyter lab --generate-config

c.ServerApp.root_dir = "/home/jupyter"

# Desactivar autenticación

c.ServerApp.token = ''
c.ServerApp.password = ''


jupyter lab --ip=0.0.0.0 --port=8888 --no-browser