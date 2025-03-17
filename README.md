# pyfort

[![github CI](https://github.com/larsbuntemeyer/pyfort/actions/workflows/ci.yaml/badge.svg)](https://github.com/larsbuntemeyer/pyfort/actions/workflows/ci.yaml)

A simple demo python package that compiles a Fortran extension using meson, based on [using f2py via meson](https://numpy.org/doc/stable/f2py/buildtools/meson.html#automating-wrapper-generation) including automatic wrapper generation.

## How to use

This repository contains a template for a python package with a Fortran extension. You should put your fortran source code into the `src` subdirectory and list all files in the `cusomt_target` and `extension_module` sections.
You can then compile and install your code using

```
pip install .
```

## References

* `meson.build` is partly based on [aburrell/apexpy](https://github.com/aburrell/apexpy/blob/main/meson.build)
* [using f2py via meson](https://numpy.org/doc/stable/f2py/buildtools/meson.html#automating-wrapper-generation)
