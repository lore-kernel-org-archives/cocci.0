Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F490CA0EFA
	for <cocci@archiver.kernel.org>; Mon, 25 Aug 2025 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=A6d17kPZ0wn89zKUhpiiGe8PrNiDYBDVVhiBL86d8h4=;
  b=qY1sP1hW26GP+ClKwS0Z6fOso/is51BoGtRqIz9uyuiV4IjgOIh+g6bU
   i/FbI7vcx0VohsXUbFqmDFkzNElum9tPtMdtRH4JrryRPh1TiL1KIAblx
   P2rz+JvxBL0k2VUq0etvskMrkLHpzL0F3gjwnaN9hVAKnsxg/aQKyoD/a
   c=;
X-CSE-ConnectionGUID: QAuDxWKCSni+1zjnofRNpg==
X-CSE-MsgGUID: SlSm10b3Rj6hwdQ9l+603Q==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.18,213,1751234400"; 
   d="scan'208";a="236016596"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2025 15:23:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9B2FE0CD5; Mon, 25 Aug 2025 15:23:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 72FD0E0172
	for <cocci@sympa.inria.fr>; Mon, 25 Aug 2025 15:23:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A6d17kPZ0wn89zKUhpiiGe8PrNiDYBDVVhiBL86d8h4=;
  b=QUMmXXV4iOkR63sEDdodAeR+X9//qZ6KY9pYdeD8vt/2w6EP5vbfUmm+
   TO2FiT2nX27cNRD4AsAu9ZRin8z/qp6H05qygYb2HU/ICceoBdUNbcjLn
   wcTZbZYIWtoqve8hAVQgwcyJAFJKZT2q+4zV+hgNQscYAkQ3eMZZWvo6e
   o=;
X-CSE-ConnectionGUID: 5V+69gevRDyoHfdOBxyXwA==
X-CSE-MsgGUID: VW+7Oh/qSryGyzJcvhZMEw==
X-IronPort-AV: E=Sophos;i="6.18,213,1751234400"; 
   d="scan'208";a="236016582"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 15:23:16 +0200
Date: Mon, 25 Aug 2025 15:23:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <eb3e0445-39fa-4f4a-aeed-96eadc94657d@web.de>
Message-ID: <alpine.DEB.2.22.394.2508251521570.3563@hadrien>
References: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de> <eb3e0445-39fa-4f4a-aeed-96eadc94657d@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-66887575-1756128195=:3563"
Subject: Re: [cocci] [RFC] Choosing =?UTF-8?Q?=E2=80=9Csemantics=E2=80=9D?=
 better for SmPL script parts?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2982
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508251521570.3563%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-66887575-1756128195=:3563
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 25 Aug 2025, Markus Elfring wrote:

> > A bit of information is provided about special “semantics” (also in the manual
> > for the semantic patch language).
>
> The usage of the semantic match functionality influences which default semantics
> should be applied for the evaluation of an SmPL rule.
> I imagine that the corresponding data processing can become more interesting
> when the needed semantics would actually be the opposite setting.
>
> * Do you tend to look for the existence of selected implementation details
>   more than that source code variants can occur on all executions paths
>   according to evolving control flows?
>
> * Would you expect to use the source code search parameter “exists” more often
>   then “forall”?

The default is exists for use with * and forall with transformation, with
the reasoning for the latter being that when transformation occurs the
trasformed code should be consistent.  But there are cases where something
else is desired, so this is controlled by the user.

julia

>
>
> Regards,
> Markus
>
--8323329-66887575-1756128195=:3563--
