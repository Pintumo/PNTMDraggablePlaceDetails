#  Be sure to run `pod spec lint PNTMDraggablePlaceDetails.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.

Pod::Spec.new do |s|
  s.name               = "PNTMDraggablePlaceDetails"
  s.swift_version      = "4.2"
  s.version            = "0.2.0"
  s.summary            = "Simple Library to display details of POIs."
  s.description        = "Simple Library to display details of POIs in a draggable modally presented UIViewController."
  s.homepage           = "https://github.com/Pintumo/PNTMDraggablePlaceDetails"
  s.license            = "MIT"
  s.author             = { "3vangelos" => "evangelos@posteo.eu" }
  s.social_media_url   = "http://twitter.com/3vangelos"
  s.platform           = :ios, "11.0"
  s.source             = { :git => "https://github.com/Pintumo/PNTMDraggablePlaceDetails.git", :tag => "#{s.version}" }
  s.source_files  = "PNTMDraggablePlaceDetails", "PNTMDraggablePlaceDetails/**/*.swift"
  s.public_header_files = "PNTMDraggablePlaceDetails/**/*.h"
  s.resources           = "PNTMDraggablePlaceDetails/**/*.xcassets", "PNTMDraggablePlaceDetails/**/*.lproj/*.strings"
  # s.frameworks         = "SomeFramework", "AnotherFramework"
  s.dependency "FlexiblePageControl"
  s.dependency "Kingfisher"
end
