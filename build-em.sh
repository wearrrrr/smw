mkdir -p build
cd build
emcmake cmake .. -Wno-dev
# Remove stupid linker flag that causes the build to fail, no idea why emscripten is emitting this!!
sed -i 's/--dependency-file=CMakeFiles\/SMW.dir\/link.d//g' CMakeFiles/SMW.dir/link.txt
emmake make -j16

mkdir -p ../output
cp SMW.html ../output/
cp SMW.js ../output/
cp SMW.wasm ../output/
cp SMW.data ../output/

echo "Build complete. Output files are in the output directory!"