Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AE6EA8550
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=6VIVnByZaEtNKe3Ksvez3UxkM5e9Pi6L3j7E8HUh3K0=;
  b=Su8NnKjxB1obAsVgEb/ds1IJ4Ixcc/C0dX634h+/zAaO1M3hPhLK5S/K
   FIVYiRJm6YbrwU6jzujm2RTBn0Jm249a+9pnsHziTLdcvCNqrmQbsZ/vV
   MOtAih46sf8OUQZr8KKq2LQ5gQw/Sh+8d8mXaBUyTvdxXMvXPaRdThmFx
   0=;
X-CSE-ConnectionGUID: 0qbq53VFSbyxTRd0g6N0Aw==
X-CSE-MsgGUID: t3z/o1TESWK645B47JpgOg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="asc'?scan'208";a="267037007"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 10:14:01 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 130EC832B6; Tue, 10 Mar 2026 10:14:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B20F6830E7
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 15:32:47 +0100 (CET)
X-CSE-ConnectionGUID: mqsf0WFbTmOfDOcxMsw0rg==
X-CSE-MsgGUID: +M6oBi7vStiFOBAaIat6YA==
IronPort-SDR: 69aed9fb_VZbjn315JGfmvbvw77RUaspVgpxNKXw/6Ju+ou0gd01MM+Z
 PXAIVQC0WdLfN+Y0Sv1x56yD0ThTT0o+9a2vIYQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F+BACC2a5phR/86qxaglmCQYEHXzMEC0kDhFWDT4Ush?=
 =?us-ascii?q?liCIQNphRGFeoZbHI0sAggHAQMBCAVKBwQBAQMBA4IMgi5GAo0hAh4HAQQzB?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYZPD?=
 =?us-ascii?q?YJiATNxgSUBAQEBAQEBAQEBAQEBHQINfQEBAQECASMdAQE3AQQLCxgqAgIQR?=
 =?us-ascii?q?gaDFQGCIgcjJwMRrHZ6gTKBAYIMAQEGgQjbIoFeCQMGFAGBOIFYhnAMAYFdh?=
 =?us-ascii?q?BeEAHonG32BEIEVgyo+gkMHFwQYhSGCaYImgQ6Bf4cNig9SgRQDWSwBSwo1D?=
 =?us-ascii?q?DMrRUMDgSlLBTdlEj8hHQ8cHzkCOAcFEiERGYFKeIIBD4ZqeQMjC14aDiICO?=
 =?us-ascii?q?lxKPmUFgiQDeD03FBsEjFEQIQ2CDj6BQmsIgQ4rIoErNR1YkmqQHqFxgT6EJ?=
 =?us-ascii?q?owelhqDcY0ThjuTGS6YWIJYizGWGYUfgX4kgVwzGggoCIJuAQEBMU8DGQ+OL?=
 =?us-ascii?q?Q0JhFmEGMNsQjUCAQEMLAIHAQoBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 v8ekQZ3J/8q6S3n7hE0K0DMqS92l1M+y42NvA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vjGVNa7AZdV2ymaWMwPXwMfXdLJyesId70hD6qm+c31om+ij5q
 eTdZUgpHvJYVMqNU3I9urtBEDtexzhHNtOkO8s1NSZLWzbUQmTXeJfBOLZqlWKcREWtNQtt5
 uIGJIfNDSfNzZHsfo=
X-Talos-CUID: =?us-ascii?q?9a23=3A2ydWNmmP81NbG8uxeBI2cjw3IMrXOXjE13mIHGG?=
 =?us-ascii?q?yNWNORpGyQk+147w8icU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AYNiGjQ35vbZsTsYbraW0O9o5CTUjoIHwD2oMzos?=
 =?us-ascii?q?9p8iqEgZZMhaUkGqGa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="asc'?scan'208";a="140821791"
X-MGA-submission: =?us-ascii?q?MDHk7nIcYq4/KhaQ1ZRUyVVndBvTqF7BUY1LKN?=
 =?us-ascii?q?38D0A+QE9zWhXC7yrUmJHAKa6ur5ph+E6XrMA5dD8q+IkDT+07baH14n?=
 =?us-ascii?q?IjVtI70kq1eHUphOpOm++lclYT/osDTF2IbaA7p4Am3Hmv3ajZsFPLJT?=
 =?us-ascii?q?lhE0GX32CIssnZ/Kfr1uPXDw=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:32:26 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7643E408E9;
	Mon,  9 Mar 2026 14:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C816FC4CEF7;
	Mon,  9 Mar 2026 14:32:22 +0000 (UTC)
Date: Mon, 9 Mar 2026 15:32:20 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Message-ID: <aa7XD-rk_KWQvTQX@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o6pp4jdt7au2a2ah"
Content-Disposition: inline
In-Reply-To: <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3365
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/yNdTieIEkaXArtHsbGKc3Q>


--o6pp4jdt7au2a2ah
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] scripts/coccinelle: Add script for using ARRAY_END()
Message-ID: <aa7XD-rk_KWQvTQX@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
MIME-Version: 1.0
In-Reply-To: <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>

Hi Markus,

On 2026-03-09T15:05:08+0100, Markus Elfring wrote:
> =E2=80=A6
> > ---
> >  scripts/coccinelle/misc/array_end.cocci | 74 +++++++++++++++++++++++++
> =E2=80=A6
>=20
> Some contributors would appreciate patch version descriptions.
> https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pr=
eviously+submitted+patch%22
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.0-rc3#n310

I replied to all of your comments, and said how I would address them, in
reply to v1.  This v2 is in-reply-to v1, so that that sub-thread is easy
to find.  And at the bottom is a range-diff where you can find all the
exact changes from v1 to v2.

I could have noted in plain English the changes from v1 to v2, but
I thought it might be a bit redundant.

> May a subdirectory name be omitted from the subject prefix?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/s=
cripts/coccinelle/

Yeah, we could do that.  Here's what I checked for writing the subject
prefix:

	$ git log --oneline --author Lawall torvalds/master scripts/coccinelle/mis=
c/=20
	f01701ce update Coccinelle URL
	92b2dada scripts/coccinelle: drop bugon.cocci
	c3003315 scripts: coccinelle: boolinit: drop warnings on named constants
	518d8a56 scripts: coccinelle: Correct warning message
	b825b432 scripts: coccinelle: only suggest true/false in files that alread=
y use>
	937c812d coccinelle: orplus: reorganize to improve performance
	69c4907b Coccinelle: use false positive annotation
	f75621c6 coccinelle: bugon: reduce rule applicability
	c7eaa887 Coccinelle: array_size: reduce rule applicability
	8f551bef Coccinelle: reduce rule applicability
	74a8478f coccinelle: misc: move constants to the right
	932058a5 coccinelle: misc: semantic patch to delete overly complex return =
code >
	24f0c2d6 scripts/coccinelle: find constant additions that could be bit ors
	ad99ac2f scripts/coccinelle/misc/warn.cocci: use WARN
	2cbd0825 scripts/coccinelle: sizeof of pointer
	4619c2b8 scripts/coccinelle: address test is always true
	89910581 coccinelle: semantic patch for bool issues
	4a05f067 coccinelle: semantic patch to check for PTR_ERR after reassignment
	29a36d4d scripts/coccinelle: improve the coverage of some semantic patches
	a1087ef6 scripts/coccinelle: update for compatability with Coccinelle 0.2.4

Since the latest line and a decent amount of lines have
"scripts/coccinelle", I picked that.  I don't have a preference, so
please let me know what's the preferred one.  I tend to prefer more
explicit ones, even if slightly longer, but I'll take whatever the
maintainers' preference is.

The only one I didn't really like was the 'scripts: coccinelle:' one.
Paths are more readable if we're going to include all the
subdirectories.  But this is just my opinion.

> =E2=80=A6
> > +// Comments: No known false positives, but has a few false negatives
>=20
> Would such information motivate for any further software refinements?

Yes, if anyone here knows how to handle the false negatives and wants to
work with me on improving those, I'm very interested.

Here's one case which isn't caught, for example (which I expect will be
difficult to handle, if not impossible):

	@@ -2876,7 +2876,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup(s=
truct=20
	inode *dir, \
	 { \
		return proc_pident_lookup(dir, dentry, \
					  LSM##_attr_dir_stuff, \
	-                                 LSM##_attr_dir_stuff + ARRAY_SIZE(LSM##_=
attr_dir_stuff)); \
	+                                 ARRAY_END(LSM##_attr_dir_stuff)); \
	 } \
	 \
	 static const struct inode_operations proc_##LSM##_attr_dir_inode_ops =3D =
{ \

I could research and find other false negatives.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--o6pp4jdt7au2a2ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmu2e0ACgkQ64mZXMKQ
wqlWBQ/8C99MHd/FasCpExad6HTYSDNWnqLOhDVeLnAam8fliZai0EvveKOeRpNg
Cdzmj7ip3djHD8x+3z5pHS9HEXhZqvreN9sEM2uqK4AvNCQRLG+TLBcMai0sSiSu
XDWI7TgIKfvW4YumFHmvJv3IUj1SuNxva7yfrEueXZU548x7C37a9j2hGfNof3t2
SSWh/TQ2/cw3jmfViJwtTF55rjMGvBt1swto9iJAhKJI0x82tWWupmCcyTWrQqum
DApgmBJ/5Vx8RvCfdqQ4qssX7LGhFcf4JXoNLZsOPAk0ByfW8j1OZcjFnaHQc0Xd
njjfBfdcNvnBgk1f/snt107KLTj4O/Iq75Co1ey3+B1/0U79ymI4xL/d5eBLu2g8
l8v6kMC/+L12VTfPIvud8OwJ9daljQS5puCX9KPt1egL2UImQ295egKXl1NRAXdM
RdNgXdD5R7B2l9wZ8OuLHbrx4o/ox+mNrGwsfGc+wlWhztnXZcOOwmzsU6/Q12VC
Sfj6cwx1YZVgmuSITQKiOnAYIHiY2wts6Af/vb/4GsEWm4+RoswkJ6Ike4eYMfbL
clTZa6CpRnYnEOd4p24oNvemFs5AVuZDiAEq+R4AJFc66Yb6z7p8TZj8d3I/4951
EM7QilN59IJzv5ejkFKdql9UGy02k4AjL3u5PPrERbPn+TYHCpk=
=ue2C
-----END PGP SIGNATURE-----

--o6pp4jdt7au2a2ah--
