From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 Aug 2014 10:22:56 +0200
Subject: [Cocci] [patch 119/197] scripts/coccinelle/free: Delete NULL
 test before freeing functions
In-Reply-To: <53e53fd1.zO3IbUqJ421c7VXf%akpm@linux-foundation.org>
References: <53e53fd1.zO3IbUqJ421c7VXf%akpm@linux-foundation.org>
Message-ID: <53E5DA60.90902@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at r depends on context || report || org @
> +expression E;
> +position p;
> +@@
> +
> +* if (E)
> +*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb\)(E);

How do you think about to add the construct "@p" also behind the function name
"usb_free_urb"?


Is my previous update suggestion for such an issue worth for another look, too?

Regards,
Markus
