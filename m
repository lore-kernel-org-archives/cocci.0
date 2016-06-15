From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 18:04:26 +0200
Subject: [Cocci] [PATCH 2/4] scripts: add reqs python library
In-Reply-To: <alpine.DEB.2.02.1606150806190.2231@localhost6.localdomain6>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-3-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606150806190.2231@localhost6.localdomain6>
Message-ID: <20160615160426.GQ11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 08:06:33AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 14 Jun 2016, Luis R. Rodriguez wrote:
> 
> > This library can be used in other python scripts to require
> > specific binary version requirements. It will be used first
> > with coccinelle's python bindings to enable coccinelle SmPL
> > files to specify version requirements per cocci file if it
> > has any.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  MAINTAINERS             |   1 +
> >  scripts/lib/__init__.py |   1 +
> >  scripts/lib/reqs.py     | 211 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 213 insertions(+)
> >  create mode 100644 scripts/lib/__init__.py
> >  create mode 100644 scripts/lib/reqs.py
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f83e19a2dd97..fdebbb513c1b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6521,6 +6521,7 @@ F:	scripts/Makefile.*
> >  F:	scripts/basic/
> >  F:	scripts/mk*
> >  F:	scripts/package/
> > +F:	scripts/lib/
> >  
> >  KERNEL JANITORS
> >  L:	kernel-janitors at vger.kernel.org
> > diff --git a/scripts/lib/__init__.py b/scripts/lib/__init__.py
> > new file mode 100644
> > index 000000000000..1bb8bf6d7fd4
> > --- /dev/null
> > +++ b/scripts/lib/__init__.py
> > @@ -0,0 +1 @@
> > +# empty
> > diff --git a/scripts/lib/reqs.py b/scripts/lib/reqs.py
> > new file mode 100644
> > index 000000000000..1325fd21a87a
> > --- /dev/null
> > +++ b/scripts/lib/reqs.py
> > @@ -0,0 +1,211 @@
> > +import subprocess, os, sys, re
> > +"""
> > +Often enough Python code can grow to depend on binaries
> > +on a system, you may also require only specific versions
> > +of these. This small library helps with this. It also has
> > +helpers for packages which we know to handle already.
> > +"""
> > +
> > +class ReqError(Exception):
> > +    pass
> > +class ExecutionError(ReqError):
> > +    def __init__(self, errcode):
> > +        self.error_code = errcode
> > +
> > +class Req:
> > +    "To be used for verifying binay package dependencies on Python code"
> 
> binay -> binary

Fixed, thanks.

  Luis
