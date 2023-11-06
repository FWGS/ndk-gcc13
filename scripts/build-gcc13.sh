# use static libs for portability, dynamic linking requires using LD_LIBRARY_PATH or rpath to make it load libs correctly
cd gmp-6.2.1/
./configure --prefix=/tmp/prefix/ --disable-shared --enable-static
make -j16
make install
cd ..
cd mpfr-4.2.1
./configure --prefix=/tmp/prefix/ --with-gmp=/tmp/prefix/ --disable-shared --enable-static
make -j16
make install
cd ..
cd mpc-1.3.0
./configure --prefix=/tmp/prefix/ --with-gmp=/tmp/prefix/ --disable-shared --enable-static
make -j16
make install
cd ..
cd isl-0.24
./configure --prefix=/tmp/prefix/ --with-gmp-prefix=/tmp/prefix/ --disable-shared --enable-static
make -j16
make install
cd ..
mkdir gcc-13/build-gcc
cd gcc-13/build-gcc
# c++11 required, use gcc-4.9 on ubuntu 12.04
CXX="g++-4.9" CC="gcc-4.9" ../configure --prefix=/tmp/prefix/ --target=arm-linux-androideabi --host=x86_64-linux-gnu --build=x86_64-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++ --with-host-libstdcxx="-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm" --disable-libssp --enable-threads --disable-nls --disable-libmudflap --disable-libstdc__-v3 --disable-sjlj-exceptions --disable-shared --disable-tls --disable-libitm --with-float=soft --with-fpu=vfp --with-arch=armv5te --enable-target-optspace --enable-initfini-array --disable-nls  --with-sysroot=/tmp/sysroot/ --with-binutils-version=2.25 --with-bugurl=http://source.android.com/source/report-bugs.html --enable-languages=c,c++ --disable-bootstrap --enable-plugins --enable-libgomp --enable-gnu-indirect-function --enable-libsanitizer --enable-gold --enable-threads --enable-graphite=yes  --enable-eh-frame-hdr-for-static --with-arch=armv5te --enable-gold=default --with-gmp=/tmp/prefix --with-mpfr=/tmp/prefix --with-mpc=/tmp/prefix --with-isl=/tmp/prefix/
make -j16
make install
# gcc codegen using sincos functions.
# They are not availiable in android, but availiable in libm_hard.a,
# so insert it in libgcc to link-in when libm_hard.a not used
ar q /tmp/prefix/lib/gcc/arm-linux-androideabi/13.2.1/libgcc.a scripts/sincos/k_rem_pio2.o scripts/sincos/s_sincos.o scripts/sincos/s_sincosf.o
# /tmp/prefix now have gcc-13.2.1 and it may be integrated to ndk