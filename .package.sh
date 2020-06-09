#!/bin/sh
ENV=$1
CR_YANDEX_ID=${CR_YANDEX_ID:-""}
DOCKER_PROJECT=${DOCKER_PROJECT:-"esb-monorepo"}
VERSION=${CI_COMMIT_TAG::1}

echo "CR_YANDEX_ID = $CR_YANDEX_ID"
echo "DOCKER_PROJECT = $DOCKER_PROJECT"
echo "CI_COMMIT_TAG = $CI_COMMIT_TAG"

image_name_with_tag() {
    echo "cr.yandex/$CR_YANDEX_ID/$DOCKER_PROJECT/$1:$CI_COMMIT_TAG"
}
image_name() {
    echo "cr.yandex/$CR_YANDEX_ID/$DOCKER_PROJECT/$1"
}


Build_Kustomize_File() {
    cat >> overlays/${ENV}/kustomization.yaml <<EOF
$(
  for i in dist/apps/*/*; do
    DIR=${i/dist\//./}
    echo  "  - ../.$DIR/overlays/${ENV}"
  done
)
images:
$(
  for i in dist/apps/*/*; do
    DIR=${i/dist\/apps\//}
    echo "  - name: $(image_name ${DIR/\//-})"
    echo "    newTag: $CI_COMMIT_TAG"
  done
)
EOF
}


[ -d "dist/apps" ] && Build_Kustomize_File || echo "Build empty"

echo "Job finish"
