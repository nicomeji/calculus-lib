#ifndef PARSER_H_
#define PARSER_H_

#include <string>
#include <map>

using std::map;
using std::string;

namespace Parser {
bool surrounded_by(const string& s, char left, char right);
void strip(string& s);
}
#endif
