GitHub Action for interacting with EKS-vended Kubernetes cluster.

## Usage

To use this action put this step into your workflow:

```
- uses: Eyevinn/action-eks-kubectl@master
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    REGION: eu-north-1
    CLUSTER: prod
  with:
    args: get pods
```

## Environment Variables

These variables are required to authorize with the EKS cluster. The AWS IAM user that is associated with the key must have permissions to access the cluster. Read more about how here: https://www.agilepartner.net/en/adding-users-to-your-eks-cluster/

| VARIABLE | DESCRIPTION |
| --- | --- |
| AWS_ACCESS_KEY_ID | AWS Access Key ID |
| AWS_SECRET_ACCESS_KEY | AWS Secret Access Key |
| REGION | AWS Region of the Cluster |
| CLUSTER | Name of the Cluster |

## Example

Updating the container image when a release is published

```
name: Deploy to production Kubernetes cluster
  
on:
  release:
    types: [published]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Get the version
        id: get_version
        run: echo ::set-output name=VERSION::$(echo $GITHUB_REF | cut -d / -f 3)
      - name: Deploy new version
        uses: Eyevinn/action-eks-kubectl@master
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          REGION: eu-north-1
          CLUSTER: prod
        with:
          args: set image --record deployment/my-app container=590877988961.dkr.ecr.eu-north-1.amazonaws.com/my-app:${{ steps.get_version.outputs.VERSION }}
```

## LICENSE

[MIT License](https://github.com/Eyevinn/action-eks-kubectl/blob/master/LICENSE)

## About Eyevinn Technology

Eyevinn Technology is an independent consultant firm specialized in video and streaming. Independent in a way that we are not commercially tied to any platform or technology vendor.

At Eyevinn, every software developer consultant has a dedicated budget reserved for open source development and contribution to the open source community. This give us room for innovation, team building and personal competence development. And also gives us as a company a way to contribute back to the open source community. 

Want to know more about Eyevinn and how it is to work here. Contact us at work@eyevinn.se!
