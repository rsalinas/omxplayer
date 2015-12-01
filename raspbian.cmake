
set(CMAKE_CXX_COMPILER /usr/bin/g++-4.7)
set(CMAKE_C_COMPILER /usr/bin/gcc-4.7)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DTARGET_RASPBERRY_PI ")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfloat-abi=hard -mcpu=arm1176jzf-s -fomit-frame-pointer -mabi=aapcs-linux -mtune=arm1176jzf-s -mfpu=vfp -Wno-psabi -mno-apcs-stack-check -mstructure-size-boundary=32 -mno-sched-prolog -march=armv6zk")

