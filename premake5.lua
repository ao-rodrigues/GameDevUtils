workspace "GameDevUtils"
	architecture "x64"
	configurations {
		"Debug",
		"Release"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "GameDevUtils"
	location "GameDevUtils"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("obj/" .. outputdir .. "/%{prj.name}")

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs {
		"%{prj.name}/src",
	}

	buildoptions { "/W3", "/MP" }
	flags { "MultiProcessorCompile" }

	filter "system:windows"
		systemversion "latest"
		characterset "MBCS"

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "on"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "on"

	filter { "system:windows", "configurations:Debug" }
		buildoptions "/MTd"

	filter { "system:windows", "configurations:Release" }
		buildoptions "/MT"