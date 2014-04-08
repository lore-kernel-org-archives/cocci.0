From: mmarek@suse.cz (Michal Marek)
Date: Tue, 08 Apr 2014 17:29:54 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle: Use PTR_ERR_OR_ZERO
In-Reply-To: <1390805482-25075-1-git-send-email-sachin.kamat@linaro.org>
References: <1390805482-25075-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <534415F2.7020601@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2014-01-27 07:51, Sachin Kamat wrote:
> PTR_RET is deprecated. Do not recommend its usage anymore.
> Use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied to kbuild.git#misc, sorry for the delay. But please always add
lkml to the cc list.

Thanks,
Michal


> ---
>  scripts/coccinelle/api/ptr_ret.cocci |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api/ptr_ret.cocci
> index e18f8402e37c..dd58dab5d411 100644
> --- a/scripts/coccinelle/api/ptr_ret.cocci
> +++ b/scripts/coccinelle/api/ptr_ret.cocci
> @@ -7,7 +7,7 @@
>  // URL: http://coccinelle.lip6.fr/
>  // Options: --no-includes --include-headers
>  //
> -// Keywords: ERR_PTR, PTR_ERR, PTR_RET, PTR_ERR_OR_ZERO
> +// Keywords: ERR_PTR, PTR_ERR, PTR_ERR_OR_ZERO
>  // Version min: 2.6.39
>  //
>  
> @@ -62,35 +62,35 @@ position p3;
>  p << r1.p1;
>  @@
>  
> -coccilib.org.print_todo(p[0], "WARNING: PTR_RET can be used")
> +coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
>  
>  
>  @script:python depends on org@
>  p << r2.p2;
>  @@
>  
> -coccilib.org.print_todo(p[0], "WARNING: PTR_RET can be used")
> +coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
>  
>  @script:python depends on org@
>  p << r3.p3;
>  @@
>  
> -coccilib.org.print_todo(p[0], "WARNING: PTR_RET can be used")
> +coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
>  
>  @script:python depends on report@
>  p << r1.p1;
>  @@
>  
> -coccilib.report.print_report(p[0], "WARNING: PTR_RET can be used")
> +coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
>  
>  @script:python depends on report@
>  p << r2.p2;
>  @@
>  
> -coccilib.report.print_report(p[0], "WARNING: PTR_RET can be used")
> +coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
>  
>  @script:python depends on report@
>  p << r3.p3;
>  @@
>  
> -coccilib.report.print_report(p[0], "WARNING: PTR_RET can be used")
> +coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> 
