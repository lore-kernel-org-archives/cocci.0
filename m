From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 9 Feb 2016 17:42:42 +0100
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <20160209163618.GA20583@gmail.com>
References: <1448041672-3986-1-git-send-email-mcgrof@do-not-panic.com>
 <1448041672-3986-3-git-send-email-mcgrof@do-not-panic.com>
 <20151125145322.GA24630@x230.dumpdata.com>
 <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160209163618.GA20583@gmail.com>
Message-ID: <20160209164242.GR25240@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Feb 09, 2016 at 05:36:18PM +0100, Olaf Hering wrote:
> On Fri, Feb 05, Konrad Rzeszutek Wilk wrote:
> 
> > Also - how does this work if you have an older version of SuSE,
> > say SLES10?
> 
> SLE10 is out of scope since along time already.
> This patch for current gnutls is already in qemu mainline.
> f40d55081667a716312b9a8b6e13835c4074f56b
> 7d2a929feba319c18603e324b1750830d6c8b7a1
> 
> I sent this already months/years ago.
> Debian Stale compiles fine, so why bother...

Thanks so it seems the other option is to bump the release, can that
be decided? What's the process for deciding that?

  Luis
