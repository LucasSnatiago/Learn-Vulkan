﻿// vulkan_guide.h : Include file for standard system include files,
// or project specific include files.

#pragma once

#include <vk_types.h>

namespace vkinit {
	//vulkan init code goes here
	VkCommandPoolCreateInfo command_pool_create_info(uint32_t queueFamilyIndex,
    	VkCommandPoolCreateFlags flags /*= 0*/);

	VkCommandBufferAllocateInfo command_buffer_allocate_info(
    	VkCommandPool pool, uint32_t count /*= 1*/);
}
