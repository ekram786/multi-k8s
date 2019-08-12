docker build -t ekram786/multi-client:latest -t ekram786/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ekram786/multi-server:latest -t ekram786/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ekram786/multi-worker:latest -t ekram786/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ekram786/multi-client:latest
docker push ekram786/multi-server:latest
docker push ekram786/multi-worker:latest

docker push ekram786/multi-client:$SHA
docker push ekram786/multi-server:$SHA
docker push ekram786/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ekram786/multi-server:$SHA
kubectl set image deployments/client-deployment client=ekram786/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ekram786/multi-worker:$SHA