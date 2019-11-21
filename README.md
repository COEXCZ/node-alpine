# Node Alpine Docker Image with basic useful tools

> Lightweight Docker image based on node:12-alpine with basic useful tools:

- yarn 1.19.1+
- openssh 7.9+
- git 2.20.1+
- bash 4.4.19+

## Examples

### Bitbucket Pipelines CI + Angular

> Deploy your Angular project with Bitbucket Pipelines to Firebase Hosting

1. Install `firebase-tools` locally in your project

```bash
yarn add firebase-tools --dev
```

2. Make alias for firebase in your project

> Add this line to your _package.json_ into `scripts` object
```json
scripts: {
  "firebase": "firebase"
}
```

3. Get the `$FIREBASE_TOKEN` by running:

```bash
yarn firebase login:ci
```

4. Set Bitbucket environment variable

- Save CI token to Bitbucket's environment variables `(Project -> Settings > Environment variables)` with variable name `FIREBASE_TOKEN`

5. Create Firebase project and make firebase config file

- [Create Firebase project](https://console.firebase.google.com/)
- Run `yarn firebase init` in your project
- Go through the wizard (it should create firebase.json and dist folder)

#### Pipelines configuration

- Create `bitbucket-pipelines.yml`

```yml
image: coexcz/node-alpine

pipelines:
  branches:
    master:
    - step:
        caches:
          - node
        script:
          - yarn
          - yarn build
          - yarn firebase deploy --token "$FIREBASE_TOKEN"
```

#### Conclusion

And now every commit pushed to `master` branch will be deployed to your firebase hosting 🎉

## Docker hub

Can be pulled from Docker Hub: [coexcz/node-alpine](https://hub.docker.com/repository/docker/coexcz/node-alpine)

```docker
docker pull coexcz/node-alpine
```

## Development
```docker
docker build -t node-alpine:v12.x.x .
docker tag node-alpine:v12.x.x coexcz/node-alpine:v12.x.x
docker push coexcz/node-alpine:v12.x.x
```