project( 'pyfort', 'c',
  # Note that the git commit hash cannot be added dynamically here
  version: '2.0.1',
  license: 'MIT',
  meson_version: '>= 0.63.0',
  default_options: [
    'buildtype=debugoptimized',
    # TODO: the below -Wno flags are all needed to silence warnings in
    # f2py-generated code. This should be fixed in f2py itself.
    'c_args=-Wno-unused-function -Wno-conversion -Wno-misleading-indentation -Wno-incompatible-pointer-types',
    'fortran_args=-Wno-conversion',  # silence "conversion from REAL(8) to INTEGER(4)"
    'fortran_std=legacy',
  ],
)

# Adding at project level causes many spurious -lgfortran flags.
add_languages('fortran', native: false)


fc = meson.get_compiler('fortran')
cc = meson.get_compiler('c')

# Don't use the deprecated NumPy C API. Define this to a fixed version instead
# of NPY_API_VERSION in order not to break compilation for released versions
# when NumPy introduces a new deprecation. Use in a meson.build file::
#
#   py3.extension_module('_name',
#     'source_fname',
#     numpy_nodepr_api)
#
numpy_nodepr_api = '-DNPY_NO_DEPRECATED_API=NPY_1_7_API_VERSION'

# https://mesonbuild.com/Python-module.html
py_mod = import('python')
py3 = py_mod.find_installation()
py3_dep = py3.dependency()
message(py3.full_path())
message(py3.get_install_dir())

incdir_numpy = run_command(py3,
  ['-c', 'import os; os.chdir(".."); import numpy; print(numpy.get_include())'],
  check : true
).stdout().strip()

incdir_f2py = run_command(py3,
  ['-c', 'import os; os.chdir(".."); from numpy import f2py; print(f2py.get_include())'],
  check : true
).stdout().strip()

fibby_source = custom_target('fibbymodule.c',
  input : ['src/fib1.f'],  # .f so no F90 wrappers
  #output : ['fibbymodule.c', 'fibby-f2pywrappers.f'],
  output : ['fibbymodule.c'],
  command : [py3, '-m', 'numpy.f2py', '@INPUT@', '-m', 'fibby', '--lower']
)

inc_dirs = include_directories(incdir_numpy, incdir_f2py)

# Platform detection to set more flags for Windows systems
is_windows = host_machine.system() == 'windows'
is_mac = host_machine.system() == 'darwin'
is_mingw = is_windows and cc.get_id() == 'gcc'

# Declare the sources
py3.install_sources([
  'pyfort/__init__.py'],
  pure: false,
  subdir: 'pyfort')

py3.extension_module('fibby',
  ['src/fib1.f', fibby_source],
  incdir_f2py / 'fortranobject.c',
  include_directories: inc_dirs,
  dependencies : py3_dep,
  install : true
)
