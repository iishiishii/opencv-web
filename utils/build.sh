git clone --branch 4.9.0 --depth 1 https://github.com/opencv/opencv.git

# Build
(
    cd opencv &&
    git checkout 4.9.0 &&

    # Add non async flag before compiling in the python build_js.py script
    docker run --rm --workdir /code -v "$PWD":/code "trzeci/emscripten:sdk-tag-1.39.4-64bit" python ./platforms/js/build_js.py build_wasm --build_wasm --build_test --build_flags "-s WASM=1 -s NO_EXIT_RUNTIME=1 -s EXTRA_EXPORTED_RUNTIME_METHODS=['addOnPostRun'] -s ASSERTIONS=1 -s ALLOW_MEMORY_GROWTH=1 -s SINGLE_FILE=0 -s ENVIRONMENT=web -s EXPORT_ES6=1 -s USE_ES6_IMPORT_META=0 -s MODULARIZE=1 "
)

# Copy compilation result
cp -a ./opencv/build_wasm/ ./build_wasm

# Transpile opencv.js files
# node opencvJsMod.js

# Beautify JS
(
    cd ./build_wasm/bin &&
    npx js-beautify opencv.js -r
)

# Copy bins to root
(
    cp ./build_wasm/bin/opencv_js.wasm ../opencv_js.wasm &&
    cp ./build_wasm/bin/opencv.js ../opencv_wasm.js
)
