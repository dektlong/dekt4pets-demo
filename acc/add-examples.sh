#!/usr/bin/env bash

source secrets/config-values.env

export tss_client_server_uri=http://acc.$SUB_DOMAIN.$DOMAIN

#add generic examples
add-generic-examples() {

    generators_files=("generator-none.yaml" "generator-boot-k8s-kubectl.yaml" "generator-boot-k8s-jpa.yaml" "generator-boot-k8s-kustomize.yaml" "generator-boot-knative-graalvm.yaml" "generator-boot-knative-jib.yaml" "generator-boot-cloudfoundry.yaml" "generator-docker-compose.yaml" "generator-web-k8s.yaml" "generator-steeltoe-k8s-skaffold.yaml" "generator-steeltoe-azure-spring-cloud.yaml")
    accelerators_files=("accelerator-music-store-steeltoe.yaml" "accelerator-ebanking.yaml" "accelerator-todo-service.yaml" "accelerator-function-kafka.yaml" "accelerator-spring-jpa.yaml" "accelerator-ruby-simple.yaml" "accelerator-dotnet-aspnet-hello.yaml" "accelerator-boot-function-knative.yaml" "accelerator-frontend-ux-for-online-stores.yaml")
    
    for i in ${!generators_files[@]}; do
        acc generator create-from-file --file=acc/generic-examples/${generators_files[$i]}
    done

    for i in ${!accelerators_files[@]}; do
        acc accelerator create-from-file --file=acc/generic-examples/${accelerators_files[$i]}
    done
}

#add msft examples
add-msft-examples() {

    generators_files=("generator-aks-resource-simple.yaml" "generator-boot-aks-data.yaml" "generator-boot-asc.yaml" "generator-boot-function-azure.yaml" "generator-cloudfoundry.yaml" "generator-docker-compose.yaml" "generator-dotnet-web-azure.yaml" "generator-kubernetes-steeltoe-skaffold.yaml" "generator-none.yaml" "generator-steeltoe-asc.yaml")
    accelerators_files=("accelerator-music-store-steeltoe.yaml" "accelerator-todo-service-asc.yaml" "accelerator-spring-cosmosdb-jpa.yaml" "accelerator-dotnet-aspnet-hello.yaml" "accelerator-boot-function-azure.yaml" "accelerator-frontend-ux-for-online-stores.yaml")

    for i in ${!generators_files[@]}; do
        acc generator create-from-file --file=acc/msft-examples/${generators_files[$i]}
    done

    for i in ${!accelerators_files[@]}; do
        acc accelerator create-from-file --file=acc/msft-examples/${accelerators_files[$i]}
    done

}
case $1 in
generic)
    acc login -u admin -p admin
	add-generic-examples
    ;;
msft)
    acc login -u admin -p admin
    add-msft-examples
    ;;
*)
    echo "Incorrect usage. Please specific generic | msft"
    ;;
esac