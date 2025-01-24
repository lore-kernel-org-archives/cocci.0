Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B19FC02194
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=n6CulgugzdnNBsl9vL56luDkD46h2b9vleEGuPlEdP4=;
  b=IvOl0bfBGoVv/tE5E6JrmVIC539T1XNnxiR+KxUteNEUijoWOH+g/HwW
   3eJ10ww2oORIOAFy4J3TG94Yu8a5MLuL3hDJmlUlnRyxBKDvofJkoNBFg
   wBVX0eqWaRhVXA+aG4qG2YqLBzQza4W2XHEuOyQtSjz+QR4rOgLpe3y4i
   U=;
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
   d="scan'208";a="205325243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0D33E0E2B; Tue, 28 Jan 2025 10:13:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 310DAE007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 18:35:06 +0100 (CET)
IronPort-SDR: 6793cf48_gh2RAbTvc6qAqC3HNoXFKFrS1ADr/QwVn9NwaJjO0sqie7A
 MFtUXcJ/EpQpsCWx3JYH+CYG0KNSFNjE4KSbDVw==
X-IPAS-Result: =?us-ascii?q?A0EcBQBTzpNnhUDyp9VaHgEBCxIMQIFICwKCGih9WicMB?=
 =?us-ascii?q?whIhFaDT4UtiAxnA4E/hSqZLQ8BAwENOQsEAQEDAQOFAAKKdQIfBgEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew1JARABg?=
 =?us-ascii?q?gcBM3GBJQEBAQEBAQEBAQEBAQEdAg19AQEBAQIBIx0BATcBBAsLEgYCAhgOA?=
 =?us-ascii?q?gJIDgYnghVYAYJBIwcBDLhTeoEygQGBCYEDAQEGgQjbF4FKGgmBGi6Fa4JjA?=
 =?us-ascii?q?YVrg316Jw+BVUSBFTWBc4ECPoJhAYU8OoIvgjOBdIJZZ4Eih02CIosjigpSe?=
 =?us-ascii?q?xwDWSwBVRMXCwcFgSlIA4ESI4EmBTUKNzqCDWlJNwINAjWCHnyCK4IfgjuER?=
 =?us-ascii?q?YRThVuCFIFlAwMWEAGCNXJ7H4EsHUADC209NxQbnV49gxxbRHUIBCtWDB8dD?=
 =?us-ascii?q?QqTdxQwgmevTTQHhB6BXQYMiimVLgRJhVukeJh8jgSVW4UdMYF9JIFcTSODN?=
 =?us-ascii?q?wlGAxkPjiEZH4NCgQSEEMB+QTU8AgcLAQEDCYtthDaBSwEB?=
IronPort-PHdr: A9a23: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
 JKhpmlH3QhkZcQ5Y6fXIfgQpmU=
IronPort-Data: A9a23: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
 vlALkXS3Hi4FX0=
IronPort-HdrOrdr: A9a23:DHPuiq157vH4swHHNSNUIQqjBL8kLtp133Aq2lEZdPWaSKKlfu
 SV7ZAmPH7P+VMssRQb8+xoV5PsfZqxz/JICMwqTNCftWrdyQmVxeNZjbcKqgeIc0bDH6xmpM
 RdmsNFaeEYY2IUsfrH
X-Talos-CUID: 9a23:wa7gzWNUEOf9y+5DXA9JqWJFGs4fUz7iyjThYHKcEWV1cejA
X-Talos-MUID: =?us-ascii?q?9a23=3AIDVOUA8VBGX33XmiezXmASmQf99Z+Z2RGmkNrdI?=
 =?us-ascii?q?9hsqcMw1hAw6toDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="107306900"
X-MGA-submission: =?us-ascii?q?MDE7AmBzyMfhIWxqjeNX9z0DkLYT4PtoalPUNx?=
 =?us-ascii?q?f5RRSe5J2haUb84bK3nNdkWQcdBkftc2pZFRjcjCNToboZ5WcPSawwQi?=
 =?us-ascii?q?u3QsVe4f4D+/chTfxo8ZjvbEJL6KbJ8M+VT1VZxlrpJhHqBrkXoeRfYu?=
 =?us-ascii?q?sE1h7sy/oRH9yvpQ4nI5APBg=3D=3D?=
Received: from perceval.ideasonboard.com ([213.167.242.64])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:35:05 +0100
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7AC4564;
	Fri, 24 Jan 2025 18:33:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737740038;
	bh=u5gqofTHiDlo8VB6AXG6vGQEZvkFPpUHAM6ATnvul0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7Zd+FqQs3gh0jbqOC817PsrYMY32rUW6mT0aGjlYbkvrnOIDo/2keCFUWMx378so
	 uvW++ypSeE2VkYKVaWwARTfQzwWSMLm44taxCiayqhogqc2EYUORGcHqw0gONmyepD
	 T1uHIbRnPdXdzwSqiF5FF3z+DMIaEP5WTS2/4s+4=
Date: Fri, 24 Jan 2025 19:34:51 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
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
	leobras.c@gmail.com, groeck@google.com, rdunlap@infradead.org,
	geert@linux-m68k.org, michel.daenzer@mailbox.org,
	sakari.ailus@iki.fi
Message-ID: <20250124173451.GB17899@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
 <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Loop: cocci@inria.fr
X-Sequence: 2258
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250124173451.GB17899%40pendragon.ideasonboard.com>

On Fri, Jan 24, 2025 at 06:32:07PM +0200, Jarkko Sakkinen wrote:
> On Fri Jan 24, 2025 at 2:58 PM EET, Nikolai Kondrashov wrote:
> > On 1/23/25 11:30 PM, Jarkko Sakkinen wrote:
> > > On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> > >> We are working towards creating a generic, upstream GitLab-CI pipeline
> > >> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
> > >> is designed with a distributed infrastructure model, making it possible
> > >> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> > >> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> > >> integration.
> > > 
> > > Why can't you keep the next version of your great pipeline outside the
> > > kernel tree?
> > > 
> > > If there is a legit motivation for doing that, why it needs to be bound
> > > to Gitlab? Why can't you make script callable from any CI?
> >
> > Greetings from the (today's) sunny Espoo!
> >
> > Of course we could keep it outside the kernel tree. However, the point of this
> > contribution is to provide kernel maintainers and developers with an easy way
> > to setup their CI pipeline on a GitLab instance (the main one, FreeDesktop
> > one, or any other). Basically this is like a template or a library, if you
> > wish, which helps you do that. Approved by Linus too.
> 
> With all due respect, "approved by Linus" is not an argument :-) I get
> that Linus can make the "ultimate decision" but in argumentation I'm not
> a strong believer of authority based decision making process. Not
> downplaying this more than that I knowingly ignore this comment.
> 
> > Why GitLab? Because it's one of the best, if not *the* best CI system these
> > days, with lots of flexibility, and it's Open-Source too (well, at least
> > open-core, which is still very capable). And also because a number of
> > maintainers and companies are already using it.
> 
> There's also Github Runners and Woodpecker CI used by Codeberg. To add,
> some companies and other organizations prefer Jenkins. This one fit for
> all strategy is somewhat short-sighted.
> 
> Also running Gitlab tasks locally is possible but is heavy-lifting.

That's my personal opinion too. In all the CI pipelines I've designed
(which totals to an amount of exactly one) I've implemented as much as
possible in shell scripts that are called from a minimal
service-specific CI configuration. I find this architecture to ease
running tests locally.

> Can we then agree that any CI changes can be sent untested to LKML if
> a patch set needs to reflect on those? It's not reasonable to except
> local runs Gitlab from individuals for patch sets. It makes our lives
> more difficult, not easier.
> 
> All maintainers I know test their patches for the most part with
> BuildRoot, distro VM's and stuff like that. Not claiming that they
> don't exist, but never heard of kernel maintainer who uses Gitlab
> as their main kernel testing tool.

That's highly subsystem-specific, and depends on what kind of testing is
performed. The Linux media subsystem recently adopted
gitlab.freedesktop.org for compilation and other static tests. As a
developer, I compile-test my kernel patches locally, and run them on
hardware without going through CI pipelines.

> > Sure, a script could be contributed too, but the value of this contribution is
> > a ready-made integration. And we want to make it easily discoverable, and
> > easily contributed to.
> 
> This is definitely NOT "lots of flexibility".
> 
> Are you dead seriously claiming that DevOps engineers could not handle
> well defined CI scripts and bind to whatever CI makes sense to them?
> o_O
> 
> > BTW, here's the talk we gave at last year's LPC regarding current use of
> > GitLab in the kernel and surrounding community:
> >
> > https://lpc.events/event/18/contributions/1728/
> 
> This patch set should make the case, not an old presentation.

-- 
Regards,

Laurent Pinchart
