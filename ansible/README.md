# Ansible Playbooks and Roles

## Folder structure

Below playbooks are executed in ec2 userdata via terraform

- Mounts EFS storage on EC2 instance

    ```storage.yaml```

- Install docker dependencies on EC2 instance

    ```docker.yaml```

- Install and configure jenkins on EC2 instance

    ```jenkins.yaml```

# Local testing setup

This repository contains a Makefile that helps set up a virtual environment, install dependencies, and perform various tasks. The Makefile provides the following targets:

## venv
Creates a virtual environment and installs dependencies specified in the `requirements.txt` file.

To create the virtual environment and install dependencies, run the following command:

`make venv`

## make check
Runs `ansible-lint` on all `*.yaml` files in the repository.

To run `ansible-lint`, use the following command:

`make check`

## clean
Removes the virtual environment and any compiled Python files (`*.pyc`) in the `src` directory.

To clean the repository, run the following command:

`make clean`

Execution of playbook locally on a remote test ec2. Kindly note to update the ip address of the test ec2 in [file](env/local). Playbook currently support only ubuntu.

```ansible-playbook -i env/local docker.yaml```