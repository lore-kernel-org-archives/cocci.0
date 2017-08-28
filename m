From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 28 Aug 2017 15:37:48 +0200
Subject: [Cocci] Addition of support for variable attributes
In-Reply-To: <alpine.DEB.2.20.1708261410460.10724@hadrien>
References: <alpine.DEB.2.20.1708261410460.10724@hadrien>
Message-ID: <6b8f6657-28b0-7572-df15-88333aa93069@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It is now (github) possible to match and transform a single such attribute
> when it comes after the name of a variable in a variable declaration.

This is a nice extension for your software.

How does this information fit to the wording in the manual?
https://github.com/coccinelle/coccinelle/blob/2776ede39f6f4197eaa0fc8344152e5ed07e0ad3/docs/manual/cocci_syntax.tex#L308
??
It is not possible to match or remove an attribute, only to add one.
??


> attribute name __ro_after_init;

Do you imagine any further software evolution if you start the specification
of this metavariable type with two words?

Regards,
Markus
