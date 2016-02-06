From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Sat, 6 Feb 2016 05:36:17 +0100
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <20160206041235.GA1232@localhost.localdomain>
References: <1448041672-3986-1-git-send-email-mcgrof@do-not-panic.com>
 <1448041672-3986-3-git-send-email-mcgrof@do-not-panic.com>
 <20151125145322.GA24630@x230.dumpdata.com>
 <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160206040322.GB25240@wotan.suse.de>
 <20160206041235.GA1232@localhost.localdomain>
Message-ID: <20160206043617.GD25240@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Feb 05, 2016 at 11:12:36PM -0500, Konrad Rzeszutek Wilk wrote:
> > a library could just add a helper gnutls_priority_set_direct() wrapper to
> > do things the old way.
> 
> Any ideas on how to detect whether the wrapper should be used from
> within the qemu-traditional code? Does the library have an programatic way
> to expose this? (#ifdef machinery?)

Sorry no I do not deal with backporting userspace applications. Is it a
requirement for developers on Xen to figure this out? I though this
would be for the folks who productize.

  Luis
