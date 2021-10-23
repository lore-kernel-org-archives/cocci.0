Return-Path: <SRS0=evXM=PL=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C245BC433EF
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 17:02:16 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3684601FC
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 17:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3684601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="129832"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2021 19:02:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5776AE001A; Sat, 23 Oct 2021 19:02:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B1332E0015
	for <cocci@sympa.inria.fr>; Sat, 23 Oct 2021 19:02:12 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3A+Mkid6NrJgWzvX7vrR19lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQC53T1232EAxjEWDDqPOv3ZZDfxfYgjO460oxhX6JTUm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPnSHeKmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0ACQnElZcWq/5eCexBTq/e7zEDLaFPr3ulgCFwme4sV5o5fA2Z?=
 =?us-ascii?q?D3eQVMjsNYwvFjOWzqJqwTeJnh+w4PczzNcUevGthxHfXF54ORZHFXrWP5tJC2?=
 =?us-ascii?q?jo0rt5BEOyYZMcDbzdrKhPabHVy1v0/YH4ltL733T+mKWQe9gLT9fdx+WXNihd?=
 =?us-ascii?q?/yv7rPca9RzBDfu0N9m7wm44M1z2R7skmCeGi?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANQlI6aF+rQrHeoSXpLqEL8eALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc3Jom6uj5qaTdZUgpHjJYVMqMk3I9ursBICtRmzR8Jht7c0tO96ZLXKWwh?=
 =?us-ascii?q?rUXf1fBOfZrwEIXheOldK1tp0QF5SWaueAaGSS5PySiGKF+pQbsbu6GcuT5Ns2?=
 =?us-ascii?q?oU0DcegnUcFdxjY8Kyq/NCRNNXF7LKt8MLq5yudKqDKmdzA5bsGnCmJtZZm7mz?=
 =?us-ascii?q?Wm+aiWHiI7Ow=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="129830"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 19:02:13 +0200
Date: Sat, 23 Oct 2021 19:02:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <kees@outflux.net>
cc: Joe Perches <joe@perches.com>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <6A7FEC25-CBC1-434D-BD81-1FDB81DD9B45@outflux.net>
Message-ID: <alpine.DEB.2.22.394.2110231901430.2967@hadrien>
References: <alpine.DEB.2.22.394.2110231758550.2967@hadrien> <6A7FEC25-CBC1-434D-BD81-1FDB81DD9B45@outflux.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] update Coccinelle entry
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 29
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110231901430.2967%40hadrien>



On Sat, 23 Oct 2021, Kees Cook wrote:

>
>
> On October 23, 2021 9:01:18 AM PDT, Julia Lawall <julia.lawall@inria.fr> wrote:
> >Update mailing list and website.  Drop Michal Marek as a maintainer, who
> >has not participated in a long time.
> >
> >Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> >---
> >
> >For information.  This will be in my tree.
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 7d46f03e5037..8746149b6623 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -4594,10 +4594,9 @@ COCCINELLE/Semantic Patches (SmPL)
> > M:	Julia Lawall <Julia.Lawall@inria.fr>
> > M:	Gilles Muller <Gilles.Muller@inria.fr>
> > M:	Nicolas Palix <nicolas.palix@imag.fr>
> >-M:	Michal Marek <michal.lkml@markovi.net>
> >-L:	cocci@systeme.lip6.fr (moderated for non-subscribers)
> >+L:	cocci@inria.fr (moderated for non-subscribers)
> > S:	Supported
> >-W:	http://coccinelle.lip6.fr/
> >+W:	https://coccinelle.gitlabpages.inria.fr/website/
> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git misc
>
> Perhaps drop this tree and add yours, too?

Sure, thanks for the suggestion.

julia

>
> > F:	Documentation/dev-tools/coccinelle.rst
> > F:	scripts/coccicheck
>
>
>
>
> --
> Kees Cook
>
