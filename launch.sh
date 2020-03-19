docker run -it -d -p 8000:8000 -v jupyterhub_conf:/home/jupyterhub/conf -v jupyterhub_data:/home/jupyterhub/data -e JUPYTERHUB_USER_PASS=test123  --name jupyterhub jemaiah/jupyterhub:0.1
