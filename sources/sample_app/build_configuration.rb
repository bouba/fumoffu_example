configuration do |c|
  # The name for your resulting application file (e.g., if the project_name is 'foo' then you'll get foo.jar, foo.exe, etc.)
  # default value: "YourProjectName"
  #
  c.project_name = "SampleApp"

  # Undocumented option 'output_dir'
  # default value: "package"
  #
  c.output_dir = "dist"

  # The main ruby file to invoke, minus the .rb extension
  # default value: "main"
  #
  c.main_ruby_file = "app/main"

  # The fully-qualified name of the main Java file used to initiate the application.
  # default value: "org.rubyforge.rawr.Main"
  #
  #c.main_java_file = "org.rubyforge.rawr.Main"

  # A list of directories where source files reside
  # default value: ["src"]
  #
  c.source_dirs = ["src/ruby", "src/java","resources"]

  # A list of regexps of files to exclude
  # default value: []
  #
  #c.source_exclude_filter = []

  # Whether Ruby source files should be compiled into .class files
  # default value: true
  #
  #c.compile_ruby_files = true

  # A list of individual Java library files to include.
  # default value: []
  #
  c.java_lib_files = ["lib/java/generated/bundled_gems.jar", "lib/java/jruby-complete.jar", "lib/java/swing-layout.jar", "lib/java/AbsoluteLayout.jar"]

  # A list of directories for rawr to include . All files in the given directories get bundled up.
  # default value: ["lib/java"]
  #
  c.java_lib_dirs = []

  # Undocumented option 'files_to_copy'
  # default value: []
  #
  #c.files_to_copy = []

  # Undocumented option 'target_jvm_version'
  # default value: 1.6
  #
  #c.target_jvm_version = 1.6

  # Undocumented option 'jvm_arguments'
  # default value: ""
  #
  #c.jvm_arguments = ""

  # Undocumented option 'java_library_path'
  # default value: ""
  #
  #c.java_library_path = ""

  # Undocumented option 'extra_user_jars'
  # default value: {}
  #
  #c.extra_user_jars[:data] = { :directory => 'resources/medias',
  #                             :location_in_jar => 'medias'}
  #                               :exclude => /*.bak$/

  # Undocumented option 'mac_do_not_generate_plist'
  # default value: nil
  #
  #c.mac_do_not_generate_plist = nil

  # Undocumented option 'mac_icon_path'
  # default value: nil
  #
  #c.mac_icon_path = nil

  # Undocumented option 'windows_icon_path'
  # default value: nil
  #
  #c.windows_icon_path = nil

end
