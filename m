Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B154BD3B98B
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gK3YHcEUeZ+zgADUiKv/PJwsDoDZu3Bm0tlV3ysUn1E=;
  b=BBrgegzY2lC5BhaL4jCK/F2tEM8F/mgGWEJjsUk7e6w0TgfHeIXi56oh
   wvwHRoWaNlppCnxTUiIxoBuy2BUXGzLkDcJEdZPzmakrBAQRVi74w89PG
   cEWh3bI8UThaMXWjkzoaXT/Bp/aueTPdUzLjxhnQtYgq1Kwi+PPMds9nD
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195869138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 13:56:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40E4FE0D1D; Tue, 26 Nov 2024 13:56:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DB2A4E0D1C
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 13:55:55 +0100 (CET)
IronPort-SDR: 6745c55b_2ZRJDMNbgU650OOjnZtlRAHrm1FZxxvZBx10nMTLRHn2Q+w
 paHc9ULU83CfsdzGTAgdt5NR0zMApVMACxBlcrw==
X-IPAS-Result: =?us-ascii?q?A0G0AAAsxEVnewsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgQNUMwQLSIRWj02BdIRrhzuHVoh1g1QPAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?QACilsCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QFCDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBESYBDwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ9gjABAzEHsC+BMoEBggwBAQbaWx8sIleBZAmBGi4BhWmCY?=
 =?us-ascii?q?gGFaTuEPCcPgVVEgTyDAz6EQ4NbgmmCKByFDyWIGGibVlJ7HANZMgFVExcLB?=
 =?us-ascii?q?wWBKREQLAMibmlOf4E2KIEpAUKBFYE5LxshC1yBKX0dFAYVBIEOBTcKPYJKa?=
 =?us-ascii?q?Us6Ag0CNoIkJFmCTYElBAWDa4ELg15lLwMDAwOCEYErgkldgnIdQAIBC209N?=
 =?us-ascii?q?wYDCxsGPaFnhyEckymyZTQHgjiBZYFjDJ9ZBhMvl0MOBpJ6iC+QTCKpBoF9J?=
 =?us-ascii?q?IFcMxokgzZPAxkPjiGELcgMQjU7AgcBCgEBAwmFRgEBi1aBSwEB?=
IronPort-PHdr: A9a23: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
 AE7gE1ybLZ1nN8Jy0g6LBzGqXlo+HQ=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pRkmq6FiOWUU9bKfpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AYYreW2tnOTEj1+Q1F8YE2IUb6IsmbiWelkroPnb?=
 =?us-ascii?q?kEH5IVeHEU1y+47lNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ae1vBbQ3MyuyZwIl44sBZQYPc2DUj4L+oE2Upqq8?=
 =?us-ascii?q?9t+qZaXUpIWejlg+pTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="102667010"
X-MGA-submission: =?us-ascii?q?MDG3k76hgYzN7ljbWD8lqa3xDXHadqlrGGTXfn?=
 =?us-ascii?q?qkX5BCrfBOip8ZjjVrQl0mJdhbm5EVmqngn86AVJe1W/NFHW77GTjJUH?=
 =?us-ascii?q?EosWkhKK0mTK3lJSFv3xdTEksPuTJdIqKfNQpN+b6ecxo8ljHuSOq5H8?=
 =?us-ascii?q?FlxCk0cHDYeemLffnnQPxUeA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 13:55:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732625738; x=1733230538; i=markus.elfring@web.de;
	bh=gK3YHcEUeZ+zgADUiKv/PJwsDoDZu3Bm0tlV3ysUn1E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ws0PxqQDC4XZm2wteDC2J3YFTVpgUeNaV7Pys1K/oBjCS3USX2Lr3IQbzsFXmEVI
	 bezYVgEGestzd5+pHFvLqhp0IFwhofb5EjkC1l8W15KQT0V9rFc19eRmKCxL+Altr
	 /j0ijHcKBeeak7lKy0wF09kMMCBFWkoje33nTjm/isWQV28lsUcsZW5VzLkNp/sIY
	 FmMJxTLyNSei5FGdlPamriRxu+kw2XJNoSiEpiZfxa+4TS/xK87Mng778wns6HDRl
	 7xiUGFzordrLFW9FSq+vmpZNtQqNU1H4O5/gdpN/Gu+3i7CVElgyO3k9SpZrQnduV
	 BfeCe6vDcqTnzID5eQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBVv-1ts19D2HxN-00en7K; Tue, 26
 Nov 2024 13:55:38 +0100
Message-ID: <8e49861c-123d-4d78-9da7-bdf747c9c33a@web.de>
Date: Tue, 26 Nov 2024 13:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MDBaCd5Ogw2HMK7C+j9ZJzpAn0WcQvq6r/9CqpSCCwTa/pHw77Z
 z29khTQMVIoaz+4QqnLEzWe/ypodb9ldfFheccW3ousjK1py8Cb/+kCL0JZy/BH9qQv5WYt
 qpOa1QAs43MpmSFuElXXieOK+Z4diFseMlqhZSsGWoYlui2blbEQy/Ab8bjUi6KSe65zdBm
 WON7+b3IX2YQB6f5D8p7A==
UI-OutboundReport: notjunk:1;M01:P0:o8lRbajgDeg=;DDK1KaYZnjqCcyqvQm63NFF+INt
 CKuiNH3fyOqSfxRWfzyEODHBWSNpfw7bmpIlwV4lTnl24NXEjWLE0hPMKdDsMwrG0uxoYHhn3
 dxvXqQVsRDiyJc89tnLJgPjNo2a9GFuzP4KqMpA/RpaIQPEv2X99K1fJwujDZDgwYztvQe2K3
 F5jYpRUuXPsxm6hOKGYB+3C3df5nTX/VnqUZ1FHUNh87hhgtJabOIRbiHQxvoY5SrgluVW2qd
 1g06360v5WijjEG7QdL+c49nNi7XOwd3hHAKn9I9tv1coJ1mw8hLBQ5VY8EpzXW8Qpan5pjKS
 81Drw9jb3cw+AL5JJhtQTNuLhQC9jiqGJrnUmcMm3R9x48MZt3dmeFtJU1XOQYhMWiY0PHnYY
 rvVosnr7WPIS7tohynjqdwHvolU1jdX7jVCYnzsttAeoHGccmNalLAlIJN75KYxfClH/NXac7
 yvLj/iYvcbVZvK/IO+lGzEiFfzrP2CP2K6StAvmieMEBlsEuCFxbQa0ddOk+j9aU9C0Z3w86K
 jVRZOqIoJ9TKk47BwoTgkg/63Dhu7fTD3g8IAvl/l86aZP5fY3+vL8/txY1jQe2Q1WValROCy
 kyNzSHofJ1/y7WISW+ymD/j6fopIopi0aSujHfApUlhztfYsk0wQ+yW7mGl4ITDWZ60Q0T1+N
 xNYOCGf80SZS6SnSdnvUJhqJEaDjbP55fIWZxadUvtR1bjm6KLHn89WcFo+dq5ixamEgE6A3h
 OzIusA4klgIDtykVWVQG+RglIVeT28s+QLOWLBEnJyAVHWZEGxvLM3xVTf1bhxDkr7X/vT0X+
 DPRKZWOQD3cVJfzPBD6meWSz7SOSDni015L1vsFhCV+hBF4MOX2smYmA2ZjSMw7eP1tOar9VT
 91No5+V5jugl4/+/zxnIsfmJqXV0kl/6cdbaKi+Y6GgTw+6eBPv3p32CSIaSSJXSkTG8gUaOd
 XicZuuVNWUNIGFvycq+soIWSYONRN2Q5KKIxvzfadKxgAKBmac7YJ+ZEpsmSF6r9hKGf6V5sW
 ECY7bizU1wxIJXGN5y1TyqyUeKwqmGW0FRsufzO2K3HW5wM9kRJb+y0lpVNQBhe5fXcGya2Ag
 qesnjVmYc=
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2130
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/8e49861c-123d-4d78-9da7-bdf747c9c33a%40web.de>

=E2=80=A6
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)

How do you think about to use an SmPL code variant like the following?

(
 E1 op1
-F@p(EL)
+E2
 op2
-E2
+F(EL)
|
-F@p(EL) op
 E
+op F(EL)
)


> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@
=E2=80=A6

I would prefer the dependency specification =E2=80=9Ccontext=E2=80=9D for =
this SmPL rule.
The SmPL asterisk functionality should be better distinguished here.


=E2=80=A6
> +@script:python depends on org@
> +p << r1.p;
> +@@
=E2=80=A6

I got the impression that source code search approaches can be safely
shared only between the operation modes =E2=80=9Corg=E2=80=9D and =E2=80=
=9Creport=E2=80=9D so far.

Regards,
Markus
