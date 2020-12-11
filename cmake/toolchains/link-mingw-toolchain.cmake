
set(TOOLCHAIN_DIR ${SOS_SDK_PATH})

message(STATUS "Use GCC toolchain install dir: " ${TOOLCHAIN_DIR})
set(CMAKE_INSTALL_PREFIX ${TOOLCHAIN_DIR} CACHE INTERNAL "CLANG INSTALL PREFIX")
include_directories(SYSTEM ${TOOLCHAIN_DIR}/include)

set(SOS_SDK_IS_WINDOWS TRUE CACHE INTERNAL "WINDOWS BUILD")
set(CMAKE_C_FLAGS "-D__win32 -mno-ms-bitfields -D__processor_${CMAKE_HOST_SYSTEM_PROCESSOR}" CACHE INTERNAL "MINGW C FLAGS")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" CACHE INTERNAL "CLANG CXX FLAGS")
