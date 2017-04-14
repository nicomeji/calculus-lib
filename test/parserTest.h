#include <cxxtest/TestSuite.h>
#include "parser.h"
using std::string;

class ParserTestSuite: public CxxTest::TestSuite {
public:
	void testStrip() {
		string s = " strip me  ";
		Parser::strip(s);
		TS_ASSERT_EQUALS(s, "strip me");
	}
	void testNoStrip() {
		string s = "don't  strip me", s1 = s;
		Parser::strip(s);
		TS_ASSERT_EQUALS(s, s1);
	}
	void testStripLeft() {
		string s = "  left strip me";
		Parser::strip(s);
		TS_ASSERT_EQUALS(s, "left strip me");
	}
	void testStripRight() {
		string s = "right strip me  ";
		Parser::strip(s);
		TS_ASSERT_EQUALS(s, "right strip me");
	}

	void testSurrondedBy() {
		const string s = "?am I surronded by questionmarks?";
		TS_ASSERT(Parser::surrounded_by(s, '?', '?'));
	}
	void testNotSurroundedBy() {
		const string s = "I'm the authority";
		TS_ASSERT(!Parser::surrounded_by(s, ' ', ' '));
	}
	void testLeftOnlySurrondedBy() {
		const string s = "?Left yes but right no.";
		TS_ASSERT(!Parser::surrounded_by(s, '?', '!'));
	}
	void testRightOnlySurroundedBy() {
		const string s = "Left no but right yes!";
		TS_ASSERT(!Parser::surrounded_by(s, '?', '!'));
	}
	void testNotSurroundedByNullChar() {
		const string s = "Am I terminated by a null char? Are we all?";
		TS_ASSERT(!Parser::surrounded_by(s, 'A', 0));
	}
	void testCStringNotSurroundedByNullChar() {
		TS_ASSERT(!Parser::surrounded_by("A C string", 'A', 0));
	}
	void testCStringSurroundedBy() {
		TS_ASSERT(Parser::surrounded_by("! Yes !", '!', '!'));
	}
};
