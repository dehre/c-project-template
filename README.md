# C Project Template

My take on setting up a nice environment for developing **C** (no C++) on MacOS.

## Features
- **CMake**

    Like it or not, it's the [most widely used tool for building C](https://www.jetbrains.com/lp/devecosystem-2021/c).  
    Without reinventing the wheel, I followed the project structure recommended by this [book](https://cliutils.gitlab.io/modern-cmake/chapters/basics/structure.html).

- **googletest**

  Again, [most popular tool](https://www.jetbrains.com/lp/devecosystem-2021/c), so I sticked to it.  
    The setup with CMake was a [breeze](https://google.github.io/googletest/quickstart-cmake.html).  
    Truth being told, the most popular unit-testing framework is "I don't write unit tests for C", followed by "I write unit tests, but I don't use any framework", which [you may decide to believe](https://www.commitstrip.com/en/2017/02/08/where-are-the-tests/?).

- **clang-tidy**

    Great static-analysis tool.  
    Unfortunately, it doesn't come preinstalled on Mac, but you can [work it around](#requirements).

- **Sanitizers**

    Address Sanitizer (ASan), Undefined Behaviour Sanitizer (UBSan), and Thread Sanitizer (TSan) for runtime analysis.  
    [Here](https://github.com/google/sanitizers) and [here](https://developer.apple.com/documentation/xcode/diagnosing-memory-thread-and-crash-issues-early) for more info.
    
- **Remote-Containers**

    Thanks to the [VSCode Remote Containers extension](https://code.visualstudio.com/docs/remote/containers), you can develop the application in a Docker container running Ubuntu `20.4`.

- **valgrind, strace, ltrace**

    These tools aren't available on Mac, but you can use them inside the Docker container.  
    You may use that docker image to play around with `gcc` and `gdb` too.

## Requirements

Install these programs on your machine:

- CMake
- Docker
- clang-tidy

PS: To install `clang-tidy`, install `llvm` with Homebrew first, then add this alias to the `.bashrc`:

```sh
alias clang-tidy='/opt/homebrew/opt/llvm/bin/clang-tidy'
```

Then install these VSCode extensions:

- ms-vscode.cpptools
- ms-vscode.cmake-tools
- ms-vscode-remote.remote-containers

## How to use it
  
Follow this tutorial, starting from the ["Select a kit"](https://code.visualstudio.com/docs/cpp/cmake-linux#_select-a-kit) section.
Everything should work out of the box: building, running, tests, and using the integrated debugger.

If you want to develop using the remote container, open the Command Palette and type `Remote-Containers: Reopen in Container` (the Docker daemon should be running already).  
Then delete the `build` directory, and build the project again.

Finally, for strace, ltrace, and valgrind, open the remote container and:

```sh
valgrind path-to-executable
strace path-to-executable
ltrace path-to-executable
gdb path-to-executable
```

## FAQ

### googletest isn't in C

Indeed, but for most use cases [it's all macros](https://github.com/google/googletest/tree/main/googletest/samples) and doesn't look much different from regular C code.

## Others

- You can use these three executable files to try out the runtime analyzers:  
    `apps/use-after-free.c`, `apps/signed-int-overflow.c`, and `apps/data-race.c`.
    Uncomment them in `apps/CMakeLists.txt`, then, as usual:

```sh
./build.sh asan
./run.sh asan use-after-free

./build.sh ubsan
./run.sh ubsan signed-int-overflow

./build.sh tsan
./run.sh tsan data-race
```

- A very good list of compiler warnings you may want to add:  
http://fastcompression.blogspot.com/2019/01/compiler-warnings.html

## TODOS for next time

- check if you can get a `launch.json` that works for both mac and ubuntu on the dev container
- check if you can get the cmake vscode extension working properly
    - if so, get rid of `build.sh`, `run.sh`, `test.sh`, and refactor `tasks.json`
- if all that above works out somehow, get rid of `docker-ubuntu-build.sh` and `docker-ubuntu-run.sh` too
