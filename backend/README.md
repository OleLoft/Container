# Building as an image
Either use the Spring Boot-provided `mvnw` or your locally installed Maven `mvn` to run the `build-image` goal. In this description we use `mvn`.
E.g.:
```
sudo mvn spring-boot:build-image -Dspring-boot.build-image.imageName=poc/backend
```

# Running image with Docker
To get a container running on port 8082 run the following:
```
sudo docker run -e SERVER_PORT=8082 -p 8082:8082 -t poc/backend
```

# Run on local K8s
To make the backend-app run on your local K8s (e.g. minikube)
run the following:
```
kubectl apply -f k8s
```

# Run on local K8s
To make the frontend/BFF setup on your local K8s (e.g. minikube)
run the following:
```
kubectl apply -f k8s
```
This will make a frontend and a BFF deployment along with matching
services. The BFF deployment expects a backend service to be in place
that it can send requests to, so make sure not to forget that.

# To run setup in docker
First build the image of the backend.
```
sudo mvn spring-boot:build-image -Dspring-boot.build-image.imageName=poc-image-backend
```
This will build the image.

Next, find the frontend project and follow the instructions here.
