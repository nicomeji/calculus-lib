#include <cv.h>
#include <highgui.h>
#include <iostream>
#include <string>
#include <sstream>

using namespace cv;
using namespace std;

int my_main() {

	Mat image;
	string imagePath = "";
	getline(cin, imagePath);
	image = imread(imagePath, CV_LOAD_IMAGE_UNCHANGED);   // Read the file

	if (!image.data)                              // Check for invalid input
	{
		cout << "Could not open or find the image" << endl;
		return -1;
	}

	namedWindow("Display window", CV_WINDOW_AUTOSIZE); // Create a window for display.
	imshow("Display window", image);                // Show our image inside it.

	waitKey(0);

	return 0;
}
