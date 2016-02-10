From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 10 Feb 2016 16:41:52 +0100
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <1455097590.19857.126.camel@citrix.com>
References: <20151125145322.GA24630@x230.dumpdata.com>
 <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160209163618.GA20583@gmail.com>
 <20160209164242.GR25240@wotan.suse.de>
 <20160209182327.GA25161@aepfle.de>
 <CAB=NE6URhBm2FDYY=7a3GnhS=_5jhstHXj+Dm3xaYzh2yxxNPw@mail.gmail.com>
 <1455097590.19857.126.camel@citrix.com>
Message-ID: <20160210154152.GX25240@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Feb 10, 2016 at 09:46:30AM +0000, Ian Campbell wrote:
> On Tue, 2016-02-09 at 19:04 -0800, Luis R. Rodriguez wrote:
> > On Tue, Feb 9, 2016 at 10:23 AM, Olaf Hering <olaf@aepfle.de> wrote:
> > > On Tue, Feb 09, Luis R. Rodriguez wrote:
> > > 
> > > > Thanks so it seems the other option is to bump the release, can that
> > > > be decided? What's the process for deciding that?
> > > 
> > > Which release should be bumped?
> > 
> > In so far as TLS is concerned:
> > 
> > mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
> > f40d55081667a716312b9a8b6e13835c4074f56b
> > v1.0-rc0~325
> > 
> > mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
> > 7d2a929feba319c18603e324b1750830d6c8b7a1
> > v1.5.0-rc0~660
> > 
> > mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
> > d321e1e526810
> > v2.5.0-rc0~125^2~2
> > 
> > As for the other fix I backported for the existing release carried:
> > 
> > mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
> > 98d23704138e0be17a3ed9eb2631077bf92cc028
> > v1.1-rc0~785
> > 
> > I wanted to see what is the current version on Xen for
> > qemu-xen-traditional-dir-remote thing, is this the right way to check
> > what version is on /tools/qemu-xen-traditional-dir-remote ?
> > 
> > mcgrof at ergon ~/devel/xen/tools/qemu-xen-traditional-dir-remote
> > (git::dummy)$ cat VERSION
> > 0.10.2
> > 
> > If so.. I'm scared.
> 
> qemu-xen-traditional Device Model is the old Xen fork which is maintained
> only in order to support old VMs which expect the hardware environment
> provided by that old version of QEMU.
> 
> The default Device Model since Xen 4.3 has been "qemu-xen", which is our
> name for QEMU upstream. Xen 4.6 shipped with a bundled QEMU 2.2.1, but
> users (and distros) are free to supply their own (see configure's --with-
> system-qemu option) instead.
> 
> Hopefully it is clear therefore why just upgrading qemu-xen-traditional to
> a newer QEMU is not an option (or rather, that already exists and is the
> default via qemu-xen)
> 
> If you aren't interested in supporting VMs installed on very old versions
> of Xen then it would be reasonable to:
>     ./configure --disable-qemu-traditional
> and avoid it all together.
> 
> So far as making qemu-xen-trad compatible with gcc5 while still retaining
> support for building on the oldest platforms we want to support (whatever
> those are) I have no real opinion, but it seems some sort of
> abstraction/shim layer would be needed to satisfy both cases.

Thanks for the details! If there is no proactive mechanism to scrape for
cherry picks for fixes or huge interest to keep it compatible with latest
compilers qemu-xen-traditional seems to be more of a liability than a
helper, would it be too irrational to propose to just burry it and mark
it as no longer supported?

  Luis
