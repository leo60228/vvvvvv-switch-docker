cmake_minimum_required(VERSION 3.18.0)
cmake_policy(VERSION 3.18.0)

# Options
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/switch-cmake/DevkitA64Libnx.cmake)
include(${CMAKE_TOOLCHAIN_FILE})
project(VVVVVV-Switch)
option(MAKEANDPLAY "Disable the main game" OFF)
find_package(PkgConfig)
pkg_check_modules(SDL2 REQUIRED sdl2 SDL2_mixer)
set(SDL2_LIBRARIES ${SDL2_STATIC_LDFLAGS})
set(ENABLE_SAVE_MIGRATION OFF)
add_definitions(-D__unix__)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/switch-cmake/cmake)

# Build
add_subdirectory(VVVVVV/desktop_version)

# Target options
if(MAKEANDPLAY)
    target_compile_definitions(VVVVVV PRIVATE -DMAKEANDPLAY=1)
endif()

# PhysFS
set_property(TARGET physfs-static PROPERTY SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_byteorder.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_unicode.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_platform_posix.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_platform_unix.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_platform_windows.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_platform_os2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_platform_qnx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_dir.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_unpacked.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_grp.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_hog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_7z.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_mvl.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_qpak.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_wad.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_zip.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_slb.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_iso9660.c
    ${CMAKE_CURRENT_SOURCE_DIR}/physfs-switch/src/physfs_archiver_vdf.c
)
find_package(Libnx)
target_link_libraries(physfs-static switch::libnx)

# Package
include(SwitchTools)
set_target_properties(VVVVVV PROPERTIES
    APP_TITLE "VVVVVV"
    APP_AUTHOR "Terry Cavanagh"
    APP_VERSION "2.3"
    ICON "${CMAKE_CURRENT_SOURCE_DIR}/VVVVVV.jpg")
if(MAKEANDPLAY)
    set_property(TARGET VVVVVV PROPERTY APP_TITLE "VVVVVV: Make and Play Edition")
endif()
add_nro_target(VVVVVV)
