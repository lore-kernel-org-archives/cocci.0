Return-Path: <SRS0=f1Jb=OH=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C9C433F5
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 06:37:23 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E56660E54
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 06:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E56660E54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="528936130"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2021 08:37:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DDED8E001C; Fri, 17 Sep 2021 08:37:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B4B7FE0015
	for <cocci@sympa.inria.fr>; Fri, 17 Sep 2021 08:37:12 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AO3WI0a6ehGB6h4SkWgPXwBbXdLJyesId70hD?=
 =?us-ascii?q?6qm+c20tTiXqrbHfoB17726EtN9/YgBcpTnrAsS9qB/nhOVICMwqTMmftWrdyR?=
 =?us-ascii?q?SVxeNZnPHfKlTbckWUnIIytMcQENkaebnN5BpB/L7HCWKDYrEdKbe8gcaVbKvl?=
 =?us-ascii?q?vgtQZDAvQ6Z87zh4ERqAe3cGN3g1OXPnLvXshPZ6mw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="393221789"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:37:12 +0200
Date: Fri, 17 Sep 2021 08:37:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
In-Reply-To: <CALogXGX6rB9vhK-RFbTZOGcP9yuh524BtN8EtH0AOeHyVs2Mmw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2109170836530.33288@hadrien>
References: <202109161609.9AB60A934B@keescook> <CALogXGX6rB9vhK-RFbTZOGcP9yuh524BtN8EtH0AOeHyVs2Mmw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 9
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/alpine.DEB.2.22.394.2109170836530.33288%40hadrien>



On Fri, 17 Sep 2021, Mansour Moufid wrote:

> On Thu, Sep 16, 2021 at 7:48 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi,
> >
> > I'd like to match any compound type containing a compound type, i.e. these:
> >
> > struct foo {
> >         struct bar instance;
> > };
> >
> > union bar {
> >         int c;
> >         struct baz d;
> > };
>
> For this first part, maybe something like:
>
> @@
> identifier s, u;
> type t1 = {struct s, union u};
> type t2 = {struct s, union u};
> identifier x;
> @@
> *   t1 {
>         ...
> *       t2 x;
>         ...
>     }

I think that this should also be ok.

julia

>
> I'll attempt the rest tomorrow.
>
