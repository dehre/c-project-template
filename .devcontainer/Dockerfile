FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install build-essential -y
RUN apt-get install git -y
RUN apt-get install cmake -y
RUN apt-get install clang-tidy -y
RUN apt-get install valgrind strace ltrace -y
RUN apt-get install man -y
RUN yes | unminimize
