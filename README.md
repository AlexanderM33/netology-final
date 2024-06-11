# netology-final-diplom

# Дипломный практикум в Yandex.Cloud
  * [Цели:](#цели)
  * [Этапы выполнения:](#этапы-выполнения)
     * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
     * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
     * [Создание тестового приложения](#создание-тестового-приложения)
     * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
     * [Установка и настройка CI/CD](#установка-и-настройка-cicd)
  * [Что необходимо для сдачи задания?](#что-необходимо-для-сдачи-задания)
  * [Как правильно задавать вопросы дипломному руководителю?](#как-правильно-задавать-вопросы-дипломному-руководителю)

**Перед началом работы над дипломным заданием изучите [Инструкция по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).**

---
## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.

---
## Этапы выполнения:

<details close>
<summary>Создание облачной инфраструктуры</summary>
<br>

Для начала необходимо подготовить облачную инфраструктуру в ЯО при помощи [Terraform](https://www.terraform.io/).

Особенности выполнения:

- Бюджет купона ограничен, что следует иметь в виду при проектировании инфраструктуры и использовании ресурсов;
Для облачного k8s используйте региональный мастер(неотказоустойчивый). Для self-hosted k8s минимизируйте ресурсы ВМ и долю ЦПУ. В обоих вариантах используйте прерываемые ВМ для worker nodes.
- Следует использовать версию [Terraform](https://www.terraform.io/) не старше 1.5.x .

Предварительная подготовка к установке и запуску Kubernetes кластера.

1. Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя
2. Подготовьте [backend](https://www.terraform.io/docs/language/settings/backends/index.html) для Terraform:  
   а. Рекомендуемый вариант: S3 bucket в созданном ЯО аккаунте(создание бакета через TF)
   б. Альтернативный вариант:  [Terraform Cloud](https://app.terraform.io/)  
3. Создайте VPC с подсетями в разных зонах доступности.
4. Убедитесь, что теперь вы можете выполнить команды `terraform destroy` и `terraform apply` без дополнительных ручных действий.
5. В случае использования [Terraform Cloud](https://app.terraform.io/) в качестве [backend](https://www.terraform.io/docs/language/settings/backends/index.html) убедитесь, что применение изменений успешно проходит, используя web-интерфейс Terraform cloud.

</details>

Ожидаемые результаты:

1. Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий.
2. Полученная конфигурация инфраструктуры является предварительной, поэтому в ходе дальнейшего выполнения задания возможны изменения.

   



### РЕШЕНИЕ:

Для выполнения я использовал чистую ВМ в VirtualBox Ubuntu 22.04.
Установил необходимые пакеты, подготовил манифесты Terraform

https://github.com/AlexanderM33/netology-final/tree/main/tf

Залогинился в Terraform Cloud по созданному токену для того, чтобы сохранялись изменения конфигурации.
В манифестах предполагается использование окружений stage и prod.
Ход выполнения задания и скриншоты из Terraform Cloud прилагаю ниже:


![0002](https://github.com/AlexanderM33/netology-final/assets/122460278/371879a7-e714-4298-b531-0d214dee2729)

![0003](https://github.com/AlexanderM33/netology-final/assets/122460278/cc549a97-2de8-433c-9405-123b5d2ac796)

![0004](https://github.com/AlexanderM33/netology-final/assets/122460278/e1c83d07-fd70-4ff2-b9ac-5b0f9132f697)

![0005](https://github.com/AlexanderM33/netology-final/assets/122460278/ced24631-be7f-4c68-b9ae-be5fb96b06ae)

![0006](https://github.com/AlexanderM33/netology-final/assets/122460278/df19b6db-3f65-46a3-8afa-fb89af1413f9)

![00010](https://github.com/AlexanderM33/netology-final/assets/122460278/080af1b9-5a32-431b-b4b1-01614665e02b)

![00011](https://github.com/AlexanderM33/netology-final/assets/122460278/f27463c3-6922-4d4b-8a60-c9659f074b77)

![00012](https://github.com/AlexanderM33/netology-final/assets/122460278/8ded4504-9e73-42dc-b111-0cd054ae4cc7)

![00013](https://github.com/AlexanderM33/netology-final/assets/122460278/fc016f5a-5fd2-4844-afae-73a2ef2059ef)

![00014](https://github.com/AlexanderM33/netology-final/assets/122460278/bd5df285-77a2-46f3-b8cd-37e04fa33078)

![000015](https://github.com/AlexanderM33/netology-final/assets/122460278/909754b8-d1eb-4a8f-bd8f-f83339f76a0a)

![00016](https://github.com/AlexanderM33/netology-final/assets/122460278/d4ec91af-b268-4f7c-93f2-fee038efc097)

![000019](https://github.com/AlexanderM33/netology-final/assets/122460278/b64420f7-a040-4084-b01e-daa03b1734e4)

![pt1](https://github.com/AlexanderM33/netology-final/assets/122460278/cac4623e-fad2-431e-aff6-0d238597d58a)

![pt2](https://github.com/AlexanderM33/netology-final/assets/122460278/1d9e51ac-bc44-49af-8628-5de8b4a099c5)

![pt3](https://github.com/AlexanderM33/netology-final/assets/122460278/694e2c50-f72a-405d-bcc7-b066244af5fd)



Здесь я проиллюстрировал изменение количества рабочих нод, применение команд `terraform destroy` и `terraform apply` происходит так, как и задумывалось - история изменений сохраняется, логи пишутся

https://app.terraform.io/app/Alexander_M_MBZ/workspaces/stage

В итоге остановился на конфигурации из одной мастер ноды и двух worker нодах



---
<details close>
<summary>Создание Kubernetes кластера</summary>
<br>


На этом этапе необходимо создать [Kubernetes](https://kubernetes.io/ru/docs/concepts/overview/what-is-kubernetes/) кластер на базе предварительно созданной инфраструктуры.   Требуется обеспечить доступ к ресурсам из Интернета.

Это можно сделать двумя способами:

1. Рекомендуемый вариант: самостоятельная установка Kubernetes кластера.  
   а. При помощи Terraform подготовить как минимум 3 виртуальных машины Compute Cloud для создания Kubernetes-кластера. Тип виртуальной машины следует выбрать самостоятельно с учётом требовании к производительности и стоимости. Если в дальнейшем поймете, что необходимо сменить тип инстанса, используйте Terraform для внесения изменений.  
   б. Подготовить [ansible](https://www.ansible.com/) конфигурации, можно воспользоваться, например [Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)  
   в. Задеплоить Kubernetes на подготовленные ранее инстансы, в случае нехватки каких-либо ресурсов вы всегда можете создать их при помощи Terraform.
2. Альтернативный вариант: воспользуйтесь сервисом [Yandex Managed Service for Kubernetes](https://cloud.yandex.ru/services/managed-kubernetes)  
  а. С помощью terraform resource для [kubernetes](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster) создать **региональный** мастер kubernetes с размещением нод в разных 3 подсетях      
  б. С помощью terraform resource для [kubernetes node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group)
  
</details>

Ожидаемый результат:

1. Работоспособный Kubernetes кластер.
2. В файле `~/.kube/config` находятся данные для доступа к кластеру.
3. Команда `kubectl get pods --all-namespaces` отрабатывает без ошибок.


### РЕШЕНИЕ:

Склонировал репозиторий kubespray
Установил необходимые зависимости
```
pip install -r requirements.txt
```
Примечание - обычным путем при помощи скриптов kubespray установить кластер сразу не получилось из за блокировки DOCKER на территории РФ (этот пункт задания я выполнял 30/05/2024) - пришлось заменить ссылки на докер в манифестах kubespray docker.io --> huecker.io -  и все взлетело
Уже потом почитал, что можно было использовать и другие зеркала:
```
dockerhub.timeweb.cloud
mirror.gcr.io 
cr.yandex/mirror
```
C 03 июня 2024 докер уже вернулся к обычнной работе, но опыт установки был интересный

Получил работающий кластер, скриншоты прилагаю:

![9](https://github.com/AlexanderM33/netology-final/assets/122460278/1b76a651-d416-4a81-a67e-fbd4385c5608)

![12](https://github.com/AlexanderM33/netology-final/assets/122460278/146978a8-3cd1-46d4-a534-a14b3687d815)

![14](https://github.com/AlexanderM33/netology-final/assets/122460278/dca6db1e-ed70-49f3-bea1-1b92721521b3)

![15](https://github.com/AlexanderM33/netology-final/assets/122460278/141088f3-3ca7-4d71-9991-abc9cf24bbe7)

![17](https://github.com/AlexanderM33/netology-final/assets/122460278/20026ddf-0b34-4aca-8ded-5b77cbc954cb)

Файлы:
Так как для экономии я во время выполнения останавливал кластер - IP адреса нод на скриншотах и в hosts разные
<details close>
<summary>hosts.yaml</summary>
<br>
 
 ```
 all:
  hosts:
    node1:
      ansible_host: 158.160.112.112
      ip: 10.10.1.6
      ansible_user: ubuntu
      kubeconfig_localhost: true
    node2:
      ansible_host: 158.160.61.190
      ip: 10.10.1.28
      ansible_user: ubuntu
    node3:
      ansible_host: 84.201.179.150
      ip: 10.10.2.33
      ansible_user: ubuntu
  children:
    kube_control_plane:
      hosts:
        node1:
    kube_node:
      hosts:
        node2:
        node3:
    etcd:
      hosts:
        node1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
 ```
 </details>    

---
<details close>
<summary>Создание тестового приложения</summary>
<br>


Для перехода к следующему этапу необходимо подготовить тестовое приложение, эмулирующее основное приложение разрабатываемое вашей компанией.

Способ подготовки:

1. Рекомендуемый вариант:  
   а. Создайте отдельный git репозиторий с простым nginx конфигом, который будет отдавать статические данные.  
   б. Подготовьте Dockerfile для создания образа приложения.  
2. Альтернативный вариант:  
   а. Используйте любой другой код, главное, чтобы был самостоятельно создан Dockerfile.

</details>
Ожидаемый результат:

1. Git репозиторий с тестовым приложением и Dockerfile.
2. Регистри с собранным docker image. В качестве регистри может быть DockerHub или [Yandex Container Registry](https://cloud.yandex.ru/services/container-registry), созданный также с помощью terraform.

Я подготовил Dockerfile 
```
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
```
Он берет станлдартный образ nginx и меняет стартовую страницу на мой файл index.html

<details close>
<summary>index.html</summary>
<br>
<!DOCTYPE html>
<HTML>

    <HEAD>
    
    <TITLE>NETOLOGY DIPLOM</TITLE>
    
    </HEAD>
    
    <BODY BGCOLOR="FFFFFF">
    
    
    <HR>
    
    <a href="https://github.com/AlexanderM33/netology-final">MY DIPLOM FILES</a>
    
    this is a link to my repository

    <H1>DevOps Sample Project</H1>
    
    <H2>v 0.0.1</H2>
    
    
    <HR>
    
    </BODY>
    
    </HTML>
</details>

Итоговый образ для теста я выложил в DockerHub
```
докерхаб логин: "alexanderm33"
пароль:    "4netology!mishin"
```

Ссылка на репозиторий:

https://hub.docker.com/repository/docker/alexanderm33/app-netology/general

Скриншоты:

![23](https://github.com/AlexanderM33/netology-final/assets/122460278/cde3834b-dd9b-4dba-9124-ac111d8fc014)

![24](https://github.com/AlexanderM33/netology-final/assets/122460278/59bf9a96-326c-4a06-980f-138f54221825)

![1212](https://github.com/AlexanderM33/netology-final/assets/122460278/80a686e3-147c-468a-981a-684686b1c13c)


---
<details close>
<summary>Подготовка cистемы мониторинга и деплой приложения</summary>
<br>


Уже должны быть готовы конфигурации для автоматического создания облачной инфраструктуры и поднятия Kubernetes кластера.  
Теперь необходимо подготовить конфигурационные файлы для настройки нашего Kubernetes кластера.

Цель:
1. Задеплоить в кластер [prometheus](https://prometheus.io/), [grafana](https://grafana.com/), [alertmanager](https://github.com/prometheus/alertmanager), [экспортер](https://github.com/prometheus/node_exporter) основных метрик Kubernetes.
2. Задеплоить тестовое приложение, например, [nginx](https://www.nginx.com/) сервер отдающий статическую страницу.

Способ выполнения:
1. Воспользовать пакетом [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus), который уже включает в себя [Kubernetes оператор](https://operatorhub.io/) для [grafana](https://grafana.com/), [prometheus](https://prometheus.io/), [alertmanager](https://github.com/prometheus/alertmanager) и [node_exporter](https://github.com/prometheus/node_exporter). При желании можете собрать все эти приложения отдельно.
2. Для организации конфигурации использовать [qbec](https://qbec.io/), основанный на [jsonnet](https://jsonnet.org/). Обратите внимание на имеющиеся функции для интеграции helm конфигов и [helm charts](https://helm.sh/)
3. Если на первом этапе вы не воспользовались [Terraform Cloud](https://app.terraform.io/), то задеплойте и настройте в кластере [atlantis](https://www.runatlantis.io/) для отслеживания изменений инфраструктуры. Альтернативный вариант 3 задания: вместо Terraform Cloud или atlantis настройте на автоматический запуск и применение конфигурации terraform из вашего git-репозитория в выбранной вами CI-CD системе при любом комите в main ветку. Предоставьте скриншоты работы пайплайна из CI/CD системы.
</details>

Ожидаемый результат:
1. Git репозиторий с конфигурационными файлами для настройки Kubernetes.
2. Http доступ к web интерфейсу grafana.
3. Дашборды в grafana отображающие состояние Kubernetes кластера.
4. Http доступ к тестовому приложению.


ВЫПОЛНЕНИЕ:
Воспользовался предложенным способом и установил все при помощи [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus)

Для просмотра веб интерфейса Grafana применил следующий манифест - он создает сервис типа NodePort на 32000порту через который смотрим в Grafana

```
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: grafana
  name: grafana-nodeport
  namespace: monitoring
spec:
  type: NodePort
  ports:
  - protocol: TCP
    port: 3000
    targetPort: 3000
    nodePort: 32000
  selector:
    app.kubernetes.io/name: grafana

```
https://github.com/AlexanderM33/netology-final/blob/main/grafana/grafana-service.yaml

Скриншоты веб интерфейса с графиками моего кластера:

![40](https://github.com/AlexanderM33/netology-final/assets/122460278/406476c0-5524-432b-8f7a-88c97f3628c5)

![41](https://github.com/AlexanderM33/netology-final/assets/122460278/fb9fff15-17c0-4446-8bf7-4fa43b61c46e)

![43](https://github.com/AlexanderM33/netology-final/assets/122460278/7cb095ef-d76d-4243-b9d9-365e2bfaf024)

![44](https://github.com/AlexanderM33/netology-final/assets/122460278/0afa795f-8ebf-4112-b0f6-8cf9f42a0f50)

![45](https://github.com/AlexanderM33/netology-final/assets/122460278/23a52191-830c-4bd8-a745-f37e18d2e84b)

![46](https://github.com/AlexanderM33/netology-final/assets/122460278/5f8926a8-cda8-4147-861d-d886a2f5055d)



Приложение разворачивается из моего репозитория в Dockerhub на кластере при помощи манифеста, который разворачивает приложение и вешает его на 30080 порту:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    name: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      name: nginx
  template:
    metadata:
      labels:
        name: nginx
    spec:
      containers:
      - name: nginx
        image: alexanderm33/app-netology:latest
        ports:
        - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    name: nginx
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
    name: http
  selector:
    name: nginx
```

Прикладываю скриншоты:

![47](https://github.com/AlexanderM33/netology-final/assets/122460278/5436d325-4e57-4914-815e-508be770b4e1)

![48](https://github.com/AlexanderM33/netology-final/assets/122460278/7f197a6f-c89e-4f72-ac20-572ada02b7e2)

![49](https://github.com/AlexanderM33/netology-final/assets/122460278/ec61c776-7373-41a2-a3e2-e7fded6884fc)

![51](https://github.com/AlexanderM33/netology-final/assets/122460278/bdcc5e54-3979-4b15-b0ff-b498262c1f40)

![53](https://github.com/AlexanderM33/netology-final/assets/122460278/1645469a-90fc-423b-8712-1e5c1e742005)


### КЛАСТЕР ПОКА РАБОТАЕТ на время проверки диплома

**Grafana**
**http://158.160.104.161:32000/login**
```
логин admin
пароль netology
```

Тестовое приложение:
**http://158.160.104.161:30080/**

---
<details close>
<summary>Установка и настройка CI/CD</summary>
<br>


Осталось настроить ci/cd систему для автоматической сборки docker image и деплоя приложения при изменении кода.

Цель:

1. Автоматическая сборка docker образа при коммите в репозиторий с тестовым приложением.
2. Автоматический деплой нового docker образа.

Можно использовать [teamcity](https://www.jetbrains.com/ru-ru/teamcity/), [jenkins](https://www.jenkins.io/), [GitLab CI](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/) или GitHub Actions.
</details>

Ожидаемый результат:

1. Интерфейс ci/cd сервиса доступен по http.
2. При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа.
3. При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистри, а также деплой соответствующего Docker образа в кластер Kubernetes.

Систему для непрерывной сборки и автоматического развертывания я отганизовал на Gitlab
Для этого перенес папки проекта в репозиторий Gitlab 
https://gitlab.com/devops-netology-homework/netology/
Убрал из кластера ручной тестовый деплоймент моего приложения из предыдущего этапа

Для организации пайплайна подготовил следующий ci-cd файл

```
stages:
- build
- deploy

variables:
  IMAGE_TAG: $CI_COMMIT_SHORT_SHA
  K8S_NAMESPACE: default
  K8S_DEPLOYMENT_NAME: app-deployment
  K8S_SERVICE_NAME: app-service

build:
  stage: build
  image:
    name: gcr.io/kaniko-project/executor:v1.9.0-debug
    entrypoint: [""]
  script:
  - /kaniko/executor --context "${CI_PROJECT_DIR}/app" --dockerfile "${CI_PROJECT_DIR}/app/Dockerfile" --destination "${CI_REGISTRY_IMAGE}:${IMAGE_TAG}"
  only:
  - main

deploy:
  image:
    name: bitnami/kubectl:latest
    entrypoint: ['']
  stage: deploy
  script:
  - kubectl config get-contexts
  - kubectl config use-context devops-netology-homework/netology:gitlab-agent
  - |
    kubectl apply -f - <<EOF
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: $K8S_DEPLOYMENT_NAME
      namespace: $K8S_NAMESPACE
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: $K8S_DEPLOYMENT_NAME
      template:
        metadata:
          labels:
            app: $K8S_DEPLOYMENT_NAME
        spec:
          containers:
            - name: $K8S_DEPLOYMENT_NAME
              image: $CI_REGISTRY_IMAGE:$IMAGE_TAG
              ports:
                - containerPort: 80
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: $K8S_SERVICE_NAME
      namespace: $K8S_NAMESPACE
    spec:
      selector:
        app: $K8S_DEPLOYMENT_NAME
      ports:
        - name: http
          protocol: TCP
          port: 80
          targetPort: 80
          nodePort: 30080
      type: NodePort
    EOF
  environment:
    name: production
  only:
  - mai

```

Скриншоты прилагаю:

![94](https://github.com/AlexanderM33/netology-final/assets/122460278/1fcbb798-6017-4892-8c36-e69fe5b9e6da)

![95](https://github.com/AlexanderM33/netology-final/assets/122460278/e59d83c4-d6f4-40ac-a3ba-63b70166291e)

![96](https://github.com/AlexanderM33/netology-final/assets/122460278/289ec477-cf33-4c1f-ae9e-223a027bf5f8)

![97](https://github.com/AlexanderM33/netology-final/assets/122460278/90580384-990b-49af-a126-ab67bf91a338)

![98](https://github.com/AlexanderM33/netology-final/assets/122460278/97b7d9be-609a-4b4e-b175-f8c5ce35e4d0)

![101](https://github.com/AlexanderM33/netology-final/assets/122460278/c1e4d32d-4e31-46d3-a3a7-2c2286fb2447)


Иллюстрирую, что происходит автодеплоймент при изменении версии приложения:

![111](https://github.com/AlexanderM33/netology-final/assets/122460278/eafdaec2-8179-49b8-bfaa-ffc6872e02d7)

![112](https://github.com/AlexanderM33/netology-final/assets/122460278/45e8d7b4-fd4c-43f8-9a16-a20f7add864a)

![113](https://github.com/AlexanderM33/netology-final/assets/122460278/25841aac-f82c-4c9f-be92-950a56d235f2)

![114](https://github.com/AlexanderM33/netology-final/assets/122460278/4b72f3cb-07f9-4ed7-96d3-b1da711c056a)

![115](https://github.com/AlexanderM33/netology-final/assets/122460278/3ee80f21-99ce-4bcb-bac0-cb6239a273bf)

![116](https://github.com/AlexanderM33/netology-final/assets/122460278/e7ac70f5-b6a9-4f5d-9157-d696ccab113b)

![117](https://github.com/AlexanderM33/netology-final/assets/122460278/a753cc07-d5fa-400b-a1f2-9d08cfd64dac)

![118](https://github.com/AlexanderM33/netology-final/assets/122460278/08f4520c-6d1b-407b-84df-dbf6293577b6)

![119](https://github.com/AlexanderM33/netology-final/assets/122460278/7ef77730-02a5-43bb-a03e-90c3c9339efa)

![120](https://github.com/AlexanderM33/netology-final/assets/122460278/459965c0-9464-4413-b77f-7c836c10744c)

![121](https://github.com/AlexanderM33/netology-final/assets/122460278/4b63e872-8e40-4e1d-8265-14aa7b75686f)

![122](https://github.com/AlexanderM33/netology-final/assets/122460278/c879637d-e297-443f-8d2d-62ee23f69213)

![123](https://github.com/AlexanderM33/netology-final/assets/122460278/675f9f86-2369-42f1-a61c-13433910c6aa)

![125](https://github.com/AlexanderM33/netology-final/assets/122460278/556c5f5d-09ec-4651-9522-5b3b7afdfec6)

![126](https://github.com/AlexanderM33/netology-final/assets/122460278/9826da45-8ab1-47b4-a16b-898c7b11f3d0)

![127](https://github.com/AlexanderM33/netology-final/assets/122460278/6bbe64e3-ec12-42de-aff3-c909c66564dd)

![128](https://github.com/AlexanderM33/netology-final/assets/122460278/9288780b-0032-4f92-8021-7ca6b747f313)

![129](https://github.com/AlexanderM33/netology-final/assets/122460278/b339963a-2494-4daa-ab89-4ddcba5f61da)





---
## Что необходимо для сдачи задания?

1. Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.
2. Пример pull request с комментариями созданными atlantis'ом или снимки экрана из Terraform Cloud или вашего CI-CD-terraform pipeline.
3. Репозиторий с конфигурацией ansible, если был выбран способ создания Kubernetes кластера при помощи ansible.
4. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.
5. Репозиторий с конфигурацией Kubernetes кластера.
6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.
7. Все репозитории рекомендуется хранить на одном ресурсе (github, gitlab)

