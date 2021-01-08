# Node Alpine Docker Image with basic useful tools

> Lightweight Docker image based on node:14-alpine with basic useful tools:

- node 14.15.4+
- yarn 1.22.5+
- npm 6.14.10+
- git 2.24.3+
- bash 5.0.11+
- openssh 8.1+
- rsync 3.1.3+
- curl 7.67.0+

## Docker hub

Can be pulled from Docker Hub: [coexcz/node-alpine](https://hub.docker.com/r/coexcz/node-alpine/tags)

```docker
docker pull coexcz/node-alpine
```

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

## Development

### Release

#### Automatically

```shell
yarn release:patch
# yarn release:minor
# yarn release:major
```

New version will be built, tagged and pushed into Docker Hub with current tag `:v1.x.x` + `:latest` tag

#### Manually

```docker
docker build --no-cache --progress plain --pull -t node-alpine:v14.x.x .
docker tag node-alpine:v14.x.x coexcz/node-alpine:v14.x.x
docker push coexcz/node-alpine:v14.x.x
```
