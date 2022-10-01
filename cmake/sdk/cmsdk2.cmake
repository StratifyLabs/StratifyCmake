function(cmsdk2_add_sources)
  set(OPTIONS "")
  set(PREFIX ARGS)
  set(ONE_VALUE_ARGS DIRECTORY LIST BINARY_DIRECTORY)
  set(MULTI_VALUE_ARGS DEPENDENCIES)
  cmake_parse_arguments(PARSE_ARGV 0 ${PREFIX} "${OPTIONS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}")

  set(REQUIRED_ARGS DIRECTORY LIST)
  foreach(VALUE ${REQUIRED_ARGS})
    if(NOT ARGS_${VALUE})
      message(FATAL_ERROR "cmsdk2_add_sources requires ${VALUE}")
    endif()
  endforeach()

  if(ARGS_BINARY_DIRECTORY)
    add_subdirectory(${ARGS_DIRECTORY} ${ARGS_BINARY_DIRECTORY})
  else()
    add_subdirectory(${ARGS_DIRECTORY})
  endif()

  #SOURCES comes from the CMakeLists.txt file in ${ARGS_DIRECTORY}
  list(TRANSFORM SOURCES PREPEND ${ARGS_DIRECTORY}/)
  list(APPEND ${ARGS_LIST} ${SOURCES})
  set(${ARGS_LIST} ${${ARGS_LIST}} PARENT_SCOPE)
endfunction()

function(cmsdk2_copy_target)
  set(OPTIONS "")
  set(PREFIX ARGS)
  set(ONE_VALUE_ARGS SOURCE)
  set(MULTI_VALUE_ARGS DESTINATION)
  cmake_parse_arguments(PARSE_ARGV 0 ${PREFIX} "${OPTIONS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}")
  if(NOT ARGS_DESTINATION)
    message(FATAL_ERROR "cmsdk2_copy_target requires DESTINATION")
  endif()
  if(NOT ARGS_SOURCE)
    message(FATAL_ERROR "cmsdk2_copy_target requires SOURCE")
  endif()

  foreach(DEST ${ARGS_DESTINATION})
    cmsdk_copy_target(${ARGS_SOURCE} ${DEST})
  endforeach()
endfunction()

function(cmsdk2_add_test)
  set(OPTIONS "")
  set(PREFIX ARGS)
  set(ONE_VALUE_ARGS TARGET)
  set(MULTI_VALUE_ARGS "")
  cmake_parse_arguments(PARSE_ARGV 0 ${PREFIX} "${OPTIONS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}")
  foreach(VALUE ${ONE_VALUE_ARGS})
    if(NOT ARGS_${VALUE})
      message(FATAL_ERROR "cmsdk2_add_test requires ${VALUE}")
    endif()
  endforeach()

  get_target_property(NAME ${ARGS_TARGET} CMSDK_PROPERTY_NAME)
  get_target_property(CONFIG ${ARGS_TARGET} CMSDK_PROPERTY_CONFIG)
  get_target_property(OPTION ${ARGS_TARGET} CMSDK_PROPERTY_OPTION)
  get_target_property(ARCH ${ARGS_TARGET} CMSDK_PROPERTY_ARCH)
  get_target_property(BUILD_FOLDER ${ARGS_TARGET} CMSDK_PROPERTY_BUILD_FOLDER)

  string(COMPARE EQUAL ${OPTION} "" OPTION_IS_EMPTY)

  if(OPTION)
    set(EXEC_NAME ${NAME}_${OPTION})
    set(DIR_NAME build_${OPTION})
  else()
    set(EXEC_NAME ${NAME})
    set(DIR_NAME build)
  endif()

  set(EXEC_NAME ${EXEC_NAME}_${CONFIG})
  set(TARGET_NAME ${EXEC_NAME}_${ARCH})

  get_target_property(TARGET_BINARY_DIR ${ARGS_TARGET} RUNTIME_OUTPUT_DIRECTORY)

  message(STATUS "add test -> ${TARGET_NAME}")

  add_test(NAME ${NAME}_${CONFIG}
    COMMAND "${TARGET_BINARY_DIR}/${TARGET_NAME}" --api
    )

  set_tests_properties(
    ${NAME}_${CONFIG}
    PROPERTIES
    PASS_REGULAR_EXPRESSION "___finalResultPass___"
  )
endfunction()


include(${CMAKE_CURRENT_LIST_DIR}/cmsdk2-app.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmsdk2-lib.cmake)
