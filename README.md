# React Image Compressor

## Overview

A simple image compressor built with [react](https://reactjs.org/) and [browser-image-compression](https://www.npmjs.com/package/browser-image-compression).

## Functionalities

- Compress Image By Reducing Resolution and Size
- Offline Compression

## Built With

- ReactJS
- React Bootstrap
- Browser Image Compression

## Prerequisites

- MAKE GNU active on your laptop
- Docker installed
- Helm3 installed, if not please check the `out.yaml` file that contains k8s manifests

## Development
1. To run local environment please run `make start`.
2. To test helm chart + manifest file, please run `make chart-test`
3. To create the image for production environment please run `make image-prod`
4. To apply helm3 chart directly please run `make chart-install -- -f {relativepath}/values.yaml`
    example `make chart-install -- -f helm/react-image-compressor/values.yaml`

## Questions
How would you try it in your local environment?

Probably the best way to try it is in with something like KinD or Minikube.
Once installed all the resources you can launch something like `k port-forward ${application}` pointing to the service 
an check if the application works.
I also prefer to check consitency of the manifest I release so for this I'd like to use `kubeval` docker image in order 
to be secure that the manifest are correctly valorized.

The Codebuild project requires a service role to do its job, but you don't need to define it properly.
Can you think of the policies it must have to complete its build and deployment task?

Please check the file under `aws` folder, the IAM Role with all the relative policies are defined there. 
