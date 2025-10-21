Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0317BCCD1A5
	for <cocci@archiver.kernel.org>; Tue, 21 Oct 2025 09:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rbF9YE5zy+qgqx4Ic8BKaWhR802WZhxDtLMgGWhY6uY=;
  b=oNWV61tMrgdzpY3rbUyT18cmB4Mf12jFSwjFe/5KJ9vXAtHdJSt6sVBe
   sJiGADn2rqWuv9/tT+I6+K+xUnUjTf38GgDgPCTjSWhQQL8kHiSlO8TEd
   ZhHr7lkDOJp9eSphgUO11Vu9gdmASwwFQYwSy1ypn7FEJMdDXsU+BaXI9
   k=;
X-CSE-ConnectionGUID: 7cayQibnSWyiEixiZYHR1Q==
X-CSE-MsgGUID: oXtMYVDkQuSN24+GjkTsXg==
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
X-IronPort-AV: E=Sophos;i="6.19,244,1754949600"; 
   d="scan'208";a="245400643"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Oct 2025 11:12:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BE4F6E0BE9; Tue, 21 Oct 2025 11:12:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AF7ECE0171
	for <cocci@sympa.inria.fr>; Tue, 21 Oct 2025 11:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=rbF9YE5zy+qgqx4Ic8BKaWhR802WZhxDtLMgGWhY6uY=;
  b=PamVCfCV8SWazmfrFSkbdg8HNeTG0LmSZFrEX20NWz02sdkIactTlWbB
   uiPzWkUEs++Zp8LugMc1wUgHlPBMdj1wqsOESr9xgF5iBzHMXoqOdKMp9
   XySGLipFi2QyJECSm6r17+I8EiWggkFRqf8amn2KP/Y2sDEIdsWAFIh+k
   k=;
X-CSE-ConnectionGUID: ZBx7Pc6vRSC1Cd6WD4nbAw==
X-CSE-MsgGUID: 0P6wBxE6RXyRZ4ei/UaUyA==
X-IronPort-AV: E=Sophos;i="6.19,244,1754949600"; 
   d="scan'208";a="128756759"
Received: from unknown (HELO smtpclient.apple) ([111.65.48.72])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 11:12:44 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Tue, 21 Oct 2025 17:12:28 +0800
Message-Id: <AF63C923-8861-4FF0-A7CB-734FA309318D@inria.fr>
References: <bf92f464-e5f3-409c-9bd5-1bba549dbaf0@web.de>
Cc: cocci@inria.fr
In-Reply-To: <bf92f464-e5f3-409c-9bd5-1bba549dbaf0@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3092
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/AF63C923-8861-4FF0-A7CB-734FA309318D%40inria.fr>


Sent from my iPhone

> On 21 Oct 2025, at 14:16, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>>> Will further clarifications become more interesting for corresponding ca=
se distinctions?
>> There is no guarantee that two metavariables don't match the same thing.
>=20
> Some test cases seem to indicate that a source code search gets restricted=
 to unique data
> if only a single metavariable is affected.
> Are there further constraints to consider for the processing of data types=
 and corresponding
> contents of (meta-)variables?

I have no idea what this means.

If a maetavariable is inherited into another rule it has to have one value. O=
therwise it needs one value per control flow path. But if thee are two occur=
rences of a metavariable in a pattern , they have to have the same value.


>=20
> Regards,
> Markus

