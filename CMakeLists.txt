cmake_minimum_required(VERSION 3.18.0)

# Options
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/switch-cmake/DevkitA64Libnx.cmake)
include(${CMAKE_TOOLCHAIN_FILE})
project(VVVVVV-Switch)
set(SDL2_INCLUDE_DIRS ${PORTLIBS}/include ${PORTLIBS}/include/SDL2)
set(SDL2_LIBRARIES ${PORTLIBS}/lib/libSDL2.a ${PORTLIBS}/lib/libSDL2_mixer.a)

# Build
add_subdirectory(VVVVVV/desktop_version)

# Package
