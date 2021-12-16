# frozen_string_literal: true

require 'fileutils'

SWIFT_TEMPLATE_PATH = "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/MultiPlatform/Source/"
SWIFT_FILE_FOLDER = "Swift File.xctemplate"
SWIFT_COPYRIGHTS_FOLDER = "Copyright Swift File.xctemplate"
SWIFT_TEMPLATE_NAME = "___FILEBASENAME___.swift"

processes_containing_xcode_count = `ps aux | grep "/Applications/Xcode.app/Contents/MacOS/Xcode" | wc -l`.to_i

# we check if lower than 3 as two processes are spawned by the script 1 from grep itself second from calling grep with the shell command from this script
unless processes_containing_xcode_count < 3
  print "Please close Xcode before proceeding ❌"
  exit
end

print("Creating empty source file 🏗\n")

Dir.chdir SWIFT_TEMPLATE_PATH
Dir.mkdir SWIFT_COPYRIGHTS_FOLDER

FileUtils.cp_r("#{SWIFT_FILE_FOLDER}/.", SWIFT_COPYRIGHTS_FOLDER)

Dir.chdir SWIFT_FILE_FOLDER
File.open(SWIFT_TEMPLATE_NAME, 'w') { |file| file.write('import Foundation') }

print("Creation completed! Open Xcode and enjoy ✅\n")