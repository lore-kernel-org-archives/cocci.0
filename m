From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 11 Aug 2014 15:00:52 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle/free/ifnullfree.cocci:
 simplify and extend to of_node_put
In-Reply-To: <1407752653-16883-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1407752653-16883-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <53E8BE84.3080505@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>  @r depends on context || report || org @
> @@ -37,7 +35,8 @@ position p;
>  @@
>  
>  * if (E)
> -*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb\)(E);
> +*  \(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb at p\|
> +*    of_node_put at p\)(E);

Why do you want to limit this semantic patch pattern to such a small list of
function names?

Would you like to consider also the hundreds of other functions which perform
input parameter validation?
Are you interested to make the checked list more complete with further
(eventually automatic?) extensions?

Regards,
Markus
