From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 17 Nov 2014 10:34:08 +0300
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end"
In-Reply-To: <54688F15.9070703@users.sourceforge.net>
References: <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54687F1A.1010809@users.sourceforge.net>
 <20141116111023.GA4905@mwanda> <20141116111446.GA4956@mwanda>
 <54688F15.9070703@users.sourceforge.net>
Message-ID: <20141117073408.GC4905@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Nov 16, 2014 at 12:48:37PM +0100, SF Markus Elfring wrote:
> > An example of a bug introduced is here:
> > 
> > https://lkml.org/lkml/2014/11/3/505
> 
> It seems that we try to clarify a different interpretation of "bugs", don't we?
> 

You removed the statement from "if (foo) kfree_fsm(foo);" so now it
prints a warning.

drivers/s390/net/fsm.c
    71  void
    72  kfree_fsm(fsm_instance *this)
    73  {
    74          if (this) {
    75                  if (this->f) {
    76                          kfree(this->f->jumpmatrix);
    77                          kfree(this->f);
    78                  }
    79                  kfree(this);
    80          } else
    81                  printk(KERN_WARNING
    82                          "fsm: kfree_fsm called with NULL argument\n");
    83  }

> It is an usual software development challenge to decide on the best source code places
> where to put input parameter validation (and when it can be omitted), isn't it?

No, it's not.  You should just try to write the most readable software
you can instead of removing if statements because you can.

But that's not my point.  My point is that these patches are not always
welcome so we should not merge them through the trivial tree.

regards,
dan carpenter
