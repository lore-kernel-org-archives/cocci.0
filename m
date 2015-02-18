From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 18 Feb 2015 22:44:49 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <dfc5063b5e46486fb5daa3c906464e80@BY2FFO11FD042.protection.gbl>
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
 <dfc5063b5e46486fb5daa3c906464e80@BY2FFO11FD042.protection.gbl>
Message-ID: <alpine.DEB.2.02.1502182242470.2248@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 17 Feb 2015, S?ren Brinkmann wrote:

> On Tue, 2015-02-17 at 09:31PM +0100, Julia Lawall wrote:
> > On Tue, 17 Feb 2015, S?ren Brinkmann wrote:
> > 
> > > On Tue, 2015-02-17 at 07:56AM +0100, Julia Lawall wrote:
> > > > Another patch is below.  With this the code parses, and the transformation 
> > > > can be made.  However, it considers this to be a duplicate const 
> > > > annotation, so I'm not sure that the const is being associated in the 
> > > > right way by the parser.
> > > 
> > > I applied the patch. I do see the mentioned warning now:
> > >   Warning: PARSING: duplicate 'const'; value = [1]
> > > 
> > > The replacement still doesn't happen though. I'm not sure whether I
> > > need another rule to catch these declarations. But I think I will
> > > just make people fix their code. I think having 'const' appear twice
> > > is not right, despite it being parseable.
> > 
> > Could you send a complete example?  It worked in the example I tried.
> 
> Sure. Please fine a test c file and my cocci patch (which grew a bit)
> attached. This is the diff I get:
>   init_defs_builtins: /usr/local/share/coccinelle/standard.h
>   HANDLING: testcase4.c
>   diff = 
>   --- testcase4.c
>   +++ /tmp/cocci-output-7912-c5f1e0-testcase4.c
>   @@ -1,21 +1,21 @@
>    
>   -typedef struct foo {
>   +struct foo {
>    	int member;
>   -} foo_t;
>   +};
>    
>   -static foo_t foo;
>   -static const foo_t stco_foo;
>   +static struct foo foo;
>   +static const struct foo stco_foo;
>    const foo_t const co_foo_co;
>    static const foo_t const stco_foo_co;

OK, the problem seems to be that the representation of the type in C code 
involves two occurrences of the token "const" and the representation of 
the type in SmPL involves at most one.  So there is no way to match one of 
these double const things.  Telling the developer to remove the second 
const is probably the reasonable solution.

julia
