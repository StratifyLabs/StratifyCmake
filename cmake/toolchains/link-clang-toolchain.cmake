
include_directories(SYSTEM ${CMSDK_LOCAL_PATH}/include)

set(CMSDK_IS_MACOS TRUE CACHE INTERNAL "MACOS BUILD")
set(TOOLCHAIN_C_FLAGS "-D__macosx -D__processor_${CMAKE_HOST_SYSTEM_PROCESSOR}" CACHE INTERNAL "CLANG C FLAGS")
set(TOOLCHAIN_CXX_FLAGS "${TOOLCHAIN_C_FLAGS}" CACHE INTERNAL "CLANG CXX FLAGS")

set(CMAKE_INSTALL_PREFIX ${CMSDK_LOCAL_PATH} CACHE INTERNAL "CLANG TOOLCHAIN INSTALL PREFIX")
message(STATUS "Set Prefix to ${CMAKE_INSTALL_PREFIX}")

set(CMAKE_C_FLAGS "${TOOLCHAIN_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${TOOLCHAIN_CXX_FLAGS}")
message(STATUS "Use Clang flags ${CMAKE_CXX_FLAGS}")
message(STATUS "Use Install prefix ${CMAKE_INSTALL_PREFIX}")


set(CMAKE_C_COMPILER clang CACHE INTERNAL "CLANG TOOLCHAIN C COMPILER")
set(CMAKE_CXX_COMPILER clang++ CACHE INTERNAL "CLANG TOOLCHAIN C++ COMPILER")
