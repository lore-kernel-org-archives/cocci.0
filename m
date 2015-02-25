From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 25 Feb 2015 09:05:09 +0100
Subject: [Cocci] Challenges around preprocessor statements?
In-Reply-To: <F3E7ABF7-5E64-4AEF-B9CF-AE8CA0CE458B@allegro.com>
References: <F3E7ABF7-5E64-4AEF-B9CF-AE8CA0CE458B@allegro.com>
Message-ID: <54ED8235.9010001@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> We were quite surprised that spatch / coccinelle isn't ignoring stuff
> (I won't say "code", because it's often non-code English text)
> within "#if 0 / #endif" blocks, and feel this is a design flaw.

The Coccinelle software works on a different abstraction level.

There is another feature request for text skipping in the waiting queue.
https://github.com/coccinelle/coccinelle/issues/20

Are there any more use cases to consider?
Would you eventually like to adjust source code between preprocessor
statements?

Regards,
Markus
