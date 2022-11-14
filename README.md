## OpenSSH Docker Server

This repository contains an example of a simple OpenSSH Docker Server. 
I made it as a shortcut to suit my working needs, but I bet it will be helpful for others as well.

## Building and running

On your remote server do the following:
1. Run `git clone https://github.com/oKatanaaa/OpenSSH-Docker-Server.git`
2. Run `cd OpenSSH-Docker-Server`
3. Set the password in `Dockerfile` (line 15). In this example a pytorch docker is being set, 
but you can customize the image to suit your needs (pick a different base image, install other packages, etc).
3. Run `./build.sh`
4. Set the port in run.sh (line 4).
5. Run `./run.sh`


## Connecting

The server is up. In Visual Studio Code open SSH configuration file (Remote-SSH: Open SSH Configuration File). Add the following (fill in where needed):
```
Host your_host_name
    HostName your_server_ip
    Port your_port
    User root
```
`your_host_name` can be arbitrary.

Once configuration is set, you can connect. Run `Remote-SSH: Connect to Host` in VS Code command palette and choose `your_host_name`. VS Code will connect and set up VS Code Server. You are good to go.
