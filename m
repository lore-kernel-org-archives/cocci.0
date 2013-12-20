From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 20 Dec 2013 16:08:34 +0100 (CET)
Subject: [Cocci] Macro expansion and matching
In-Reply-To: <1387549107.30343.33.camel@ice-age2.regit.org>
References: <1387549107.30343.33.camel@ice-age2.regit.org>
Message-ID: <alpine.DEB.2.10.1312201607110.11971@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 20 Dec 2013, Eric Leblond wrote:

> Hello,
>
> I'm a bit confused with macro expansion. I've read this mail:
> http://lists.diku.dk/pipermail/cocci/2009-April/000145.html
>
> My first question is: is this up-to-date ?
>
> My specific problem is the following. I don't manage to match when a
> macro definition is called.
>
> The SMPL patch is the following:
>
> =========
> @sizet@
> size_t p;
> identifier func =~ "^(sprintf|printf|SCLog.*)$";
> position p1;
> @@
>
> func(..., p, ...)@p1;
>
> @script:python @
> p1 << sizet.p1;
> @@
>
> print "Invalid printf with size_t (not casted to uintmax_t) at %s:%s" % (p1[0].file, p1[0].line)
> ========
>
> And the code is this one:
>
> =======
> typedef struct bstr_t bstr;
>
> struct bstr_t {
>     size_t len;
>     unsigned char *realptr;
> };
>
> #define bstr_len(X) ((*(X)).len)
>
> int main()
> {
> bstr *onestr;
>
> printf("%"PRIuMAX, bstr_len(onestr));
> printf("%"PRIuMAX, onestr->len);
> }
> =======
>
> With that I've only got a match on second printf. So it seems there is a
> problem with the macro expansion.
>
>
> BUt what I don't understand is that I've got two matches if I rewrite
> the bstr_len macro to
> #define bstr_len(X) ((size_t)(*(X)).len)

I have the impression that it only calculates the type of a macro
expression once, based on the information in the macro code.  In the
original example, it doesn't know about the type of X, so it doesn't
calculate any type information.  This is probably not an easily fixable
problem.

julia
