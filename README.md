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

![Fally Screenshot](/Readme/image/input-file-location.png?raw=true "Fally Screenshot")

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
