From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 10 Dec 2014 22:43:02 +0100
Subject: [Cocci] [PATCH] scripts: coccinelle: add uses of
	memzero_explicit
In-Reply-To: <1418242123-8610-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1418242123-8610-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <5488BE66.8040804@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Memzero_explicit is a version of memset that is resistent to compiler
> optimizations when the set region is about to go out of scope.

Thanks for another interesting update suggestion.


> This was suggested by Daniel Borkmann

How do you think about to amend such a commit message here?

Would it eventually be better to use a tag like "Suggested-by" there
(instead of finishing this sentence with a full stop)?

Regards,
Markus
