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
struct bar{
	string toString(){
		return "foo";}
}
unittest{
	import std;
	bar b;
	b.writeln;
}