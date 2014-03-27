#include "number.h"

class Polynomial {
   public:
      virtual Number operator() (const Number & num) const =0;
      friend Polynomial & operator+ (const Polynomial & sum1, const Polynomial & sum2);
};

class SimplePolynomial : public Polynomial {
   public:
      virtual Number operator() (const Number & num) const {
         return num;
      };
};

class SumPolynomial : public Polynomial {
   public:
      SumPolynomial (const Polynomial & part_1, const Polynomial & part_2) : part1(part_1), part2(part_2) { };
      virtual Number operator() (const Number & num) const {
         return part1(num) + part2(num);
      };
   private:
      const Polynomial & part1, & part2;
};

Polynomial & operator+ (const Polynomial & sum1, const Polynomial & sum2) {
   return *new SumPolynomial (sum1, sum2);
};
