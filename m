From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 19 Feb 2016 13:25:05 +0100
Subject: [Cocci] [PATCH] scripts/coccinelle: modernize &
In-Reply-To: <1455750974-24339-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1455750974-24339-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <56C709A1.6060004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> & is no longer allowed in column 0, since Coccinelle 1.0.4.

This information corresponds to the support for handling of conjunctions
in the semantic patch language which was added with the software
release "Coccinelle 1.0.3".
https://systeme.lip6.fr/pipermail/cocci/2015-October/002634.html


> diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> index f085f59..ce8cc9c 100644
> --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> @@ -123,7 +123,7 @@ list_remove_head(x,c,...)
>  |
>  sizeof(<+...c...+>)
>  |
> -&c->member
> + &c->member

The added space character is not in the first column of this SmPL script.

* Can it be that the additional character will be transformed according to
  special pretty-printing rules?
  https://github.com/coccinelle/coccinelle/issues/37

* Is such a change a possible workaround for open issues around
  the message "minus: parse error" (or software improvements
  which were developed in the meantime)?


>  |
>  c = E
>  |


Does the shown tweak need any further considerations?

Regards,
Markus
