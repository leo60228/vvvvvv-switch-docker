cmake_minimum_required(VERSION 3.18.0)
cmake_policy(VERSION 3.18.0)

# Options
set(CMAKE_TOOLCHAIN_FILE /opt/devkitpro/cmake/Switch.cmake)
include(${CMAKE_TOOLCHAIN_FILE})
project(VVVVVV-Switch)
option(MAKEANDPLAY "Disable the main game" OFF)
find_package(PkgConfig)
pkg_check_modules(SDL2 REQUIRED sdl2 SDL2_mixer)
set(SDL2_LIBRARIES ${SDL2_STATIC_LDFLAGS})
add_definitions(-D__unix__)

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
set_property(TARGET physfs-static PROPERTY C_STANDARD 99)

# Package
if(MAKEANDPLAY)
    set(APP_TITLE "VVVVVV: Make and Play Edition")
else()
    set(APP_TITLE "VVVVVV")
endif()
nx_generate_nacp(VVVVVV.nacp NAME ${APP_TITLE} AUTHOR "Terry Cavanagh" VERSION "2.3")
nx_create_nro(VVVVVV ICON "${CMAKE_CURRENT_SOURCE_DIR}/VVVVVV.jpg" NACP VVVVVV.nacp)
