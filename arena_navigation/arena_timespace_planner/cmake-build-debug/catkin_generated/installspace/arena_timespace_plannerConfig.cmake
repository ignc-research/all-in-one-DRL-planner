# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list and remove existing duplicates from the list
# copied from catkin/cmake/list_append_deduplicate.cmake to keep pkgConfig
# self contained
macro(_list_append_deduplicate listname)
  if(NOT "${ARGN}" STREQUAL "")
    if(${listname})
      list(REMOVE_ITEM ${listname} ${ARGN})
    endif()
    list(APPEND ${listname} ${ARGN})
  endif()
endmacro()

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# pack a list of libraries with optional build configuration keywords
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_pack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  set(_argn ${ARGN})
  list(LENGTH _argn _count)
  set(_index 0)
  while(${_index} LESS ${_count})
    list(GET _argn ${_index} lib)
    if("${lib}" MATCHES "^(debug|optimized|general)$")
      math(EXPR _index "${_index} + 1")
      if(${_index} EQUAL ${_count})
        message(FATAL_ERROR "_pack_libraries_with_build_configuration() the list of libraries '${ARGN}' ends with '${lib}' which is a build configuration keyword and must be followed by a library")
      endif()
      list(GET _argn ${_index} library)
      list(APPEND ${VAR} "${lib}${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}${library}")
    else()
      list(APPEND ${VAR} "${lib}")
    endif()
    math(EXPR _index "${_index} + 1")
  endwhile()
endmacro()

# unpack a list of libraries with optional build configuration keyword prefixes
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_unpack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  foreach(lib ${ARGN})
    string(REGEX REPLACE "^(debug|optimized|general)${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}(.+)$" "\\1;\\2" lib "${lib}")
    list(APPEND ${VAR} "${lib}")
  endforeach()
endmacro()


if(arena_timespace_planner_CONFIG_INCLUDED)
  return()
endif()
set(arena_timespace_planner_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if("FALSE" STREQUAL "TRUE")
  set(arena_timespace_planner_SOURCE_PREFIX /home/johannes/catkin_ws/src/arena-rosnav/arena_navigation/arena_timespace_planner)
  set(arena_timespace_planner_DEVEL_PREFIX /home/johannes/catkin_ws/src/arena-rosnav/arena_navigation/arena_timespace_planner/cmake-build-debug/devel)
  set(arena_timespace_planner_INSTALL_PREFIX "")
  set(arena_timespace_planner_PREFIX ${arena_timespace_planner_DEVEL_PREFIX})
else()
  set(arena_timespace_planner_SOURCE_PREFIX "")
  set(arena_timespace_planner_DEVEL_PREFIX "")
  set(arena_timespace_planner_INSTALL_PREFIX /usr/local)
  set(arena_timespace_planner_PREFIX ${arena_timespace_planner_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'arena_timespace_planner' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(arena_timespace_planner_FOUND_CATKIN_PROJECT TRUE)

if(NOT "include " STREQUAL " ")
  set(arena_timespace_planner_INCLUDE_DIRS "")
  set(_include_dirs "include")
  if(NOT " " STREQUAL " ")
    set(_report "Check the issue tracker '' and consider creating a ticket if the problem has not been reported yet.")
  elseif(NOT " " STREQUAL " ")
    set(_report "Check the website '' for information and consider reporting the problem.")
  else()
    set(_report "Report the problem to the maintainer 'root <root@todo.todo>' and request to fix the problem.")
  endif()
  foreach(idir ${_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif("${idir} " STREQUAL "include ")
      get_filename_component(include "${arena_timespace_planner_DIR}/../../../include" ABSOLUTE)
      if(NOT IS_DIRECTORY ${include})
        message(FATAL_ERROR "Project 'arena_timespace_planner' specifies '${idir}' as an include dir, which is not found.  It does not exist in '${include}'.  ${_report}")
      endif()
    else()
      message(FATAL_ERROR "Project 'arena_timespace_planner' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in '\${prefix}/${idir}'.  ${_report}")
    endif()
    _list_append_unique(arena_timespace_planner_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "arena_timespace_planner")
foreach(library ${libraries})
  # keep build configuration keywords, target names and absolute libraries as-is
  if("${library}" MATCHES "^(debug|optimized|general)$")
    list(APPEND arena_timespace_planner_LIBRARIES ${library})
  elseif(${library} MATCHES "^-l")
    list(APPEND arena_timespace_planner_LIBRARIES ${library})
  elseif(${library} MATCHES "^-")
    # This is a linker flag/option (like -pthread)
    # There's no standard variable for these, so create an interface library to hold it
    if(NOT arena_timespace_planner_NUM_DUMMY_TARGETS)
      set(arena_timespace_planner_NUM_DUMMY_TARGETS 0)
    endif()
    # Make sure the target name is unique
    set(interface_target_name "catkin::arena_timespace_planner::wrapped-linker-option${arena_timespace_planner_NUM_DUMMY_TARGETS}")
    while(TARGET "${interface_target_name}")
      math(EXPR arena_timespace_planner_NUM_DUMMY_TARGETS "${arena_timespace_planner_NUM_DUMMY_TARGETS}+1")
      set(interface_target_name "catkin::arena_timespace_planner::wrapped-linker-option${arena_timespace_planner_NUM_DUMMY_TARGETS}")
    endwhile()
    add_library("${interface_target_name}" INTERFACE IMPORTED)
    if("${CMAKE_VERSION}" VERSION_LESS "3.13.0")
      set_property(
        TARGET
        "${interface_target_name}"
        APPEND PROPERTY
        INTERFACE_LINK_LIBRARIES "${library}")
    else()
      target_link_options("${interface_target_name}" INTERFACE "${library}")
    endif()
    list(APPEND arena_timespace_planner_LIBRARIES "${interface_target_name}")
  elseif(TARGET ${library})
    list(APPEND arena_timespace_planner_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND arena_timespace_planner_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path /usr/local/lib;/home/johannes/catkin_ws/devel/lib;/opt/ros/melodic/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(arena_timespace_planner_LIBRARY_DIRS ${lib_path})
      list(APPEND arena_timespace_planner_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'arena_timespace_planner'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND arena_timespace_planner_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(arena_timespace_planner_EXPORTED_TARGETS "")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${arena_timespace_planner_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "arena_mapping;arena_path_search;arena_traj_planner;arena_dynamic_channel;visualization_msgs;geometry_msgs;nav_msgs;roscpp;rospy;sensor_msgs;std_msgs")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 arena_timespace_planner_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${arena_timespace_planner_dep}_FOUND)
      find_package(${arena_timespace_planner_dep} REQUIRED NO_MODULE)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${arena_timespace_planner_dep} REQUIRED NO_MODULE ${depend_list})
  endif()
  _list_append_unique(arena_timespace_planner_INCLUDE_DIRS ${${arena_timespace_planner_dep}_INCLUDE_DIRS})

  # merge build configuration keywords with library names to correctly deduplicate
  _pack_libraries_with_build_configuration(arena_timespace_planner_LIBRARIES ${arena_timespace_planner_LIBRARIES})
  _pack_libraries_with_build_configuration(_libraries ${${arena_timespace_planner_dep}_LIBRARIES})
  _list_append_deduplicate(arena_timespace_planner_LIBRARIES ${_libraries})
  # undo build configuration keyword merging after deduplication
  _unpack_libraries_with_build_configuration(arena_timespace_planner_LIBRARIES ${arena_timespace_planner_LIBRARIES})

  _list_append_unique(arena_timespace_planner_LIBRARY_DIRS ${${arena_timespace_planner_dep}_LIBRARY_DIRS})
  list(APPEND arena_timespace_planner_EXPORTED_TARGETS ${${arena_timespace_planner_dep}_EXPORTED_TARGETS})
endforeach()

set(pkg_cfg_extras "")
foreach(extra ${pkg_cfg_extras})
  if(NOT IS_ABSOLUTE ${extra})
    set(extra ${arena_timespace_planner_DIR}/${extra})
  endif()
  include(${extra})
endforeach()
