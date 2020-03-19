c.JupyterHub.cookie_secret_file = '/home/jupyterhub/conf/jupyterhub_cookie_secret'
c.PAMAuthenticator.service = 'jupyterhub'
c.Spawner.cmd = '/home/jupyterhub/anaconda3/bin/jupyterhub-singleuser'
# put the log file in /var/log
c.JupyterHub.extra_log_file = '/home/jupyterhub/conf/jupyterhub.log'
c.JupyterHub.db_url = '/home/jupyterhub/conf/jupyterhub.sqlite'
c.Spawner.notebook_dir = '/home/jupyterhub/data'
