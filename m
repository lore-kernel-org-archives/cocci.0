From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 8 May 2015 16:23:42 +0200
Subject: [Cocci] disjoint rule problem
Message-ID: <20150508142342.GA32286@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi all !

Trying to do type checking on calls within functions and
ran into the problem that I'm unable to create disjoint rules for
those functions that assigne their return value to a variable and
those that do not. The reason why this is need (I think atleast) 
is because in the first rule the assignment 
  T2 << match.T2 
would not apply to baz and boo in the test-case and thus they are not
processes.

/* simple test-case for type.cocci */
#include <stdio.h>
int foo(void) { return printf("Hello"); }
int bar(char *msg) { return printf(msg); }
long baz(void) { return printf("\n"); }
void boo(char *msg) { return printf(msg); }

int main(int argc, char **argv) {
	int ret;
        unsigned int ret2;
	ret = foo();	/* match1 */
	ret2 = bar(".");/* match1 */
	baz();          /* match2 */
	boo("\n");	/* match2 */
	return 0;
}
<snip>

and my type.cocci attempt

<snip>
virtual org
virtual report

/* match calls that assignment a return */
@match1@
type T1,T2;
idexpression T1 call;
idexpression T2 ret;
identifier f;
position p0,p1;
@@

f at p0(...) {
<+...
(
* ret = call at p1()
|
* ret = call@p1(...)
)
...+>
}

/* match those that do not assignment a return */
@match2@
type T1;
idexpression T1 call;
identifier f;
position p0,p1;
@@

f at p0(...) {
<+...
(
* call at p1(...)
|
* call@p1()
)
...+>
}

@script:python match1_org depends on match1@
p0 << match1.p0;
p1 << match1.p1;
fn << match1.f;
call << match1.call;
T1 << match1.T1;
T2 << match1.T2;
@@
print "%s %s %s (%s:%s)" % (call, T1, T2, fn, p1[0].line)

@script:python match2_org depends on match2@
p0 << match2.p0;
p1 << match2.p1;
fn << match2.f;
call << match2.call;
T1 << match2.T1;
@@
print "%s %s %s (%s:%s)" % (call, T1, "NA", fn, p1[0].line)
<snip>

Unfortunately I'm too stupid to come up with rules that would
really differenciate between those calls with and those without
an assignement to a return value - some obviously match both
rules ...

hofrat at debian:/tmp$ spatch --sp-file type.cocci  hello.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: hello.c
     (ONCE) already tagged but only removed, so safe
foo int ( void ) int (main:11)
bar int ( char * msg ) unsigned int (main:12)
boo void ( char * msg ) NA (main:14)
foo int ( void ) NA (main:11)
bar int ( char * msg ) NA (main:12)
baz long ( void ) NA (main:13)
diff = 
--- hello.c
+++ /tmp/cocci-output-25231-e59ede-hello.c
@@ -8,9 +8,5 @@ void boo(char *msg) { return printf(msg)
 int main(int argc, char **argv) {
        int ret;
        unsigned int ret2;
-       ret = foo();
-       ret2 = bar("world");
-       baz();
-       boo("\n");
        return 0;
 }


match1 seems to be ok - but match2 is too generic how can it be
restricted ?
hope its not too obviouls what Im overlooking but Im stuck...again...

thx!
hofrat
