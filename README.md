# Fally

Fally is an app designed for detecting
human falls especially for elder people.

When fall detected and you don’t press
an “Tap here if you're ok” button within the specify time,
Fally will automatically notify your family
for help.

## Screenshot
![Fally Screenshot](/Readme/image/fally-screenshot.png?raw=true "Fally Screenshot")

## Getting Started

### Prerequisites

This project requires the Xcode 8 and WatchOS 3.1<br>
See [this link](https://developer.apple.com/xcode/) for further details about Xcode

### Build and Run

Using Apple Watch's Simulator, Xcode built-in, to simulate this application

## How to run in Simulator
### Input file
Since Xcode simulator doesn't provide the feature which allow us to simulute CMDeviceMotion data directly, we'll use an input file to feed Fally mock up acceleration data; in x, y and z axises instead.<br>
An input file fed to Fally must be conform to the following pattern:

#### input_file_name.txt
```
,,acceleration_x_axis,acceleration_y_axis,acceleration_z_axis
,,acceleration_x_axis,acceleration_y_axis,acceleration_z_axis
,,acceleration_x_axis,acceleration_y_axis,acceleration_z_axis
...
```
Note that `,,` in front of each line cannot be omitted and all `acceleration_?_axis` is in G unit.

Then, add all input files under ```Fally Watchkit Extension``` group in Xcode.

![Input file location](/Readme/image/input-file-location.png?raw=true "Input file location")

### Include your Input File in Simulator Scheme
Select ```Edit Scheme...``` from build panel as seen in an image below.

![Edit scheme](/Readme/image/edit-scheme.png?raw=true "Edit scheme")

Then, select ```Arguments``` and under ```Environment Variables```edit ```input``` value to match your input file name without file extension.

![Input value](/Readme/image/input-value.png?raw=true "Input value")

### Run in Simulator
Eventually, your app is ready to run. Make sure that ```Fally WatchKit App``` Scheme is selected before clicking ```Build and then run the current scheme```.

![Select scheme](/Readme/image/select-scheme.png?raw=true "Select scheme")

![Build and then run](/Readme/image/build-and-then-run.png?raw=true "Build and then run")

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
