find_package(Vulkan REQUIRED)

add_library(vkbootstrap STATIC)
add_library(glm INTERFACE)
add_library(vma INTERFACE)
add_library(stb_image INTERFACE)
add_library(tinyobjloader STATIC)
add_library(vulkan-headers INTERFACE)
add_library(sdl3 INTERFACE)
add_library(sdl3_image INTERFACE)

add_subdirectory(fmt)
add_subdirectory(SDL)
add_subdirectory(SDL_image)

target_include_directories(vulkan-headers INTERFACE vulkan-headers)
target_include_directories(vma INTERFACE vma)
target_include_directories(glm INTERFACE glm)

target_sources(tinyobjloader PRIVATE
    tinyobjloader/tiny_obj_loader.h
    tinyobjloader/tiny_obj_loader.cc
)
target_include_directories(tinyobjloader PUBLIC tinyobjloader)

target_link_libraries(sdl3 INTERFACE SDL3)
target_link_libraries(sdl3_image INTERFACE SDL3_image)

target_link_directories(sdl3 INTERFACE ${SDL3_BINARY_DIR})

target_link_libraries(sdl3 INTERFACE SDL3::SDL3-shared)

# Configuração do ImGui
add_library(imgui STATIC)
target_sources(imgui PRIVATE
    imgui/imgui.h
    imgui/imgui.cpp
    imgui/imgui_demo.cpp
    imgui/imgui_draw.cpp
    imgui/imgui_widgets.cpp
    imgui/imgui_impl_vulkan.cpp
    imgui/imgui_impl_sdl3.cpp
)
target_include_directories(imgui PUBLIC imgui)
target_link_libraries(imgui PUBLIC Vulkan::Vulkan sdl3)

# Configuração de stb_image
target_include_directories(stb_image INTERFACE stb_image)

target_sources(vkbootstrap PRIVATE
    vkbootstrap/VkBootstrap.h
    vkbootstrap/VkBootstrapDispatch.h
    vkbootstrap/VkBootstrap.cpp
)
target_include_directories(vkbootstrap PUBLIC vkbootstrap)
target_link_libraries(vkbootstrap PUBLIC Vulkan::Vulkan)
