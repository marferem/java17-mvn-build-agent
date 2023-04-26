docker run                                                                                          ^
    -p 8888:8080                                                                                    ^
    -p 50000:50000                                                                                  ^
    --restart=on-failure                                                                            ^
    -v "C:\Users\emmanuel martinez\Documents\workshops\jenkins\jenkins-worskpace:/var/jenkins_home" ^
    --name jenkins                                                                                  ^
    --network=devops-nw                                                                             ^
    jenkins/jenkins:lts-jdk11
