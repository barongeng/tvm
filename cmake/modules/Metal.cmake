if(USE_METAL)
  message(STATUS "Build with Metal support")
  find_library(METAL_LIB Metal)
  find_library(FOUNDATION_LIB Foundation)
  file(GLOB RUNTIME_METAL_SRCS src/runtime/metal/*.mm)
  list(APPEND TVM_RUNTIME_LINKER_LIBS ${METAL_LIB} ${FOUNDATION_LIB})
  list(APPEND RUNTIME_SRCS ${RUNTIME_METAL_SRCS})
  list(APPEND COMPILER_SRCS src/codegen/opt/build_metal_on.cc)

  if(USE_MPS)
    file(GLOB MPS_CONTRIB_SRC src/contrib/mps/*.mm)
    list(APPEND RUNTIME_SRCS ${MPS_CONTRIB_SRC})
    find_library(MPS_CONTRIB_LIB MetalPerformanceShaders)
    list(APPEND TVM_RUNTIME_LINKER_LIBS ${MPS_CONTRIB_LIB})
  endif()
else(USE_METAL)
  list(APPEND COMPILER_SRCS src/codegen/opt/build_metal_off.cc)
endif(USE_METAL)
