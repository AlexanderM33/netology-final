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

![0007](https://github.com/AlexanderM33/netology-final/assets/122460278/fae65957-8aa0-4e21-bb45-0bc2be268dbe)

![0008](https://github.com/AlexanderM33/netology-final/assets/122460278/ad2275ec-2114-4381-bdad-4246ec64715c)

![009](https://github.com/AlexanderM33/netology-final/assets/122460278/c01d46d3-ec3c-4fab-a940-bb4f6326c821)

![00010](https://github.com/AlexanderM33/netology-final/assets/122460278/080af1b9-5a32-431b-b4b1-01614665e02b)

![00011](https://github.com/AlexanderM33/netology-final/assets/122460278/f27463c3-6922-4d4b-8a60-c9659f074b77)

![00012](https://github.com/AlexanderM33/netology-final/assets/122460278/8ded4504-9e73-42dc-b111-0cd054ae4cc7)

![00013](https://github.com/AlexanderM33/netology-final/assets/122460278/fc016f5a-5fd2-4844-afae-73a2ef2059ef)

![00014](https://github.com/AlexanderM33/netology-final/assets/122460278/bd5df285-77a2-46f3-b8cd-37e04fa33078)

![000015](https://github.com/AlexanderM33/netology-final/assets/122460278/909754b8-d1eb-4a8f-bd8f-f83339f76a0a)

![00016](https://github.com/AlexanderM33/netology-final/assets/122460278/d4ec91af-b268-4f7c-93f2-fee038efc097)

![00017](https://github.com/AlexanderM33/netology-final/assets/122460278/b3e2d896-b59c-407b-9088-55a33cfb3d0e)

![00018](https://github.com/AlexanderM33/netology-final/assets/122460278/8931e0a3-c44b-41d4-b11d-1fbcb58d96d0)

![000019](https://github.com/AlexanderM33/netology-final/assets/122460278/b64420f7-a040-4084-b01e-daa03b1734e4)





https://app.terraform.io/app/Alexander_M_MBZ/workspaces/stage




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

Нормальным путем при помощи скриптов kubespray установить не получилось из за блокировки DOCKER на территории РФ (30/05/2024)  - пришлось заменить 

Заменил ссылки на докер в манифестах kubespray docker.io --> huecker.io -  и все взлетело

Уже потом почитал, что можно было использовать и другие заркала:
dockerhub.timeweb.cloud
mirror.gcr.io 
cr.yandex/mirror

Получил работающий кластер, скриншоты прилагаю:

![9](https://github.com/AlexanderM33/netology-final/assets/122460278/fbd0c55e-91bc-4437-9833-5ebc62fcdd67)

![12](https://github.com/AlexanderM33/netology-final/assets/122460278/89dea242-7597-46bc-8970-a00a6f438feb)

![14](https://github.com/AlexanderM33/netology-final/assets/122460278/83989f1e-03e9-4793-aa86-aa5150d9c224)

![15](https://github.com/AlexanderM33/netology-final/assets/122460278/14b543b9-db3c-4c0d-9b91-62c5b97e772d)


![17](https://github.com/AlexanderM33/netology-final/assets/122460278/d66f2d12-310e-4e03-a7df-bef829207378)

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

---
## Что необходимо для сдачи задания?

1. Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.
2. Пример pull request с комментариями созданными atlantis'ом или снимки экрана из Terraform Cloud или вашего CI-CD-terraform pipeline.
3. Репозиторий с конфигурацией ansible, если был выбран способ создания Kubernetes кластера при помощи ansible.
4. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.
5. Репозиторий с конфигурацией Kubernetes кластера.
6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.
7. Все репозитории рекомендуется хранить на одном ресурсе (github, gitlab)

