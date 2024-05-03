Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B6C4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H9VYHkDDTeFdNvIfPZAIxWaaCqExi+KN3Yp59gnPDcY=;
  b=Rpj2lnW0231NkJU+AEhxGUYHeC/GC/1Ehdr+fXJgcyj0GNe/5Ho0kR5v
   FW1g1brGuzxhq5cBPSe4q5cP6Q6F9w2Xr/Djb8kZVg03EC4nNG4zGttpi
   HNT2PgL8agG9auYeO2X8aeNfhw+LUtE3WcXkAufy2O4tjiZXvPK1GXRJP
   k=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164337311"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 10:00:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 64950E0141; Fri,  3 May 2024 10:00:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 129F6E0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 10:00:24 +0200 (CEST)
IronPort-SDR: 66349997_GmBEuUAHNCMXEPs89JhTVOlBoGbxjbxjFIojYnvRT621auy
 8kgYer5oD3CM/e6HaVc+nlDHrvJoeG4JbefO96A==
X-IPAS-Result: =?us-ascii?q?A0EKBgCImDRmh07ASNlaHgEBCxIMQIFRgkJ/VDMEC0iEV?=
 =?us-ascii?q?o9GgXUwhDuHOYdPhGyEBYMWPg8BAwENQQECBAEBAwSCC4J0AoguAh4HAQQ1B?=
 =?us-ascii?q?Q0BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4V0D?=
 =?us-ascii?q?YJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEBAQIBIx0BAREnBAsLG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfIIwAQMOIwe0MIEygQGCDAEBBtpZHywiV4FiCYEaL4gtA?=
 =?us-ascii?q?YV8hEAnD4FVRIE8C4J4PogegmmaK4xwVH0cA1khEwFVExcLPgkWAhYDGxQEM?=
 =?us-ascii?q?A8JCyYDKgY2AhIMBgYGWSAWCQQjAwgEAxA0AyBvEQMEGgQLB3WBfIE1BBNEA?=
 =?us-ascii?q?4E4iX0MgX2BNIF3KYQhCENsFYN2gXgOYoNhglsdQAIBC209NQkLGwYiAR3MO?=
 =?us-ascii?q?qEgNAeCNoFggWEMn0QGEy+DcgGTRQ4Gkmguh1iQXCCjHoVJgX0igVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIBmEFJpkQTU7AgcLAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:WFCa160x/M8Jma+Xsuf9kQqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ALdpH2mnpBpuga+lWUqKzsLd1/ZDXOUDN7zCPDXK?=
 =?us-ascii?q?KMktWZqCPSg7I04dKj+M7zg=3D=3D?=
X-Talos-MUID: 9a23:eZEFdgruiqHNlklnd68ezwxYOppR8/W2MVomqM0Ltfu/bytuZijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164337299"
X-MGA-submission: =?us-ascii?q?MDHVVgwoItQvddbGLWg9uvRCJK8BEshUFiwhWn?=
 =?us-ascii?q?LFfbNY4/N3SEqxFedPpvv0x7izlFcgRrossKNZnTZ5yp2IiyajYFLAIN?=
 =?us-ascii?q?l/YV2BXNrp/D58OzbUSkiA9XIXwg7ZVmLOBD0HhikG4ig4QHaVerr55L?=
 =?us-ascii?q?iFU0H6tBB0ZUHZxb0G887goQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:00:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714723222; x=1715328022; i=markus.elfring@web.de;
	bh=H9VYHkDDTeFdNvIfPZAIxWaaCqExi+KN3Yp59gnPDcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lh4D6DV6f2Mb4F0G6r7ZMSqdrPvHxnvHpRge9V12V42Ht5IKsMuFLMsG1SPIDmFt
	 Y4tkbHSnPm0uMog/IzPzdhGZbK8+2czWN3tGEp7Y8gbK7PinS1Mz3r/fFMoDjlgT0
	 KoiZxcIVDHlWUPgOrZf88YSjZDMbtGdhkeZQT9rhmxAqsM86AKaCYeWh4dA20Vvm6
	 W7ZujSYMBD865impJAs4MjE9EkmEVYl0mPzIAIWYv7a3KGzkA/3H7UG6lKSBnoGrF
	 XvjPN0nYFmamifOSsbo/+PIRCX+h0ultAETvcMZ8PSslWNuXecaPFExa9j/jrFA5F
	 GB3OFQ3wsccyJ9zPoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOhx-1sOPY23eLP-00mpWg; Fri, 03
 May 2024 10:00:21 +0200
Message-ID: <f353bd20-1821-4112-b12b-bd1a111f7d20@web.de>
Date: Fri, 3 May 2024 10:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com> <20240502171930.GE30267@redhat.com>
 <20240502173148.GF30267@redhat.com>
 <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
 <20240503073135.GR7636@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240503073135.GR7636@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3DrFyF56Lw/fvikbQKpUAoJDZxf9aHIDtpE71vsBdwqAc7IBags
 b7xRYdzApehdCxgnBBi+ZAQkHZmroCS9GQDgfQWudyouyAtn2VaPbhRCTmDVGe4ujQfhx9O
 uh4bbYErI9Ryb7EV0VlCy+O01lStrNhQs1L1coUSuqSB1oopRZ6i1GqKzAXHzkEhDMpgLKs
 BVw8H0y+kHtJmAyadfRyQ==
UI-OutboundReport: notjunk:1;M01:P0:n1AMTfX/98E=;h5GR/FP9JF+oKixYEyvsng+f+nM
 q9LzKYC+ZJad9uL/4qeAeSv0GisSTjRI8Ijzw1KUDDUfrcZFxRCqldO+lXavtRszK9jIibl1p
 wPC+txtXt5tHbAzjib/Cz/BREIEG0cnNaXz4ei/72uKKQE2GJIuVvoxkKuLuww9fxSzCCJ2d4
 yynpziW2bhRW48boAd/kfNX7dXwYxOTRLY2XtSCMYfHCiAcRcTCmuoYtSEJVMRQAvxLw5XqS/
 luPRStZPuDMa3jFGAyxS3GMdCLTWmSaKl0+x62iyuRyvhHtDuGbepazxUK+hwvPykpJGspAC3
 Gd3h/IAnXwuXFDjGFjKIHVB7iBZPcnpAifDWPAdm4/qXZZFdITlCTkWhJ7G+1m1A0thMpMU6l
 5Ir+qx42wFudt/5RfasMVjSbhErXB0nt44ssW2EYMcxjDpBy85FhJaP80xuBuKFkCd2NzF0t/
 xjkiSSL21EsLgkblwM5rnF9J7UXk4MOOQXKotdgTkjuf7aEdhHri9y4MLB5KDOgT05qWNx55Z
 x2cYfb+Mt+E5cy8TCn35DpsiF9GaUYujKsS0amGqxEvznBiTS5EwybwqHrkfQEaP9Bz3OwuXz
 xSb+eqVdXWfADM8wrGJCO7A49qLTaTNzjRWHmYuTlFd4MOU+9p8V/1qcvf/e4DIZ7GbpbQqbs
 VLddKP+nI3OdQFaMDLt0qGbvWrHeCNls4/2OOl0Bt3gm9DGF9CaeAXdOBWvbCUJTJcQ5n7x5z
 hJoUR/HqsOwgL5b54ekgyZPtiZQ2tujd4tDoqXWiilTZjdDztHl29OJkTLFaiXHl3WM8vyNux
 sgSYZe+hMFa6S2ffzMqWz8XQo4KRnY9pXTem/Dqag1ftofNZJTHwcCvMyxQUfBMu2k
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1690
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/f353bd20-1821-4112-b12b-bd1a111f7d20%40web.de>

> Let me keep looking for a bit and see if I can find the root cause.

Can the analysis become easier anyhow according to questionable software run time characteristics?

Regards,
Markus
