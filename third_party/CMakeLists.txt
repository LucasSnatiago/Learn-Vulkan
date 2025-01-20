include(FetchContent)
set(FETCHCONTENT_QUIET FALSE)

find_package(Vulkan REQUIRED)

add_library(vkbootstrap STATIC)
add_library(glm INTERFACE)
add_library(vma INTERFACE)
add_library(stb_image INTERFACE)
add_library(tinyobjloader STATIC)

# Configuração de vkbootstrap
target_sources(vkbootstrap PRIVATE
    vkbootstrap/VkBootstrap.h
    vkbootstrap/VkBootstrap.cpp
)
target_include_directories(vkbootstrap PUBLIC vkbootstrap)
target_link_libraries(vkbootstrap PUBLIC Vulkan::Vulkan $<$<BOOL:UNIX>:${CMAKE_DL_LIBS}>)

# Configuração de glm e vma
target_include_directories(vma INTERFACE vma)
target_include_directories(glm INTERFACE glm)

# Configuração de tinyobjloader
target_sources(tinyobjloader PRIVATE
    tinyobjloader/tiny_obj_loader.h
    tinyobjloader/tiny_obj_loader.cc
)
target_include_directories(tinyobjloader PUBLIC tinyobjloader)

# Configuração do FetchContent para SDL3 e SDL3_image
FetchContent_Declare(
    SDL3
    GIT_REPOSITORY https://github.com/libsdl-org/SDL
    GIT_TAG prerelease-3.1.10
    GIT_PROGRESS TRUE
)
FetchContent_Declare(
    SDL3_IMAGE
    GIT_REPOSITORY https://github.com/libsdl-org/SDL_image
    GIT_TAG preview-3.1.0
    GIT_PROGRESS TRUE
)
FetchContent_MakeAvailable(SDL3 SDL3_IMAGE)

# Configuração de SDL3
add_library(sdl3 INTERFACE)
target_include_directories(sdl3 INTERFACE ${sdl3_SOURCE_DIR}/include)
target_link_libraries(sdl3 INTERFACE SDL3)

# Configuração de SDL3_image
add_library(sdl3_image INTERFACE)
target_include_directories(sdl3_image INTERFACE ${sdl3_image_SOURCE_DIR})
target_link_libraries(sdl3_image INTERFACE SDL3_image)

# Adicionando diretório de link para SDL3
target_link_directories(sdl3 INTERFACE ${SDL3_BINARY_DIR})

# Linkando a biblioteca compartilhada SDL3
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
