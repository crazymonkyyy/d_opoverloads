struct foo{
	int i;
	int opBinary(string op:"+")(typeof(this) bar){
		return i+bar.i;}
}
unittest{
	foo a;
	foo b;
	int c=a+b;
}