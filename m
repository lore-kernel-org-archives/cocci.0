From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 20 May 2016 00:53:31 +0200
Subject: [Cocci] [RFC 3/3] coccinelle: add control flow documentation
In-Reply-To: <17faa474-e8f4-1cc0-b585-3c0840d44d00@users.sourceforge.net>
References: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
 <1463607743-11947-4-git-send-email-mcgrof@kernel.org>
 <17faa474-e8f4-1cc0-b585-3c0840d44d00@users.sourceforge.net>
Message-ID: <20160519225331.GJ11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 19, 2016 at 09:36:50AM +0200, SF Markus Elfring wrote:
> > +this rule by providing additional requirements and usign ellipses in between.
> 
> Will the wording "using" be better here?

Fixed.

> > +or that the statements in between must be present at leaset once (<+... ...+).
> 
> Please fix another typo: least.

Fixed.

> How do you think about to add any references (or links) for this functionality?

Please feel free to follow up with patches, preferably examples.

  Luis
