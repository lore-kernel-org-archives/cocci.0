Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B362DC0218D
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=buj9ZenxsIQ69t/K1EE7HtMo+2bG/oWLj5fvcapjxUA=;
  b=h/MGwOHBdDHwxMhGDOEG8379Hg8BtqIupfc4G5oXmV2jlvoK3iYQ2ewH
   NWkU88sQBGJtLAwBG70ncz28P0JkUa5jZat8OYcxXhbFCI74dk26AQQYe
   A8J85b1GM3kwWVNO/qVSxg4GfSNU4SMTsVznb9jtbkKl2nXtL970JVgAn
   8=;
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
   d="scan'208";a="205325135"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9E00DE0DDF; Tue, 28 Jan 2025 10:13:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E8531E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 17:32:16 +0100 (CET)
IronPort-SDR: 6793c08f_pfk+Q+rKB1MTEPv2YyZVrsBQKkCNXIq+pemMvkcT5eVrD69
 lhWy3h0lw+LDq7LX+jYnvhHVvPjS59//DFdX89A==
X-IPAS-Result: =?us-ascii?q?A0FlBQARv5Nnj9lUsotaHQEBAQEJARIBBQUBQIFTAoIaK?=
 =?us-ascii?q?H1aMwQLSIRWg0+FLYZSgiEDhmmZLQ8BAwENOQsEAQEDAQOBUIMwAop1Ah4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJh?=
 =?us-ascii?q?XsNSQEQAYIHATNxgSUBAQEBAQEBAQEBAQEBHQINfQEBAQECASMdAQE3AQQLC?=
 =?us-ascii?q?xgCAgUhAgIPRwYBJoIVWAGCQSMDEbgweoEygQGBCYEDAQEGgQjcYRoDBoEaL?=
 =?us-ascii?q?ohOAYVrhHcnG4INgRWCKIECPoJhAYFhFYNGgmmCM4F0g0CBIodNgiKLI4oJS?=
 =?us-ascii?q?Ap7HANZLAFVEw0KCwcFYUgQOAMrCwwLFBwVI4EmBTUKNzqCDWlJNwINAjWCH?=
 =?us-ascii?q?iRYgiuCH4I7hEWEU4JDgxiCFHprAwMWEYI1cnsfgSwdQAMLGA1IESw3Bg4bB?=
 =?us-ascii?q?j0BbgecJT2DG1tEdQgEgQEMPA0Kk3dEgmcBsAAKhBuBYwKKM5UyFjOXRJMPm?=
 =?us-ascii?q?HwijWKVW2iEZoF+I4FcfQiDIk8DGQ+OIRkfhEaEEMBkQTU8AgcLAQEDCYtth?=
 =?us-ascii?q?DaBSwEB?=
IronPort-PHdr: A9a23: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
 EgiMy3LFeo5Z15Idm1xjgLY/5xVFqwEJZA=
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:Ng4WXaBcUUEQPUjlHemp55DYdb4zR+YMi2TDGXoBKiC9Ffb2qy
 nOppomPHrP5Qr5N0tApTntAtjkfZqYz+8N3WBuB9eftXjd1FdARbsKheCJ/9SjIVyZygc379
 YDT0ERMqyVMbEDt7ec3DWF
X-Talos-CUID: 9a23:xnQE527s0Uk+c4Y2+dssqmoYA/8maWzm7FjWIxS+WHZEQri/YArF
X-Talos-MUID: =?us-ascii?q?9a23=3AgxEX+AyvH+NUfRTuG83Oi2FiIr2aqK+MS0QmlYQ?=
 =?us-ascii?q?CgvCFBxZ+Yge3hW2cSZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="107302033"
X-MGA-submission: =?us-ascii?q?MDE8mXO88YJhFvv/PUxJw01Nn0uPK330llhRW1?=
 =?us-ascii?q?gzMa/kzDY/l+32Wc6w5BcfGFNVeY3B8d5vN+9U/Fd5hU535ipuF+8/C3?=
 =?us-ascii?q?NvqLv+nQPJmKBP3tKvKtiR/r5sBRMpnwzv5uQi4Q/SFHY+FrLiR5+TwB?=
 =?us-ascii?q?6KMKV4ht50bP2jxYKR7YUapg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 17:32:15 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1DB945C60C0;
	Fri, 24 Jan 2025 16:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEBBC4CED2;
	Fri, 24 Jan 2025 16:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737736332;
	bh=buj9ZenxsIQ69t/K1EE7HtMo+2bG/oWLj5fvcapjxUA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=H3I7/p6qOiDIGiOoQBAUG1hcJ+tysCWHdaFE1PaW4uhteDjw3pR+npaF06v/zkBW0
	 MbvWEMBlbFZTbRdpQOSZ68zcmPDZrOiZ9D7DatPBA7aTco5xScRGmKpAsIm6Eo5fdW
	 GpjiAmKQyF+VYkNffdKZzHpx24g4AW9KqM++lgiw363/TI+q3ftRqDzId4liHJLawe
	 rANWO2Bs/y4K8MRmrCdmYTG11Hr08TVlZ6+7BRBcDxwtI4KHFazipsaMAhAk4FNAZh
	 8rCH0ZYiySGZMj8kltBgr6JzKJc5dxzmUi5mCX2w5sd1uJxWVGjvc8cNNU39uUUqD/
	 93AnUorFuJvJA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 18:32:07 +0200
Message-Id: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
Cc: <linuxtv-ci@linuxtv.org>, <dave.pigott@collabora.com>,
 <mripard@kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
 <gustavo.padovan@collabora.com>, <pawiecz@collabora.com>,
 <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>,
 <laurent.pinchart@ideasonboard.com>, <broonie@kernel.org>,
 <leobras.c@gmail.com>, <groeck@google.com>, <rdunlap@infradead.org>,
 <geert@linux-m68k.org>, <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Nikolai Kondrashov" <Nikolai.Kondrashov@redhat.com>, "Vignesh Raman"
 <vignesh.raman@collabora.com>, <kernelci@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
In-Reply-To: <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2254
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/D7AG4810MH9U.3SA2YT8ZPY6QF%40kernel.org>

On Fri Jan 24, 2025 at 2:58 PM EET, Nikolai Kondrashov wrote:
> Hi Jarkko,
>
> On 1/23/25 11:30 PM, Jarkko Sakkinen wrote:
> > On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> >> We are working towards creating a generic, upstream GitLab-CI pipeline
> >> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipe=
line
> >> is designed with a distributed infrastructure model, making it possibl=
e
> >> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> >> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> >> integration.
> >=20
> > Why can't you keep the next version of your great pipeline outside the
> > kernel tree?
> >=20
> > If there is a legit motivation for doing that, why it needs to be bound
> > to Gitlab? Why can't you make script callable from any CI?
>
> Greetings from the (today's) sunny Espoo!
>
> Of course we could keep it outside the kernel tree. However, the point of=
 this
> contribution is to provide kernel maintainers and developers with an easy=
 way
> to setup their CI pipeline on a GitLab instance (the main one, FreeDeskto=
p
> one, or any other). Basically this is like a template or a library, if yo=
u
> wish, which helps you do that. Approved by Linus too.

With all due respect, "approved by Linus" is not an argument :-) I get
that Linus can make the "ultimate decision" but in argumentation I'm not
a strong believer of authority based decision making process. Not
downplaying this more than that I knowingly ignore this comment.

> Why GitLab? Because it's one of the best, if not *the* best CI system the=
se
> days, with lots of flexibility, and it's Open-Source too (well, at least
> open-core, which is still very capable). And also because a number of
> maintainers and companies are already using it.

There's also Github Runners and Woodpecker CI used by Codeberg. To add,
some companies and other organizations prefer Jenkins. This one fit for
all strategy is somewhat short-sighted.

Also running Gitlab tasks locally is possible but is heavy-lifting.

Can we then agree that any CI changes can be sent untested to LKML if
a patch set needs to reflect on those? It's not reasonable to except
local runs Gitlab from individuals for patch sets. It makes our lives
more difficult, not easier.

All maintainers I know test their patches for the most part with
BuildRoot, distro VM's and stuff like that. Not claiming that they
don't exist, but never heard of kernel maintainer who uses Gitlab
as their main kernel testing tool.

> Sure, a script could be contributed too, but the value of this contributi=
on is
> a ready-made integration. And we want to make it easily discoverable, and
> easily contributed to.

This is definitely NOT "lots of flexibility".

Are you dead seriously claiming that DevOps engineers could not handle
well defined CI scripts and bind to whatever CI makes sense to them?
o_O

>
> BTW, here's the talk we gave at last year's LPC regarding current use of
> GitLab in the kernel and surrounding community:
>
> https://lpc.events/event/18/contributions/1728/

This patch set should make the case, not an old presentation.

> Nick

BR, Jarkko
