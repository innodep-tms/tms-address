#!/bin/bash
# 빌드
BUILD_TYPE="devel"
VERSION="1.0.5"
BUILD_NUMBER="1"

BUILD_DATE=$(date +%y%m%d_%H_%M_%S)
build_tag="$BUILD_TYPE-$VERSION.$BUILD_NUMBER-$BUILD_DATE"
build_latest_tag="$BUILD_TYPE-$VERSION-latest"
echo "$build_tag" > ./config/version.txt

# 도커 푸시
docker build --tag innodep.azurecr.io/tms-update-address:$build_latest_tag --tag innodep.azurecr.io/tms-update-address:"$build_tag" .
#docker push innodep.azurecr.io/tms-update-address:"$build_tag"

# 업로드가 완료된 이미지 삭제
#docker rmi innodep.azurecr.io:/tms-update-address:$build_latest_tag innodep.azurecr.io/tms-update-address:"$build_tag"