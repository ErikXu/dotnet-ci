#!/bin/bash

SERVICE_NAME=${SERVICE_NAME:-dotnet-ci}
echo "SERVICE_NAME: "$SERVICE_NAME

IMAGE_NAME=${IMAGE_NAME:-dotnet-ci}
echo "IMAGE_NAME: "$IMAGE_NAME

IMAGE_TAG=${IMAGE_TAG:-1.0.0}
echo "IMAGE_TAG: "$IMAGE_TAG

cat yaml/k8s.yaml.template | sed 's|{service-name}|'$SERVICE_NAME'|g; s|{image-name}|'$IMAGE_NAME'|g; s|{image-tag}|'$IMAGE_TAG'|g' > yaml/k8s.yaml
cat yaml/vs.yaml.template | sed 's|{service-name}|'$SERVICE_NAME'|g' > yaml/vs.yaml

kubectl set image deployment/$SERVICE_NAME $SERVICE_NAME=$IMAGE_NAME:$IMAGE_TAG

if [ $? -ne 0 ]; then
    echo "更新[$SERVICE_NAME]失败，服务可能不存在，尝试创建"
    kubectl apply -f yaml/k8s.yaml
    kubectl apply -f yaml/vs.yaml
fi

if [ $? -ne 0 ]; then
  echo "[$SERVICE_NAME]部署失败"
else
  echo "[$SERVICE_NAME]部署成功"
fi