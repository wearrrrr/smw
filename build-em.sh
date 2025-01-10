mkdir -p build
cd build
emcmake cmake .. -Wno-dev
# Remove stupid linker flag that causes the build to fail, no idea why emscripten is emitting this!!
sed -i 's/--dependency-file=CMakeFiles\/SMW.dir\/link.d//g' CMakeFiles/SMW.dir/link.txt
emmake make -j16

mkdir -p ../web/smw/
cp SMW.html ../web/smw/
cp SMW.js ../web/smw/
cp SMW.wasm ../web/smw/
cp SMW.data ../web/smw/

cd ..

# echo "Running wasm-opt on output wasm..."
# G="--generate-global-effects"
# wasm-opt ./output/SMW.wasm -o SMW-optimized.wasm --converge -tnh --enable-threads --enable-bulk-memory --enable-simd \
# 			$G --type-unfinalizing $G --type-ssa $G -O4 $G --flatten $G --rereloop $G -O4 $G -O4 $G --type-merging $G --type-finalizing $G -O4 \
# 			$G --type-unfinalizing $G --type-ssa $G -Oz $G --flatten $G --rereloop $G -Oz $G -Oz $G --type-merging $G --type-finalizing $G -Oz \
# 			$G --abstract-type-refining $G --code-folding $G --const-hoisting $G --dae $G --flatten $G --dfo $G --merge-locals $G --merge-similar-functions --type-finalizing \
# 			$G --type-unfinalizing $G --type-ssa $G -O4 $G --flatten $G --rereloop $G -O4 $G -O4 $G --type-merging $G --type-finalizing $G -O4 \
# 			$G --type-unfinalizing $G --type-ssa $G -Oz $G --flatten $G --rereloop $G -Oz $G -Oz $G --type-merging $G --type-finalizing $G -Oz 

echo "Build complete! Output files are in the output directory."
