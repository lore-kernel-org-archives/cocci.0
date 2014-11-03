From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 03 Nov 2014 11:35:21 +0100
Subject: [Cocci] [PATCH 1/1] kconfig: Deletion of unnecessary checks
 before the function call "sym_calc_value"
In-Reply-To: <54568924.5010008@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54568924.5010008@users.sourceforge.net>
Message-ID: <1415010921.20372.35.camel@x220>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Since you use "SF Markus Elfring", this patch should start with:

From: Markus Elfring <elfring@users.sourceforge.net>

We don't care that you used a sourceforge.net address. Or has SF another
meaning? 

On Sun, 2014-11-02 at 20:42 +0100, SF Markus Elfring wrote:
> The sym_calc_value() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.

Side note: I guess the coccinelle script you use just skips cases like
    if (sym) {
        sym_calc_value(sym);
        do_foo_bar():
    }

Or did you filter those manually?

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/kconfig/confdata.c | 6 ++----
>  scripts/kconfig/symbol.c   | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index f88d90f..3073cb6 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -262,8 +262,7 @@ int conf_read_simple(const char *name, int def)
>  			goto load;
>  		sym_add_change_count(1);
>  		if (!sym_defconfig_list) {
> -			if (modules_sym)
> -				sym_calc_value(modules_sym);
> +			sym_calc_value(modules_sym);
>  			return 1;
>  		}
> 
> @@ -399,8 +398,7 @@ setsym:
>  	free(line);
>  	fclose(in);
> 
> -	if (modules_sym)
> -		sym_calc_value(modules_sym);
> +	sym_calc_value(modules_sym);
>  	return 0;
>  }
> 
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index 7caabdb..3f7797b 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -447,8 +447,7 @@ void sym_clear_all_valid(void)
>  	for_all_symbols(i, sym)
>  		sym->flags &= ~SYMBOL_VALID;
>  	sym_add_change_count(1);
> -	if (modules_sym)
> -		sym_calc_value(modules_sym);
> +	sym_calc_value(modules_sym);
>  }
> 
>  void sym_set_changed(struct symbol *sym)

Please resend with
    Acked-by: Paul Bolle <pebolle@tiscali.nl>

added.


Paul Bolle
