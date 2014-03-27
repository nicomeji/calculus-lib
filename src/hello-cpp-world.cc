#include <iostream>
#include "polynomiun.h"

/*
Mi idea es desarrollar una librería que me permita, utilizando sus definiciones,
escribir funciones matemáticas.
Un ejemplo sería, poder escribir algo con la siguiente forma:
   f(x)=sin(x)
   g(x)=x^2
   h(x)=f(x)+g(x)
   cout << "h(x)=" << h(x) << endl;
   cout << "h(0)=" << h(0) << endl;
Entonces, esperaría la siguiente salida:
h(x)=sin(x)+x^2
h(0)=0
*/

int main() {
   const Polynomial &a = SimplePolynomial();
//   auto b = SimplePolynomial();
//   a = a+b;
   std::cout << a(1) << std::endl;
   std::cout << "Hello World!" << std::endl;
}
