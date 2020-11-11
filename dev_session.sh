#!/usr/bin/bash

#Arguments: , 
    #target directory(Where to root the session)
    #session name
    #more stuff...?

#Rudimentary script to open a tmux session at the given directory, look for and open build & bin dirs in the given root
# in a separate window

if [ "$#" -lt 2 ]
then
    echo "Usage: dev_session.sh <root directory> <session name> ..."
    exit
fi

ROOTDIR=$1
SESSIONNAME=$2

if [ ! -d $ROOTDIR ]
then
    echo "$ROOTDIR not found! Type better...."
else
    cd $ROOTDIR
fi

tmux new-session -d -s $SESSIONNAME

#Rename first window to nvim
tmux rename-window -t 0 'neovim'
tmux send-keys 'nvim' C-m


#Create second window and move to build & bin directories

tmux select-window -t $SESSIONNAME:1

if [ -d $ROOTDIR/build ]
then
    tmux new-window -n 'build/test' -t 1 -c $ROOTDIR/build
fi

if [ -d $ROOTDIR/bin ]
then
    tmux split-window -v -t 0 -c $ROOTDIR/bin
else
    tmux split-window -v -t 0
fi

tmux select-window -t $SESSIONNAME:0
tmux attach-session -t $SESSIONNAME
