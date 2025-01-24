Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D52C0218A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AW3iy9ioSGDSR2gs4R3wC+1JZkWJ9KDlORtY+SMxvIE=;
  b=DC698v5rq14Sx1UOx60zSKOEUMIYzkCPuurGz30zpj37hBRr/LnlQHA9
   pJTq1P3d8k5tRmE4GbCqsC902kldshjJxVPqBlnK8SJBIy4o8RdW1Ppeb
   XpqolLVIhqm8VMx46CUrb7eVrEKqX5b1rqUDbPHYFCzcRJVxMuePEzp9p
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324860"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B24F3E0D85; Tue, 28 Jan 2025 10:13:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4BD03E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 14:00:33 +0100 (CET)
IronPort-SDR: 67938ef0_Z6bhBjKqrId8GazonN78Bb6d9XTizsqpHNWKnJlWOl3hJeA
 RzdcjY4KGvv7xAtWKw0gZIS82S+hFvg+RCTC9GQ==
X-IPAS-Result: =?us-ascii?q?A0FhAQAZjpNnhUDyp9VaHgEBCxIMQIFIC4JEfVonDAcIS?=
 =?us-ascii?q?ASEUoh8iAxnA4E/nFmBfg8BAwENOQsEAQEDAQOCDIJ0Aop1Ah8GAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiATNxg?=
 =?us-ascii?q?SUBAQEBAQEBAQEBAQEBAQEBAQEBFwINfQEBAQECASMdAQE3AQQLCxgCAhgOA?=
 =?us-ascii?q?gJWBhMUgm0BgkEjBwEMuB96gTKBAYIMAQEG3B+BZAmBGi6Fa4JjAYVrg316J?=
 =?us-ascii?q?w+BVUSBSoFzTzM+iB46gi+CM4F0gjQlZ4sRgT2CPhaBbYRngWOIYFJ7HANZL?=
 =?us-ascii?q?AFVExcLBwWBKUgDgRIjgSYFNQo3OoINaUk3Ag0CNYIefIIrgh+CO4RFhFOFW?=
 =?us-ascii?q?4IUgWUDAxYQAYI1cnsfgSgdQAMLbT03FBudXD2FHwgQcSCBJkCSQAiDR69NN?=
 =?us-ascii?q?AeEHoFdBgyKKZIkgwoESYQEgVeLL5lJmHyLMlmBeZp4MYFnOoFcTSODNwkKP?=
 =?us-ascii?q?AMZD44hGR+DQoUUwFdBNQIBOQIHCwEBAwmQI4FLAQE?=
IronPort-PHdr: A9a23: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
 5WrqiAZsz8=
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:oSbme6vAtdPOw5YE8hnRz13w7skDe9V00zEX/kB9WHVpmwKj+f
 xGuM5rsSMc6QxhPU3I/OrrBEDuex7hHPJOjbX5eI3SOzUO21HYTr2Kj7GD/9SIIUSXndK1l5
 0QEJSWY+eQMbEVt6nH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3AzBtTImqdfprvsecLK17Fm5PmUZ8PUXeB4ljXHxC?=
 =?us-ascii?q?pC0BCbLuUYmC126wxxg=3D=3D?=
X-Talos-MUID: 9a23:Wuyj3Qt17m0HqOueuM2nqzVSF8xDvJqUC10PmKgG49a8ERRyNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="204853283"
X-MGA-submission: =?us-ascii?q?MDHgT8VRxRVGzct+7U2BGawlx8XOjDZ+6XqcQ3?=
 =?us-ascii?q?QZyvlDJNPYkFpiloZJcmi5SMTzuQwDIK1fDtTOy++aISBgzUG07xwDTo?=
 =?us-ascii?q?DeXQhG5JGNGCHD6YenEZGCV0byQ6x2DzajArcgH2UaKQAwCnl6+JvZLg?=
 =?us-ascii?q?5FT7LQJZXoLHwrDeR4PfScKw=3D=3D?=
Received: from perceval.ideasonboard.com ([213.167.242.64])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 14:00:33 +0100
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3285514;
	Fri, 24 Jan 2025 13:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737723567;
	bh=xNXL25JANeVMtEb0+OfqIO3h2IoWDgiFX+8jcNI02p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4qb+ksvrFNjt1lUlMKYpvv6Llm2SfKel8ltpSoSKQB/zL+rhRnXN9nqD7v7PAZOT
	 0zQHazpPs0rYNHY58A5Q+uNQOh3k/vIWQckRdLAc34lAkpLOC2/lpa2DpLb/D1w8zX
	 yAx03s18qJJI2X4j5+o14/20nCIGnJQvwM78BlBY=
Date: Fri, 24 Jan 2025 15:00:21 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
	daniels@collabora.com, helen.koike@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
	airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
	groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Message-ID: <20250124130021.GA6853@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <20250124135203.040d0852@foz.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124135203.040d0852@foz.lan>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Loop: cocci@inria.fr
X-Sequence: 2248
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250124130021.GA6853%40pendragon.ideasonboard.com>

On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> 
> > > It's been a few years since I first thought on finding a good way of helping
> > > kernel developers testing their patches, while making use of the free runner
> > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > new to kernel development, or students trying to understand it better.
> > > 
> > > And this patchset allows that to happen :)
> > > 
> > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > 
> > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> 
> Sounds interesting!
> 
> > Gitlab as an open-source software project (the community edition) is one
> > thing, but can we please avoid advertising specific proprietary services
> > in the kernel documentation ?
> 
> Every time Gitlab is mentioned, the brand of the company that
> developed it and has been providing proprietary services is also
> advertised. If you're not happy with that, you should move to use
> a git forge developed by some open source community.

I'm fine mentioning the gitlab community edition, I'm not fine
advertising gitlab.com SaaS in the kernel source tree.

> The way I see, the best would be if the CI integration could work
> with more than one type of forge and being able to use any
> free Git??b-CI runners that would be available for developers to
> use, as this would allow testing more subsystems with CI, thus
> increasing code quality.

-- 
Regards,

Laurent Pinchart
