cmake_minimum_required(VERSION 3.10)
project(ambed LANGUAGES CXX)

#
# Configuration 
# 
# Each of these variables can be overriden using cmake invocation
# during build time such as 'cmake -DVERSION_MAJOR=3 -DVERSION_MINOR=0' etc.
#

set(VERSION_MAJOR "1" CACHE STRING "Set major version number")
set(VERSION_MINOR "3" CACHE STRING "Set minor version number")
set(VERSION_REVISION "5" CACHE STRING "Set revision version number")

option(ENABLE_DAEMON "Run as daemon" OFF)
set(NB_MAX_STREAMS "99" CACHE STRING "Max number of streams")
set(TRANSCODER_PORT "10100" CACHE STRING "UDP port for transcoder")
set(CODECGAIN_AMBEPLUS "-10" CACHE STRING "AMBE+ gain in dB")
set(CODECGAIN_AMBE2PLUS "-10" CACHE STRING "AMBE2+ gain in dB")
set(USE_AGC "0" CACHE STRING "Use AGC")
set(AGC_CLAMPING "3" CACHE STRING "clamps the AGC gain to +- this value")
set(USE_BANDPASSFILTER "1" CACHE STRING "Use BANDPASSFILTER")
set(STREAM_ACTIVITY_TIMEOUT "3" CACHE STRING "in seconds")


configure_file(${CMAKE_SOURCE_DIR}/config.h.in ${CMAKE_BINARY_DIR}/config.h)
include_directories(${CMAKE_BINARY_DIR})

# Set compiler flags
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

# Gather all source files
file(GLOB SOURCES "*.cpp")

# Create executable from sources
add_executable(ambed ${SOURCES})
target_compile_options(ambed PRIVATE -pthread)

target_compile_definitions(ambed PRIVATE
    $<$<BOOL:${ENABLE_DAEMON}>:RUN_AS_DAEMON>
)

install(TARGETS ambed DESTINATION bin)

# Custom clean command
add_custom_target(clean-all
    COMMAND ${CMAKE_COMMAND} -E rm -f ambed *.o
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)


