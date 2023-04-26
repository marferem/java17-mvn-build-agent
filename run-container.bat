docker run                          ^
    --name java17-mvn-build-agent   ^
    -itd                            ^
    -p "22:22"                      ^
    --network=devops-nw             ^
    java17-mvn-build-agent