From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 29 Dec 2014 14:41:16 +0100
Subject: [Cocci] Support for SmPL ellipsis in logical expressions?
In-Reply-To: <alpine.DEB.2.10.1412291422340.2558@hadrien>
References: <54A1525D.3040009@users.sourceforge.net>
 <alpine.DEB.2.10.1412291422340.2558@hadrien>
Message-ID: <54A159FC.8040705@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It has nothing particularly to do with a conditional.

Thanks for your quick feedback.


> || has two arguments, both expressions.

That is clear.


> If you want to describe a subterm of an expression, you have to put
> <+...  ...+> around it.

I have tried to express the possibility that additional operators
like "logical not" are optional in my semantic filter approach.

I try to find also function implementations which have got similar 
properties like the function "kernfs_put".
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/fs/kernfs/dir.c?id=9b053f3207e8887fed88162a339fdd4001abcdb2#n383

Regards,
Markus
