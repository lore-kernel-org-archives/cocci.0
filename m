Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022EBC02193
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bPcr0RKhMhDtLdbfCMgWqzU/jgE4vjruqfDCkUBsVps=;
  b=udVoDSoKtu7M3K/8xCXlz0hWkwPlPNBH5g3Es5EhpOvnWI/ZrKxQQHU0
   2o+SpXu1cAlJTEbN5050UMp6dFFHv7gWE7em2WDhbI+8mrwAK/Fh6GmdM
   VghWyqYdP7peIFmEJTR6FcmT4M1/jQtseMCeD3fdh6DvcDClIipvfJ7et
   M=;
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
   d="scan'208";a="205325565"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 648F5E0ED4; Tue, 28 Jan 2025 10:13:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9F1BE0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 08:07:15 +0100 (CET)
IronPort-SDR: 679730a3_LkwaqrruDl2Cml/vgYNz06AGF15l4ynjAq0FDqR/Kh3g/IF
 rdaxBs65lQuGJ3MO3Prnsd2U/V5eIrFYQ06LjrA==
X-IPAS-Result: =?us-ascii?q?A0F0AQBLL5dnj9lUsotagQmBU4JEfVozBAtIBIRSg0+FL?=
 =?us-ascii?q?YZTgiEDnEKBVhSBag8BAwENOQsEAQEDAQOCDIJ0Aop1Ah4HAQQyBw4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYV7DYJiATNxg?=
 =?us-ascii?q?SUBAQEBAQEBAQEBAQEBAQEBAQEBFwINfQEBAQECASMdAQEuCQEECwsYAgIRF?=
 =?us-ascii?q?QICVgYTFIJuAYJBIwMRtUx6gTKBAYIMAQEGgQjbF4FkCYEaLog0GgFyhHkbg?=
 =?us-ascii?q?2J6J4Iogz1PMz6DfEc/gxyCaYIzS0VkgSqBCoEMhzWDXYE7X4FfFiEleyyEZ?=
 =?us-ascii?q?0IEEVwvPohBSAp7HANZLAFVEw0KCwcFYUhIAzYMCzAVI4EmBTUKNzqCDWlJN?=
 =?us-ascii?q?wINAjWCHnyCK4IhgjuERYRRhV6CFIFlAwMWE4I1cnkegU0dQAMLGA1IESw3F?=
 =?us-ascii?q?BsGPQFuB5w5ATyDf4EjCBAgAjsUChZtNQRAkkAIg0ewAYQljBiSJIMKTYQEg?=
 =?us-ascii?q?VeLL4Y6kw+YfIsyWYF5lVOFVoFuBi2BXE0wgyoJCjwDGQ+LSIJlDQkWg0KFE?=
 =?us-ascii?q?y7CEkI1AgE5AgcBCgEBAwmQGIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QOKKFK6cDulyx2zTtQPXwM3XdLJyesId70hD6qm+c31om6uj5r
 mTdZUgpHnJYVMqNU3I9urtBEDtexzhHNtOkOss1NSZLW7bUQmTXeJfBOLZqlWKcREWtNQtsJ
 uIGJIfNDSfNzZHZL7BkW2FL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3ALoAmfWnlsSrJh/kNDrIKxbJCXsfXOVn+0S3xCQz?=
 =?us-ascii?q?kM2dOcL/IR32x6bhizvM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A+YS8Dw73m3PPmE29We6gaXH1xox0zvuTJH8Br64?=
 =?us-ascii?q?bkPCYNyd2AR2lj2iOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,237,1732575600"; 
   d="scan'208";a="205086781"
X-MGA-submission: =?us-ascii?q?MDGHCCwi0SMYLy/M6Cp3Z26+/yYdiRvSonRd/f?=
 =?us-ascii?q?oMGRi53rMH6UsQiPf2JonAe1HbxqNhKA+j5/cyGd+FtQj9p1OGEetKiz?=
 =?us-ascii?q?ird1NvFmFu7lguJKscrx/YOlSgLr68t2aoramAOoezQmpIiWGKeNgK8M?=
 =?us-ascii?q?JVD6hXbc5gTaDnYTlNu9yURQ=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:07:15 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1DEC75C0C3F;
	Mon, 27 Jan 2025 07:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF15DC4CEE4;
	Mon, 27 Jan 2025 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737961633;
	bh=9Ez1zOChWlmyhAFXJELL4Q+Ba8u7zI70k04btQJ7GY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZ3yAWrbH0ux0vOf0oP6c8x4wyiAhU+pzINvZTmepJq8amVfhad2FZTMJ3Pfam/B3
	 hBvyREeMomlzBmyiw1+EhdtrYAendqzX2erOtad0dQiSG8N3ZaGT8wezgigwHKYddf
	 zFwQiVkPOBwtXK2fW/ypHzo2doKJ6qbzAjEjt2tXpntOeunKP239ejfuiYurMjqXpw
	 3KEdYFnyxzL3E+nh+3FxoAS++7hc/NxEhwZz63y7yM1zKTbdXELeJlpJ1C+Y0BoSky
	 dKVRLHV+Hz6zFy+vf6EHcp8/VGAsg3vkI2UfTpsajcLiPCOyn276K4vqs9LvTSADAe
	 b37EheV7PDmBA==
Date: Mon, 27 Jan 2025 08:07:03 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leonardo =?UTF-8?B?QnLDoXM=?= <leobras.c@gmail.com>, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Vignesh Raman
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
 daniels@collabora.com, shreeya.patel@collabora.com, denys.f@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Message-ID: <20250127080618.55f5f915@foz.lan>
In-Reply-To: <20250127060738.GA16795@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<20250124135203.040d0852@foz.lan>
	<20250124130021.GA6853@pendragon.ideasonboard.com>
	<f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
	<bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
	<20250127060738.GA16795@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2267
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250127080618.55f5f915%40foz.lan>

Em Mon, 27 Jan 2025 08:07:38 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> On Fri, Jan 24, 2025 at 06:12:24PM -0300, Leonardo Br=C3=A1s wrote:
> > On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote: =20
> > > Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Laurent Pinchart a =
=C3=A9crit=C2=A0: =20
> > > > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wro=
te: =20
> > > > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > > > >  =20
> > > > > > > It's been a few years since I first thought on finding a good=
 way of helping
> > > > > > > kernel developers testing their patches, while making use of =
the free runner
> > > > > > > minutes Gitlab offers. It can greatly simplify the testing fo=
r people who are
> > > > > > > new to kernel development, or students trying to understand i=
t better.
> > > > > > >=20
> > > > > > > And this patchset allows that to happen :)
> > > > > > >=20
> > > > > > > Actually, I spoke to Helen last year, and to enable it to run=
 on the free
> > > > > > > Gitlab-CI runners, there is a small extra patch which is need=
ed:
> > > > > > >=20
> > > > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@r=
edhat.com/   =20
> > > > >=20
> > > > > Sounds interesting!
> > > > >  =20
> > > > > > Gitlab as an open-source software project (the community editio=
n) is one
> > > > > > thing, but can we please avoid advertising specific proprietary=
 services
> > > > > > in the kernel documentation ? =20
> > > > >=20
> > > > > Every time Gitlab is mentioned, the brand of the company that
> > > > > developed it and has been providing proprietary services is also
> > > > > advertised. If you're not happy with that, you should move to use
> > > > > a git forge developed by some open source community. =20
> > > >=20
> > > > I'm fine mentioning the gitlab community edition, I'm not fine
> > > > advertising gitlab.com SaaS in the kernel source tree. =20
> >=20
> > Hello Laurent,
> >=20
> > I see your point, and I see no issue on removing the two last lines of =
CI_TAGS
> > documentation.
> >=20
> > I just added this information on documentation because the default runn=
er used
> > for the Free Tier of Gitlab does not work for this CI, as it needs more
> > resources to run. This information can be added on some other place, bu=
t at the
> > time I thought it would be ok to let it be there.=C2=A0
> > This other runner I mentioned in the patch is also available on the Fre=
e Tier
> > (free as in beer).
> >=20
> > I would like to make it clear that I have no connection/affiliation to =
Gitlab,
> > other than a free account in their system, which I use for some CI. I h=
ave no
> > interest on advertising anything from them.
> >=20
> > My only objective is to make it easier to hobbyists/beginners to use th=
ose
> > available free minutes to test some change before sending the patch, if=
 they
> > think that's valuable. =20
>=20
> Given the 400 free computes minute per month, and the fact that the
> saas-linux-medium-amd64 runner consumers two minutes per minute, how
> many of the proposed CI runs would be available per month ?
>=20
> CI pipeline runs always compile the kernel from scratch as far as  can
> see. This may not be an issue for final testing before submission of a
> patch series, but it just won't work for incremental testing of changes.
> Think of how inefficient it would be to run a full pipeline just to get
> the checkpatch.pl output for instance. This is why I believe tests
> should focus first and foremost on ease of use in developers' local
> environments. A standardized, from-scratch, comprehensive test run as a
> gate keeper for integration has value as well, but that won't help
> beginners much.

To better cope with free minutes, CI pipelines should allow setting
up build just the subsystem instead of the entire Kernel. Not perfect,
but still if CI would test multiple archs/Kconfig options, it would
be useful to get early lots of potential issues.

That's said, using developers' local environments is interesting.
Yet, there's s potential risk of using it while having an external
entity running a git forge, as it would mean that a remote entity
would trigger something to run locally. Personally, I would=20

So, if I were to setup a local build environment, I would either use
a separate machine outside my internal network or I would opt to
install a local git forge instance. No idea how easy/hard would
be to maintain such local gitlab instance.

Thanks,
Mauro
