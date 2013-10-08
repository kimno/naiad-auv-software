#include "processing_wrap.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <vector>

std::vector<cv::Mat> img;

void appendImg_Wrap(char * src)
{
  img.push_back(cv::imread(src));
}

void cvtColor_Wrap(int src, int dst, int filter)
{
  cv::cvtColor(img.at(src), img.at(dst), filter);
}

void Canny_Wrap(int src, int dst, int lThresh, int hThresh, int kernelSize)
{

  printf("im here now yeahhhhhh");
  cv::Canny(img.at(src), img.at(dst), lThresh, hThresh, kernelSize);
  printf("unfortunately il never be here !!");
}

void imread_Wrap(char * name)
{
  cv::imread(name);
}

int imwrite_Wrap(char * name, int src)
{
  if (cv::imwrite(name, img.at(src)))
    return 1;
  else
    return 0;
}

void imshow_Wrap(char * name, int src)
{
  cv::imshow(name, img.at(src));
}

void waitKey_Wrap(void)
{
  cv::waitKey(0);
}

int size_Wrap(void)
{
   return img.size();
}