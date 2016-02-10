From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 9 Feb 2016 19:04:17 -0800
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <20160209182327.GA25161@aepfle.de>
References: <1448041672-3986-1-git-send-email-mcgrof@do-not-panic.com>
 <1448041672-3986-3-git-send-email-mcgrof@do-not-panic.com>
 <20151125145322.GA24630@x230.dumpdata.com>
 <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160209163618.GA20583@gmail.com>
 <20160209164242.GR25240@wotan.suse.de> <20160209182327.GA25161@aepfle.de>
Message-ID: <CAB=NE6URhBm2FDYY=7a3GnhS=_5jhstHXj+Dm3xaYzh2yxxNPw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Feb 9, 2016 at 10:23 AM, Olaf Hering <olaf@aepfle.de> wrote:
> On Tue, Feb 09, Luis R. Rodriguez wrote:
>
>> Thanks so it seems the other option is to bump the release, can that
>> be decided? What's the process for deciding that?
>
> Which release should be bumped?

In so far as TLS is concerned:

mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
f40d55081667a716312b9a8b6e13835c4074f56b
v1.0-rc0~325

mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
7d2a929feba319c18603e324b1750830d6c8b7a1
v1.5.0-rc0~660

mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains d321e1e526810
v2.5.0-rc0~125^2~2

As for the other fix I backported for the existing release carried:

mcgrof at ergon ~/devel/qemu (git::master)$ git describe --contains
98d23704138e0be17a3ed9eb2631077bf92cc028
v1.1-rc0~785

I wanted to see what is the current version on Xen for
qemu-xen-traditional-dir-remote thing, is this the right way to check
what version is on /tools/qemu-xen-traditional-dir-remote ?

mcgrof at ergon ~/devel/xen/tools/qemu-xen-traditional-dir-remote
(git::dummy)$ cat VERSION
0.10.2

If so.. I'm scared.

 Luis
