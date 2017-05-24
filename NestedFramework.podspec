Pod::Spec.new do |s|

    s.name         = 'NestedFramework'
    s.version      = '1.0.0'
    s.summary      = 'McDonald SDK for iOS.'

    s.description  = 'The McDonald SDK for iOS provides a library, and a collection of selectable features that can be used to make apps with selected features'

    s.homepage     = 'htps://www.mcdonalds.com'
    s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }

    s.author       = { 'McDonalds' => 'Sapient' }
    s.platform     = :ios, '9.0'
    s.source       = { :git => 'https://github.com/Shwethamugeraya/NestedFramework.git',
                       :tag => s.version}
    s.requires_arc = true
    s.dependency 'FBSDKCoreKit', '4.22.0'
    s.dependency 'FBSDKLoginKit', '4.22.0'
    s.source_files = 'NestedFramework/src/**/*.swift'

end