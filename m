Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA62C02193
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ChQwyx9ou1MQai7Seraqgab5uZ5KJv/6Tgq7MNDhUhw=;
  b=eMBt3MOC0oQyx259io/4eOs82jJtc06Eqe3iRFsUdmLfkDx3LPYmrCQR
   8/7GEIwj/9SLxd+vqHL73YrCu76pgv8JIF/MfqSqpoq8DDn+EgnSEZQxF
   LHWQ6PJyKUE/Ytp8igLmbmBawcz+/3sSbFtfA99hlXU4DculrBGz71cn1
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324976"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B04ACE0D6F; Tue, 28 Jan 2025 10:13:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D5499E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 16:29:39 +0100 (CET)
IronPort-SDR: 6793b1da_LtZg9yuUJaUsQn2LVukA7aBDyIb9tD0ppRELdsAmJ9eAmes
 4x9uwIYQjEtjXAzVISei/xv4iJC/O0jkrshISJg==
X-IPAS-Result: =?us-ascii?q?A0EXAACPsZNnj9lUsotaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDfVozBAtIhFaIHV+GUoIhA54YgX4PAQMBDTETBAEBAwSCDIJ0Aop1Ah4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFS?=
 =?us-ascii?q?YV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBIx0BATcBBAsLGAICJ?=
 =?us-ascii?q?gICVgYTFIJtAYJBIwO4Q3qBMoEBggwBAQbcH4FkAwaBGi4BiE0BhWsbg2J6J?=
 =?us-ascii?q?4IohD8+hEODW4JpghwXS4EpgjSBDIsRgT2EQYRnPooFSAp7HANZLAFVEw0KC?=
 =?us-ascii?q?wcFYUhIAzYMCzAVI4EmBTUKNzqCDWlJNwINAjWCHnyCK4IfgjuERYRThVuCF?=
 =?us-ascii?q?IFlAwMWEYI1cnsfgSgdQAMLGA1IESw3FBsGPQFuB5wjATyDfIEQK4EFDElFG?=
 =?us-ascii?q?AQ8kkCDTwGMXaMjhCWMGJUuTYQEjQaGOpMPmHyOBJspgWc6gVxNMIMqTwMZD?=
 =?us-ascii?q?44hDA0JFohWwFZCNTwCBwEKAQEDCZAjgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xoER1K0fK+xgLPDfxt57ZwqjBLckLtp133Aq2lEZdPWaSK2lfq
 eV7Y0mPH7P+VAssRQb9OxoV5PtfZqxz/FICMwqTNWftWrdyQyVxeNZnOjfKlTbckWUnNK1l5
 0QFpSWY+eRMbEVt6jHCXGDYrId/OU=
X-Talos-CUID: 9a23:wMcOmmO/1KaS4+5DXBFNyxYZPcUebmTE/HTuKFa3CE9sR+jA
X-Talos-MUID: 9a23:twKt+AoVuCr78KeOhKYezztoOJ91yIOPMl4mu4s85eSOMzMrCw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="204895247"
X-MGA-submission: =?us-ascii?q?MDF3njETPLXgCmeQj9XOjWajVrYBvUcrED+0Cg?=
 =?us-ascii?q?DQAwgIRhruz0o5/NCaLc8HRHMp4TLbfRFdOqI1HX+zPovItaZT+xseCH?=
 =?us-ascii?q?r2m928ycx+dqYCUXltL7Y0PLH7i2P0xTfDAvhSeuxmgIOYq+2OA2sCXL?=
 =?us-ascii?q?1RWhhdkQ38HdaWyf6xOvg2BA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 16:29:30 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4AF3F5C4B92;
	Fri, 24 Jan 2025 15:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6EFC4CED2;
	Fri, 24 Jan 2025 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737732568;
	bh=ChQwyx9ou1MQai7Seraqgab5uZ5KJv/6Tgq7MNDhUhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uigEQoiIjkXxJ20JO73f87y2KEY+jWTS8X1vjt8pER827MglxF5IMH33+3bGy+JL6
	 n9nMNmpn8j5rdsfpqGfSZk+NehQRvvOKQWYqfQVfInpv1SGkj6L+Df/g8D5R/x2WOZ
	 VvMinIZozTpRqG6M1+nFyaXlp7Ykjp6dxNA90RPyZxOs4JfMPZeTZ3+dRU1mJ5R8gc
	 Gkmg4wo0tVVMeq8KsOIuswC2HCqQKZAZhoMyH5ScOUYJ2SGHNV5T3rmt6d9NboL2pM
	 moLcc63NclEZBlBxEsO7Lwo07F5wNnnzm7VVgqOcKDZZBT8uU14rQl2AGkfnihpGTt
	 Vz+4sm62k4lnQ==
Date: Fri, 24 Jan 2025 16:29:16 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, Jarkko Sakkinen	
 <jarkko@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leonardo =?UTF-8?B?QnLDoXM=?=	 <leobras.c@gmail.com>, Vignesh Raman
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
 melissa.srw@gmail.com, simona@ffwll.ch, airlied@gmail.com,
 Tim.Bird@sony.com, broonie@kernel.org, groeck@google.com,
 rdunlap@infradead.org, geert@linux-m68k.org, michel.daenzer@mailbox.org,
 sakari.ailus@iki.fi
Message-ID: <20250124162916.38e5c6a0@foz.lan>
In-Reply-To: <b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	<298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
	<b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2251
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250124162916.38e5c6a0%40foz.lan>

Em Fri, 24 Jan 2025 09:26:33 -0500
Nicolas Dufresne <nicolas.dufresne@collabora.com> escreveu:

> Hi,
>=20
> Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Nikolai Kondrashov a =C3=
=A9crit=C2=A0:
> > On 1/24/25 2:16 PM, Jarkko Sakkinen wrote: =20
> > > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote: =20
> > > > Gitlab as an open-source software project (the community edition) i=
s one
> > > > thing, but can we please avoid advertising specific proprietary ser=
vices
> > > > in the kernel documentation ? =20
> > >=20
> > > I don't think we should have any of this in the mainline kernel.
> > >=20
> > > One angle is that "no regressions rule" applies also to the shenaniga=
ns.
> > >=20
> > > Do we really spend energy on this proprietary crap to the eternity? =
=20
> >=20
> > This is not getting included into the kernel itself, the contributed co=
de is,
> > of course, open-source. And yes it would execute just fine on the fully
> > open-source community-edition GitLab.=20

> > I don't think "no regressions rule" should apply here.

It doesn't, as this is not a Kernel userspace API. It is just some
facility to integrate Kernel builds using a CI infrastructure. This can
change with time as needed.

Still, once people start using it, developers need to take some care to
avoid regressions that would cause CI builds to fail for the ones using
such facilities.

Also, ideally, this should be completely independent of the Kernel version,
e.g. if one sets up an infra using the version that was there when, let's
say, Kernel 6.14 is released, the same CI scripts should work just fine
with stable Kernels and even future Kernels.

Due to that, I'm not convinced that such kernel CI files should be
hosted at the Kernel tree.

IMO, this should be stored on a separate repository hosted at
kernel.org, using Semantic Versoning (https://semver.org/) - e. g.
when there are incompatible changes, major version number will be
increased.

> > This is for developers only, and is a template for making
> > your own pipeline mostly, with pieces which can be reused. =20
>=20
> Perhpas worth clarifying that Media and DRM subsystem have opted for the
> Freedesktop instance. This instance is running the Open Source version of
> Gitlab, with hundreds of CI runners contributed and shared among many pro=
jects
> (which includes Mesa, GStreamer, Wayland, Pipewire, libcamera, just to na=
me
> few).

It doesn't matter much what git forge some projects are currently using, as
things like that could change with time.=20

Starting with supporting just one type of git forge sounds OK to me,
but long term goal should be to make it generic enough to be used with as
much CI engines as possible - not only forges developed by companies that
provide paid services like Gitlab/Github, but also completely open
source forges and even Jenkins.

Thanks,
Mauro
