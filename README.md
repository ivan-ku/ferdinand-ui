# Hello!
Meet Ferdinand - efficient and extendable ActionScript 3 UI system with built-in rapid prototyping capabilities. 
Intended usage: implement HUD, menus and other UI for AAA games that use [Scaleform](https://en.wikipedia.org/wiki/Scaleform_Corporation) .
Starling support is planned as well.

# Functional requirements: 
* Support skinning, dynamic skin (re)loading, external skin libraries, skins from .fla files
* Support rich animation capabilities without MovieClip
* Support any FPS, tweakable by designer
* Support mouse, keyboard, gamepad and touch interaction
* Support easy switch between Starling and classic DisplayObjects
* Data input interface that supports live updates and disk input

# Performance requirements:
* Any part of the system could be easily rewritten in C++ for optimization
* Provide easy way to setup different performance "presets" for each skin:
    * low - best performance
    * optimal - balanced, best for average hardware
    * fine - best-looking, possibly slow
* Do not allocate memory outside layout (re)load, skin/preset/resolution change (setup())
* Designer may add placeholder(preloader) animation/state for expensive operations (like setup()) to any skin
* Time-budget for frame (1ms for everything by default)
* Delay update if we don't fit, do not accumulate the lag with time
* Any time-consuming process (like setup()) could be "split" into several frames to prevent lag

# Technological requirements:
* Define scene layout, event-reaction and data-bindings in designer-friendly text mode OR in declarative AS3 mode  
* Allow fast (less than 2 seconds) scene reload with preserved state in designer-friendly text mode
* Precise debug output and error reporting in debug build
* Error prevention, suppression and recovery in release build
* Cover with unit tests everything that could be unit-tested

# Roadmap
Right now demo-app featuring List-like controls with scrolling is in active development, see [demo branch](https://github.com/ivan-ku/ferdinand-ui/tree/demo) 

# See you!
Ferdinand named after [Ferdinand de Saussure](https://en.wikipedia.org/wiki/Ferdinand_de_Saussure) and is just a fantasy right now, but it will be real soon (at least I hope so).