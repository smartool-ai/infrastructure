# Studio

Studio is the home for the infrastructure layer hosted on AWS and utilizing SAM to generate Cloudformation templates.

Deployments/Updates of stacks should be done strictly through CI/CD for Production environments always.

Any sensitive secrets/tokens should be passed via environment variables and never hardcoded into sam template.


The `template.yaml` file contains the configuration for AWS Cloudformation

- [Initial Setup](#initial-setup)
    - [Install AWS CLI](#install-aws-cli)
    - [Install AWS SAM CLI](#install-aws-sam-cli)
    - [Deploy to your AWS Account](#deploy-to-your-aws-account)
- [Architecture](#architecture)

## Initial Setup

### Install AWS CLI

Follow the instructions found [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) to install AWS Command Line Interface

Here are the suggested steps for macOS:

- 1. Download the file using the curl command. The -o option specifies the file name that the downloaded package is written to. In this example, the file is written to AWSCLIV2.pkg in the current folder. 
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
```
- 2. Run the standard macOS installer program, specifying the downloaded .pkg file as the source. Use the -pkg parameter to specify the name of the package to install, and the -target / parameter for which drive to install the package to. The files are installed to /usr/local/aws-cli, and a symlink is automatically created in /usr/local/bin. You must include sudo on the command to grant write permissions to those folders.
```bash
sudo installer -pkg ./AWSCLIV2.pkg -target /
```
- 3. To verify that the shell can find and run the aws command in your $PATH, use the following commands.
```bash
which aws
aws --version
```
- Last step should print out the version of awscli installed


### Install AWS SAM

Follow the instructions found [here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html) to install AWS Serverless Application Model Command Line Interface

Here are the suggested steps for macOS:

- 1. To begin installation, download the macOS pkg to a directory of your choice:

x86_64 (Intel) – [here](https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-macos-x86_64.pkg)

arm64 (Apple) – [here](https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-macos-arm64.pkg)

- 2. Verify the integrity and authenticity of the downloaded installer by generating a hash value using the following command:
```bash
shasum -a 256 path-to-pkg-installer/name-of-pkg-installer

# Examples
shasum -a 256 /Users/myUser/Downloads/aws-sam-cli-macos-arm64.pkg
shasum -a 256 /Users/myUser/Downloads/aws-sam-cli-macos-x86_64.pkg
```

- 3. Modify and run the installation script:
```bash
sudo installer -pkg path-to-pkg-installer/name-of-pkg-installer -target /
```

- 4. Verify that the AWS SAM CLI has properly installed and that your symlink is configured by running:
```bash
which sam

sam --version
```

### Deploy to your AWS Account

This step will deploy to your own AWS account so that you can build/run/test in your own personal cloud environment. To do this you will first need access to AWS. You can reach out to project lead for this.

Once you have access to AWS, you will want to export AWS environment variables that will allow you to connect your account to AWS cli. One way of doing this is by navigating to AWS SSO through Okta and click your personal account. You should see drop down of your personal accounts. Choose whichever you wish to deploy to that has write permissions, the default is AWS AdministratorAccess account, and click 'Command line or programmatic access'. This will bring up a box with several options to gain access to your account. Choose one of them and follow the instructions.

Once done you will follow these steps to make a deployment:

- 1. Ensure required environment variables are set, current required variables:
**DO NOT SET TO PROD**
No one has access to write to production, but this shouldn't be done nonetheless
```bash
set -a
export STAGE_NAME=local
set +a
```

- 2. Run deployment command:
```bash
make sam-deploy
```
**Note: If this is the initial deployment of studio on an AWS account then it will get stuck on CertificateManager creation as this creation will not move to COMPLETED state until the certificate is verified. Certificate manager generates a CNAME record that you will have to go into the console and click a button that automatically adds it to the HostedZone. Also, since this stack is actually creating a subdomain on your AWS account you will have to manually copy the NS record values that were created in the HostedZone and create a new NS record in Zone Management accounts only HostZone. This connects the subdomain to the base domain and allows the certificate to be verified.

**Note: Be aware when deploying to your AWS account that when you delete the stack, sometimes deletion
of the VPC isn't successful and you may have to manually delete from the console.

```

## Architecture

For a model of the architecture follow this [link](https://www.figma.com/file/yaIhjNiAjkSmWnvlBEZePf/Backend-Architecture-Models?t=oJ2eFB60UA3VLw9b-0) and make sure to add updates to these diagrams as necessary.