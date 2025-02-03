#!/bin/bash

# Determine project type based on the first argument
if [ -z "$1" ] || [ "$1" = "--cpp" ]; then
    PROJECT_TYPE="cpp"
    PROJECT=${2:-Kookie}
    PROJECT_DIR=~/Documents/c++/$PROJECT
    BUILD_DIR=$PROJECT_DIR/build
elif [ "$1" = "--java" ]; then
    PROJECT_TYPE="java"
    PROJECT=${2:-JavaProject}
    PROJECT_DIR=~/Documents/java/$PROJECT
    BUILD_DIR=$PROJECT_DIR/build
elif [ "$1" = "--rust" ]; then
    PROJECT_TYPE="rust"
    PROJECT=${2:-rs}
    PROJECT_DIR=~/Documents/rs/$PROJECT
    BUILD_DIR=$PROJECT_DIR/target
else
    echo "Unsupported project type.\nSupported types are '--cpp' '--java' '--rust'."
    exit 1
fi

# Create the project directory if it doesn't exist
mkdir -p $PROJECT_DIR
mkdir -p $BUILD_DIR

# Check if the tmux session already exists
tmux has-session -t $PROJECT 2>/dev/null

if [ $? != 0 ]; then
    # Start tmux session
    tmux new-session -d -s $PROJECT

    # Create neovim window
    tmux rename-window -t $PROJECT:0 'Neovim'
    tmux send-keys -t $PROJECT:0 "cd $PROJECT_DIR" C-m
    tmux send-keys -t $PROJECT:0 'nvim' C-m

    # Create git window
    tmux new-window -t $PROJECT:1 -n 'Git'
    tmux send-keys -t $PROJECT:1 "cd $PROJECT_DIR" C-m

	# Create debugging/gdb window
    tmux new-window -t $PROJECT:2 -n 'Debugging'
    tmux send-keys -t $PROJECT:2 "cd $BUILD_DIR" C-m

fi

# Attach to the tmux session
tmux attach-session -t $PROJECT
