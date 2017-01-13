From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Jan 2017 11:59:22 +0100 (CET)
Subject: [Cocci] Coccinelle problems
In-Reply-To: <d03925e4-f9a0-533c-02b3-b12d3f8236de@roeck-us.net>
References: <d03925e4-f9a0-533c-02b3-b12d3f8236de@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1701131157290.2055@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 12 Jan 2017, Guenter Roeck wrote:

> Hi Julia,
>
> I have a couple of new problems with coccinelle.
>
> First, please have a look at the attached testc.c and test.cocci.
> Running test.cocci on testc.c results in a hang. The problems seems
> to be related to the number of (to-be-folded) labels.

Here is a more efficient version.  I put an exists in the first rule - you
just care if there exists a path to the double label, but don't care if
all paths lead to the double label.  In the second rule, I changed <+...
...+> to <... ...>, because there is no need to check if there is at least
one match.  You just want to perform the change if the opportunity arises.

julia

virtual patch

@unneeded_label exists@
identifier fn;
position p1;
identifier l1,l2;
@@

fn(...) {
<+...
l1:@p1
l2:
...+> }

@fold_label@
identifier unneeded_label.fn;
identifier l,l1,l2;
position p != unneeded_label.p1;
position any p1;
statement S;
@@

fn(...) {
<...
- goto l1;
+ goto l2;
  ...
-l1:
 <... when != S
 l:@p1
 ...>
 l2:@p
...> }
