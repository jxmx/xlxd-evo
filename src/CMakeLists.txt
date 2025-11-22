cmake_minimum_required(VERSION 3.10)
project(xlxd LANGUAGES CXX)

#
# Configuration 
# 
# Each of these variables can be overriden using cmake invocation
# during build time such as 'cmake -DVERSION_MAJOR=3 -DVERSION_MINOR=0' etc.
#

set(VERSION_MAJOR "2" CACHE STRING "Set major version number")
set(VERSION_MINOR "5" CACHE STRING "Set minor version number")
set(VERSION_REVISION "3" CACHE STRING "Set revision version number")

option(ENABLE_DAEMON "Run as daemon" ON)
option(ENABLE_JSON "Enable JSON monitor" OFF)

set(NB_OF_MODULES "10" CACHE STRING "Set number of modules available 1 to 26")

set(DEXTRA_PORT "30001" CACHE STRING "UDP port for extra")
set(DEXTRA_KEEPALIVE_PERIOD "3" CACHE STRING "Keepalive period in seconds")
set(DEXTRA_KEEPALIVE_TIMEOUT "30" CACHE STRING "Keepalive timeout in seconds (keepalive * 10)")

set(DPLUS_PORT "20001" CACHE STRING "UDP port for DPlus")
set(DPLUS_KEEPALIVE_PERIOD "1" CACHE STRING "Keepalive period in seconds")
set(DPLUS_KEEPALIVE_TIMEOUT "10" CACHE STRING "Keepalive timeout in seconds (keepalive * 10)")

set(DCS_PORT "30051" CACHE STRING "UDP port for DCS")
set(DCS_KEEPALIVE_PERIOD "1" CACHE STRING "Keepalive period in seconds")
set(DCS_KEEPALIVE_TIMEOUT "30" CACHE STRING "Keepalive timeout in seconds (keepalive * 30)")

set(XLX_PORT "10002" CACHE STRING "UDP port for XLX")
set(XLX_KEEPALIVE_PERIOD "1" CACHE STRING "Keepalive period in seconds")
set(XLX_KEEPALIVE_TIMEOUT "30" CACHE STRING "Keepalive timeout in seconds (keepalive * 30)")
set(XLX_RECONNECT_PERIOD "5" CACHE STRING "Reconnect period in seconds")

set(DMRPLUS_PORT "8880" CACHE STRING "UDP port for DMRPlus")
set(DMRPLUS_KEEPALIVE_PERIOD "1" CACHE STRING "Keepalive period in seconds")
set(DMRPLUS_KEEPALIVE_TIMEOUT "10" CACHE STRING "Keepalive timeout in seconds (keepalive * 10)")
set(DMRPLUS_REFLECTOR_COLOUR "1" CACHE STRING "DMRPlus reflector colour (0–15)")

set(DMRMMDVM_PORT "62030" CACHE STRING "UDP port for DMRMMDVM")
set(DMRMMDVM_KEEPALIVE_PERIOD "10" CACHE STRING "Keepalive period in seconds")
set(DMRMMDVM_KEEPALIVE_TIMEOUT "100" CACHE STRING "Keepalive timeout in seconds (keepalive * 10)")
set(DMRMMDVM_REFLECTOR_COLOUR "1" CACHE STRING "DMRMMDVM reflector colour (0–15)")

set(YSF_PORT "42000" CACHE STRING "UDP port for YSF")
set(YSF_KEEPALIVE_PERIOD "3" CACHE STRING "Keepalive period in seconds")
set(YSF_KEEPALIVE_TIMEOUT "30" CACHE STRING "Keepalive timeout in seconds (keepalive * 10)")
set(YSF_DEFAULT_NODE_TX_FREQ "437000000" CACHE STRING "Default TX frequency in Hz")
set(YSF_DEFAULT_NODE_RX_FREQ "437000000" CACHE STRING "Default RX frequency in Hz")
set(YSF_AUTOLINK_ENABLE "0" CACHE STRING "Enable YSF auto-link (1=yes, 0=no)")
set(YSF_AUTOLINK_MODULE "A" CACHE STRING "YSF auto-link target module")

set(G3_PRESENCE_PORT "12346" CACHE STRING "UDP port for G3 presence service")
set(G3_CONFIG_PORT "12345" CACHE STRING "UDP port for G3 configuration")
set(G3_DV_PORT "40000" CACHE STRING "UDP port for G3 digital voice")
set(G3_KEEPALIVE_PERIOD "10" CACHE STRING "Keepalive period in seconds")
set(G3_KEEPALIVE_TIMEOUT "3600" CACHE STRING "Keepalive timeout in seconds")

set(IMRS_PORT "21110" CACHE STRING "UDP port for IMRS")
set(IMRS_KEEPALIVE_PERIOD "30" CACHE STRING "Keepalive period in seconds")
set(IMRS_KEEPALIVE_TIMEOUT "150" CACHE STRING "Keepalive timeout in seconds (keepalive * 5)")
set(IMRS_DEFAULT_MODULE "B" CACHE STRING "Default module to link in")

set(TRANSCODER_PORT "10100" CACHE STRING "UDP port for Transcoder")
set(TRANSCODER_KEEPALIVE_PERIOD "5" CACHE STRING "Keepalive period in seconds")
set(TRANSCODER_KEEPALIVE_TIMEOUT "30" CACHE STRING "Keepalive timeout in seconds")
set(TRANSCODER_AMBEPACKET_TIMEOUT "400" CACHE STRING "Timeout for AMBE packet in milliseconds")

set(DMRIDDB_USE_RLX_SERVER "1" CACHE STRING "Use RLX server for DMR ID DB (1=remote, 0=local file)")
set(DMRIDDB_PATH "/etc/xlxd/dmrid.dat" CACHE STRING "Path to local DMR ID database")
set(DMRIDDB_REFRESH_RATE "180" CACHE STRING "DMR ID DB refresh rate in minutes")

set(YSFNODEDB_USE_RLX_SERVER "1" CACHE STRING "Use RLX server for YSF Node DB (1=remote, 0=local file)")
set(YSFNODEDB_PATH "/etc/xlxd/ysfnode.dat" CACHE STRING "Path to local YSF node database")
set(YSFNODEDB_REFRESH_RATE "180" CACHE STRING "YSF node DB refresh rate in minutes")

set(LASTHEARD_USERS_MAX_SIZE "100" CACHE STRING "Size of LastHeard log file")
set(XML_UPDATE_PERIOD "10" CACHE STRING "Update period for XML output in seconds")
set(JSON_UPDATE_PERIOD "10" CACHE STRING "Update period for JSON output in seconds")
set(JSON_PORT "10001" CACHE STRING "Port for JSON service")

set(XML_PATH "/var/log/xlxd.xml" CACHE STRING "Output path for XML file")
set(WHITELIST_PATH "/etc/xlxd/xlxd.whitelist" CACHE STRING "Path to whitelist config")
set(BLACKLIST_PATH "/etc/xlxd/xlxd.blacklist" CACHE STRING "Path to blacklist config")
set(INTERLINKLIST_PATH "/etc/xlxd/xlxd.interlink" CACHE STRING "Path to interlink list")
set(TERMINALOPTIONS_PATH "/etc/xlxd/xlxd.terminal" CACHE STRING "Path to terminal options file")
set(DEBUGDUMP_PATH "/var/log/xlxd.debug" CACHE STRING "Path to debug output file")

configure_file(${CMAKE_SOURCE_DIR}/config.h.in ${CMAKE_BINARY_DIR}/config.h)
include_directories(${CMAKE_BINARY_DIR})

# Set compiler flags
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

# Gather all source files
file(GLOB SOURCES "*.cpp")

# Create executable from sources
add_executable(xlxd ${SOURCES})
target_compile_options(xlxd PRIVATE -pthread)

target_compile_definitions(xlxd PRIVATE
    $<$<BOOL:${ENABLE_DAEMON}>:RUN_AS_DAEMON>
    $<$<BOOL:${ENABLE_JSON}>:JSON_MONITOR>
)

install(TARGETS xlxd DESTINATION bin)

# Custom clean command
add_custom_target(clean-all
    COMMAND ${CMAKE_COMMAND} -E rm -f xlxd *.o
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)


