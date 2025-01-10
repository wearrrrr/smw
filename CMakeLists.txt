cmake_minimum_required(VERSION 3.1)

project(SMW)
set(CMAKE_CXX_STANDARD 11)

set(EMSCRIPTEN, TRUE)

# Set compiler to emscripten
set(CMAKE_C_COMPILER "emcc")
SET(CMAKE_BUILD_TYPE_INIT "Release")

if(CMAKE_C_COMPILER MATCHES "emcc")
  message("Emscripten build detected")
  set(CMAKE_EXECUTABLE_SUFFIX .html)

  set(EM_USE_FLAGS "-sDISABLE_EXCEPTION_CATCHING=0")
  set(EM_LINK_FLAGS "--preload-file smw_assets.dat --preload-file smw.ini -sASYNCIFY=1")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${EM_USE_FLAGS} -sUSE_SDL=2 -sUSE_SDL_IMAGE=2 -O2")

  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_LINKER_FLAGS} ${EM_USE_FLAGS} ${EM_LINK_FLAGS}")
endif()

file(
    GLOB 
    SOURCES 
    "smb1/*.c",
    "smbll/*.c",
    "src/*.c",
    "src/snes/*.c",
    "third_party/**/*.c",
    "third_party/**/*.h",
    "assets/*.h",
)
list(SORT SOURCES)

# Log out all the files found
foreach(file ${SOURCES})
  message(STATUS "Found file: ${file}")
endforeach()

foreach(file ${THIRD_PARTY})
  message(STATUS "Found file: ${file}")
endforeach()

# Copy assets to build directory
file(COPY smw_assets.dat DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY smw.ini DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

add_executable(SMW ${SOURCES} ${THIRD_PARTY})