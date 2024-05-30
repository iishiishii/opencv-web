Compiled OpenCV following [OpenCV tutorial](https://docs.opencv.org/4.x/d4/da1/tutorial_js_setup.html) and [opencv-wasm](https://github.com/echamudi/opencv-wasm) targeting web environment.

## Install
```bash
npm install opencv-web
```

To specify a custom path for the `opencv_js.wasm` file, replace `PATHTOWASMFILE` in the code snippet below and add it to your HTML file.
```html
    <script>
      var Module = {
        locateFile: function(s) {
          return PATHTOWASMFILE+ s;
        }
      };
    </script> 
```

## Compile process
```bash
./utils/build.sh
```

`WASM=1`:
This flag ensures that the output is in WebAssembly format. Emscripten supports both asm.js and WebAssembly, and this flag specifies the use of WebAssembly.

`NO_EXIT_RUNTIME=1`:
By setting this flag, the runtime does not shut down after the main function finishes executing. This is useful for applications that need to continue running after the main function completes, such as those that use async functions or handle events.

`EXTRA_EXPORTED_RUNTIME_METHODS=['addOnPostRun']`:
This flag specifies additional runtime methods to be exported. The addOnPostRun method allows you to add functions that will be called after the main function has executed. This is useful for initializing code or handling tasks that need to occur post-execution.

`ASSERTIONS=1`:
Enabling assertions includes runtime checks to help catch common errors and issues during development. This is useful for debugging, but these checks can be disabled in a production build to improve performance.

`ALLOW_MEMORY_GROWTH=1`:
This flag allows the memory used by the WebAssembly module to grow dynamically. By default, WebAssembly memory is fixed in size, but enabling memory growth can help handle cases where the application needs more memory than initially allocated.

`SINGLE_FILE=0`:
This flag controls whether to output a single file or separate files for the JavaScript and WebAssembly code. Setting it to 0 means that the output will be split into multiple files (a separate .wasm file and a .js file).

`ENVIRONMENT=web`:
This flag specifies the target environment for the compiled code. Setting it to web indicates that the code is intended to run in a web browser environment.

`EXPORT_ES6=1`:
This flag specifies that the output JavaScript module should use ES6 module syntax (import and export). This makes the generated code compatible with modern JavaScript module systems.

`USE_ES6_IMPORT_META=0`:
This flag controls the use of the ES6 import.meta construct. Setting it to 0 disables the use of import.meta, which might be necessary for compatibility with certain JavaScript environments that do not support this feature.

`MODULARIZE=1`:
This flag makes the output JavaScript code modular, meaning the WebAssembly module is wrapped in a function. This allows for better integration with JavaScript module systems and can help with namespace management.