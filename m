Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E08CAC5B5
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LQ0oVUoCfOIt+x7Lrmwu8ybl4g7WomzcWHQHXOArN0Q=;
  b=ZO6n67Ht8zib+tKWAc1PEb0+0Df5zhy2C+hypdxC78ylB8OhCeJlG+4c
   fCVPeaGkbgWud/QQp2utOmeAUKKckvCxasE7parq8YO5VC55lpG0iHUGr
   VKZLDWwNKLR/SrWbJda5p1yADTkfG9J/Mxlh96GdIidp7YMzyuLp4YeV6
   A=;
X-CSE-ConnectionGUID: CMEpkuWhTs+/vo+ShO+7bA==
X-CSE-MsgGUID: bQP1SiAcSDCUDawJv87FGg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241372577"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 14:23:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E821E0C55; Sun, 28 Sep 2025 14:23:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7BC33E0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 14:23:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LQ0oVUoCfOIt+x7Lrmwu8ybl4g7WomzcWHQHXOArN0Q=;
  b=VVmEs1dMHxRYWP6310N3UmeXvTSs2wunfyGQ9e1HWH9ySKoxPVRoQIzc
   qh+IeW7Y8K1OXbjjA/paMTM/x0nsGa6wfqygPZwAkdVsIXC13BAT+WSMc
   jgnsJ/0GdcF3ZFml4uoaD7FDj+nvKD2OFTIAjOknxbeeUb2LDIThfWMcI
   w=;
X-CSE-ConnectionGUID: H3kCSCiFRsiWEEcHmsvPHQ==
X-CSE-MsgGUID: 3KepsOaeTPq4en8K/f/1cQ==
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="126750158"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 14:23:40 +0200
Date: Sun, 28 Sep 2025 14:23:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Gal Pressman <gal@nvidia.com>
cc: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>, 
    cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
    linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
    Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
    Richard Cochran <richardcochran@gmail.com>, 
    Saeed Mahameed <saeedm@nvidia.com>
In-Reply-To: <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
Message-ID: <7522bdc8-1379-d516-d1fd-f7835453f23@inria.fr>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com> <1758192227-701925-2-git-send-email-tariqt@nvidia.com> <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de> <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-117506010-1759062220=:4035"
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3046
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/7522bdc8-1379-d516-d1fd-f7835453f23%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-117506010-1759062220=:4035
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> >> +@r@
> >> +expression ptr;
> >> +constant fmt;
> >> +position p;
> >> +identifier print_func;
> >> +@@
> >> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
> >
> > How do you think about to use the metavariable type “format list”?
>
> I did find "format list" in the documentation, but spatch fails when I
> try to use it.

I would suggest constant char[] fmt.

format is for the case where you want to specify something about the %d
%s, etc in the string.

> > Would it matter to restrict expressions to pointer expressions?
>
> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
> didn't find anything. Am I doing it wrong?

expression *ptr should be a valid metavariable declaration.  But
Coccinelle needs to have enough information to know that something is a
pointer.  If you have code like a->b and you don't have the definition of
the structure type of a, then it won't know the type of a->b.  More
information about types is available if you use options like
--recursive-includes, but then treatment of every C file will entail
parsing lots of header files, which could make things very slow.  So you
have to consider whether the information that the thing is a pointer is
really necessary to what you are trying to do.

> >> +@script:python depends on r && org@
> >
> > I guess that such an SmPL dependency specification can be simplified a bit.
>
> You mean drop the depends on r?
>
> >
> >
> >> +p << r.p;

Since you have r.p, the rule will only be applied if r has succeeded and
furthermore if p has a value.  So depends on r is not necessary.

julia

> >> +@@
> >> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
> >
> > I suggest to reconsider the implementation detail once more
> > if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
> >
> > The operation mode “context” can usually work also without an extra position variable,
> > can't it?
>
> Can you please explain?
>
--8323329-117506010-1759062220=:4035--
