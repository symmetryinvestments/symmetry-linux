module symmetry.linux.random_name;
import symmetry.sildoc;

version(Posix):

string randomMajor()
{
	import std.random;
	auto rnd = MinstdRand0(42);
	auto ret = [
		"fool", "magician", "high-priestess", "empress", "emperor",
		"hierophant", "lovers", "chariot", "strength", "hermit",
		"wheel", "justice", "hanged-man", "death", "temperance",
		"devil", "tower", "star", "moon", "sun", "judgment", "world",
	].choice(rnd);
	return ret;
}


string randomMinor()
{
	import std.random;
	auto rnd = MinstdRand0(42);
	auto ret = [
			"two", "three", "four", "five", "six", "seven", "eight",
			"nine", "ten", "page", "knight", "queen", "king",
			"swords", "wands", "pentacles", "cups",
	].choice(rnd);
	return ret;
}

string randomName()
{
	import std.format : format;
	return format!"%s-%"(randomMajor(), randomMinor());
}
