From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 6 May 2016 12:58:19 +0200
Subject: [Cocci] [PATCH 5/5] pycocci: enable SmPL <=> Patch equivalence
 tests
In-Reply-To: <1462478624-25117-6-git-send-email-mcgrof@kernel.org>
References: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
 <1462478624-25117-6-git-send-email-mcgrof@kernel.org>
Message-ID: <9343f29c-899a-ffb1-8f38-8b158a5c6e0f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> We can extend Coccinelle's existing test framework to support
> multiple files, header files, but a different can also consist
> of making use of SmPL <=> Patch equivalence support. Instead of
> relying on .res files, this relies on patches that provide
> a outline of differences using standard diff.

Does this wording need a bit more fine-tuning to make
the understanding easier for the suggested software development?

Regards,
Markus
