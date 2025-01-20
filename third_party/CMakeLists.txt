find_package(Vulkan REQUIRED)

add_library(vkbootstrap STATIC)
add_library(glm INTERFACE)
add_library(vma INTERFACE)

add_library(stb_image INTERFACE)

add_library(tinyobjloader STATIC)

target_sources(vkbootstrap PRIVATE
    vkbootstrap/VkBootstrap.h
    vkbootstrap/VkBootstrap.cpp
    )

target_include_directories(vkbootstrap PUBLIC vkbootstrap)
target_link_libraries(vkbootstrap PUBLIC Vulkan::Vulkan $<$<BOOL:UNIX>:${CMAKE_DL_LIBS}>)

#both vma and glm and header only libs so we only need the include path
target_include_directories(vma INTERFACE vma)
target_include_directories(glm INTERFACE glm)

target_sources(tinyobjloader PRIVATE
    tinyobjloader/tiny_obj_loader.h
    tinyobjloader/tiny_obj_loader.cc
    )

target_include_directories(tinyobjloader PUBLIC tinyobjloader)


add_library(sdl3 INTERFACE)
set(sdl3_DIR "SDL_PATH" CACHE PATH "Path to SDL3")

if (WIN32)
target_include_directories(sdl3 INTERFACE ${sdl3_DIR}/include ${sdl3_image_DIR}/include)
target_link_directories(sdl3 INTERFACE ${sdl3_DIR}/lib/x64 ${sdl3_image_DIR}/lib/x64)
elseif (UNIX)
target_include_directories(sdl3 INTERFACE ${sdl3_DIR}/include/SDL3 ${sdl3_image_DIR}/include/SDL3)
target_link_directories(sdl3 INTERFACE ${sdl3_DIR}/lib ${sdl3_image_DIR}/lib)
endif()

target_link_libraries(sdl3 INTERFACE SDL3)

add_library(imgui STATIC)

target_include_directories(imgui PUBLIC imgui)

target_sources(imgui PRIVATE
    imgui/imgui.h
    imgui/imgui.cpp

    imgui/imgui_demo.cpp
    imgui/imgui_draw.cpp
    imgui/imgui_widgets.cpp

    imgui/imgui_impl_vulkan.cpp
    imgui/imgui_impl_sdl3.cpp
    )

target_link_libraries(imgui PUBLIC Vulkan::Vulkan sdl3)

target_include_directories(stb_image INTERFACE stb_image)
