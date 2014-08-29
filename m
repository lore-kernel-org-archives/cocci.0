From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 29 Aug 2014 11:00:11 +0200
Subject: [Cocci] patch for coccinelle's Makefile
In-Reply-To: <53FF35F5.9040903@inria.fr>
References: <53FF35F5.9040903@inria.fr>
Message-ID: <5400411B.1030400@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I think the uninstall target can be made much simpler and robust.

How do think about to combine also the affected file deletion commands
into fewer calls with longer parameter lists if your prefer still to
adjust a Make file directly?
(I imagine that improvements for other build scripts would be more
useful, wouldn't it?)

Regards,
Markus
