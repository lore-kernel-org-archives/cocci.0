From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 5 Feb 2016 23:12:36 -0500
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <20160206040322.GB25240@wotan.suse.de>
References: <1448041672-3986-1-git-send-email-mcgrof@do-not-panic.com>
 <1448041672-3986-3-git-send-email-mcgrof@do-not-panic.com>
 <20151125145322.GA24630@x230.dumpdata.com>
 <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160206040322.GB25240@wotan.suse.de>
Message-ID: <20160206041235.GA1232@localhost.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > Also - how does this work if you have an older version of SuSE,
> > say SLES10?
> 
> Beats me. I just dealt with getting this to compile with what is current.
> I kind of doubt what is in xen master or staging will end up in SLE10's
> version of Xen too. If that had to happen people porting this to an old

I build staging on Fedora Core 13 and then occasionally on OL5 and OL6.

> library could just add a helper gnutls_priority_set_direct() wrapper to
> do things the old way.

Any ideas on how to detect whether the wrapper should be used from
within the qemu-traditional code? Does the library have an programatic way
to expose this? (#ifdef machinery?)

> 
>   Luis
