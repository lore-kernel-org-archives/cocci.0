Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0740C0218D
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XqoYrz1As8fQclDj4knZBeMDedtFY4BX82AcbJjtwi0=;
  b=sckPRozxZkw3qF/VdPkgIATx6K3TMkpXDpf7TW1cA6IvvnbbrZHM6gQV
   fDSEJILYy3YiinUYBadv/fpGUOIfHlIH6cJRnbPfHdoXWqG/XNvM1iUt6
   YuDMkp9+pIbpcuNG/z44nxSneVEAFUCyO7ICtshgrEtutQM2xk9GnWAdv
   Q=;
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
   d="scan'208";a="205325438"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5DDAFE0E89; Tue, 28 Jan 2025 10:13:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A5B88E0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 07:39:44 +0100 (CET)
IronPort-SDR: 67972a30_u5U7iiATBqS0MHj8Uy2+pIU+1mfCGBEnUlrhCZVDENUdLie
 4O34mqClJ6h4EIfXlOrfverVYcwe0UkZekUMe/Q==
X-IPAS-Result: =?us-ascii?q?A0ENAACRKZdnj9lUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYIbKH1aMwQLSIRWiB1fhlOCIQORSoxOgX4PAQMBDTETBAEBAwSCD?=
 =?us-ascii?q?IJ0Aop1Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAQEBATkFSYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBIx0BA?=
 =?us-ascii?q?TcBBAsLGAICJgICVgYTFAeCZwGCQSMDtV56gTKBAYIMAQEG3B+BZAMGgRouA?=
 =?us-ascii?q?YhNAYVrG4NieieCKIEVgyo+hEODW4JpghwXS4EpgjSBDIsSgTuEQYRnPoojS?=
 =?us-ascii?q?Ap7HANZLAFVEw0KCwcFYUhIAzYMCzAVI4EmBTUKNzqCDWlJNwINAjWCHnyCK?=
 =?us-ascii?q?4IhgjuERYRRhV6CFIFlAwMWE4I1cnkegU0dQAMLGA1IESw3FBsGPQFuB5w5A?=
 =?us-ascii?q?TyDfwIsYit7CgwPIwIVRRgEAjqSQINPAYxdoyOEJYwYlS5NhASNBoY6j0GDT?=
 =?us-ascii?q?pgYZI4ElVAHBAuFQ4FnOoFcTTBDgmdPAxkPjiEMDQkWdgEJh1XCQkI1PAIHA?=
 =?us-ascii?q?QoBAQMJkBiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:PJ3gY6+OFnn/ZGLP1Hxuk+DdI+orL9Y04lQ7vn2ZhyY1TiX+rb
 HWoB17726TtN91YhwdcL+7VJVoLUmyyXcx2/hyAV7AZniAhILLFvAA0WKK+VSJcEfDH6xmpM
 JdmsNFaOEYY2IVsS+D2njdL+od
X-Talos-CUID: 9a23:dV6/H27dxdxxwsSGXtss7BYmIJ84Ik/myXKOZFeyLm9SUpK3RgrF
X-Talos-MUID: 9a23:TxR6ewrfFz5swmRE17Iez2twaYRO6qquMwMuiplW/OSZEg5AOA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,237,1732575600"; 
   d="scan'208";a="205083358"
X-MGA-submission: =?us-ascii?q?MDHNxmXl/h3oZtL3NJEwlIXxDxg4l7xHmA2PcW?=
 =?us-ascii?q?4Z09bkITlz9MfwjrNwxHTFeiLKVlqvykD4mv0x/RVLE6lvpBhK33CGWb?=
 =?us-ascii?q?C6OWeJiSdWI1MSVRuhg6GjwHEDzyHbxcjzd2wsLRWP2q342WN6z4rzee?=
 =?us-ascii?q?VtgbvBRR5cMHjZUeizsGGyxg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:39:43 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B3CB75C459F;
	Mon, 27 Jan 2025 06:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D25C4CED2;
	Mon, 27 Jan 2025 06:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737959980;
	bh=o0L9ITlbXOuGoG5NvSGkBzqfS1QOGvu9eKNxY3F9rHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxNfvZiRWJwa/UVTqhlDj9DaNKCCoh7fy2jNfvL+/1YFt0KI6yr3MRvyWSCv9fOT/
	 hWOPCpYqBZkH7Tm/DG1eRJFvL7wLwTJmabXYY4tNdo8XaNe2rMVK2QHsKZxB05Abm6
	 JGO7LPaTa+WZiPZe656OG3/9h+NlimjjUH5D90qJ35EYQiESb6M936sYoWbiUtliXW
	 ZsWMEu6YoCos20hKD2g18+sWnRC9tNppWG0uY3vb01wYpxSdpGyPrgE4ktyCx6rNTB
	 TCW20ZbrmBmV+XHlSnwt7wC2xmA6oryeNUQDl30mpZAZppbzLmHv+5QPmGGGfVwWCh
	 kDBsvl5T4nSzg==
Date: Mon, 27 Jan 2025 07:39:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc: "Nicolas Dufresne" <nicolas.dufresne@collabora.com>, "Nikolai
 Kondrashov" <Nikolai.Kondrashov@redhat.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Leonardo =?UTF-8?B?QnLDoXM=?="
 <leobras.c@gmail.com>, "Vignesh Raman" <vignesh.raman@collabora.com>,
 "kernelci" <kernelci@lists.linux.dev>, "linuxtv-ci"
 <linuxtv-ci@linuxtv.org>, "dave.pigott" <dave.pigott@collabora.com>,
 "mripard" <mripard@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel@lists.freedesktop.org>, "linux-kselftest"
 <linux-kselftest@vger.kernel.org>, "gustavo.padovan"
 <gustavo.padovan@collabora.com>, "pawiecz" <pawiecz@collabora.com>,
 "spbnick" <spbnick@gmail.com>, "tales.aparecida"
 <tales.aparecida@gmail.com>, "workflows" <workflows@vger.kernel.org>,
 "skhan" <skhan@linuxfoundation.org>, "kunit-dev"
 <kunit-dev@googlegroups.com>, "nfraprado" <nfraprado@collabora.com>,
 "davidgow" <davidgow@google.com>, "cocci" <cocci@inria.fr>, "Julia.Lawall"
 <Julia.Lawall@inria.fr>, "laura.nao" <laura.nao@collabora.com>, "kernel"
 <kernel@collabora.com>, "torvalds" <torvalds@linuxfoundation.org>, "gregkh"
 <gregkh@linuxfoundation.org>, "daniels" <daniels@collabora.com>,
 "shreeya.patel" <shreeya.patel@collabora.com>, "denys.f"
 <denys.f@collabora.com>, "louis.chauvet" <louis.chauvet@bootlin.com>,
 "hamohammed.sa" <hamohammed.sa@gmail.com>, "melissa.srw"
 <melissa.srw@gmail.com>, "simona" <simona@ffwll.ch>, "airlied"
 <airlied@gmail.com>, "Tim.Bird" <Tim.Bird@sony.com>, "broonie"
 <broonie@kernel.org>, "groeck" <groeck@google.com>, "rdunlap"
 <rdunlap@infradead.org>, "geert" <geert@linux-m68k.org>, "michel.daenzer"
 <michel.daenzer@mailbox.org>, "sakari.ailus" <sakari.ailus@iki.fi>
Message-ID: <20250127073400.6307d033@foz.lan>
In-Reply-To: <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	<298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
	<b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
	<20250124162916.38e5c6a0@foz.lan>
	<19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2266
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250127073400.6307d033%40foz.lan>

Em Fri, 24 Jan 2025 16:49:30 -0300
Helen Mae Koike Fornazier <helen.koike@collabora.com> escreveu:

> Hi Mauro,
>=20
>=20
>=20
> ---- On Fri, 24 Jan 2025 12:29:16 -0300 Mauro Carvalho Chehab  wrote ---
>=20
>  > Em Fri, 24 Jan 2025 09:26:33 -0500=20
>  > Nicolas Dufresne nicolas.dufresne@collabora.com> escreveu:=20
>  >   =20
>  > > Hi,=20
>  > >=20
>  > > Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Nikolai Kondrashov a=
 =C3=A9crit=C2=A0:  =20
>  > > > On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:  =20
>  > > > > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:  =20
>  > > > > > Gitlab as an open-source software project (the community editi=
on) is one=20
>  > > > > > thing, but can we please avoid advertising specific proprietar=
y services=20
>  > > > > > in the kernel documentation ?  =20
>  > > > >=20
>  > > > > I don't think we should have any of this in the mainline kernel.=
=20
>  > > > >=20
>  > > > > One angle is that "no regressions rule" applies also to the shen=
anigans.=20
>  > > > >=20
>  > > > > Do we really spend energy on this proprietary crap to the eterni=
ty?  =20
>  > > >=20
>  > > > This is not getting included into the kernel itself, the contribut=
ed code is,=20
>  > > > of course, open-source. And yes it would execute just fine on the =
fully=20
>  > > > open-source community-edition GitLab.  =20
>  >   =20
>  > > > I don't think "no regressions rule" should apply here.  =20
>  > =20
>  > It doesn't, as this is not a Kernel userspace API. It is just some=20
>  > facility to integrate Kernel builds using a CI infrastructure. This ca=
n=20
>  > change with time as needed.=20
>  > =20
>  > Still, once people start using it, developers need to take some care t=
o=20
>  > avoid regressions that would cause CI builds to fail for the ones usin=
g=20
>  > such facilities.=20
>  > =20
>  > Also, ideally, this should be completely independent of the Kernel ver=
sion,=20
>  > e.g. if one sets up an infra using the version that was there when, le=
t's=20
>  > say, Kernel 6.14 is released, the same CI scripts should work just fin=
e=20
>  > with stable Kernels and even future Kernels.  =20
>=20
> Or you can just configure your GitLab CI to work and an older version of
> the script by just pointing the right yaml URL at that versions in the co=
nfigs,
> or am I missing something?

The problem of placing them altogether is that it would be hard to track
incompatible changes, as there's not separate versioning for the yaml
files.

>  > =20
>  > Due to that, I'm not convinced that such kernel CI files should be=20
>  > hosted at the Kernel tree.=20
>  > =20
>  > IMO, this should be stored on a separate repository hosted at=20
>  > kernel.org, using Semantic Versoning (https://semver.org/) - e. g.=20
>  > when there are incompatible changes, major version number will be=20
>  > increased.  =20
>=20
> A key benefit of having it in-tree is the test expectation list, as seen =
with
> DRM-CI. This allows developers to track the state of drivers and progress=
 over
> time by showing which tests are expected to pass or fail at a given point=
 in
> history. (From what I see in DRM-CI, this adds a considerable amount of v=
alue.)
> Please check the VKMS patch in this patchset.

I'm not saying that everything should be on a separate tree. Things like
expected tests and test results are dependent at Kernel versions.

What I'm saying is that hosting CI-specific files a separate repository is
better, as you can keep there what is generic.

> Also, if we keep this tool out of tree, I=E2=80=99m concerned that subsys=
tems like DRM
> and Media will continue not collaborating=E2=80=94each currently has its =
own solution
> when the base could be shared and reused. All static checks, build proces=
ses,
> and boot mechanisms are fundamentally the same, with only minor differenc=
es
> that are customizable. Other subsystems could use just the base or build =
their
> specific configurations/tests on top of it.

I'm in favor of having a common set of CI tooling for all subsystems intere=
sted
on setting up CI. Yet moving part of it to be on a separate repository won't
prevent collaboration. Also, either in or out of tree won't avoid different
subsystems to use different solutions.

What would make people use it is the capability of quickly setting it up
on a new repository. For this to happen, documentation is really important.
Equally important is to have support for multiple git forges and other CI e=
ngines.

For instance, besides media and DRM, I'm also personally interested on havi=
ng
it setup for other subsystems that I also collaborate.

> Having it in-tree sends a message: "You can create your own GitLab CI pip=
eline,
> but why not use this existing one, contribute to it, and collaborate for
> everyone's benefit?".
>
> Since it's under the tools/ folder, it=E2=80=99s a helper tool.

It makes sense to have it documented at the Kernel Documentation folder
and to have something at tools/ that would setup the git forge repositories=
=20
used for CI to do Kernel builds.

> Make sense?
>=20
> Thanks,
> Helen
>=20
>  >   =20
>  > > > This is for developers only, and is a template for making=20
>  > > > your own pipeline mostly, with pieces which can be reused.  =20
>  > >=20
>  > > Perhpas worth clarifying that Media and DRM subsystem have opted for=
 the=20
>  > > Freedesktop instance. This instance is running the Open Source versi=
on of=20
>  > > Gitlab, with hundreds of CI runners contributed and shared among man=
y projects=20
>  > > (which includes Mesa, GStreamer, Wayland, Pipewire, libcamera, just =
to name=20
>  > > few).  =20
>  > =20
>  > It doesn't matter much what git forge some projects are currently usin=
g, as=20
>  > things like that could change with time.=20
>  > =20
>  > Starting with supporting just one type of git forge sounds OK to me,=20
>  > but long term goal should be to make it generic enough to be used with=
 as=20
>  > much CI engines as possible - not only forges developed by companies t=
hat=20
>  > provide paid services like Gitlab/Github, but also completely open=20
>  > source forges and even Jenkins.=20
>  > =20
>  > Thanks,=20
>  > Mauro=20
>  >  =20
>=20



Thanks,
Mauro
