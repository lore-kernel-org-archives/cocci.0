From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 4 Dec 2015 09:55:29 +0100
Subject: [Cocci] how to find missing initializer
In-Reply-To: <56603DC3.8040609@hurleysoftware.com>
References: <56603DC3.8040609@hurleysoftware.com>
Message-ID: <56615501.4070200@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> So trying to find those in-tree drivers which _do not_ define a cleanup
> method with coccinelle, led to this fragment which has a parse error.
> 
> Apologies if my question is obvious or trivial;

Your support request is fine. - You show just another interesting use case.

The preferred approach is mostly not so obvious for things you find
to be missing.


> I'm still learning coccinelle.

It is usual that it will take some time to become familiar to express
better solutions also with another programming language.
My knowledge is still evolving ?

There are more software development challenges to consider for
the semantic patch language around the handling of function pointers,
aren't there?

Regards,
Markus
