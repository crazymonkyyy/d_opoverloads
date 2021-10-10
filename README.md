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

// todo cover 1 d indexing treating opslice as a first class citizen

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
You can optionally define, back, popBack, opIndex(see above), save, moveFront

//todo, explain the basics, but not the hierarchy or go to far down the rabbit hole

## foo.writeln

toString

## bar[foo]

toHash

## bar = foo

alias this

## foo.bar

opDispatch