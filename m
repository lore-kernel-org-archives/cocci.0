From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 6 Aug 2016 08:30:29 +0200
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace NULL test with
 IS_ERR test for devm_ioremap_resource
In-Reply-To: <20160806051548.GA30731@amitoj-Inspiron-3542>
References: <20160806051548.GA30731@amitoj-Inspiron-3542>
Message-ID: <0fc7f1af-b66d-3089-8c15-6cdc570ac159@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at err depends on context || org || report@
> +statement S;
> +expression e;
> +position j0;

How do you think about to omit the number from this variable name?


> +@@
> +
> +  e = devm_ioremap_resource(...);
> +* if (!e at j0) S

Are there any more functions to consider for such a source code search pattern?
How do you think about to use a function name list here?


> +// ----------------------------------------------------------------------------

I suggest to omit such comment lines from this SmPL script.

Regards,
Markus
