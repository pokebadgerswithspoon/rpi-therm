# Ansible

## Prerequisite

Install ansible: https://docs.ansible.com/ansible/latest/installation_guide/index.html


## Run playbooks

Have a look at [hosts.ini](./inventories/hosts.ini) and adjust accordingly.

### Setup board

Rember data pin your data cable is connected to? Playbook assumes it is `GPIO4`. If it is not the case, adjust the number in playbook.

```sh
ansible-playbook playbooks/thermometer-setup.yml
```

### Install scripts

```sh
ansible-playbook playbooks/thermometer-scripts.yml
```

It will install a brunch of scripts to `/opt/therm/bin` folder of the pi.

Note. It will also instll a cronjob which will post temperature somewhere to internet. Disable it unless needed.

If postage of temerature is needed, then you might want to have a look at `thermometer_post.sh` and make sure APP_HOST is correct there.

### Install NGINX

This will spinup local server

```sh
ansible-playbook playbooks/thermometer-nginx.yml
```

## PS

If everything is all right, there will be a a web server on your PI showing temerature online.

http://raspberry-pi/