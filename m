Return-Path: <SRS0=+1Gz=OI=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D15AC433F5
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 18:51:03 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2102961179
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 18:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2102961179
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529179475"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Sep 2021 20:51:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17142E0019; Sat, 18 Sep 2021 20:51:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 67248E0015
	for <cocci@sympa.inria.fr>; Sat, 18 Sep 2021 20:50:58 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AD8rvz64rTrstwjCd6APXwM/XdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX2rauTdZggvyMczQxxZJhCo6HkBEDjexPhHPdOiOEs1PWZLWrbUQ?=
 =?us-ascii?q?CTQr2Kg7GP/9StIVydysdtkZYlSaR4BdHqZGIWse/x6mCDfOod/A=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="393356709"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 20:50:57 +0200
Date: Sat, 18 Sep 2021 20:50:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: Mansour Moufid <mansourmoufid@gmail.com>, cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
In-Reply-To: <202109180813.D8EC1ECE07@keescook>
Message-ID: <alpine.DEB.2.22.394.2109182050320.2929@hadrien>
References: <202109161609.9AB60A934B@keescook> <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com> <202109180813.D8EC1ECE07@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 15
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/alpine.DEB.2.22.394.2109182050320.2929%40hadrien>

> But it emits a bunch of warnings:
>
> warning: compound: metavariable os not used in the - or context code
> warning: compound: metavariable is not used in the - or context code
> warning: compound: metavariable iu not used in the - or context code
> warning: compound: metavariable ou not used in the - or context code
> warning: array_of_compound_type: metavariable u not used in the - or context code
> warning: array_of_compound_type: metavariable s not used in the - or context code
>
> Can these be silenced in some sane way?

The problem is fixed.

julia
