require 'json'

package = package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
s.name                = package['name']
s.version             = "1.0"
s.summary             = package['description']

s.homepage            = "https://github.com/cnjon/react-native-pdf-view"
s.license             = package['license']
s.author              = "cnjon"
s.source              = { :git => "git@git.github.com/cnjon/react-native-pdf-view"}
s.requires_arc        = true
s.platform            = :ios, "9.0"
s.preserve_paths      = "*.framework"
s.source_files        = 'RNPDFView/**/*.{h,m}'

end
