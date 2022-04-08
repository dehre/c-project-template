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

- **valgrind, strace, ltrace**

    Those three aren't available on Mac.  
    To work it around, there's a `Dockerfile` that sets them up on Ubuntu.  
    You may use that docker image to play around with `gcc`, `gdb`, and `Linux` too.

## Requirements

- CMake
- Docker
- clang-tidy

To install `clang-tidy`, I installed `llvm` with Homebrew first, then added this alias to my `.bashrc`:

```sh
alias clang-tidy='/opt/homebrew/opt/llvm/bin/clang-tidy'
```

## How to use it

(The `build`, `run`, and `test` commands can also be run as VSCode Tasks, see `.vscode/tasks.json`.)

An example is worth a thousand words:

```sh
# build in debug mode
./build.sh debug
# or just
./build.sh

# clean build in debug mode
./build.sh debug clean

# build in release mode, or with ASan, UBSan, or TSan
./build.sh release
./build.sh asan
./build.sh ubsan
./build.sh tsan

# run in debug and release mode, assuming `main` is an executable name in `apps/CMakeLists.txt`
./run.sh debug main [<args...>]
./run.sh release main [<args...>]

# run with ASan
./run.sh asan main [<args...>]

# run test in debug mode, assuming `modern_test` is a test in `tests/CMakeLists.txt`
./test.sh debug modern_test

# run all tests in release mode
./test.sh release all

# run the debugger, assuming `main` is an executable name in `apps/CMakeLists.txt`
lldb build/debug/apps/main
```

Now valgrind. The Docker daemon should be running already:

```sh
# you need to run it only once, but I'll take a while to build...
./docker-ubuntu-build.sh

./docker-ubuntu-run.sh
cd project

rm -rf build
./build.sh
valgrind build/debug/apps/main
strace build/debug/apps/main
ltrace build/debug/apps/main
gdb build/debug/apps/main
```

My use cases for this repo:

1. Write a tiny snippet of code and check how it behaves.  
    I'd write everything in `main.c` like there's no tomorrow.  
    Other source and header files, if needed, would still go in the `apps` directory, with the former added to `apps/CMakeLists.txt`.  
    I would not create libraries or write tests, but I would make heavier use of the runtime analyzers.

2. Create a small project that aims at some meaningful outcome.  
    I'd write as much code as possible in one or more libraries, in the `src` directory, and write tests for them.  
    Public headers would placed in the `include` directory.  
    The executable file would merely handle user input and call library functions.  
    Check again this [book](https://cliutils.gitlab.io/modern-cmake/chapters/basics/structure.html) for the project structure.

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
