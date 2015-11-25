From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 25 Nov 2015 20:36:51 +0100
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <20151125145322.GA24630@x230.dumpdata.com>
References: <1448041672-3986-1-git-send-email-mcgrof@do-not-panic.com>
 <1448041672-3986-3-git-send-email-mcgrof@do-not-panic.com>
 <20151125145322.GA24630@x230.dumpdata.com>
Message-ID: <20151125193651.GH9528@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 25, 2015 at 09:53:27AM -0500, Konrad Rzeszutek Wilk wrote:
> On Fri, Nov 20, 2015 at 09:47:45AM -0800, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > Using deprecate gnutls_*_set() triggers a failure to compile
> > with gnutls30-3.4.4, used on OpenSUSE factory:
> > 
> > ../libqemu_common.a(vnc.o): In function `vnc_start_tls':
> > ~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2164: undefined reference to `gnutls_kx_set_priority'
> > ~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2171: undefined reference to `gnutls_certificate_type_set_priority'
> > ~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2178: undefined reference to `gnutls_protocol_set_priority'
> > 
> > This compilation issue can be fixed by using the new routine
> > gnutls_priority_set_direct() which replaces the deprecated calls
> > which also simplifies the code considerably.
> 
> 
> Thanks for posting that! It certainly fixes that issue.

Acked-by?

> I was wondering if you had seen these as well:
> 
> /home/konrad/qemu-trad.git/vnc.c:1929:1: warning:
> ?gnutls_anon_server_credentials? is deprecated
> [-Wdeprecated-declarations]
>  {
>  ^
> /home/konrad/qemu-trad.git/vnc.c: In function
> ?vnc_tls_initialize_anon_cred?:
> /home/konrad/qemu-trad.git/vnc.c:1930:5: warning:
> ?gnutls_anon_server_credentials? is deprecated
> [-Wdeprecated-declarations]
>      gnutls_anon_server_credentials anon_cred;
>      ^
> /home/konrad/qemu-trad.git/vnc.c: In function ?vnc_start_tls?:
> /home/konrad/qemu-trad.git/vnc.c:2203:6: warning:
> ?gnutls_anon_server_credentials? is deprecated
> [-Wdeprecated-declarations]
>       gnutls_anon_server_credentials anon_cred =
> vnc_tls_initialize_anon_cred();
>       ^
> ?
> 
> (This is Fedora 23)

Nope.

 Luis
