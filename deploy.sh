docker build -t machinedatainsights/multi-client:latest -t machinedatainsights/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t machinedatainsights/multi-server:latest -t machinedatainsights/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t machinedatainsights/multi-worker:latest -t machinedatainsights/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push machinedatainsights/multi-client:latest
docker push machinedatainsights/multi-server:latest
docker push machinedatainsights/multi-worker:latest

docker push machinedatainsights/multi-client:$SHA
docker push machinedatainsights/multi-server:$SHA
docker push machinedatainsights/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=machinedatainsights/multi-server:$SHA
kubectl set image deployments/client-deployment client=machinedatainsights/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=machinedatainsights/multi-worker:$SHA 



