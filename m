From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 20 Dec 2014 21:51:57 +0100 (CET)
Subject: [Cocci] Change function invocations argument
In-Reply-To: <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
 <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
 <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
Message-ID: <alpine.DEB.2.02.1412202147460.2098@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 20 Dec 2014, Eliseo Mart?nez wrote:

> Great. That worked. Just one more thing, please.
> Some of the replacements done by the rule before leave literals of the form ?(uintmax_t)34?.
> I would like to use an unsigned constant in those cases. This is, something like ?34u?. 
> So I add the following rule:
> 
> ```
> @@ expression e1, e3; constant c2; @@
>  30 
>  31 - put_bytes(e1, (uintmax_t)c2, e3)
>  32 + put_bytes(e1, c2, e3)
> ```
> 
> That does the work, except adding the ?u?. How could I do that?
> Is it possible adding something literally in the output?
> Is it possible to somehow say in line 32 ?render c2 but with u suffix??

It is possible, but somewhat awkward.  Here is a simpler example that you 
can adapt to your case:

@r@
typedef uintmax_t;
constant c;
@@

(uintmax_t)c

@script:python s@
c << r.c;
cu;
@@

coccinelle.cu = "%su" % (c)

@@
constant r.c;
identifier s.cu;
@@

- (uintmax_t)c
+ cu

julia
