#!/usr/bin/env bash

set -x

# Frankfurt
export ZONE=europe-west3-a
#export ZONE=europe-west3-b
#export ZONE=europe-west3-c
export REGION=europe-west3

export PROJECT_ID=gke-cluster-335922

export CLUSTER_NAME=gke-cluster

set +x
echo "################################################################################"
echo "### create gke cluster in Frankfurt"
echo "################################################################################"
set -x

gcloud config set project ${PROJECT_ID}

gcloud services enable \
    container.googleapis.com

gcloud config set compute/zone ${ZONE}
gcloud config set compute/region ${REGION}

sleep 20

gcloud container clusters create \
    ${CLUSTER_NAME} \
    --num-nodes "3"

sleep 60

gcloud container clusters describe \
    ${CLUSTER_NAME}

gcloud container clusters get-credentials \
    ${CLUSTER_NAME}

sleep 20

set +x
echo "################################################################################"
echo "### get nodes and pods"
echo "################################################################################"
set -x

kubectl get nodes

kubectl get deployments --all-namespaces

kubectl get pods --all-namespaces

sleep 20

gcloud container clusters delete \
    ${CLUSTER_NAME} \
    --quiet

sleep 20
