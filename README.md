docker build -t leanote:latest -f dockerfile_leanote .
docker rm -f -v leanote; docker run -it -d -p9000:9000  --name leanote leanote:latest
