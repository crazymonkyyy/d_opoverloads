## ++foo

The "unary" operators are: -, +, ~, *, ++. --
```d
int opUnary(string op:"++")(){//++foo.i
	i=i+1;
	return i;
}
```

```d
auto opUnary(string op)(){
	return mixin(op~"package;");}
```

## foo + bar

The binary operators are:+, -, *, /, %, ^^, &, |, ^, <<, >>, >>>, ~, in

```d
int opBinary(string op:"+")(typeof(this) bar){
	return i+bar.i;}
```

```d
auto opBinary(string op,T)(T bar){
	return mixin("i"~"bar.i");}
```

note opBinaryRight exists. Which is helpful for dealing with types you dont control but a headache that should be avoided if possible.

See trianry for an example of implimenting several operators over several types.

## foo < bar

The two comparision functions are opEquals and opCmp; opCmp should return an int thats -1,0, or 1. (no there isn't much flexablity there)

There is no opCmp defined for base types, meaning you must manually recreate the logic

```d
bool opEqual(typeof(this) bar){
	return i==bar;}

int opCmp(typeof(this) bar){
	int opcmp(T)(T a,T b){
		if(a>b){return 1;}
		if(a==b){return 0;}
		return -1;
	}
	return i.opcmp(bar.i);
}
```

## foo = bar

//todo

## this

//todo

## foo[]

```d
struct foo{
	auto opIndex(){}            //foo[]
	auto opIndex(int i){}       //foo[1]
	auto opSlice(int i, int j){}//foo[1..10]
	auto opIndex(int i, int j){}//foo[1,2]
	auto opIndex(string s){}    //foo["bar"]
	auto opDollar(){return length;}
}
```

These functions are fairly flexable, and simple things that should be possible likely are once you figure out the vocab. opDollar can return a "dollar" object that you then use as an index.

Defining opDollars as however you calculate length inables statements like `foo[i%$]`, or as a specail dollar object(with its own opoverloads) allows `foo[$-3]` going 3 nodes back from the end in a doubly linked list.

```d
struct linkedlist{
	struct dollar{
		auto opBinary(){}
	}
	dollar opDollar(){ return dollar();}
	opIndex(int i){}
	opIndex(dollar i){}
}
```

The index can be anything, (but should be int ~~or size_t~~ for simple indexs) including key types for custom aa arrays.

```d
struct myaa(K,V){
	V opIndex(K a){}
}
```

See the offical spec for exterme multidementional slicing.

## foo[]=bar

// .... Im actaully not sure ive used slice assigns, only a simple index

## foo.map

Ranges start with defining three functions: front, popFront, empty as follows

```d
struct myrange{
	int start;
	int end;
	int front(){return start;}
	int popFront(){start++;}
	bool empty(){return start==end;}
}
```
You can optionally define, back, popBack, opIndex(see "foo[]" above), save, moveFront.//todo check for others

Afterwords you should in thoery be able to use std.algorithium

//todo, explain the basics, but not the hierarchy or go to far down the rabbit hole

## foo.writeln

```d
string toString(){
	return "foo";}
```

toString is techincally part of object.d, but you can overload it easily enough and this overload is always(/almost?) used when the std wants a string from an object, and probaly should be used when writting your own print code.

## bar[foo]

toHash

## bar = foo

```d
struct nullable(T){
	T payload;
	bool isnull=true;
	void opAssign(T foo){
		payload=foo; isnull=false;}
	alias payload this;
}
```

"alias this", allows a type to implictly return anything else when ever it fails to compile the first way. And it nice for thin wrappers around most types.

However, it can be unpredictable if you overuse it, many bugs come from the wrong opoverload being called because the compiler prefered a different path of alias this and templates then what you intented.

## foo.bar

opDispatch

## to 

//can I consider to to be an operator? how does it play with std.conv in other poeples code?