# Create a build directory
cd build-android

#!/bin/bash

# Path to the Android NDK
ANDROID_NDK=D:/personal/machine-learning/android-ndk-r26b

# Minimum Android platform
ANDROID_PLATFORM=android-21

# Build types (e.g., Debug, Release)
BUILD_TYPE=Release

# List of ABIs to build for
declare -a ANDROID_ABIS=("x86_64" "x86" "arm64-v8a" "armeabi-v7a")

# Loop over each ABI and build
for ABI in "${ANDROID_ABIS[@]}"; do
    # Create a build directory for the ABI
    BUILD_DIR=build-android-$ABI
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR

    # Run CMake to configure the project for the ABI
    cmake -DANDROID_NDK=$ANDROID_NDK \
          -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
          -DANDROID_ABI=$ABI \
          -DANDROID_PLATFORM=$ANDROID_PLATFORM \
          -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
          -G "Ninja" \
          ../..

    # Build the project
    cmake --build .

    # Go back to the previous directory
    cd ..
done
