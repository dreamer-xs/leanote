docker build -t leanote:latest -f dockerfile .
docker tag leanote:latest  registry.svicloud.com/tools/leanote:latest
docker-compose -f docker-compose.yml up

