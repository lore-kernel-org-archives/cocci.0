From: bp@alien8.de (Borislav Petkov)
Date: Mon, 17 Jul 2017 10:39:46 +0200
Subject: [Cocci] [PATCH] EDAC: remove unnecessary static in
 edac_fake_inject_write()
In-Reply-To: <20170704214440.GA9462@embeddedgus>
References: <20170704214440.GA9462@embeddedgus>
Message-ID: <20170717083946.GB23129@nazgul.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 04, 2017 at 04:44:40PM -0500, Gustavo A. R. Silva wrote:
> Remove unnecessary static on local variable _type_.
> Such variable is initialized before being used,
> on every execution path throughout the function.
> The static has no benefit and, removing it reduces
> the code size.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> 
> static T x at p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> 
> -static
>  T x at p;
>  ... when != x
>      when strict
> ?x = e;

So the fix is ok but I don't understand Coccinelle to be able to judge
whether the above patch is fine or not. If it is, it probably should be
put somewhere in scripts/coccinelle/ so that others can use it too so
that they can catch such useless uses of static too.

Lemme add the Coccinelle ML to CC.

(Leaving in the rest for reference.)

> In the following log you can see the difference in the code size and,
> also a significant difference in bss segment. This log is the output
> of the size command, before and after the code change:
> 
> before:
>    text    data     bss     dec     hex filename
>    2966     920     128    4014     fae drivers/edac/debugfs.o
> 
> after:
>    text     data     bss    dec     hex filename
>    2961     832      64    3857     f11 drivers/edac/debugfs.o
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/edac/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
> index 92dbb7e..ba0af49 100644
> --- a/drivers/edac/debugfs.c
> +++ b/drivers/edac/debugfs.c
> @@ -8,7 +8,7 @@ static ssize_t edac_fake_inject_write(struct file *file,
>  {
>  	struct device *dev = file->private_data;
>  	struct mem_ctl_info *mci = to_mci(dev);
> -	static enum hw_event_mc_err_type type;
> +	enum hw_event_mc_err_type type;
>  	u16 errcount = mci->fake_inject_count;
>  
>  	if (!errcount)
> -- 
> 2.5.0
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
