#include <iostream>
#include <cmath>
#include <fstream>
#include <iomanip>
#include <limits>

//  Функция для вычисления значения функции U(r; De, ke, re)
double calculateU(double r, double De, double ke, double re) {
 double a = sqrt(ke / (2 * De));
 return De * pow((1 - exp(-a * (r - re))), 2);
}

int main(int argc, char* argv[]) {
 if (argc != 4) {
 std::cout << "Usage: ./calc a b N" << std::endl;
 return 1;
 }

 double a = std::stod(argv[1]);
 double b = std::stod(argv[2]);
 int N = std::stoi(argv[3]);

 double h = (b - a) / 1000.0;

 std::cout << "Enter " << N << " values of z:" << std::endl;

 std::ofstream output_files[N];
 double min_y = std::numeric_limits<double>::max();
 double max_y = std::numeric_limits<double>::min();

 for (int i = 0; i < N; i++) {
 double z;
 std::cin >> z;

 std::string filename = std::to_string(i + 1) + ".txt";
 output_files[i].open(filename);

 output_files[i] << "#z = " << z << std::endl;
 output_files[i] << std::setw(8) << "a" << std::setw(12) << "y(a;z)" << std::endl;

 for (double x = a; x <= b; x += h) {
 double y = calculateU(x, z, z, z);

 output_files[i] << std::setw(8) << x << std::setw(12) << y << std::endl;

 min_y = std::min(min_y, y);
 max_y = std::max(max_y, y);
 }

 output_files[i].close();
 }

 std::cout << "m = " << min_y << std::endl;
 std::cout << "M = " << max_y << std::endl;

 return 0;
}
