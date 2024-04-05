# Docker commands for RMQ or Redis

docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.13-management


docker run -d -p 5672:5672 rabbitmq
docker run -d -p 6379:6379 redis
