FROM ubuntu:latest
LABEL authors="yago"

ENTRYPOINT ["top", "-b"]