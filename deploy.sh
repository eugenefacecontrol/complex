# $SHA is specified in the .travis.yml environment section
docker build -t yauhenisheima/multi-client:latest -t yauhenisheima/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yauhenisheima/multi-server:latest -t yauhenisheima/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yauhenisheima/multi-worker:latest -t yauhenisheima/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yauhenisheima/multi-client:latest
docker push yauhenisheima/multi-server:latest
docker push yauhenisheima/multi-worker:latest

docker push yauhenisheima/multi-client:$SHA
docker push yauhenisheima/multi-server:$SHA
docker push yauhenisheima/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=yauhenisheima/multi-client:$SHA
kubectl set image deployments/server-deployment server=yauhenisheima/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yauhenisheima/multi-worker:$SHA