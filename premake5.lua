workspace "DllProject"
	architecture "x64"
	startproject "Application"
	configurations { "Debug", "Release" }

project "Application"
	location "Application"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	systemversion "latest"

	dependson { "Library" } 

	targetdir "Bin/Application/%{cfg.buildcfg}/%{cfg.platform}"
	objdir "Bin/Intermediate/Application/%{cfg.buildcfg}/%{cfg.platform}"

	files
	{
		"%{prj.name}/include/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/include"	
	}
	
	externalincludedirs
	{
		"%{prj.name}/../Library/include"
	}

	libdirs
	{
		"Bin/Library/%{cfg.buildcfg}/%{cfg.platform}"
	}

	links
	{
		"Library.lib"
	}

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"
		runtime "Debug"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		runtime "Release"
		
		
project "Library"
	location "Library"
	kind "SharedLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"
	systemversion "latest"
	
	targetdir "Bin/Library/%{cfg.buildcfg}/%{cfg.platform}"
	objdir "Bin/Intermediate/Library/%{cfg.buildcfg}/%{cfg.platform}"
	
	files
	{
		"%{prj.name}/include/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/include",
	}

	postbuildcommands
	{
		"{MKDIR} \"%{wks.location}Bin/Application/%{cfg.buildcfg}/%{cfg.platform}\"",
		"{COPYFILE} \"%{wks.location}Bin/Library/%{cfg.buildcfg}/%{cfg.platform}/%{cfg.buildtarget.basename}%{cfg.buildtarget.extension}\" \"%{wks.location}Bin/Application/%{cfg.buildcfg}/%{cfg.platform}\""
	}

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"
		runtime "Debug"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		runtime "Release"