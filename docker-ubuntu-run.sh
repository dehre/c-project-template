#!/bin/sh

docker run -ti -v "$PWD":/project ubuntu-cmake bash

#
# # to launch two or more sessions connected to the same container:
#
# docker exec -it <container-id> bash
#
