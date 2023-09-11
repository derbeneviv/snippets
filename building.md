Building with kaniko
on host in project dir
```
podman run -it --entrypoint=sh -v $(pwd):/workspace \
  -e ARTIFACTORY_SERVER="artifactory.raiffeisen.ru" \
  -e ARTIFACTORY_USER=${ARTIFACTORY_USER} \
  -e ARTIFACTORY_PASSWORD=${ARTIFACTORY_PASSWORD} \
  artifactory.raiffeisen.ru/ext-devops-community-docker/kaniko:1.7.0
```
inside container
```
mkdir -p /kaniko/.pip
mkdir -p /kaniko/apt
echo "machine artifactory.raiffeisen.ru login $ARTIFACTORY_USER password $ARTIFACTORY_PASSWORD" > /kaniko/apt/auth.conf
cat > /kaniko/.pip/pip.conf << EOF
[global]
index-url = https://${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD}@artifactory.raiffeisen.ru/artifactory/api/pypi/remote-pypi/simple
index = https://${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD}@artifactory.raiffeisen.ru/artifactory/api/pypi/remote-pypi
disable-pip-version-check = true
trusted-host = artifactory.raiffeisen.ru
EOF
echo "{\"auths\":{\"$ARTIFACTORY_SERVER\":{\"username\":\"$ARTIFACTORY_USER\",\"password\":\"$ARTIFACTORY_PASSWORD\"}}}" > /kaniko/.docker/config.json
/kaniko/executor --no-push
```
