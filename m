From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 28 Aug 2013 18:52:04 +0200 (CEST)
Subject: [Cocci] question about --allow-inconsistent-paths
In-Reply-To: <1377707947.3192.51.camel@zamolxis.metaware.tm.fr>
References: <1377707947.3192.51.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1308281850460.2279@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 28 Aug 2013, Nic Volanschi (R&D) wrote:

> Hi again,
>
> When trying to instrument switch statements (this time), by adding calls
> to trace() in every branch and after the switch, I got some Fatal errors
> because of inconsistent paths.
>
> The rule I'm trying is:
>
> --- trace.c
> @@ statement s; @@
>  switch(...) {
>  case ...:
> +mwtrace();/*case*/
>   s
>   ... }
> +mwtrace();/*endsw*/
>
> @@ statement s; @@
>  switch(...) {
>  default:
> +mwtrace();/*def*/
>   s
>   ... }
>
> I applied this patch to both of the following two files:
>
> --- contbreak.c:
> short GetInfoDestInf() {
>    short i = 0;
>    for(i=0; i<10; i++) {
>       switch(i) {
>          case 1:
> 	   printf("i=1\n");
>          break;
>          default:
> 	   printf("default\n");
> 	   continue;
>          break;
>       }
>       printf("for body\n");
>    }
>    return 0;
> }
>
>
> --- ifdefcase.c
> short GetInfoOcc(long lTypeArray)
> {
>    switch(lTypeArray)
>    {
>       case C_RINA_ST_BLK :
> 	sRetour = 0;
>       break;
> #ifdef INA_UNIX
>       case C_RINA_MES_ST_LST_THEME :
> 	sRetour = 1;
>       break;
> #endif
>       default:
>          sRetour = -1;
>       break;
>    }
>    return sRetour;
> }
>
> As a result, I get in both cases a fatal error:
> Fatal error: exception Failure("rule starting on line 1: node 13:
> [endswitch][1,2,4,5,6] in GetInfoDestInf reachable by inconsistent
> control-flow paths")
> Fatal error: exception Failure("rule starting on line 1: node 18:
> sRetour = ... ;[1,2,3,4,8,9] in GetInfoOcc reachable by inconsistent
> control-flow paths")
>
> By plaing a bit with the examples, I saw that:
> - in contbreak.c, the problem comes from the "continue" followed by the
> "break", because commenting either one eliminates the error
> - in ifdefcase.c, the problem comes from the case within #if/#endif,
> because taking this out eliminate the error.
>
> To avoid the problem, I used the option --allow-inconsistent-paths, and
> this works for both cases, with the results I'm expecting. So this is
> ok.
>
> However, as the manual says that this option is "unsafe", my question
> is: do I risk anything on this kind of local syntactic transformations?
> I mean, when all the rules have to be applied independently of the
> control flow graph?

I haven't looked at the example in detail, but the control-flow graph for
switches is known not to be as nice as one would want.  The problem is
with the need to support fall through from one branch to the next.
Probably the best thing is to look at the code and check that it is OK, if
that is not too much of a burden...

julia
