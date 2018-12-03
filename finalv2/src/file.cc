#include <iostream>
#include <map>

using namespace std;

class file{
  private:
    map<string, string> functions;
    map<string, string> attributes;

  public:
    bool functions_add(string name) {
      functions[name] = name;
      return true;
    }
    bool functions_del(string name) {
      functions.erase(name);
      return true;
    }
};
