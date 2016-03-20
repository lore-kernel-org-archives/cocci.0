From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 20 Mar 2016 13:25:28 +0100 (CET)
Subject: [Cocci] [PATCH] Coccinelle: setup_timer: Add space in front of
 parentheses
In-Reply-To: <1458451652-5933-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1458451652-5933-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <alpine.DEB.2.10.1603201325011.2597@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 20 Mar 2016, Vaishali Thakkar wrote:

> Add space in front of the offending parentheses to silent the
> parse error for older Coccinelle versions. This makes the rule
> usable with all Coccinelle versions.
>
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/api/setup_timer.cocci | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/setup_timer.cocci b/scripts/coccinelle/api/setup_timer.cocci
> index 8ee0ac3..eb6bd9e 100644
> --- a/scripts/coccinelle/api/setup_timer.cocci
> +++ b/scripts/coccinelle/api/setup_timer.cocci
> @@ -106,7 +106,7 @@ position j0, j1, j2;
>  @match_function_and_data_after_init_timer_context
>  depends on !patch &&
>  !match_immediate_function_data_after_init_timer_context &&
> -(context || org || report)@
> + (context || org || report)@
>  expression a, b, e1, e2, e3, e4, e5;
>  position j0, j1, j2;
>  @@
> @@ -127,7 +127,7 @@ position j0, j1, j2;
>  @r3_context depends on !patch &&
>  !match_immediate_function_data_after_init_timer_context &&
>  !match_function_and_data_after_init_timer_context &&
> -(context || org || report)@
> + (context || org || report)@
>  expression c, e6, e7;
>  position r1.p;
>  position j0, j1;
> --
> 2.1.4
>
>
