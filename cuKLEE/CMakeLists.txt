cmake_minimum_required(VERSION 3.13)
project(cuKLEE)


find_package(LLVM CONFIG)

# includes headers from LLVM - update the include paths accordingly
include_directories(SYSTEM ${LLVM_INCLUDE_DIRS})
link_directories(${LLVM_LIBRARY_DIRS})
add_definitions(${LLVM_DEFINITIONS})


add_library(ReplaceDeviceStubCallsPass SHARED src/ReplaceDeviceStubCallsPass.cpp)
add_library(SignednessPropagationPass SHARED src/SignednessPropagationPass.cpp)

include_directories(${CMAKE_SOURCE_DIR}/include)
add_executable(cuKLEE src/main.cpp)

# Link the necessary LLVM libraries
llvm_map_components_to_libnames(llvm_libs
    support
    core
    irreader
)

target_link_libraries(cuKLEE ${llvm_libs})
