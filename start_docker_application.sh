#!/bin/bash
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ --name hsi_calib square_calib_hsi:latest
