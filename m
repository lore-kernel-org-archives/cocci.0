Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F01BC0218A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jz5/hmxmF6z1lymaIefjN3fmjmXtR5QscHB+vV975r8=;
  b=IntUuUFv13/ET2ayCQQi/UO5n5kcUlmxpd4QCntpOOa9Jum1xopHlKpi
   rIvleUTXkUbgILCz9jgiyuo9ipNrLMY+pOHD5DfWGsATIqD4F9TNzGQ3t
   IzqWaA+/mTBJY8w2+xR9lIVbOVbIPDhfRDV2EytSIiPIIFEKeKEgSkxLk
   c=;
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
   d="scan'208";a="205325402"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 03BAEE0E7C; Tue, 28 Jan 2025 10:13:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 51B1DE0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 07:07:50 +0100 (CET)
IronPort-SDR: 679722b5_rj/fjXACLWm2o7tSXeMp08iSIFrGlYXbGJ3OX43qUNSbf1Q
 C6dDteDfqEFq8ocWNIpEbejTHc03z177CvNBHqQ==
X-IPAS-Result: =?us-ascii?q?A0HNAwBvIZdnhUDyp9VaHQEBAQEJARIBBQUBQIFTgkR9W?=
 =?us-ascii?q?icMBwhIBIRSg0+FLYgNZwOBP5sDgWqBag8BAwENOQsEAQEDAQOCDIJ0Aop1A?=
 =?us-ascii?q?h8GAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJh?=
 =?us-ascii?q?XsNgmIBM3GBJQEBAQEBAQEBAQEBAQEBAQEBAQEXAg19AQEBAQIBIw8BDQEBL?=
 =?us-ascii?q?gkBDwsYAgIRBw4CAlYGExSCbgGCQSMHAQy1TnqBMoEBggwBAQaBCNsXgWQJg?=
 =?us-ascii?q?RouhWuCSRoBcoR5g316Jw+BVUSBSoFzTzM+g3yBBoMcOoIvgjOBEGSBKoEKJ?=
 =?us-ascii?q?WeHNYNdgTtfgV8WISV7LIRnQgQRXC8+iEFSexwDWSwBVRMXCwcFgSlIA4ESI?=
 =?us-ascii?q?4EmBTUKNzqCDWlJNwINAjWCHnyCK4IhgjuERYRRhV6CFIFlAwMWEgGCNXJ5H?=
 =?us-ascii?q?oFNHUADC209NxQbnXI9g3+BIwgQIFEgB2Y1BECSQAiDR69NNAeEHoFdBgyKK?=
 =?us-ascii?q?ZIkgwoESYQEgVeLL5lJmHyLMlmBeZVThSUxgX4jgVxNI4M3CQo8AxkPjiEZH?=
 =?us-ascii?q?4NChRMuwhRBNQIBOQIHAQoBAQMJkBiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4fyp8KoDM88oGqb1yPxavNQaV5ooeYIsimQD101hICG9vPb3qy
 mLpoV+6faSskd3ZJhAo6HkBEDkexnhHPFOjLX5UY3PYOCighrPEGgA1/qB/9SDIU3DH4dmvM
 8KT0E9MqySMbEQt6fHCWeDfOod/A==
X-Talos-CUID: 9a23:yRCgAWOqiOMCue5DZSp6/U0PMPEcKiONxVr9HRSeJUI1R+jA
X-Talos-MUID: 9a23:BCAyfQRh1Ycln61xRXSzoSB+H8xn4Z/pS2cokdIass7eOxVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,237,1732575600"; 
   d="scan'208";a="205081174"
X-MGA-submission: =?us-ascii?q?MDFIeznUWzCeMxC0ws45qR2wcUygXdXpmjBZG2?=
 =?us-ascii?q?u4wcquf+zUmZLCo+Vms7Pw9qwCg9vuox2+JaqdCLPcTOgbGg3BfeL2I6?=
 =?us-ascii?q?DkV8riQSENgSTeuCW/E8coU+ygRe0RT0WuToNACDonGRFQRokdn1wXCE?=
 =?us-ascii?q?n9cJF3JI4TmqkJnlq9c681DA=3D=3D?=
Received: from perceval.ideasonboard.com ([213.167.242.64])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:07:50 +0100
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 981F9496;
	Mon, 27 Jan 2025 07:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737958002;
	bh=1PaZnQBrTgFdzNwyFGepkFiUf9DmyMOVozBizg170xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wg76r+aLaFMHJluyTdjsdq+Inq2rF8WaS13E1+T6WTus5cN3mHgPYCKYKmAyFUcwf
	 LruXKaGbye7fMI4VJDL5/tACuukhXEf+qbB5dXx15WCUsSOEcVouiEpLea6BTeSBy5
	 5MfnZLdJTtA8GQI3XY0xYDfbw6L0BkK9FtHnXlU8=
Date: Mon, 27 Jan 2025 08:07:38 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	kernel@collabora.com, torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org, daniels@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
	melissa.srw@gmail.com, simona@ffwll.ch, airlied@gmail.com,
	Tim.Bird@sony.com, broonie@kernel.org, groeck@google.com,
	rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Message-ID: <20250127060738.GA16795@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <20250124135203.040d0852@foz.lan>
 <20250124130021.GA6853@pendragon.ideasonboard.com>
 <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
 <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Loop: cocci@inria.fr
X-Sequence: 2265
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250127060738.GA16795%40pendragon.ideasonboard.com>

On Fri, Jan 24, 2025 at 06:12:24PM -0300, Leonardo Brás wrote:
> On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote:
> > Le vendredi 24 janvier 2025 à 15:00 +0200, Laurent Pinchart a écrit :
> > > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > > > 
> > > > > > It's been a few years since I first thought on finding a good way of helping
> > > > > > kernel developers testing their patches, while making use of the free runner
> > > > > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > > > > new to kernel development, or students trying to understand it better.
> > > > > > 
> > > > > > And this patchset allows that to happen :)
> > > > > > 
> > > > > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > > > 
> > > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> > > > 
> > > > Sounds interesting!
> > > > 
> > > > > Gitlab as an open-source software project (the community edition) is one
> > > > > thing, but can we please avoid advertising specific proprietary services
> > > > > in the kernel documentation ?
> > > > 
> > > > Every time Gitlab is mentioned, the brand of the company that
> > > > developed it and has been providing proprietary services is also
> > > > advertised. If you're not happy with that, you should move to use
> > > > a git forge developed by some open source community.
> > > 
> > > I'm fine mentioning the gitlab community edition, I'm not fine
> > > advertising gitlab.com SaaS in the kernel source tree.
> 
> Hello Laurent,
> 
> I see your point, and I see no issue on removing the two last lines of CI_TAGS
> documentation.
> 
> I just added this information on documentation because the default runner used
> for the Free Tier of Gitlab does not work for this CI, as it needs more
> resources to run. This information can be added on some other place, but at the
> time I thought it would be ok to let it be there. 
> This other runner I mentioned in the patch is also available on the Free Tier
> (free as in beer).
> 
> I would like to make it clear that I have no connection/affiliation to Gitlab,
> other than a free account in their system, which I use for some CI. I have no
> interest on advertising anything from them.
> 
> My only objective is to make it easier to hobbyists/beginners to use those
> available free minutes to test some change before sending the patch, if they
> think that's valuable.

Given the 400 free computes minute per month, and the fact that the
saas-linux-medium-amd64 runner consumers two minutes per minute, how
many of the proposed CI runs would be available per month ?

CI pipeline runs always compile the kernel from scratch as far as  can
see. This may not be an issue for final testing before submission of a
patch series, but it just won't work for incremental testing of changes.
Think of how inefficient it would be to run a full pipeline just to get
the checkpatch.pl output for instance. This is why I believe tests
should focus first and foremost on ease of use in developers' local
environments. A standardized, from-scratch, comprehensive test run as a
gate keeper for integration has value as well, but that won't help
beginners much.

> > I've just looked attentively, the intention is just to explain you may need to
> > set gitlab variable in your project fork in order to select correctly sized
> > sized runners in your own instance.
> 
> That's correct
> 
> >  Its is not strictly about commercial gitlab.com instance. 
> 
> Exactly, the change is about being able to choose the runner you want.
> 
> > The default only works with the original project used
> > instance (which is not gitlab.com as far as I know), but the comment refer to
> > companies that will choose gitlab.com internally to reduce their IT cost.
> 
> Correct.
> Companies can benefit on that, but my focus was on hobbyist (or begginers) who
> may want to test their patches on free CI before sending them to the ML.
> 
> > Its quite a stretch to call this "advertisement", that makes it looks very
> > dramatic. I personally believe its quite ahead of most other gitlab CI to take
> > into consideration running these pipelines on foreign (to the project)
> > instances.
> >
> > > > The way I see, the best would be if the CI integration could work
> > > > with more than one type of forge and being able to use any
> > > > free Git??b-CI runners that would be available for developers to
> > > > use, as this would allow testing more subsystems with CI, thus
> > > > increasing code quality.

-- 
Regards,

Laurent Pinchart
