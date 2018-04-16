# Copyright 2017 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# WBRASWELL 20180315 2018.074: manually set PACKAGE_PREFIX_DIR due to CMake "does not exist" failures
set (PACKAGE_PREFIX_DIR /usr)

set (BSON_MAJOR_VERSION 1)
set (BSON_MINOR_VERSION 9)
set (BSON_MICRO_VERSION 3)
set (BSON_VERSION 1.9.3)

# In a pure-CMake project this is inserted by configure_package_config_file(),
# but we want to be able to build this file the same from the Autotools, so
# let's manually insert this code.
get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

set_and_check (BSON_INCLUDE_DIRS "${PACKAGE_PREFIX_DIR}/include/libbson-1.0")

# We want to provide an absolute path to the library and we know the
# directory and the base name, but not the suffix, so we use CMake's
# find_library() to pick that up.  Users can override this by configuring
# BSON_LIBRARY themselves.
find_library(BSON_LIBRARY bson-1.0 PATHS "${PACKAGE_PREFIX_DIR}/lib" NO_DEFAULT_PATH)

set (BSON_LIBRARIES ${BSON_LIBRARY})

