From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 10 Oct 2014 09:55:16 +0200 (CEST)
Subject: [Cocci] [PATCH 1/1 linux-next]
 scripts/coccinelle/misc/boolinit.cocci: fix assignment warnings
In-Reply-To: <1412925511-3556-1-git-send-email-fabf@skynet.be>
References: <1412925511-3556-1-git-send-email-fabf@skynet.be>
Message-ID: <alpine.DEB.2.10.1410100954590.2402@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks!

On Fri, 10 Oct 2014, Fabian Frederick wrote:

> Replace "Assignment of bool to 0/1" by "Assignment of 0/1 to bool"
>
> Suggested-by: Dan Mick <dan.mick@inktank.com>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  scripts/coccinelle/misc/boolinit.cocci | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
> index b9abed4..63c4562 100644
> --- a/scripts/coccinelle/misc/boolinit.cocci
> +++ b/scripts/coccinelle/misc/boolinit.cocci
> @@ -145,13 +145,13 @@ cocci.print_main("WARNING: Comparison of bool to 0/1",p)
>  p1 << r3.p1;
>  @@
>
> -cocci.print_main("WARNING: Assignment of bool to 0/1",p1)
> +cocci.print_main("WARNING: Assignment of 0/1 to bool",p1)
>
>  @script:python depends on org@
>  p2 << r3.p2;
>  @@
>
> -cocci.print_main("ERROR: Assignment of bool to non-0/1 constant",p2)
> +cocci.print_main("ERROR: Assignment of non-0/1 constant to bool",p2)
>
>  @script:python depends on report@
>  p << r1.p;
> @@ -169,10 +169,10 @@ coccilib.report.print_report(p[0],"WARNING: Comparison of bool to 0/1")
>  p1 << r3.p1;
>  @@
>
> -coccilib.report.print_report(p1[0],"WARNING: Assignment of bool to 0/1")
> +coccilib.report.print_report(p1[0],"WARNING: Assignment of 0/1 to bool")
>
>  @script:python depends on report@
>  p2 << r3.p2;
>  @@
>
> -coccilib.report.print_report(p2[0],"ERROR: Assignment of bool to non-0/1 constant")
> +coccilib.report.print_report(p2[0],"ERROR: Assignment of non-0/1 constant to bool")
> --
> 1.9.3
>
>
