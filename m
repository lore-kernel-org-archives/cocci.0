From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 17 Feb 2015 16:50:55 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.02.1502172131100.2306@localhost6.localdomain6>
References: <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
 <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
 <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
 <alpine.DEB.2.02.1502170754400.2079@localhost6.localdomain6>
 <cce01af047524475b08dcc21781ce23f@BL2FFO11FD010.protection.gbl>
 <alpine.DEB.2.02.1502172131100.2306@localhost6.localdomain6>
Message-ID: <dfc5063b5e46486fb5daa3c906464e80@BY2FFO11FD042.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2015-02-17 at 09:31PM +0100, Julia Lawall wrote:
> On Tue, 17 Feb 2015, S?ren Brinkmann wrote:
> 
> > On Tue, 2015-02-17 at 07:56AM +0100, Julia Lawall wrote:
> > > Another patch is below.  With this the code parses, and the transformation 
> > > can be made.  However, it considers this to be a duplicate const 
> > > annotation, so I'm not sure that the const is being associated in the 
> > > right way by the parser.
> > 
> > I applied the patch. I do see the mentioned warning now:
> >   Warning: PARSING: duplicate 'const'; value = [1]
> > 
> > The replacement still doesn't happen though. I'm not sure whether I
> > need another rule to catch these declarations. But I think I will
> > just make people fix their code. I think having 'const' appear twice
> > is not right, despite it being parseable.
> 
> Could you send a complete example?  It worked in the example I tried.

Sure. Please fine a test c file and my cocci patch (which grew a bit)
attached. This is the diff I get:
  init_defs_builtins: /usr/local/share/coccinelle/standard.h
  HANDLING: testcase4.c
  diff = 
  --- testcase4.c
  +++ /tmp/cocci-output-7912-c5f1e0-testcase4.c
  @@ -1,21 +1,21 @@
   
  -typedef struct foo {
  +struct foo {
   	int member;
  -} foo_t;
  +};
   
  -static foo_t foo;
  -static const foo_t stco_foo;
  +static struct foo foo;
  +static const struct foo stco_foo;
   const foo_t const co_foo_co;
   static const foo_t const stco_foo_co;
   static const foo_t const stco_foo_coarr[] = {
   };
   
  -typedef struct {
  +struct bar {
   	int member;
  -} bar_t;
  +};
   
  -static bar_t bar;
  -static const bar_t stco_bar;
  +static struct bar bar;
  +static const struct bar stco_bar;
   const bar_t const co_bar_co;
   static const bar_t const stco_bar_co;
   static const bar_t const stco_bar_coarr[] = {

	Thanks,
	S?ren
-------------- next part --------------
A non-text attachment was scrubbed...
Name: testcase4.c
Type: text/x-csrc
Size: 412 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150217/17db5dc0/attachment.bin>
-------------- next part --------------
/* Convert typdefed structs to structs */

/* Convert typdef to struct declaration */
@ rule1 @
identifier i;
type t;
@@
-typedef struct i {
+struct i {
	...
}
- t
;

/* Replace type with struct */
@ rule2 @
identifier rule1.i;
type rule1.t;
@@
-t
+struct i

/* Catch occurences of 'const' instances/pointers */
@ rule3 @
identifier rule1.i;
type rule1.t;
@@
const
-t
+struct i

/* Replace typdef forward declarations with struct declaration */
@ rule4 @
identifier i;
type t;
@@
-typedef struct i t;
+struct i;

/* Replace type with struct (forward declarations */
@ rule5 @
identifier rule4.i;
type rule4.t;
@@
-t
+struct i

/* Replace type with struct (forward declarations */
@ rule6 @
identifier rule4.i;
type rule4.t;
@@
const
-t
+struct i

/* Convert unnamed structs */
@ rule7 @
type t;
@@
typedef struct {
	...
}
t
;

/* Make typename usable as identifier */
@ script:python rule8 @
t << rule7.t;
i;
@@
coccinelle.i = t.rstrip('_t')

@ rule9 @
type rule7.t;
identifier rule8.i;
@@
-typedef struct {
+struct i {
	...
}
- t
;

/* Replace type with struct */
@ rule10 @
type rule7.t;
identifier rule8.i;
@@
-t
+struct i

/* Catch occurences of 'const' instances/pointers */
@ rule11 @
type rule7.t;
identifier rule8.i;
@@
const
-t
+struct i
