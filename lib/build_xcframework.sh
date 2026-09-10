# https://medium.com/strava-engineering/convert-a-universal-fat-framework-to-an-xcframework-39e33b7bd861
mkdir -p build/iphoneos
mkdir -p build/iphonesimulator

# Copy framework into the platform specific directories
cp -R RoxSdk/ROXCore.framework/ build/iphoneos/ROXCore.framework
cp -R RoxSdk/ROXCore.framework/ build/iphonesimulator/ROXCore.framework

# Look at the architectures in the original binary
xcrun lipo -i RoxSdk/ROXCore.framework/ROXCore

# Remove slices that aren't relevant to the device slice of the xcframework
xcrun lipo -remove i386 -remove x86_64 -remove armv7 ./build/iphoneos/ROXCore.framework/ROXCore -o ./build/iphoneos/ROXCore.framework/ROXCore

# Confirm the binary has the proper (arm64) slice
xcrun lipo -i build/iphoneos/ROXCore.framework/ROXCore

# Remove slices that aren't relevant to the simulator slice of the xcframework
xcrun lipo -remove i386 -remove arm64 -remove armv7 ./build/iphonesimulator/ROXCore.framework/ROXCore -o ./build/iphonesimulator/ROXCore.framework/ROXCore

# Confirm the binary has the proper (x86_64) slice.
xcrun lipo -i build/iphonesimulator/ROXCore.framework/ROXCore

# Create xcframework from the platform slices
xcodebuild -create-xcframework -framework build/iphoneos/ROXCore.framework/ -framework build/iphonesimulator/ROXCore.framework/ -output "ROXCore.xcframework"

rm -rf build
