From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 9 Feb 2016 16:46:36 +0100
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <56B9D35D02000078000CFF46@prv-mh.provo.novell.com>
References: <1448041672-3986-1-git-send-email-mcgrof@do-not-panic.com>
 <1448041672-3986-3-git-send-email-mcgrof@do-not-panic.com>
 <20151125145322.GA24630@x230.dumpdata.com>
 <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160206040322.GB25240@wotan.suse.de>
 <56B9D35D02000078000CFF46@prv-mh.provo.novell.com>
Message-ID: <20160209154636.GL25240@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Feb 09, 2016 at 03:54:05AM -0700, Jan Beulich wrote:
> >>> On 06.02.16 at 05:03, <mcgrof@suse.com> wrote:
> > On Fri, Feb 05, 2016 at 10:45:54PM -0500, Konrad Rzeszutek Wilk wrote:
> >> Also - how does this work if you have an older version of SuSE,
> >> say SLES10?
> > 
> > Beats me. I just dealt with getting this to compile with what is current.
> > I kind of doubt what is in xen master or staging will end up in SLE10's
> > version of Xen too. If that had to happen people porting this to an old
> > library could just add a helper gnutls_priority_set_direct() wrapper to
> > do things the old way.
> 
> Looks like you misunderstand: The question isn't what products
> code might end up in, but what platforms are supported for
> building. Right now, building of Xen and tools still works on SLE10
> (and e.g. gcc is documented to be usable far enough back), so
> you should avoid breaking the build on such older platforms (or
> if you can't avoid it, you should make this explicit).

I did misunderstand the question, but the same question applies, are
we supposed to backport solutions for new libraries all the way down to
things such as SLE10? That's a pretty important requirements and it
by no means was clear as a requirement to me. Is full Xen compiling
on SLE10 as of today before these changes? Who's testing that? Why
SLE10 and not factory?

  Luis
