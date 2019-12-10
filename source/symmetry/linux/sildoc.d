module symmetry.linux.sildoc;
version(Posix):

version(SILdoc) {} else
{
	struct SILdoc
	{
		string value;
	}
}

