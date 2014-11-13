From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 13 Nov 2014 09:43:58 +0100 (CET)
Subject: [Cocci] [PATCH v2 2/2] staging: rtl8188eu: Better memory
 clean-up in efuse_phymap_to_logical()
In-Reply-To: <5463C373.5050804@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com> <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5463C10D.6020409@users.sourceforge.net>
 <5463C373.5050804@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1411130942150.2389@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> index 697876b..359f169 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
[...]
> -exit:
> +cleanup2:
> +	kfree(eFuseWord);
> +
> +cleanup1:
>  	kfree(efuseTbl);
>
> -	kfree(eFuseWord);
> +exit:
> +	;
>  }

You are not using the most recent version of the code.  The issue has
already been fixed. Concretely, this part of the function now reads:

exit:
        kfree(eFuseWord);

eFuseWord_failed:
	kfree(efuseTbl);

julia
