//
//  main.h
//  xlxd
//
//  Created by Jean-Luc Deltombe (LX3JL) on 31/10/2015.
//  Copyright © 2015 Jean-Luc Deltombe (LX3JL). All rights reserved.
//
// ----------------------------------------------------------------------------
//    This file is part of xlxd.
//
//    xlxd is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    xlxd is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
// ----------------------------------------------------------------------------

#ifndef main_h
#define main_h

#include <vector>
#include <array>
#include <map>
#include <queue>
#include <chrono>
#include <thread>
#include <mutex>
#include <atomic>
#include <condition_variable>
#include <ctime>
#include <cctype>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <algorithm>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include "config.h"

////////////////////////////////////////////////////////////////////////////////////////
// defines
//
// NOTE: ALL CONFIGURATION HAS BEEN MOVED TO CMAKE. THERE SHOULD BE NO REASON
// IN GENERAL TO MODIFY THIS FILE UNLESS YOU ARE DEVELOPING THE CODEBASE
//

// debug -------------------------------------------------------
//#define DEBUG_NO_ERROR_ON_XML_OPEN_FAIL
//#define DEBUG_DUMPFILE
//#define DEBUG_NO_G3_ICMP_SOCKET


// protocols ---------------------------------------------------
#define NB_OF_PROTOCOLS                 9

#define PROTOCOL_ANY                    -1
#define PROTOCOL_NONE                   0
#define PROTOCOL_DEXTRA                 1
#define PROTOCOL_DPLUS                  2
#define PROTOCOL_DCS                    3
#define PROTOCOL_XLX                    4
#define PROTOCOL_DMRPLUS                5
#define PROTOCOL_DMRMMDVM               6
#define PROTOCOL_YSF                    7
#define PROTOCOL_G3                     8
#define PROTOCOL_IMRS                   9

// DMR slots ----------------------------------------------------
#define DMRPLUS_REFLECTOR_SLOT          DMR_SLOT2
#define DMRMMDVM_REFLECTOR_SLOT         DMR_SLOT2

// codec --------------------------------------------------------
#define CODEC_NONE                      0
#define CODEC_AMBEPLUS                  1                                   // DStar
#define CODEC_AMBE2PLUS                 2                                   // DMR

// system constants ---------------------------------------------
#define NB_MODULES_MAX                  26

////////////////////////////////////////////////////////////////////////////////////////
// typedefs

typedef unsigned char           uint8;
typedef unsigned short          uint16;
typedef unsigned int            uint32;
typedef unsigned int            uint;


////////////////////////////////////////////////////////////////////////////////////////
// macros

#define MIN(a,b) 				((a) < (b))?(a):(b)
#define MAX(a,b) 				((a) > (b))?(a):(b)
#define MAKEWORD(low, high)		((uint16)(((uint8)(low)) | (((uint16)((uint8)(high))) << 8)))
#define MAKEDWORD(low, high)	((uint32)(((uint16)(low)) | (((uint32)((uint16)(high))) << 16)))
#define LOBYTE(w)				((uint8)(uint16)(w & 0x00FF))
#define HIBYTE(w)				((uint8)((((uint16)(w)) >> 8) & 0xFF))
#define LOWORD(dw)				((uint16)(uint32)(dw & 0x0000FFFF))
#define HIWORD(dw)				((uint16)((((uint32)(dw)) >> 16) & 0xFFFF))

////////////////////////////////////////////////////////////////////////////////////////
// global objects

class CReflector;
extern CReflector  g_Reflector;

class CGateKeeper;
extern CGateKeeper g_GateKeeper;

#if (DMRIDDB_USE_RLX_SERVER == 1)
    class CDmridDirHttp;
    extern CDmridDirHttp   g_DmridDir;
#else
    class CDmridDirFile;
    extern CDmridDirFile   g_DmridDir;
#endif

#if (YSFNODEDB_USE_RLX_SERVER == 1)
    class CYsfNodeDirHttp;
    extern CYsfNodeDirHttp   g_YsfNodeDir;
#else
    class CYsfNodeDirFile;
    extern CYsfNodeDirFile   g_YsfNodeDir;
#endif

class CTranscoder;
extern CTranscoder g_Transcoder;


////////////////////////////////////////////////////////////////////////////////////////
#endif /* main_h */
