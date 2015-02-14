From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 14 Feb 2015 19:56:28 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
Message-ID: <alpine.DEB.2.10.1502141955040.6185@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 14 Feb 2015, S?ren Brinkmann wrote:

> Hi,
>
> I'm just getting my feet wet with coccinelle, so I'm probably missing
> something really obvious in my problem.
>
> I have a codebase that uses plenty of
>   typedef struct foo {
>   	...
>   } bar;
>
> I want to remove all these typedefs and simply use struct foo instead. I
> came up with this patch:
>
>   /// Convert typdefed structs to structs
>
>   @ rule1 @
>   identifier i;
>   type t;
>   @@
>   -typedef struct i {
>   +struct i {
>   	...
>   - }t;
>   + };
>
>   @@
>   identifier rule1.i;
>   type rule1.t;
>   @@
>   -t
>   +struct i
>   // end of patch
>
> This seems to work for most occurrences, but there are a couple of
> variables defined like this:
>
>   static const t *const baz[MAX] = {
>   	...
>   };
>
> And also function declarations like:
>   u32 fn(const t* const baz);
>
> In such cases, t isn't replaces as I would expect, but those lines
> aren't changed at all.
>
> Other variables and non-const function parameters seem to be replaced as
> expected.
> Does anybody have an idea what I'm missing?

In principle, it should be OK.  Could you send a concrete example of C
conde on which it does not work?  It is possible that there is some
problem in parsing baz, and it is just skipping over it.  For this, you
can run spatch --parse-c on your file.  If there is a BAD or bad in front
of the code that you expect to have changed, then there may be a problem.

julia
