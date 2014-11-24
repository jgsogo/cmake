###################################################################
# - Find VLD (Visual Detectioon Leak)
# http://sites.google.com/site/dmoulding/vld
#
#
#  VLD_FOUND       - True if vlib found.  
#  VLD_INCLUDE_DIR - where to find vlib.h
#  VLD_LIBRARY   - List of libraries used for compilation under MSVC
#  VLD_SYMBOLS     - List of symbols to add to compilation
#	
# - This script as been created by Benoit Rat (17/03/2010)
#	* Set the default windows path to: %PROGRAMFILES%\Visual Leak Detector\ if no VLDDIR are defined.
#	* Changes the way to find includes and library.
#	* Add the VLD_SYMBOLS to check #ifdef _VLD #endif
#

# This library is only used with Microsoft Visual Studio
if(MSVC) 

option(BUILD_WITH_VLD false "Build with Visual Leak Detection library")

if(BUILD_WITH_VLD)

if(WIN32) 
    if(NOT EXISTS $ENV{VLDDIR}) 
    	set(ENV{VLDDIR}  "$ENV{PROGRAMFILES}\\Visual Leak Detector")
    endif(NOT EXISTS $ENV{VLDDIR}) 
    message(STATUS "VLD is $ENV{VLDDIR}") 
ENDIF(WIN32)


                     

find_path(VLD_INCLUDE_DIR NAMES "vld.h" PATHS $ENV{VLDDIR} PATH_SUFFIXES "include" "../include/")

find_library(VLD_LIBRARY NAMES "vld" PATHS $ENV{VLDDIR} PATH_SUFFIXES "lib" "../lib" "lib/Win32", "../lib/Win32") 

if (VLD_INCLUDE_DIR AND VLD_LIBRARY)
   set(VLD_FOUND TRUE)
endif (VLD_INCLUDE_DIR AND VLD_LIBRARY)


if (VLD_FOUND)
   if (NOT VLD_FIND_QUIETLY)
      message(STATUS "Found VLD: ${VLD_LIBRARY}")
	  set(VLD_SYMBOLS "-D_VLD")
   endif (NOT VLD_FIND_QUIETLY)
else (VLD_FOUND)
   if (VLD_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find VLD")
   endif (VLD_FIND_REQUIRED)
endif (VLD_FOUND)

endif(BUILD_WITH_VLD)

else(MSVC)

	SET(VLD_FOUND false)
	
endif(MSVC)

