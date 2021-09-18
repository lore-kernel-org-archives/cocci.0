Return-Path: <SRS0=+1Gz=OI=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380F3C433F5
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 16:13:37 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF5D61051
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 16:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DF5D61051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529173533"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Sep 2021 18:13:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13552E001B; Sat, 18 Sep 2021 18:13:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8CAA0E0015
	for <cocci@sympa.inria.fr>; Sat, 18 Sep 2021 18:13:32 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AIeHtXqnYl/Bxe/ob6RK5M9XambzpDfIr3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzuiWetN98YhsdcJW7WZVoIkmskKKdg7NwAV7KZmCPhI?=
 =?us-ascii?q?LrFvAA0WKI+VPd8kPFmtK1mZ0QEZRWOZnASWJ3isv3+2CDfuoIytPvys+Vuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529173532"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 18:13:32 +0200
Date: Sat, 18 Sep 2021 18:13:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: Mansour Moufid <mansourmoufid@gmail.com>, cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
In-Reply-To: <202109180847.33FE2744@keescook>
Message-ID: <alpine.DEB.2.22.394.2109181812421.2929@hadrien>
References: <202109161609.9AB60A934B@keescook> <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com> <202109180813.D8EC1ECE07@keescook> <202109180847.33FE2744@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 14
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/alpine.DEB.2.22.394.2109181812421.2929%40hadrien>



On Sat, 18 Sep 2021, Kees Cook wrote:

> On Sat, Sep 18, 2021 at 08:40:19AM -0700, Kees Cook wrote:
> > Yeah, this is for the kernel. Thanks for helping with this! I was able
> > to continue the construction and get it working. :)
>
> I spoke too soon; it fails on the kernel with:
> EXN: Coccinelle_modules.Common.Timeout

What is your command line?  If it times out on one file, it should just
move on to the next one.

julia
