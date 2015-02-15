From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sat, 14 Feb 2015 17:22:54 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.10.1502141955040.6185@hadrien>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
Message-ID: <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Sat, 2015-02-14 at 07:56PM +0100, Julia Lawall wrote:
> On Sat, 14 Feb 2015, S?ren Brinkmann wrote:
> 
> > Hi,
> >
> > I'm just getting my feet wet with coccinelle, so I'm probably missing
> > something really obvious in my problem.
> >
> > I have a codebase that uses plenty of
> >   typedef struct foo {
> >   	...
> >   } bar;
> >
> > I want to remove all these typedefs and simply use struct foo instead. I
> > came up with this patch:
> >
> >   /// Convert typdefed structs to structs
> >
> >   @ rule1 @
> >   identifier i;
> >   type t;
> >   @@
> >   -typedef struct i {
> >   +struct i {
> >   	...
> >   - }t;
> >   + };
> >
> >   @@
> >   identifier rule1.i;
> >   type rule1.t;
> >   @@
> >   -t
> >   +struct i
> >   // end of patch
> >
> > This seems to work for most occurrences, but there are a couple of
> > variables defined like this:
> >
> >   static const t *const baz[MAX] = {
> >   	...
> >   };
> >
> > And also function declarations like:
> >   u32 fn(const t* const baz);
> >
> > In such cases, t isn't replaces as I would expect, but those lines
> > aren't changed at all.
> >
> > Other variables and non-const function parameters seem to be replaced as
> > expected.
> > Does anybody have an idea what I'm missing?
> 
> In principle, it should be OK.  Could you send a concrete example of C
> conde on which it does not work?  It is possible that there is some
> problem in parsing baz, and it is just skipping over it.  For this, you
> can run spatch --parse-c on your file.  If there is a BAD or bad in front
> of the code that you expect to have changed, then there may be a problem.

When I run with --parse-c, all I get is this:
  init_defs_builtins: /usr/share/coccinelle/standard.h
  
  PARSING: testcase.c
  -----------------------------------------------------------------------
  maybe 10 most problematic tokens
  -----------------------------------------------------------------------
  -----------------------------------------------------------------------
  NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
  nb good = 10,  nb passed = 0 =========> 0.000000% passed
  nb good = 10,  nb bad = 0 =========> 100.000000% good

It doesn't show any code (not sure whether that is correct or not), but no 'BAD' either.
Running that file through gcc -c -Wall works fine as well. So, it should be legal c (just
a warning regarding an unused variable).

I attached the testcase.c and my cocci patch. This is the diff I get:
  init_defs_builtins: /usr/share/coccinelle/standard.h
  HANDLING: testcase.c
  diff =
  --- testcase.c
  +++ /tmp/cocci-output-17008-c37c42-testcase.c
  @@ -1,11 +1,11 @@
  -typedef struct a_struct {
  +struct a_struct {
          int a_member;
  -} a_struct;
  +};
  
   static const a_struct *const a_struct_array[3] = {
   };
  
   unsigned int function(const a_struct* const a_struct_arg);
  
  -static a_struct a_struct_instance;
  +static struct a_struct a_struct_instance;
   static const a_struct a_const_struct_instance;

	Thanks,
	Soren
-------------- next part --------------
A non-text attachment was scrubbed...
Name: testcase.c
Type: text/x-csrc
Size: 251 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150214/07a3a4cb/attachment.bin>
-------------- next part --------------
/// Convert typdefed structs to structs

@ rule1 @
identifier i;
type t;
@@
-typedef struct i {
+struct i {
	...
- }t;
+ };

@ rule2 @
identifier rule1.i;
type rule1.t;
@@
-t
+struct i

@ rule3 @
identifier i;
type t;
@@

-typedef struct i t;
