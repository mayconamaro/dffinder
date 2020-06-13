# DFFinder - Duplicate File Finder

![build](https://github.com/mayconamaro/dffinder/workflows/build/badge.svg?branch=master&event=push)

This is a simple application that scans an entire folder's tree structure (all files in all subfolders) for duplicate files. The files are compared in terms of content, so duplicate files with different names are still found.



## Getting DFFinder

When I test the program in different platforms I will publish the binaries somewhere and update this *readme*. Until there you can build your own version easily:

1. Get [Haskell Stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/) 

2. Clone this repository on your machine

3. Open a terminal/prompt on the directory

4. Execute `stack setup` to download the compiler and dependencies (it may take some time, don't worry)

5. Execute `stack build` to compile it

6. Execute `stack install` to get a binary copied into a predefined folder (~/.local/bin on POSIX systems)



## What's the idea?

I did not do anything new here, we compare the files' checksum in order to find the ones that generated the same hash number. Yeah, I know that different files can generate one same hash number (which in fact is needed by security), but chances are very low.

## Contribute

I'll will gladly check all pull requests and accept contributions to this project =D
