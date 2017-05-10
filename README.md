docker build -t leanote:latest -f dockerfile_leanote .
docker rm -f -v leanote; docker run -it -d -p9000:9000  --name leanote -v /opt/svicloud/tools/leanote/conf:/usr/local/bin/leanote/conf /opt/svicloud/tools/leanote/mongo_data:/usr/local/bin/mongodb-linux-x86_64-3.0.1/data leanote:latest
