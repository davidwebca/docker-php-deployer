# Custom Dockerfile for Bitbucket Pipeline PHP deployment

This is a lightweight and simple Dockerfile pre-packaged with all the necessary softwares that we use in our continuous deployment system. I've based this Dockerfile on many other found on the web and wanted to combine everything in a single Docker Image to avoid building my Bitbucket Pipeline in multiple steps in different images.

## Dependencies installed
Here's the full list of dependencies installed: 
- Based on php:8.0.25-cli-alpine
- bash
- curl
- git
- make
- rsync
- openssh-client-default
- sshpass
- openssh-keygen
- ca-certificates
- tzdata
- libstdc++
- libgcc
- composer
- node (installed with n because of Alpine Linux limitations on versioning)
- git-ftp

## Todo
- [ ] Provide bitbucket-pipeline.yml example
- [ ] Tag dynamically from upstream PHP version to allow selecting different PHP versions
- [ ] Validate if all installed dependencies are necessary (ex.: tzdata - since I've based this image on multiple others, I fear I have created a Frankeinsein and still need to validate that everything is necessary)

## Bitbucket Pipeline example
Soon

## Contributions 
Even though this image is made public, please be mindful that this is mostly for private usage as of now. If you find this useful and want to contribute with pull requests, pleaase add as much detail as possible in the description of the PR. Using issues is discouraged and will mostly be ignored.