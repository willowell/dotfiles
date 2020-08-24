# Environment Setup
This guide is for setting up my development environment on my computer. This guide is intended for personal use, but if it is of any use to anyone else, that's great!!

I have listed the directions per language in alphabetical order, starting with an overview of my operating system.



# Computer Setup
OS: macOS Catalina 10.15.*

# Preliminary setup
1. Install Homebrew
2. Install the Xcode CLT via `xcode-select --install`.
3. Install iTerm2
4. Update .zshrc, make sure Oh-my-Zsh and everything works.

# Agda
Dependencies: Haskell and Cabal

Follow the directions here to install Agda and the standard library:
https://plfa.github.io/GettingStarted/

For convenience, I have arranged my Agda stuff as:
Agda
    * agda
    * agda-stdlib-XX
    * plfa.github.io
  
It is also necessary to globally install the `iee754` Haskell package via Cabal. Simply run `cabal v1-install iee754`.

# APL

Download and install the Dyalog APL app. Nothing else is needed.

# C/C++

For brand new features, download and install LLVM/Clang from Homebrew.

Download and install `vcpkg` from https://github.com/microsoft/vcpkg.

# Common Lisp

For Clozure CL, check https://github.com/Clozure/ccl and follow the latest release instructions.
For SBCL, download and install SBCL from Homebrew.

# D

Simply install DMD from Homebrew. DMD comes with DUB, so nothing else is needed.

# Elixir

Simply install Elixir from Homebrew.

# Futhark

Install Futhark from Homebrew.

# Haskell

Download and install `ghcup`. Install GHC and Cabal via `ghcup`.
Install Stack from Homebrew.

For the Haskell Language Server, clone https://github.com/haskell/haskell-language-server and follow the installation directions.

You may also want to install `implicit-hie` from https://github.com/Avi-D-coder/implicit-hie.

# Idris

Install Idris from Homebrew.

# Java

Install the OpenJDK distribution AdoptOpenJDK from Homebrew.
Check that the `JAVA_HOME` path variable in `.zshrc` is correct; adjust as needed.

# JavaScript
**DO NOT INSTALL NPM DIRECTLY FROM HOMEBREW!!!**

Install Yarn from Homebrew.

Install the Node Version Manager by following https://github.com/nvm-sh/nvm.

Globally install:
* Gatsby
* PureScript and Spago
* ReasonML and Esy
* TypeScript

# Julia

Just install Julia from the website. That's it. 

# NASM

Install NASM from Homebrew.

# OCaml

Follow the installation instructions at https://ocaml.org/docs/install.html.

# Odin

Install from Homebrew, or follow the directions at https://odin-lang.org/docs/install/.

# .NET

Install Visual Studio for Mac.

# Processing

Install Processing from the website.

# Prolog

Install `swi-prolog` from Homebrew.

# Python
**DO NOT INSTALL PYTHON DIRECTLY FROM HOMEBREW!!!**
A number of Homebrew packages depend on Python in one way or another, so it is best to go with a Homebrew-independent installation in this case.

Install Anaconda from Homebrew.

Install Python Poetry by following the instructions at https://python-poetry.org/.

Optionally install Python 3.8 standalone from the website.

# Qiskit
Dependencies: Anaconda

Make an Anaconda virtual environment for Qiskit, and then activate it and run `pip install qiskit`.

# Racket

Install Racket from Homebrew.

# Rust

Just follow the installation instructions at https://www.rust-lang.org/.

# Swift

macOS comes with Swift, so there is no need to do anything here.

# Unity

Install Unity from the website.

# Vulkan

Download and install the Vulkan SDK from https://vulkan.lunarg.com/sdk/home.
