#!/bin/bash

APP_DIR="$HOME/remrob-app"

REPO_URL="https://github.com/unitartu-remrob/remrob-docker"
GIT_BRANCH="ros2/jazzy"

TARGET="jazzy"
BUILD_FLAGS=""

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --clone-dir <dir>  Directory to clone the repository to (default: \$HOME/remrob-app)"
    echo "  --target <target>  Target ROS distro (default: $TARGET)"
    echo "  --nvidia           Build with NVIDIA support"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --clone-dir) APP_DIR="$2"; shift ;;
        --target) TARGET="$2"; shift ;;
        --nvidia)
            BUILD_FLAGS="$BUILD_FLAGS --nvidia"
            ;;
        --help)
            usage ;;
        *)
            echo "Unknown option: $1"
            usage ;;
    esac
    shift
done

SERVICE_DIR="$APP_DIR/remrob-docker"

if [ -d $SERVICE_DIR ]; then
    echo "Repository remrob-docker at $APP_DIR already exists. Updating..."
    cd $SERVICE_DIR
    git pull
else
    echo "Cloning remrob-docker:$GIT_BRANCH repository..."
    git clone $REPO_URL -b $GIT_BRANCH $SERVICE_DIR
fi

echo "Building $TARGET image..."

cd $SERVICE_DIR
bash ./build.sh --target $TARGET $BUILD_FLAGS

