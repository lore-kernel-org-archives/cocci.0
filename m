From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 27 Jun 2016 21:36:53 +0200
Subject: [Cocci] [PATCH v3] bundles/pycaml/: use .NOTPARALLEL on bundles
In-Reply-To: <f1af02e0-02ae-98be-5e79-b0b6dcf3e08c@users.sourceforge.net>
References: <1466461206-6960-1-git-send-email-mcgrof@kernel.org>
 <f1af02e0-02ae-98be-5e79-b0b6dcf3e08c@users.sourceforge.net>
Message-ID: <20160627193653.GN25646@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 25, 2016 at 02:54:46PM +0200, SF Markus Elfring wrote:
> >  bundles/menhirLib/Makefile | 1 +
> >  bundles/parmap/Makefile    | 1 +
> >  bundles/pcre/Makefile      | 1 +
> >  bundles/pycaml/Makefile    | 1 +
> 
> How do you think about to

[...]

I'm dropping this patch in favor of some other stuff being which
will fix this in a better way.

  Luis
