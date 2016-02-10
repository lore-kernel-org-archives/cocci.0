From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 10 Feb 2016 07:55:08 -0800
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <20160210154423.GA15658@aepfle.de>
References: <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160209163618.GA20583@gmail.com> <20160209164242.GR25240@wotan.suse.de>
 <20160209182327.GA25161@aepfle.de>
 <CAB=NE6URhBm2FDYY=7a3GnhS=_5jhstHXj+Dm3xaYzh2yxxNPw@mail.gmail.com>
 <1455097590.19857.126.camel@citrix.com> <20160210154152.GX25240@wotan.suse.de>
 <20160210154423.GA15658@aepfle.de>
Message-ID: <CAB=NE6WyLFzzL_5RmKD-JqtgSjX_MUSHtMzCtxQn++dJqY_o9Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Feb 10, 2016 at 7:44 AM, Olaf Hering <olaf@aepfle.de> wrote:
> On Wed, Feb 10, Luis R. Rodriguez wrote:
>
>> cherry picks for fixes or huge interest to keep it compatible with latest
>> compilers qemu-xen-traditional seems to be more of a liability than a
>
> Hey, this is about gnutls, not gcc!

Actually no, I also had backported another fix which I submitted part
of this series, and it is present as of this release:

mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
98d23704138e0be17a3ed9eb2631077bf92cc028
v1.1-rc0~785

How are fixes of interested backported regularly for this to make it
reasonable to at least keep this as a viable option which at least
compiles? Only compiling is one thing, how are security fixes
backported proactively?

 Luis
