#!/usr/bin/env bash

xdg-open $(fd -E Documents/misery/Vivado -E Games | fuzzel --dmenu --prompt "[FILES]: " --width 100)
