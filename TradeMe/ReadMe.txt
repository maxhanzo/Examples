Requisites: Carthage

This project makes use of AFNetworking via Carthage. For more information on how to install Cartague: https://github.com/Carthage/Carthage

Once Carthage is installed, please follow these steps:

On the terminal, and at the project's root folder, run these commands:
    carthage update --platform iOS

After the dependencies are updated:
    open Carthage

This will open the finder window and will show these folders: Build and Checkouts.

Next, follow these steps in this animated gif: http://www.raywenderlich.com/wp-content/uploads/2015/06/carthage-settings.gif
but choosing AFNetworking.framework & dragging it to the Linked Frameworks and Libraries section in XCode (On the project navigator's root).

The Run Script on the "Build Phases" section should be there. If not. please add a new Run Script:
    /usr/local/bin/carthage copy-frameworks

The input files should be like this:
    $(SRCROOT)/Carthage/Build/iOS/AFNetworking.framework

