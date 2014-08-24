From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 24 Aug 2014 14:41:01 +0200
Subject: [Cocci] Clarification for dependencies in SmPL rules
In-Reply-To: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <53F9DD5D.50807@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at depends on patch@
> +identifier r.i;
> +type t;
> +@@

Would the specification "@variable_deletion depends on r@" be useful for such a
semantic patch rule?

Regards,
Markus
