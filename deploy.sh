docker build -t ryanl123/multi-client:latest -t ryanl123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ryanl123/multi-server:latest -t ryanl123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ryanl123/multi-worker:latest -t ryanl123/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ryanl123/multi-client:latest
docker push ryanl123/multi-server:latest
docker push ryanl123/multi-worker:latest

docker push ryanl123/multi-client:$SHA
docker push ryanl123/multi-server:$SHA
docker push ryanl123/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ryanl123/multi-server:$SHA
kubectl set image deployments/client-deployment client=ryanl123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ryanl123/multi-worker:$SHA