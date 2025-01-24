Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ACFC0218D
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=P3plHeS1o3KvPZ1XoCcefzHmD3HT2RUHL6C1XVcnSgw=;
  b=IvpEQu9+GDMLC5GbFZ9hHKPhlGD77qFo4AFqpD+M+Voz3i9ABu5ugSX1
   /V1Hvd2YoRHUOAN8Lp4G6VL+9Mt812IP/RJgP7rBW+dEQuF2+cY5FHeaR
   k55M1Gqj5+G211Q7+to3R8iavsfuH86qMX0nDYtpPYWSmS1zpQJH1SKYm
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=helen.koike@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325244"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D448E0D79; Tue, 28 Jan 2025 10:13:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 91E04E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 20:50:23 +0100 (CET)
IronPort-SDR: 6793eefe_AmodpDrlNMXbgHcV84I4rRjmNqdA2APElt+rSh4AsdyCAWy
 reo4uE5dXJ7hrbFBc/F0VNFnlpFs2TsNgzcJiaw==
X-IPAS-Result: =?us-ascii?q?A0EbAAD47ZNng3C8j4haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVk0BAtIg1CBBogdhzGCIQORSoxOgX4PAQMBDTETBAEBAwEDg?=
 =?us-ascii?q?gyCbgQCAop0Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAQE5Bw47hXsNgmI0cYElAQEBAQEBAQEBAQEBAR0CCAVeAQEdAQEBA?=
 =?us-ascii?q?QIBIx0BATcBDwsYAgImAgJWBgwHFAeCZgGCQSMDuQN6gTKBAYIMAQEG3B+BZ?=
 =?us-ascii?q?AMGgRouAYVqglkKAYFsg38bg2J6J4FkRIEVgyo+hEODW4JpghwXS4EpgjSBD?=
 =?us-ascii?q?IsRgT2EQYRnPooOCT8KexwDWSwBVRMNCgsHBYEpSAM2DAswFSOBJgU1Cjc6g?=
 =?us-ascii?q?g1pSTcCDQI1gh58giuCH4I7hEWEU4VbghSBZQMDFhGCNXJ7H4EwDw5AAwsYD?=
 =?us-ascii?q?UgRLDcUGwY+bgecKAE8g30CLGIrgQUMDzpFGAQ8kkCDTwGMXaMjB4QejBiVe?=
 =?us-ascii?q?4QEjQaVe4NOmHyOBJVQCwuFQ4FnOoFcMxojUIJnTwMZD44hDA0JFoNChRTBY?=
 =?us-ascii?q?CwyPAIHAQoBAQMJkCKBSwEB?=
IronPort-PHdr: A9a23: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
 kxjcjzDQuAJ51OPXWtsjAvVs5xVELhXSqgWOXct
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DiDU+6wML+ivBfLRrBsUKrPwDb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYfgqKRIdcLe7SdG9qBLnhOdICOwqUYtKMzOJhILFFuBfBKrZskbd8mjFh4tgPM
 RbAs5D4b/LfDpHZK/BiWHWLz9j+qjizEnCv5a4854Cd2FXgu1bnn1E436gYzBLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3A5qs30GnBVdfBc5y19IZe3uNNjMrXOSCD5UrgAUi?=
 =?us-ascii?q?xNVpwEKPFZ0CvpIZi1OM7zg=3D=3D?=
X-Talos-MUID: 9a23:JBCqIASUOvhJbH1iRXTNghZSc+wz+5iHUkQHyoc5/Pm2LhF/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,232,1732575600"; 
   d="scan'208";a="107312418"
X-MGA-submission: =?us-ascii?q?MDElLrS2biRAdG/9ioIQj7LM6M2wRwt8jrMHVC?=
 =?us-ascii?q?vQ1zbvkwTPyFu6yNQmNYDo7PrNaNkNIOg031B9bjStlGCJqTMP/vDKvM?=
 =?us-ascii?q?35GK7Z1x7z4jT06KrkZnXyq0wCefToP9PlT5twU9nwa/vV9MnDbcX7fu?=
 =?us-ascii?q?JHkTRKlHg2vG3bwCeULyI62g=3D=3D?=
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 20:50:21 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1737748172; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ky4r6TF07Lob+Ez5NvZxliQNWjB06Ko6ISb5A8jkdRrK7cWRkjawZZv99VwjE+CpwqAPfPVQycd8SooO/SF/FtRQfRIch6f78vzJ0wDraBlkGKfGDMMO5nIBHdw9O6MPFo4/z8/mql1sNo/LFWfnKvmEpr8dTJp52QqwBDXMuHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737748172; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P3plHeS1o3KvPZ1XoCcefzHmD3HT2RUHL6C1XVcnSgw=; 
	b=h8iYZaTY/Xye1Wl3/TjEaXv4nB4nn2J/y/z2lKE4foZ5PefjqoKK08K01dEqaD1OOA801IpFfe3MbtwnolnNi8irplmauwxvBXgH/DcxuIFoyLt6pLmcMdvPX/DJe3cEtc3DEaobSP1xldtkEasiG3VBrD99AO726WIoXNANBdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737748172;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=P3plHeS1o3KvPZ1XoCcefzHmD3HT2RUHL6C1XVcnSgw=;
	b=G6dRYyspG/n+UZlni8DR0M1S94yBZIZtpGcCi9rwapNjc4V4MuO26GvzfejV3Gta
	+3ulO24vLha/n+JGzLD20695nB94aQ5TiG8tVk25OnLtay10v5bsgdos/ziuqBVI8I5
	4hnDxGrvctHtow+i8LiyR1PwFKfEKnrrplo0tUnw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1737748170108910.7137931457631; Fri, 24 Jan 2025 11:49:30 -0800 (PST)
Date: Fri, 24 Jan 2025 16:49:30 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Cc: "Nicolas Dufresne" <nicolas.dufresne@collabora.com>,
	"Nikolai Kondrashov" <Nikolai.Kondrashov@redhat.com>,
	"Jarkko Sakkinen" <jarkko@kernel.org>,
	"Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
	=?UTF-8?Q?=22Leonardo_Br=C3=A1s=22?= <leobras.c@gmail.com>,
	"Vignesh Raman" <vignesh.raman@collabora.com>,
	"kernelci" <kernelci@lists.linux.dev>,
	"linuxtv-ci" <linuxtv-ci@linuxtv.org>,
	"dave.pigott" <dave.pigott@collabora.com>,
	"mripard" <mripard@kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"gustavo.padovan" <gustavo.padovan@collabora.com>,
	"pawiecz" <pawiecz@collabora.com>, "spbnick" <spbnick@gmail.com>,
	"tales.aparecida" <tales.aparecida@gmail.com>,
	"workflows" <workflows@vger.kernel.org>,
	"skhan" <skhan@linuxfoundation.org>,
	"kunit-dev" <kunit-dev@googlegroups.com>,
	"nfraprado" <nfraprado@collabora.com>,
	"davidgow" <davidgow@google.com>, "cocci" <cocci@inria.fr>,
	"Julia.Lawall" <Julia.Lawall@inria.fr>,
	"laura.nao" <laura.nao@collabora.com>,
	"kernel" <kernel@collabora.com>,
	"torvalds" <torvalds@linuxfoundation.org>,
	"gregkh" <gregkh@linuxfoundation.org>,
	"daniels" <daniels@collabora.com>,
	"shreeya.patel" <shreeya.patel@collabora.com>,
	"denys.f" <denys.f@collabora.com>,
	"louis.chauvet" <louis.chauvet@bootlin.com>,
	"hamohammed.sa" <hamohammed.sa@gmail.com>,
	"melissa.srw" <melissa.srw@gmail.com>, "simona" <simona@ffwll.ch>,
	"airlied" <airlied@gmail.com>, "Tim.Bird" <Tim.Bird@sony.com>,
	"broonie" <broonie@kernel.org>, "groeck" <groeck@google.com>,
	"rdunlap" <rdunlap@infradead.org>, "geert" <geert@linux-m68k.org>,
	"michel.daenzer" <michel.daenzer@mailbox.org>,
	"sakari.ailus" <sakari.ailus@iki.fi>
Message-ID: <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
In-Reply-To: <20250124162916.38e5c6a0@foz.lan>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	<298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
	<b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com> <20250124162916.38e5c6a0@foz.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Helen Mae Koike Fornazier <helen.koike@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2259
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/19499dcc55d.d07a9615183956.5491109771298297030%40collabora.com>

Hi Mauro,



---- On Fri, 24 Jan 2025 12:29:16 -0300 Mauro Carvalho Chehab  wrote ---

 > Em Fri, 24 Jan 2025 09:26:33 -0500=20
 > Nicolas Dufresne nicolas.dufresne@collabora.com> escreveu:=20
 > =20
 > > Hi,=20
 > >=20
 > > Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Nikolai Kondrashov a =
=C3=A9crit=C2=A0:=20
 > > > On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:=20
 > > > > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:=20
 > > > > > Gitlab as an open-source software project (the community edition=
) is one=20
 > > > > > thing, but can we please avoid advertising specific proprietary =
services=20
 > > > > > in the kernel documentation ?=20
 > > > >=20
 > > > > I don't think we should have any of this in the mainline kernel.=
=20
 > > > >=20
 > > > > One angle is that "no regressions rule" applies also to the shenan=
igans.=20
 > > > >=20
 > > > > Do we really spend energy on this proprietary crap to the eternity=
?=20
 > > >=20
 > > > This is not getting included into the kernel itself, the contributed=
 code is,=20
 > > > of course, open-source. And yes it would execute just fine on the fu=
lly=20
 > > > open-source community-edition GitLab.=20
 > =20
 > > > I don't think "no regressions rule" should apply here.=20
 > =20
 > It doesn't, as this is not a Kernel userspace API. It is just some=20
 > facility to integrate Kernel builds using a CI infrastructure. This can=
=20
 > change with time as needed.=20
 > =20
 > Still, once people start using it, developers need to take some care to=
=20
 > avoid regressions that would cause CI builds to fail for the ones using=
=20
 > such facilities.=20
 > =20
 > Also, ideally, this should be completely independent of the Kernel versi=
on,=20
 > e.g. if one sets up an infra using the version that was there when, let'=
s=20
 > say, Kernel 6.14 is released, the same CI scripts should work just fine=
=20
 > with stable Kernels and even future Kernels.=20

Or you can just configure your GitLab CI to work and an older version of
the script by just pointing the right yaml URL at that versions in the conf=
igs,
or am I missing something?

 > =20
 > Due to that, I'm not convinced that such kernel CI files should be=20
 > hosted at the Kernel tree.=20
 > =20
 > IMO, this should be stored on a separate repository hosted at=20
 > kernel.org, using Semantic Versoning (https://semver.org/) - e. g.=20
 > when there are incompatible changes, major version number will be=20
 > increased.=20

A key benefit of having it in-tree is the test expectation list, as seen wi=
th
DRM-CI. This allows developers to track the state of drivers and progress o=
ver
time by showing which tests are expected to pass or fail at a given point i=
n
history. (From what I see in DRM-CI, this adds a considerable amount of val=
ue.)
Please check the VKMS patch in this patchset.

Also, if we keep this tool out of tree, I=E2=80=99m concerned that subsyste=
ms like DRM
and Media will continue not collaborating=E2=80=94each currently has its ow=
n solution
when the base could be shared and reused. All static checks, build processe=
s,
and boot mechanisms are fundamentally the same, with only minor differences
that are customizable. Other subsystems could use just the base or build th=
eir
specific configurations/tests on top of it.
Having it in-tree sends a message: "You can create your own GitLab CI pipel=
ine,
but why not use this existing one, contribute to it, and collaborate for
everyone's benefit?".
Since it's under the tools/ folder, it=E2=80=99s a helper tool.

Make sense?

Thanks,
Helen

 > =20
 > > > This is for developers only, and is a template for making=20
 > > > your own pipeline mostly, with pieces which can be reused.=20
 > >=20
 > > Perhpas worth clarifying that Media and DRM subsystem have opted for t=
he=20
 > > Freedesktop instance. This instance is running the Open Source version=
 of=20
 > > Gitlab, with hundreds of CI runners contributed and shared among many =
projects=20
 > > (which includes Mesa, GStreamer, Wayland, Pipewire, libcamera, just to=
 name=20
 > > few).=20
 > =20
 > It doesn't matter much what git forge some projects are currently using,=
 as=20
 > things like that could change with time.=20
 > =20
 > Starting with supporting just one type of git forge sounds OK to me,=20
 > but long term goal should be to make it generic enough to be used with a=
s=20
 > much CI engines as possible - not only forges developed by companies tha=
t=20
 > provide paid services like Gitlab/Github, but also completely open=20
 > source forges and even Jenkins.=20
 > =20
 > Thanks,=20
 > Mauro=20
 >=20

