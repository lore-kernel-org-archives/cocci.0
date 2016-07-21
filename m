From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 21 Jul 2016 22:47:13 +0200 (CEST)
Subject: [Cocci] Changing return value determination in if statements
 with SmPL
In-Reply-To: <95f4ee32-f5dc-6c0e-7ed1-5a62dfcd8648@users.sourceforge.net>
References: <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <66bd684a-98f1-0ec4-aa95-1a966d7c4e90@users.sourceforge.net>
 <6a8f4258-188e-36f6-28fa-1626c29cf361@users.sourceforge.net>
 <alpine.DEB.2.10.1607172056220.3177@hadrien> <20160720155333.GE1688@katana>
 <b249584b-47b8-ffd9-432e-986d69260ff1@users.sourceforge.net>
 <20160721062726.GC1664@katana>
 <b221aadb-2af7-8d0f-ce8e-99b1efa31edd@users.sourceforge.net>
 <20160721163714.GB1616@katana>
 <6f2ca140-9384-bc3f-9d20-2433b808d566@users.sourceforge.net>
 <alpine.DEB.2.10.1607212159150.3326@hadrien>
 <95f4ee32-f5dc-6c0e-7ed1-5a62dfcd8648@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1607212246050.3326@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 21 Jul 2016, SF Markus Elfring wrote:

> > A parameter list is something that comes after the name of a function in
> > the function header.  Something like int x, int y, in foo (int x, int y) {
> > ... }.  Probably you want an expression list.
>
> * How do you call the list usually that is used for the definition before
>   the function body?

parameter list

>
> * Did I get inappropriate expectations from a description around a "parameter-list-declarator"?
>   http://en.cppreference.com/w/c/language/function_definition
>

Apparently.  A link from taht page quite clearly says:

parameter-list 	- 	either the single keyword void or a
comma-separated list of parameters, which may end with an ellipsis
parameter

julia

> * The following SmPL script variant seems to work better.
>
>
> @checking_function_calls_directly@
> identifier checker, retval, work;
> expression list el;
> statement is, es;
> type rt;
> @@
>  rt checker(...)
>  {
>   <+...
> -retval = work(el);
>  if (
> -    retval
> +    work(el)
>     )
>     is
>  else
>     es
>   ...+>
>  }
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file checking_function_calls_directly2.cocci ~/Projekte/Linux/next-patched/drivers/staging/ks7010/ks7010_sdio.c
> init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
> HANDLING: /home/elfring/Projekte/Linux/next-patched/drivers/staging/ks7010/ks7010_sdio.c
> diff =
> --- /home/elfring/Projekte/Linux/next-patched/drivers/staging/ks7010/ks7010_sdio.c
> +++ /tmp/cocci-output-1578-3a5e93-ks7010_sdio.c
> @@ -99,9 +99,7 @@ void ks_wlan_hw_sleep_doze_request(struc
>
>  	if (atomic_read(&priv->sleepstatus.status) == 0) {
>  		rw_data = GCR_B_DOZE;
> -		retval =
> -		    ks7010_sdio_write(priv, GCR_B, &rw_data, sizeof(rw_data));
> -		if (retval) {
> +		if (ks7010_sdio_write(priv, GCR_B, &rw_data, sizeof(rw_data))) {
>  			DPRINTK(1, " error : GCR_B=%02X\n", rw_data);
>  			goto out;
>  		}
> ?
>
>
> Regards,
> Markus
>
