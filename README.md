# Fally

Fally is an app designed for detecting
human falls especially for elder people.

When fall detected and you don’t press
an “Tap here if you're ok” button within the specify time,
Fally will automatically notify your family
for help.

** Make Fally be a part of your daily life to protect yourself and your loved one. **

## Screenshot
![Fally screenshot](/Readme/image/fally-screenshot.png?raw=true "Fally screenshot")

## Getting Started

### Prerequisites

This project requires the Xcode 8 and WatchOS 3.1<br>
See [this link](https://developer.apple.com/xcode/) for further details about Xcode

### Build and Run

Using Apple Watch's Simulator, Xcode built-in, to simulate this application

## How to run in Simulator
### Input file
Since Xcode simulator doesn't provide the feature which allow us to simulate CMDeviceMotion data directly, we'll use an input file to feed Fally mock up acceleration data; in x, y and z axises instead.<br>
An input file fed to Fally must be conform to the following pattern:

#### input_file_name.txt
```
,,acceleration_x_axis,acceleration_y_axis,acceleration_z_axis
,,acceleration_x_axis,acceleration_y_axis,acceleration_z_axis
,,acceleration_x_axis,acceleration_y_axis,acceleration_z_axis
...
```
**Note that** `,,` in front of each line cannot be omitted and all `acceleration_?_axis` is in G unit.<br>
:point_right: See example of input file [here](Fally WatchKit Extension/fall25.txt).

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

## Authors

* **Parinthorn Saithong** (@pirsquareff)
* **Sirinthra Chantharaj** (@sirinthra-cc)

## Citation

* Bogdan Kwolek, Michal Kepski, Human fall detection on embedded platform using depth maps and wireless accelerometer, Computer Methods and Programs in Biomedicine, Volume 117, Issue 3, December 2014, Pages 489-501, ISSN 0169-2607. [[Link]](http://home.agh.edu.pl/~bkw/research/pdf/2014/KwolekKepski_CMBP2014.pdf)

## Warning

Since main purpose of this application is to demonstrate human fall detection algorithm, most part of this application are **partially implemented**.

And we also know that we should promote such this important section to the top of this README.md :grinning:

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
