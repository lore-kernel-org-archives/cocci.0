From: asmadeus@codewreck.org (Dominique Martinet)
Date: Fri, 13 Jul 2018 10:00:23 +0200
Subject: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
In-Reply-To: <20180713074455.GA6859@himanshu-Vostro-3559>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <20180713074455.GA6859@himanshu-Vostro-3559>
Message-ID: <20180713080023.GB9638@nautica>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Himanshu Jha wrote on Fri, Jul 13, 2018:
> > I expect each maintainer will pick their share of the patchs if they
> > agree with it and the rest will just be dropped?
> 
> Masahiro Yamada <yamada.masahiro@socionext.com> takes coccinelle patches,
> so please cc him or your patch would be lost.

Thanks, will do.

> > +virtual patch
> > +virtual context
> 
> You might consider adding context rule or remove this line perhaps ?

Victim of copypasta, I'll remove this.

> > +-strncpy at p(
> > ++strlcpy(
> > +  dest, src, sz);
> > +-dest[sz - 1] = '\0';
> 
> The above rule produces an output that I think is not correct:
> --------------------------------------------------------------
> diff = 
> diff -u -p a//ti/wl1251/acx.c b//ti/wl1251/acx.c
> --- a//ti/wl1251/acx.c
> +++ b//ti/wl1251/acx.c
> @@ -150,14 +150,7 @@ int wl1251_acx_fw_version(struct wl1251
>  	}
>  
>  	/* be careful with the buffer sizes */
> -	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> -
> -	/*
> -	 * if the firmware version string is exactly
> -	 * sizeof(rev->fw_version) long or fw_len is less than
> -	 * sizeof(rev->fw_version) it won't be null terminated
> -	 */
> -	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
> +	strlcpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> 
> -----------------------------------------------------------------
> 
> I think the comment is useful and should not be removed.

I agree this comment is useful now that I'm taking a closer look, I
glanced at this too fast.
I'm not sure how to make coccinelle not remove comments between lines
though?

> Also, consider changing Confidence level appropriately.

I am (was?) pretty confident on the change itself, the only exceptions
would be if someone relied on strncpy to fill the end of the buffer with
zero to not leak data somewhere but that is not easy to judge by itself
(although I hope rare enough)

I'm honestly not sure what would be appropriate in this case.

-- 
Dominique Martinet
