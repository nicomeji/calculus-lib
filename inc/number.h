#include <iostream>

class Number {
   public:
      Number (int number = 0) {
         std::cout << "Creating Number " << this << std::endl;
         this->number=number;
      };
      Number (const Number & number) : Number (number.number) {
         std::cout << "Copying Number " << &number;
         std::cout << " into " << this << std::endl;
      };
      ~Number (void) {
         std::cout << "Destroying Number " << this << std::endl;
      };
      Number operator- (const Number & num) const {
         return this->number-num.number;
      };
      Number operator+ (const Number & num) const {
         return this->number+num.number;
      };
      Number operator* (const Number & num) const {
         return this->number*num.number;
      };
      Number operator/ (const Number & num) const {
         return this->number/num.number;
      };
      friend std::ostream & operator<< (std::ostream & o, const Number & num);
   private:
      int number;
};

std::ostream & operator<< (std::ostream & o, const Number & num) {
   return o << num.number;
};
