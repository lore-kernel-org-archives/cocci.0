From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 02 Oct 2014 14:52:50 +0200
Subject: [Cocci] string parameter concatenation
In-Reply-To: <20141001130215.GB4701@rei.suse.cz>
References: <20141001130215.GB4701@rei.suse.cz>
Message-ID: <542D4AA2.6060407@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> nit.cocci:
> @@
> expression list L;
> @@
> - f(L);
> + g(L);

Would it make sense and work to write a semantic patch rule like the following?

@replacement@
@@
-f
+g
(L);


Can the passed parameters be omitted from the desired adjustment by "the plus line"?

Regards,
Markus
