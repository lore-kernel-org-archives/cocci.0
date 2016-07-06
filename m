From: Frederic.LEROY@b-com.com (=?iso-8859-1?Q?Fr=E9d=E9ric_LEROY_=28ext=29?=)
Date: Wed, 6 Jul 2016 13:54:41 +0000
Subject: [Cocci] Adding missing parameter to function if missing
Message-ID: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, 

I am new to coccinelle and I have trouble to use it.
What I want to do is add a missing parameter to a function call (bar)
and add this parameter to the function prototype calling it if missing.

Example : 

f1(void *arg) {
	bar(anything);
}

f2(my_type foo, void *arg) {
	bar(anything);
}

=> 

f1(my_type foo, void *arg) {
	bar (foo, anything);
}

f2(my_type foo, void *arg) {
	bar (foo, anything);
}

I tried several ways to do it without success. If I add a negative depends on rule, it won't work.

Here is the c test file :

--------8<--------8<--------8<--------8<--------8<
static void f1(void *args) {
    bar(anything);
}

static void f2(my_type *foo, void *args) {
    bar(anything);
}

static void f3(my_type *foo, void *args) {
}

static void f4(void *args) {
}

static void f5(void *args) {
    int b;
    bar(anything);
    b = 5;
    bar(anything);
}

static void f6(my_type *foo, void *args) {
    int b;
    bar(anything);
    b = 5;
    bar(anything);
}
--------8<--------8<--------8<--------8<--------8<

And here my spatch:

--------8<--------8<--------8<--------8<--------8<
@@
expression E;
@@

- bar(E);
+ bar(foo, E);

@fn_with_user@
identifier fn, foo;
typedef my_type;
parameter list pl;
expression E; 
@@

fn(my_type *foo, pl) {
<+... 
bar(foo, E);
...+> 
}

@ test depends on !fn_with_user@
identifier fn_with_user.fn;
parameter list pl;
expression E;
@@    

fn(
+ my_type *foo,
pl) {
<+...
bar(foo, E);
...+>
}
--------8<--------8<--------8<--------8<--------8<

Could you help me ?

Sincerely,

Fr?d?ric Leroy
