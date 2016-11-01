#!/usr/bin/env bash
# adapted from https://github.com/vapor/swift/blob/master/ci

echo "Hypertext Continuous Integration";

UBUNTU_RELEASE=`lsb_release -a 2>/dev/null`;
if [[ $UBUNTU_RELEASE == *"15.10"* ]];
then
    OS="ubuntu1510";
else
    OS="ubuntu1404";
fi

echo "Installing Dependencies"
sudo apt-get install -y clang libicu-dev uuid-dev

echo "Installing Swift";
if [[ $OS == "ubuntu1510" ]];
then
    SWIFTFILE="swift-3.0-RELEASE-ubuntu15.10";
else
    SWIFTFILE="swift-3.0-RELEASE-ubuntu14.04";
fi
wget https://swift.org/builds/swift-3.0-release/$OS/swift-3.0-RELEASE/$SWIFTFILE.tar.gz
tar -zxf $SWIFTFILE.tar.gz
export PATH=$PWD/$SWIFTFILE/usr/bin:"${PATH}"

echo "Version: `swift --version`";

echo "Building";
swift build
if [[ $? != 0 ]];
then
    echo "Build failed";
    exit 1;
fi

echo "🔎 Testing";

swift test
if [[ $? != 0 ]];
then
    echo "Tests failed";
    exit 1;
fi

echo "Done."
