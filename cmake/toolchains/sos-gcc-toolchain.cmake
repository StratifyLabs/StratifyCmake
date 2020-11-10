

set(TOOLCHAIN_DIR ${SOS_SDK_PATH}/Tools/gcc)
set(TOOLCHAIN_HOST arm-none-eabi)

message(STATUS "GCC Toolchain is: " ${TOOLCHAIN_DIR}/${TOOLCHAIN_HOST})
set(TOOLCHAIN_BIN_DIR "${TOOLCHAIN_DIR}/bin" CACHE INTERNAL "GCC TOOLCHAIN BINARY DIR")
set(TOOLCHAIN_INC_DIR "${TOOLCHAIN_DIR}/${TOOLCHAIN_HOST}/include" CACHE INTERNAL "GCC TOOLCHAIN INCLUDE DIR")
set(TOOLCHAIN_LIB_DIR "${TOOLCHAIN_DIR}/${TOOLCHAIN_HOST}/lib" CACHE INTERNAL "GCC TOOLCHAIN LIBRARY DIR")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
if(TOOLCHAIN_HOST)
	set(TOOLCHAIN_HOST_PREFIX ${TOOLCHAIN_HOST}- CACHE INTERNAL "GCC ARM TOOLCHAIN PREFIX")
else()
	set(TOOLCHAIN_HOST_PREFIX "" CACHE INTERNAL "GCC TOOLCHAIN PREFIX")
endif()


set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_NO_SYSTEM_FROM_IMPORTED ON CACHE INTERNAL "GCC don't use isystem")
set(CMAKE_C_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}gcc${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN C COMPILER")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}g++${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN C++ COMPILER")
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}g++${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN ASM COMPILER")
set(CMAKE_AR ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}gcc-ar${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN AR")
set(CMAKE_RANLIB ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}gcc-ranlib${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN RANLIB")
set(CMAKE_NM ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}gcc-nm${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN NM")
set(CMAKE_OBJCOPY ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}objcopy${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN OBJCOPY")
set(CMAKE_OBJDUMP ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}objdump${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN OBJDUMP")
set(CMAKE_SIZE ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_HOST_PREFIX}size${TOOLCHAIN_EXEC_SUFFIX} CACHE INTERNAL "GCC TOOLCHAIN SIZE")
set(CMAKE_INSTALL_PREFIX ${TOOLCHAIN_DIR}/${TOOLCHAIN_HOST} CACHE INTERNAL "GCC TOOLCHAIN INSTALL PREFIX")

set(CMAKE_CXX_FLAGS "-fno-exceptions -fno-unwind-tables -fno-rtti" CACHE INTERNAL "CMAKE CXX FLAGS")
set(CMAKE_ASM_FLAGS "-mthumb" CACHE INTERNAL "CMAKE ASM FLAGS")

