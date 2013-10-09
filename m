From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Oct 2013 15:20:14 +0200 (CEST)
Subject: [Cocci] problem with a (contorted) macro
In-Reply-To: <1381324407.3213.42.camel@zamolxis.metaware.tm.fr>
References: <1381311937.3213.23.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1310091155210.2237@hadrien>
 <1381324407.3213.42.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1310091515280.2237@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 9 Oct 2013, Nic Volanschi (R&D) wrote:

> On Wed, 2013-10-09 at 11:55 +0200, Julia Lawall wrote:
> > It's not a perfect solution, but could you try putting the ifth rule last
> > instead of first?
>
> Julia, thanks for the suggestion. It does work on the cited example, but
> causes the reverse problem (i.e. handles the "for" rules but not the
> "if" rules) in other cases, such as the following one:
>
> --- test.c:
> short calculeEPP() {
>   long stCorps;
>   TRNIV1
>     affObjCU(&stCorps);
>   return 0;
> }
>
> #define RETURN(s,n) {                                              \
>    if (n == POPG)                                                  \
>        return -1 ;                                                 \
> }
>
> short calculCITA( long lNuOpg ) {
>   short     idRsq = 0 ;
>   short      iPos = 0 ;
>   long     idxChv = 0 ;
>   short      sRet = 0;
>
>   if (sRet != 0) {
>     RETURN( "retour lectObjCU()", sRet) ;
>   }
>
>   for(idRsq = 0; idRsq < 10; idRsq++) {
>     for (idxChv = 0; idxChv < 11; idxChv++) {
>       if (lNuOpg != 2) {
>         for (iPos = 0 ; iPos < 12 ; iPos++ ) {
>           if (iPos > 0) {
>            TRNIV1
>              printf(" pourcent : %ld\n", lNuopg);
>           }
>         }
>       }
>     }
>   }
>   return 0;
> }
> --- EOF test.c
>
> --- macros.h:
> #define TEST(X, Y) \
>  if((X) >= (Y))
>
> #define TRNIV1 TEST(NIVTRCUSR, NIVTRC1)
> --- EOF macros.h
>
> --- test.cocci:
> @@ statement s1; @@
>  for(...;...;...)
> +{mwtrace();/*for*/
>   s1
> +}
>
> @@ statement s1; @@
>  for(...;...;...) s1
> +mwtrace();/*endfor*/
>
> @@ type T; identifier f; @@
>  T f(...) {
> +mwtrace();/*fun*/
>   ...
>  }
>
> @@ statement s1, s2; @@
>  if(...)
> +{mwtrace();/*ifelth*/
>   s1
> +}
>  else
> +{mwtrace();/*ifelel*/
>   s2
> +}
>
> @@ statement s1; @@
>  if(...)
> +{mwtrace();/*ifth*/
>   s1
> +}
>
> @@ statement s1, s2; @@
>  if(...) s1 else s2
> +mwtrace();/*endifel*/
> --- EOF test.cocci
>
> So in this example, the command:
>
> spatch --macro-file macros.h --ibm -c test.cocci
> --allow-inconsistent-paths --out-place test.c
>
> results in handling all the three for-s but not the two embedded if-s.
>
> However, I found that a solution that works in both cases is to declare
> the macro TRNIV1 as a MACROSTATEMENT (in macros.h), and use
> --macro-file-builtins, the same way some debugging macros are treated in
> Linux (in standard.h). This solution is satisfactory for now.

If you do that, I think it will not see TRNIV1 as a conditional.  It is
doing that now.

I think that the problem is that when code is generated that contains
TRNIV1, it is not reparsed properly.  I will have to look at why that is
the case.

> On the other hand, note that there are some other strange things
> happening in this example:
>
> 1. If I take out the first function (calculeEPP), or just comment the
> TRNIV1 in its definition, I get a parse error (command: spatch
> --macro-file macros.h --ibm --parse-unparse test.c), and the second
> function (calculCITA) is no more transformed at all. What's the
> connection between the first and the second function??

Information collected in parsing one function can be used in processing
another function.  I will have to look at it.

> 2. If I only define the macro TRNIV1 as a MACROSTATEMENT (in macros.h),
> but use the option --macro-file (without -builtins), I get a crash:
>
> Fatal error: exception Failure("expanded token return on line 11 is
> either modified or stored in a metavariable")

Normally, you cannot make transformations on macros for which it used the
macro definition file.  It would be nice if you could add code to such
things, which is the only thing you want to do.  I don't see any danger in
that.

julia
