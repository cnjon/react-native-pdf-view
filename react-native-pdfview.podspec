require 'json'

package = package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
s.name                = package['name']
s.version             = "1.0.2"
s.summary             = package['description']
s.description         = <<-DESC
React Native apps are built using the React JS
framework, and render directly to native UIKit
elements using a fully asynchronous architecture.
There is no browser and no HTML. We have picked what
we think is the best set of features from these and
other technologies to build what we hope to become
the best product development framework available,
with an emphasis on iteration speed, developer
delight, continuity of technology, and absolutely
beautiful and fast products with no compromises in
quality or capability.
DESC
s.homepage            = "https://github.com/cnjon/react-native-touch-id"
s.license             = package['license']
s.author              = "Jianglei"
s.source              = { :git => "git@git.github.com/cnjon/react-native-pdf-view"}
s.requires_arc        = true
s.platform            = :ios, "9.0"
s.preserve_paths      = "*.framework"
s.source_files        = 'RNPDFView/**/*.{h,m}'

end
