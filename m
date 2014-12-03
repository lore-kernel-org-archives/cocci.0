From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 03 Dec 2014 13:31:19 +0100
Subject: [Cocci] [patch] CodingStyle: add some more error handling
	guidelines
In-Reply-To: <20141202085950.GA13434@mwanda>
References: <20141202085950.GA13434@mwanda>
Message-ID: <547F0297.6030202@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> index 9f28b14..9c8a234 100644
> --- a/Documentation/CodingStyle
> +++ b/Documentation/CodingStyle
> @@ -392,7 +392,12 @@ The goto statement comes in handy when a function exits from multiple
>  locations and some common work such as cleanup has to be done.  If there is no
>  cleanup needed then just return directly.
>  
> -The rationale is:
> +Choose label names which say what the goto does or why the goto exists.  An
> +[...]  Avoid
> +using GW-BASIC names like "err1:" and "err2:".  Also don't name them after the
> +goto location like "err_kmalloc_failed:"

I find this documentation approach not safe and clear enough so far.

* How should the reference to an other programming language help in the understanding
  of the recommended naming convention for jump labels?

* To which source code place should the word "location" refer to?
  - jump source
  - jump target

Regards,
Markus
