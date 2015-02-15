From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 15 Feb 2015 13:05:59 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
Message-ID: <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 2015-02-15 at 10:38AM +0100, Julia Lawall wrote:
> On Sat, 14 Feb 2015, S?ren Brinkmann wrote:
> 
> > Hi Julia,
> > 
> > On Sat, 2015-02-14 at 07:56PM +0100, Julia Lawall wrote:
> > > On Sat, 14 Feb 2015, S?ren Brinkmann wrote:
> > > 
> > > > Hi,
> > > >
> > > > I'm just getting my feet wet with coccinelle, so I'm probably missing
> > > > something really obvious in my problem.
> > > >
> > > > I have a codebase that uses plenty of
> > > >   typedef struct foo {
> > > >   	...
> > > >   } bar;
> > > >
> > > > I want to remove all these typedefs and simply use struct foo instead. I
> > > > came up with this patch:
> > > >
> > > >   /// Convert typdefed structs to structs
> > > >
> > > >   @ rule1 @
> > > >   identifier i;
> > > >   type t;
> > > >   @@
> > > >   -typedef struct i {
> > > >   +struct i {
> > > >   	...
> > > >   - }t;
> > > >   + };
> > > >
> > > >   @@
> > > >   identifier rule1.i;
> > > >   type rule1.t;
> > > >   @@
> > > >   -t
> > > >   +struct i
> > > >   // end of patch
> > > >
> > > > This seems to work for most occurrences, but there are a couple of
> > > > variables defined like this:
> > > >
> > > >   static const t *const baz[MAX] = {
> > > >   	...
> > > >   };
> > > >
> > > > And also function declarations like:
> > > >   u32 fn(const t* const baz);
> > > >
> > > > In such cases, t isn't replaces as I would expect, but those lines
> > > > aren't changed at all.
> > > >
> > > > Other variables and non-const function parameters seem to be replaced as
> > > > expected.
> > > > Does anybody have an idea what I'm missing?
> 
> OK, the issue is that const is considered to be part of the type, so when 
> you have a metavariable that contains type foo, it doesn't match an 
> occurrence of const foo.  I'm not sure if it is correct to consider const 
> to be part of the type, but I'm also not eager to change it.  Could you 
> live with the solution of just making one more rule:
> 
> @@
> identifier rule1.i;
> type rule1.t;
> @@
>  const
> -t
> +struct i

Yes, that works for me. Thanks!

But I just ran into the next controversy:
I extended my patch to also catch typedef forward declarations:

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

This works mostly fine, but fails (under certain circumstances) on a
line like this:
  typedef u32 (*const fnptr2)(a_struct_t *strptr);

I did a little bit of testing:
 - the parser chokes on that line unless
   - the u32 typedef is in the same file before the failing line (not
     sure why it's not enough to pull it in through an include)
   - a similar line without the 'const' precedes the failing line e.g.
	typedef u32 (*fnptr)(a_struct_t *strptr);

I attach a patch and c file to reproduce this. Running
'spatch --parse-c --spfile test.cocci testcase2.c' reveals some
parsing issues.  If the annotated line int he c file is commented
in, parsing goes through fine.

	Thanks,
	Soren
-------------- next part --------------
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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: testcase2.c
Type: text/x-csrc
Size: 285 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150215/0ff2dc93/attachment.bin>
