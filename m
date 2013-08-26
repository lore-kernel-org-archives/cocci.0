From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 26 Aug 2013 21:48:20 +0200 (CEST)
Subject: [Cocci] if statements including assignments
In-Reply-To: <20130826192608.GA3117@katana>
References: <20130826192608.GA3117@katana>
Message-ID: <alpine.DEB.2.02.1308262139330.2044@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 26 Aug 2013, Wolfram Sang wrote:

> Hi,
> 
> I'd basically need something like:
> 
> 	if (... when != var)
> 
> to match. I couldn't find a way to express it. This is needed since
> there are constructs like:
> 
> 	if (var = something())
> 
> which I don't want to match since they assign var a value which is fine
> in my case.

This is not really clear enough for me to understand what you do want to 
do.  I imagine that you want something like

(
if (pattern_you_like) S1 else S2
|
* if (pattern_you_dont_like)
  S1 else S2
)

Where pattern_you_like might be <+... var ...+>, if you like everything 
that somewhere contains var.

I would really rather that all assignments in if tests disappear, because 
they make more than one way of expressing the same thing, and thus 
complicate other semantic patches.  I made the attached semantic patch to 
remove them in cases where one could safely put the assignment just before 
the if, but it touched over 1100 files in the Linux kernel, so I ran out 
of courage...

julia
-------------- next part --------------
@ok@
expression e,e1,e2;
statement S1,S2,S1a,S2a;
position p;
type T;
identifier i;
iterator I;
@@

(
if (...) S1a else S2a
|
while (...) S1a
|
for (...;...;...) S1a
|
I (...) S1a
|
T i;
|
 e;
)
if at p (
(
 (e1 = e2) != 0
|
 (e1 = e2) == 0
|
 (e1 = e2) != NULL
|
 (e1 = e2) == NULL
|
 IS_ERR(e1 = e2)
)
 ) S1 else S2

@@
expression e1,e2;
statement S1,S2;
position ok.p;
@@

+e1 = e2;
if at p (
(
- (e1 = e2)
+ e1
 != 0
|
- (e1 = e2)
+ e1
 == 0
|
- (e1 = e2)
+ e1
 != NULL
|
- (e1 = e2)
+ e1
 == NULL
|
 IS_ERR(
-   e1 = e2
+   e1
 )
)
 ) S1 else S2

@alsook@
expression e1,e2;
statement S1,S2;
position p;
@@

{
if at p (
(
 (e1 = e2) != 0
|
 (e1 = e2) == 0
|
 (e1 = e2) != NULL
|
 (e1 = e2) == NULL
|
 IS_ERR(e1 = e2)
)
 ) S1 else S2
... when any
}

@@
expression e1,e2;
statement S1,S2;
position alsook.p;
@@

+e1 = e2;
if at p (
(
- (e1 = e2)
+ e1
 != 0
|
- (e1 = e2)
+ e1
 == 0
|
- (e1 = e2)
+ e1
 != NULL
|
- (e1 = e2)
+ e1
 == NULL
|
 IS_ERR(
-   e1 = e2
+   e1
 )
)
 ) S1 else S2
