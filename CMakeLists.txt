cmake_minimum_required (VERSION 2.8)

project (omxplayer)
find_package(PkgConfig)
include(ExternalProject)

ExternalProject_Add(ffmpeg
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/ffmpeg
    CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/ffmpeg/configure  --prefix=${CMAKE_BINARY_DIR}/ffmpeg_compiled
    BUILD_COMMAND ${MAKE}
)

pkg_check_modules (DBUS_1 dbus-1 REQUIRED)
find_package(Freetype)
find_package(Boost REQUIRED )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -DTARGET_POSIX -DTARGET_LINUX -fPIC -DPIC -D_REENTRANT -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DHAVE_CMAKE_CONFIG -D__VIDEOCORE4__ -U_FORTIFY_SOURCE -Wall -DHAVE_OMXLIB -DUSE_EXTERNAL_FFMPEG  -DHAVE_LIBAVCODEC_AVCODEC_H -DHAVE_LIBAVUTIL_OPT_H -DHAVE_LIBAVUTIL_MEM_H -DHAVE_LIBAVUTIL_AVUTIL_H -DHAVE_LIBAVFORMAT_AVFORMAT_H -DHAVE_LIBAVFILTER_AVFILTER_H -DHAVE_LIBSWRESAMPLE_SWRESAMPLE_H -DOMX -DOMX_SKIP64BIT -ftree-vectorize -DUSE_EXTERNAL_OMX -DUSE_EXTERNAL_LIBBCM_HOST")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ")


link_directories(${CMAKE_CURRENT_SOURCE_DIR})
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/..)
link_directories(/opt/vc/lib)

include_directories(./)
include_directories(${CMAKE_BINARY_DIR})
link_directories(${CMAKE_BINARY_DIR}/ffmpeg_compiled/usr/local/lib/)
include_directories(${CMAKE_BINARY_DIR}/ffmpeg_compiled/usr/local/include/)
include_directories(linux)
include_directories(/opt/vc/include)
include_directories(/opt/vc/include/interface/vcos/pthreads)
include_directories(/opt/vc/include/interface/vmcs_host)
include_directories(/opt/vc/include/interface/vmcs_host/linux)
include_directories(${Boost_INCLUDE_DIRS})
include_directories(${DBUS_1_INCLUDE_DIRS})

include_directories(/usr/include/freetype2)


add_executable(omxplayer linux/XMemUtils.cpp utils/log.cpp  DynamicDll.cpp  utils/PCMRemap.cpp  utils/RegExp.cpp  OMXSubtitleTagSami.cpp  OMXOverlayCodecText.cpp  BitstreamConverter.cpp  linux/RBP.cpp  OMXThread.cpp  OMXReader.cpp  OMXStreamInfo.cpp OMXAudioCodecOMX.cpp OMXCore.cpp OMXVideo.cpp OMXAudio.cpp OMXClock.cpp File.cpp OMXPlayerVideo.cpp OMXPlayerAudio.cpp OMXPlayerSubtitles.cpp SubtitleRenderer.cpp Unicode.cpp Srt.cpp KeyConfig.cpp OMXControl.cpp Keyboard.cpp omxplayer.cpp ${CMAKE_BINARY_DIR}/version.h ${CMAKE_BINARY_DIR}/help.h ${CMAKE_BINARY_DIR}/keys.h)
add_dependencies(omxplayer ffmpeg)
set_target_properties(omxplayer PROPERTIES OUTPUT_NAME "omxplayer.bin")
target_link_libraries(omxplayer ${DBUS_1_LIBRARIES} pthread c rt z pcre)
target_link_libraries(omxplayer avcodec avutil avformat swresample)
target_link_libraries(omxplayer GLESv2 EGL bcm_host openmaxil freetype )


add_custom_command(PRE_BUILD OUTPUT version.h
    COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/gen_version.sh > version.h
)

add_custom_command(PRE_BUILD OUTPUT help.h
    COMMAND ./gen_help.sh > ${CMAKE_BINARY_DIR}/help.h
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/README.md gen_help.sh
)

add_custom_command(PRE_BUILD OUTPUT keys.h
    COMMAND ./gen_keys.sh > ${CMAKE_BINARY_DIR}/keys.h
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/README.md gen_keys.sh
)
