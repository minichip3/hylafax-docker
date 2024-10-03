A Docker Container with hylafax and t38modem

How to build (Using docker build)
1. Read the /pkgs/required-package.txt and get the correct .deb package
2. Save the package to /pkgs/
3. Build using ```docker build -t hylafax .```
4. Now run using this command:
```
docker run -d hylafax\
    --name hylafax --privileged \
    -v /path-of-config:/etc/hylafax \
    -e SIPADDR=example.com \
    -e SIPUSER=username \
    -e SIPPASS=password
```

How to build (Using docker-compose)
1. Read the /pkgs/required-package.txt and get the correct .deb package
2. Save the package to /pkgs/
3. Edit your sip setting to environment of docker-compose.yml
4. Now run ```docker-compose build```

How to use
1. Deploy the container with sip settings to environment and run it
2. Go to shell of the container using ```docker exec -it hylafax bash```
3. Run ```faxsetup```
4. Re-run the container
