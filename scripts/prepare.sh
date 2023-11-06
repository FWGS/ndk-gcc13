# use binutils and gcc sysroot/startfiles from 4.9
cp -a $ANDROID_NDK/toolchains/arm-linux-androideabi-4.9 /tmp/prefix
cp -a platforms/android-9/arch-arm /tmp/sysroot
# TODO: replace by tag when it will be marked, we are on 788d572f9a6d198f3309dea066fb43f0b7180b6a now
git clone https://github.com/gcc-mirror/gcc gcc-13 -b releases/gcc-13 --depth 1
wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.24.tar.bz2
tar xf isl-0.24.tar.bz2
wget https://www.mpfr.org/mpfr-current/mpfr-4.2.1.tar.xz
tar xf mpfr-4.2.1.tar.xz
wget https://www.multiprecision.org/downloads/mpc-1.3.0.tar.gz
tar xf mpc-1.3.0.tar.gz
cd mpc-1.3.0
# mpc.h missing stdio.h include...
patch -p1 < ../scripts/mpc.patch
cd ..
wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz
tar xf gmp-6.2.1.tar.xz
