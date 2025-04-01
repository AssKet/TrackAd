Symfony + Docker + Kubernetes + GitLab CI/CD
Этот репозиторий содержит проект Symfony, который использует Docker для локальной разработки и развертывания в Kubernetes с использованием Helm. Мы также настроили автоматическую сборку и деплой через GitLab CI/CD.


Требования
Docker — для создания и запуска контейнеров.

Docker Compose — для упрощенного локального запуска.

Kubernetes — для развертывания в облачном или локальном кластере.

Helm — для управления Kubernetes приложениями.

GitLab — для CI/CD.

PHP 8.1 и Symfony — для работы с фреймворком.

MySQL — для базы данных (используется в локальной среде и Kubernetes).

Локальный запуск
Для локального запуска проекта с использованием Docker и Docker Compose следуйте инструкциям ниже.

Шаг 1: Склонировать репозиторий
Сначала склонировать репозиторий:

git clone https://github.com/your-repo/symfony-docker-k8s.git
cd symfony-docker-k8s

Шаг 2: Запуск с Docker Compose
Docker Compose позволяет легко запустить все необходимые сервисы (Symfony, MySQL и т.д.) локально.

Сначала создайте образ Symfony, используя Docker Compose:

bash
Копировать
Редактировать
docker-compose up --build
Это создаст и запустит два контейнера:

Symfony-приложение.

MySQL-базу данных.

Symfony будет доступен на порту 9000.

Шаг 3: Проверка работы
После того как контейнеры запустятся, вы сможете открыть приложение в браузере по следующему адресу:

arduino
Копировать
Редактировать
http://localhost:9000
Если все настроено правильно, вы увидите страницу вашего Symfony-приложения.

Настройка Kubernetes с Helm
Шаг 1: Установка Kubernetes и Helm
Для использования Kubernetes и Helm вам нужно установить их на своей машине.

Установка Kubernetes (можно использовать Minikube для локального Kubernetes):

bash
Копировать
Редактировать
brew install minikube
minikube start
Установка Helm:

bash
Копировать
Редактировать
brew install helm
Шаг 2: Установка и настройка Helm Chart
В корне проекта у вас есть Helm Chart, который включает все необходимые манифесты для развертывания Symfony в Kubernetes. Он находится в папке helm-chart.

Убедитесь, что в файле helm-chart/values.yaml правильно указаны параметры, такие как имя репозитория Docker-образа и тег.

yaml
Копировать
Редактировать
image:
  repository: my-symfony-app
  tag: latest
Шаг 3: Развертывание Symfony в Kubernetes
Настройте Kubernetes и Helm, используя ваш кластер Kubernetes.

Создайте Kubernetes namespace (если он еще не создан):

bash
Копировать
Редактировать
kubectl create namespace symfony
Установите или обновите приложение Symfony с помощью Helm:

bash
Копировать
Редактировать
helm upgrade --install symfony ./helm-chart --namespace symfony \
  --set image.repository=my-symfony-app \
  --set image.tag=latest
После развертывания вы можете проверить состояние развернутых ресурсов:

bash
Копировать
Редактировать
kubectl get pods -n symfony
kubectl get svc -n symfony