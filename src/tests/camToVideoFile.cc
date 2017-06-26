// OpenCV accessing video camera and saving the result
#include <iostream>
#include <opencv2/opencv.hpp>
#include <unistd.h>
#include <thread>

#define EXIT_TOKEN  'q'
char c = 0;

void getChar(){
	while(c != EXIT_TOKEN) {
		std::this_thread::sleep_for (std::chrono::milliseconds(150));
		std::cin >> c;
	}
}

void camToVideoFile() {
    // Open the first camera attached to your computer
    cv::VideoCapture cap(0);
    if(!cap.isOpened()) {
        std::cout << "Unable to open the camera\n";
        std::exit(-1);
    }

    cv::Mat image;
    double FPS = 10.0;

    // Get the width/height of the camera frames
    int width = static_cast<int>(cap.get(CV_CAP_PROP_FRAME_WIDTH));
    int height = static_cast<int>(cap.get(CV_CAP_PROP_FRAME_HEIGHT));

    // Open a video file for writing (the MP4V codec works on OS X and Windows)
    cv::VideoWriter out("output.mov", CV_FOURCC('m','p', '4', 'v'), FPS, cv::Size(width, height));
    if(!out.isOpened()) {
        std::cout <<"Error! Unable to open video file for output." << std::endl;
        std::exit(-1);
    }

    std::thread first(getChar);

    while(true) {
        cap >> image;
        if(image.empty()) {
            std::cout << "Can't read frames from your camera\n";
            break;
        }

        // Save frame to video
        out << image;

        cv::imshow("Camera feed", image);

//        std::cout << "Voy a dormir";
//        usleep(10000);
//        std::cout << "Listo";
        // Stop the camera if the user presses the "ESC" key
        cv::waitKey(1000.0/FPS);

        if(c == EXIT_TOKEN) {
        	return;
        }
        if(c != 0) {
        	std::cout << "Key pressed: " << c << std::endl;
        	c = 0;
        }
    }
    first.join();
    std::cout << "DONE";
}
