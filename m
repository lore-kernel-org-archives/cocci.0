From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 21 Apr 2015 16:17:18 -0600
Subject: [Cocci] [PATCH v4 2/2] IB/qib: use arch_phys_wc_add()
In-Reply-To: <1429653035-19424-3-git-send-email-mcgrof@do-not-panic.com>
References: <1429653035-19424-1-git-send-email-mcgrof@do-not-panic.com>
 <1429653035-19424-3-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <20150421221718.GA10836@obsidianresearch.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Apr 21, 2015 at 02:50:35PM -0700, Luis R. Rodriguez wrote:
> -	if (qib_wc_pat) {
> -		resource_size_t vl15off;
> -		/*
> -		 * We do not set WC on the VL15 buffers to avoid
> -		 * a rare problem with unaligned writes from
> -		 * interrupt-flushed store buffers, so we need
> -		 * to map those separately here.  We can't solve
> -		 * this for the rarely used mtrr case.
> -		 */
> -		ret = init_chip_wc_pat(dd, 0);
> -		if (ret)
> -			goto bail;
> +	/*
> +	 * We do not set WC on the VL15 buffers to avoid
> +	 * a rare problem with unaligned writes from
> +	 * interrupt-flushed store buffers, so we need
> +	 * to map those separately here.  We can't solve
> +	 * this for the rarely used mtrr case.
> +	 */

This is a small change in behavior, but it doesn't seem important..

Mike, what do you think about adding:

 if (dd->wc_cookie)
    dev_err(.., "Using this device without CPU PAT support is known to be broken");

or similar..

Jason
