#!/bin/bash

set -eu

NEW_ORG=${NEW_ORG:-manifoldfinance}

DOCKERFILE_PATH=$1

echo Building docker image from $DOCKERFILE_PATH

function repo_name() {
  repo_tag=$( echo ${DOCKERFILE_PATH} | sed 's|.*/\([^/]*\)/images/.*/Dockerfile|\1|g')
  echo "${NEW_ORG}/${repo_tag}"
}

REPO_NAME=$(repo_name)

IMAGE_NAME=${REPO_NAME}:$(cat TAG)

echo "OFFICIAL IMAGE REF: $IMAGE_NAME"

function is_variant() {
    echo ${DOCKERFILE_PATH} | grep -q -e 'images/.*/.*/Dockerfile'
}

# pull to get cache and avoid recreating images unnecessarily
docker pull $IMAGE_NAME || true

docker build --pull -t $IMAGE_NAME . || (sleep 2; echo "retry building $IMAGE_NAME"; docker build --pull -t $IMAGE_NAME .)

# DISABLED `run_goss_tests`
#    run_goss_tests

    # provide an option to build but not push images
    # this can be used to build/test images on forked PRs
    # or just to skip pushing if desired

    if [[ $PUSH_IMAGES == true ]]; then
        docker push $IMAGE_NAME
		imageDigest=$(docker inspect --format='{{index .RepoDigests 0}}' ${IMAGE_NAME})
		echo "${IMAGE_NAME}: $imageDigest" >> ./docker-image-digests.txt

        handle_ccitest_org_images

        update_aliases
    fi

    popd
fi
