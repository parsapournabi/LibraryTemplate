# LibraryTemplate

A modern **Qt5 / Qt6** CMake template for building reusable C++ libraries.

This repository provides a ready-to-use project structure for creating Qt-based libraries with support for:

- Modern CMake
- Qt 5 / Qt 6
- Cross-platform (Windows / Linux / macOS)
- Shared libraries (.dll/.so/.dylib)
- QML Modules
- GLSL Shaders
- Resources (.qrc)
- Automatic installation
- CMake package export
- `find_package()` support
- `add_subdirectory()` support

The goal of this template is to eliminate repetitive setup work so every new library starts from the same clean architecture.

---

# Features

- Modern CMake (3.16+)
- Qt5 / Qt6 compatible
- Automatic Qt MOC/UIC/RCC
- Optional QML support
- Automatic QML import path configuration
- Automatic resource (.qrc) generation
- Automatic qmldir generation
- Automatic recursive file discovery
- Install & Export support
- Namespace targets
- Cross-platform
- Git ready
- Formatting configuration (AStyle / Qt Creator)

---

# Project Structure

```
.
├── cmake/
├── config/
├── docs/
├── examples/
├── include/
├── qml/
├── scripts/
├── shaders/
├── share/
├── src/
├── tests/
└── resources.qrc
```

---

# Getting Started

Clone the template

```bash
git clone https://github.com/parsapournabi/LibraryTemplate.git MyLibrary
```

Rename the module.

The template uses **Module** as a placeholder.

Run:

```bash
scripts/rename-all.sh \
    --paths . \
    --current Module \
    --target MyLibrary
```

This automatically renames:

- directories
- filenames
- occurrences inside files

---

Generate qmldir

```bash
scripts/update-qml-module.sh \
    --dir qml \
    --module com.wearily.MyLibrary \
    --version 1.0
```

This automatically generates the **qmldir** file by scanning all QML and JavaScript files recursively.

---

Generate resources.qrc

```bash
scripts/update-qrc.sh
```

This automatically scans:

- qml/
- shaders/

and updates

```
resources.qrc
```

Additional directories can also be specified.

---

Done.

The project is now ready to build.

---

# Building

```bash
mkdir build

cd build

cmake ..

cmake --build .
```

---

# Optional Features

Enable QML support

```bash
cmake .. -DMyLibrary_WITH_QML=ON
```

Build examples

```bash
cmake .. -DMyLibrary_BUILD_EXAMPLES=ON
```

Build tests

```bash
cmake .. -DMyLibrary_BUILD_TESTS=ON
```

---

# Installation

Install library

```bash
cmake --install .
```

The following files will be installed automatically:

- shared library
- headers
- CMake package
- QML module (optional)
- share/ resources

---

# Using as Subdirectory

```cmake
add_subdirectory(3rdParty/MyLibrary)

target_link_libraries(MyApplication
    PRIVATE
        QtWea::MyLibrary
)
```

No additional include directories are required.

Everything is exported through the library target.

---

# Using with find_package()

Install the library first.

Then

```cmake
find_package(MyLibrary REQUIRED)

target_link_libraries(MyApplication
    PRIVATE
        QtWea::MyLibrary # QtWea is MODULE_NAMESPACE (You can modify it in .cmake.conf)
)
```

---

# QML Modules

When QML support is enabled, the template automatically:

- configures QML import paths for Qt Creator
- installs the QML module
- supports recursive qmldir generation
- supports JavaScript modules
- supports plugins.qmltypes

Module example

```
qml/
└── com/
    └── wearily/
        └── MyLibrary/
```

Import:

```qml
import com.wearily.MyLibrary 1.0
```

> [!TIP]
> Replace `wearily` name with your `organization name`.

---

# Resources

The template uses a single root

```
resources.qrc
```

Resources are generated automatically by

```
update-qrc.sh
```

Supported directories include

- qml/
- shaders/
- share/

Additional directories can easily be added.

---

# Scripts

## rename-all.sh

Recursively renames

- directories
- filenames
- file contents

Useful when creating a new library from the template.

---

## update-qml-module.sh

Automatically generates

```
qmldir
```

by scanning

- QML files
- JavaScript files

Supports recursive directories.

---

## update-qrc.sh

Automatically regenerates

```
resources.qrc
```

from project resources.

---

# Recommended Workflow

Clone template

↓

Rename Module

↓

Generate qmldir

↓

Generate resources.qrc

↓

Build

↓

Install

Everything else is handled automatically.

---

# Requirements

- CMake 3.16+
- Qt 5.15+
- Qt 6.x
- C++17

---

# License

Choose any license appropriate for your project.

---

Created with ❤️ for reusable Qt libraries.