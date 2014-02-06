From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 6 Feb 2014 08:39:58 +0530
Subject: [Cocci] [PATCH] scripts/coccinelle: Use PTR_ERR_OR_ZERO
In-Reply-To: <1390805482-25075-1-git-send-email-sachin.kamat@linaro.org>
References: <1390805482-25075-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAK9yfHzotmve4R_o=i95ybPeEMe5cNyn_ZmRDryzZKYmeL-JYw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 27 January 2014 12:21, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> PTR_RET is deprecated. Do not recommend its usage anymore.
> Use PTR_ERR_OR_ZERO instead.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
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
> --
> 1.7.9.5
>

Gentle ping..

-- 
With warm regards,
Sachin
