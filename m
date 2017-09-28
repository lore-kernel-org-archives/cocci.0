From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Sep 2017 14:15:15 +0200
Subject: [Cocci] Further improvements for safer building of the
 Coccinelle software
In-Reply-To: <alpine.DEB.2.20.1709272124330.3493@hadrien>
References: <alpine.DEB.2.20.1709272124330.3493@hadrien>
Message-ID: <2349f9c2-4f5b-c87a-be07-6facd21419c2@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> A number of recent commits have been pushed to github,

Thanks for your information.


> including a new make system.

Does this indicate a growing interest to clarify remaining (or even recurring)
open issues in such a software area?


> Let us know if any difficulties are encountered.

I commented a few commits again.


I have built your current software on my test system a moment ago.
Now I wonder about the following display.

elfring at Sonne:~> /usr/local/bin/spatch.opt --version
spatch version 1.0.6-00242-g3f038a5d compiled with OCaml version 4.05.0
?
elfring at Sonne:~> /usr/local/bin/spatch --version
spatch version 1.0.6-00304-gdb8e301e compiled with OCaml version 4.05.0
?

Regards,
Markus
