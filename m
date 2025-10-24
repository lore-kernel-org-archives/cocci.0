Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE26DCCF9E0
	for <cocci@archiver.kernel.org>; Fri, 24 Oct 2025 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=usBZgdSPyixnuxWiJaOrbZDiF0HCL11dwWEeynBiVBk=;
  b=LHOaSEbnULDhHTTlzYc3QT7O5rulJ2b5AQOujrMq+BOunLeH/J9/xTBc
   2uySjbV777kadFCKzlarcC1d0A1a4olexX+beLbSapxnI0Wm0NP2I9Z/r
   QNNlMURMuNB+FmcOdnyuJbyqpaLudBV3rPlzN+lCc+WiLSbx6oS4L0/Lf
   U=;
X-CSE-ConnectionGUID: Xo8P4BbkQe+llRlFJIw45Q==
X-CSE-MsgGUID: ZKreTYxGTbm5cAD92z0nyw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,253,1754949600"; 
   d="scan'208";a="246098232"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2025 21:04:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E8E2EE0CD5; Fri, 24 Oct 2025 21:04:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D9419E0171
	for <cocci@sympa.inria.fr>; Fri, 24 Oct 2025 21:03:56 +0200 (CEST)
X-CSE-ConnectionGUID: OuM6mIrkQduv31PzcwpU4w==
X-CSE-MsgGUID: 1mEM0jf7QHGzy256bzkm/Q==
IronPort-SDR: 68fbcd9c_pdQpiVG3v4MysCNEE62MfvPlceBRp3em4AGoWQ0E1KL4yGp
 lTmoRWqQqVbEEMPSYEP0SG0RGqLOB2FbqwlQ1/w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAABuzPtogAwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/AgEBAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHVYh5g1ICD?=
 =?us-ascii?q?wEDAQ1OAQIEAQEDBIUAAoxOAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfoIjAQYQAQMPJwewQYEyg?=
 =?us-ascii?q?QGCDAEBBtpfHywiWYFkCYEcLgGFbIJkAYYnhD0nD4FVRIE8C4JAOD6EQ4Nbg?=
 =?us-ascii?q?mmCJoEOmEBSeBwDWSwBVRMXCwcFgSBDAyo0LSNLBS0dgSciHxgTYD0XQINJG?=
 =?us-ascii?q?wZoDwaBEhlJAgICBQJCOoFoIgYfEgIDAQICOlcNgXcCAgSCG4EDgikPiAICA?=
 =?us-ascii?q?QttPTcJCxsGPZQGgn+nOKJ7NAeCOIFngWQMn2wGEy+XUg4GkwWZBiKpH4F+J?=
 =?us-ascii?q?IFcMxokgzZPAxkPjiGEM8MiQTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 hNk0mND
IronPort-Data: A9a23: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
 C7lNAMfNMk2YdiIndgQLjgussdzy9Hi4uvEGwE=
IronPort-HdrOrdr: A9a23:HenpcK3jxwQ99COhC3DMGQqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ABsH47WvK804wyRCTEj3g9HY46IsCb1iDyVbKIHa?=
 =?us-ascii?q?0FHgyEYWHQkCIxf97xp8=3D?=
X-Talos-MUID: 9a23:Qm124gmWu6oUvYdg22C5dno7MepNu6agV3ktvocX4ZTaPz5zPnCk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,253,1754949600"; 
   d="scan'208";a="129097042"
X-MGA-submission: =?us-ascii?q?MDFBJ+1v7nx02hBTMZ5ZjW5e67ubcHi/C0UpaT?=
 =?us-ascii?q?B89qBRLe2UjGzA2LgNEZqNvGvl/GV4PDVMxPZBjs1CFPhaeLbsI4OMzy?=
 =?us-ascii?q?sDzBeJfyQhsUvV0qAxD6kOg/bE47AyOe5/CvdXtuEmxIfVq462fGzUJY?=
 =?us-ascii?q?VYIkfYciLZLAp72yK5xGMGOQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 21:03:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761332635; x=1761937435; i=markus.elfring@web.de;
	bh=usBZgdSPyixnuxWiJaOrbZDiF0HCL11dwWEeynBiVBk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bBRA3UUJs+WYEAvEMoct1dwX3TvUWo3BPzJzUtTmdFd5s06F7MUgTNoOMY/q9+IT
	 w+1ACCddXfso5lpxnnhaxrWJyZLFpSFUQElvlPhLujfGfJoIh4VVDp6eotL6iJWTk
	 iB/ngS5b7bbRGIQHxutwEPIxtKalIJu/NsOidkE6s7NnE/zK/VBg9CHW64J2tzTiW
	 t/UII1L+wxfONXVQcl3xBJzkMNcgoL4CaqIPVX4IWuxhRxgC8e04jsQUFE5X41o4H
	 wvQ1ln+mKZfU8nFoH/bWQQfTyBWfaa/OXNL3WDpEsYssMJwm1811/UTtupxztlfp/
	 Jxx72IphkLDqmYrKTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.198]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M608n-1v4xLl4B4N-00HL3s; Fri, 24
 Oct 2025 21:03:55 +0200
Message-ID: <bd83f450-3110-47a5-ac5d-ea12f5eae323@web.de>
Date: Fri, 24 Oct 2025 21:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
 <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dFcKBSD3k52DNSXJMODZenLoRCEnM8gzXou6lMwsj/BM1IElobl
 1Cdmc1TVWsdb3+8aSmfie8rq1hJaf5DLWtBiZg5CY9rqlKlYmfgeh/eirdO3rSixYPEbLeJ
 5+9P1OdzUP/9t1E8imLiZEgD7UL5p7MGmzI6EHTOnun5LjfW9OBmr/7VfLRRyp02LqyhTlF
 L5kvg9rhV0NxJwhEy/gZQ==
UI-OutboundReport: notjunk:1;M01:P0:UxXhFinn8gs=;q05FgANsLWeJIsVwdr4FFk69KgM
 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
 Mmlird8fJWyXc1NKe/N0EDAcB8=
Subject: Re: [cocci] Terminology evolution for SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3096
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/bd83f450-3110-47a5-ac5d-ea12f5eae323%40web.de>

> There is no guarantee that two metavariables don't match the same thing.

Can such information also mean that some metavariables would be treated as=
 aliases?

I imagine there are further consequences to consider for the involved term=
inology.
Will chances grow to achieve related improvements?


> If you don't want them to match the same thing, then you need to use a d=
isjunction.

It seems that there are logical constraints.


>               In the first branch,

Unwanted source code parts can be excluded at the beginning so that the =
=E2=80=9Cgems=E2=80=9D
would be left over at the end.


>                                    the same metavariable should be used =
twice,

Some processing efforts were needed already for such a condition check.
Would it be nice if further symbol information can be reused?


>        and then in the second branch there would be the two different me=
tavariables.

Can a name registry be helpful here?



>                 The match should only be indicated for the second branch=
.

Would it eventually become affected by combinatorial explosion?

Regards,
Markus
