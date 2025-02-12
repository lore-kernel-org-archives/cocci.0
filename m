Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E4AC0219E
	for <cocci@archiver.kernel.org>; Wed, 12 Feb 2025 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mjZMexpxRGQVOf2DMaZMat+0jXOPqFph5NI7jpZf1nE=;
  b=KBFjObok4Vu9WRXP6h3klv3/BAW/q0qfXQFflFf1wV4N9CMM0nb2SGvY
   +oQqE6gOVkharIoqBUxD1y4XeSSROx282AuC22KoFk7dJxedHhg1ihJhF
   xhHle68cprKUfUZN9zMGqx3d5Mv227rkC/xykZ0AW8sssSrRfyj+Hy2go
   E=;
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
X-IronPort-AV: E=Sophos;i="6.13,279,1732575600"; 
   d="scan'208";a="207870216"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Feb 2025 10:52:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09EE7E0264; Wed, 12 Feb 2025 10:52:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AE9F0E0260
	for <cocci@sympa.inria.fr>; Wed, 12 Feb 2025 10:52:26 +0100 (CET)
IronPort-SDR: 67ac6f5a_q6jMi15ogD3goNco3NUGDqnRnBnmMAXT16yr+zwh3tEtldm
 zFUQVUWvXMmnzk1+3MvqIs9wFaSRs4Ksm4c5pBg==
X-IPAS-Result: =?us-ascii?q?A0HRAADCbqxng07ASNlaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPT4F0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACiwkCH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO?=
 =?us-ascii?q?4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfoIwAQMOIwewA4EygQGCDAEBBtpcHywiV4FlCYEaLgGFa4JjA?=
 =?us-ascii?q?YYmhDwnD4FVRIE8C4J4PoRDg1uCaYIzgnCBV2eaU4oCUnscA1ksAVUTFwsHB?=
 =?us-ascii?q?YEpSAMqNjEjgSMFNEE6gg1pSToCDQI1gh4kWIIragQFgSuCO4RDhE2FWIISg?=
 =?us-ascii?q?WMDAxYQAYIxcHgcg1SBTx1AAgELbT03CQsbBj2faYcsxwc0B4I4gWaBYwyfX?=
 =?us-ascii?q?AYTL4NwAZNSDgaSe5h8IqkMgX0kgVwzGiSDNk8DGQ+OIRmEFMYkQjU8AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBineBSwEB?=
IronPort-PHdr: A9a23:C4b/1hL3X/K9U/hEy9mcuIJsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSVBtiGo7Ic0qyK6PmmATRBqb+681k8M7V0FCU5wf0MmAIhBMPXQWbaF9XNKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAvPusUMnYduNqk9xxTHr3ZIe+ld2GdkKU6Okxrm6cq98oNv/z5Mt/498sJLTLn3cbk/Q
 bFEAzsqNHw46tfsuRffUwWE+2ESUn8RkhpGAgjF6A/1U5LsuSbkteRzxTeXM9TuQb87RTqt4
 aFrSAT1iCgcLD427HvXis1rg61Fph+qugFyzJTVYIGRM/p+Y7/dcNYHTmdPQspdSypMCZ6nY
 oARE+QOI/pXr4jlp1sPsxS+AxWsBPjywTNMn3P6wLE23/gkHQzAwQcuHc8BsG7Modv2OqkdX
 u66wrTWwzXNb/1bxzXy55THfB06vfGMRKh9fdbNxUUxFQ7IiEibp4z/PzOS0+QAq2+V4PB6V
 eKslm4nsBx6rDerxscikInJh4QVyl/Z/ih+x4g6P8e4SE1mYd6/CpdeuCWaN4VsQsMjRWFot
 z03y7MYtpGgZiQF1YooygfZZveafIeG/gjtW/yNITdkmn1lYrS/ig68/0Wvy+DwSsm63UtEo
 yZZjNTAqm4A2h/O5saIVvZw/kWs1CqS2g7d6u9JJVw4mLfVJZMu3LI8i5QevErBEyL0nkj9k
 ayYdl089+S29ujqYK/qq52CO4Nulw3zNroilta9DOk7KgQDW2eW9f6y2bH+50H0RLtHgucrn
 qXEtp3RONoWpqqkAw9OzoYs9Qy/ASqn0NUZg3YKNE5JdRSahIbzIV7OOur3DfKnjlSsjjhrw
 /fGM6XkApXKM3jDjK3tfLhj5EFH0gY80M5Q64pVCrEHPv3zRlf8uMLFAhI7KQC5wfjrBM9g2
 o4aR26DGK2UPaDKvV+N/O0vIu2MZIEPuDb6Lvgo//nggmUjmV8eYKmpxoEbZn+8HvRoOUWZY
 HzsgtgaHGYEoAUxV/bmh0CcXjJLYXa9RLoz5isnB4K+EYfDWoetjaSf0CujBJ1ZenhGCkyQE
 Xfvb4iLR/AMZz6OLc9giTEETrigS4o51R60rgP6yrxnLvDV+iICr57j2sJ16/XJlR4u7Tx0E
 9id02aVQmFqkWMHXTo207t+oUNj0FeOyql5g/1dFdNI/fNGSB02NZ/az+xgCtD9QBjNftmTS
 AXuftLzPzA6UtUri/AHZkx8Fs/q2g7C1DatGfkanrmBBZEu2qPaxXn4YchnnTKO364qhFgOQ
 81VNGTgiLQs2RLUAtvsml+air3iWKASxi/L+y/X6GOUv1xDFiN0X7/EW383eUbc69j0sBCRB
 4SyAKgqZ1MSgfWJLbFHP5iw1Q0urJbLPd3fZzj0gGKsHVOSwbjKaoP2emIb1SGbCU4ekglV8
 2zVfRMmCHKHpGTTRCdrCUqpe1nlpMx3snCmVQkZyw+Qbktu/6W48FgZiK/UUOsdi4oNozxps
 DBoBBC41tPSBcCHol9Edb9ffMh7zVNJz2PfuCRiM5bmI60xzkUGfVFRuEXjnw5yFp0GkcUuq
 yYyyxFuLKuDzF5bXzafwIy2JbDdbGX/lPy2Q4jR3FyWkNOf+6NVre89t02mpgaiUEwr73Rg1
 dBRlXqa/JTDSgQIA9r3VQ4s+h52qqu/AGF17p7I1XBqLai/syPTk9MvCuw/zx+8ftBZeKqaH
 Q72GsceCoCgMusv01SuaxsFOqhV+stWd4uDfuGFxbXtEeJuhjOggkxY7Yo73k/NvytwR+jU3
 ooUlumC11jPXDP9gVG998HvzNodOndNRCzmmHKiW94CA886NZwGAmqvPcCtk9B3hpq3HmVd6
 EbmHVQNnsmgZRuVaVX5mwxWz0Ue53K9yk7ah3R5lS8kqq2H0WnA2ePnIVAiM3RIWXIkoFPiO
 4mygPgFUULuYwVjx37HrQ7qgrNWoqhyNTyZZE5SfDXtaUxmXLGxsLWqfMNFrp8l+3YyMqz0c
 RWRTbjzpAEf2iXoEj5FxTw1QDqtv43wgx1wjG/1wG9blHPCYokwwB7e4IaZXvtNxn8cQyI+j
 zDLB1+6Nt3v/NOOlp6FvPrsH26mU5RSd2Hsw+bi/GOe7HdpHAb5svS9gNzhHiAl3CW929QiW
 SjTrRn6a5XmzOzgaL0hIRMuXQ6mrZUqUohl2pM9npQRxWQXivD3tTIcnGH/PM8akaPyYXwRR
 CIaltvc4QzrwkpmfTqCw4P0UGnYw9M0PYDlJDxMnHtstYYVWPTxjvQMhyZ+r1umoBiEZPF8m
 m1Y0v4y8DsAhOpPvgMxzyKbC7RUHE9CPCWqmQ7birL25KhRemurdqC9kURkmtX0RpSLuAJBQ
 zDUfpk4HCl/xtpyOhTA3Tegj+OsMMmVdt8VuhCOxl3lhvJWNYl3u/4EnythNkrisHdjx+Nx3
 nkMldmq+YOALWtq5qewBBVVYyb0a80k8Tbola9Cn8yS0tPnDtB7Fz4MRpetUeOwHWdYq6H8L
 wjXWm5ZyD/TCf/FEASY8ksjs3/fD8XhKSSMPHdAhdwwQR6AOApAjQpSUDhyl8w8ER22gdzvd
 11m7yodoEH1oF1Ax4cKf1H2AGLYuRvtYDApTpOSagVb5EdO6g/cY8mZ8/42FDpS45mi6lWEL
 GDCIQ9PCARrEgSNVVXkI6Xr7sLL9PKAQLO3KfeXJ76JrKRIXvOMj/pDy6NA+DCBfoWKN3hmV
 bgg31ZbGGp+EILfkikOTCoek2TMadSarVGy4H8/qMf36/ntVA/1gOnHQ7JPLdVi/Qy3iqafJ
 qaRgih+MzNRypILwzfB1rEe2FcYjywmeSOqFPwMsivETaSYnaEybVZTcyRoKM5B9L4xxCFIP
 tPHzMz43Ph0g799CltIU0DghtD8ZcEOJDLYVhuPD0KKObKaYDzTlpuuPuXjE/sJ3b8S6E3j3
 FTTW1XuNTmCiTTzAhWmMOUWyTqeIAQbooa2NBBkFWnkStviLBy9Kt5+yzMskthWzjvHM3ARN
 T9kfgZDtLqVuGl9i+98BncHw35rN+iClA6G4uOeJptc4p4JSmxk0vlX5ng30e4f9CZfWPl8g
 zfftPZrpEy61PaCwHxrXVAdz1QDzJLOtkJkN6LD85BGUnuR5xMB41KbDBESrsdkANni00i/4
 sfCnuT/JWUbmzox1dQRDY7YJZDfWJLAGR/uBSKSEwYPCzKmZzm3ug==
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:BQSZx6mbkrsjaQZ42u00wr3OcDTpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AFRKP92sMIbJkoCHC42zrAIrk6IsEflr29H2Ne3a?=
 =?us-ascii?q?mJj5EcrvEewG+8vJrxp8=3D?=
X-Talos-MUID: 9a23:6WgDnQRXas24f00nRXTPjy1dCdU1xZ2AVkkzrLwrkNTaBRBJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,279,1732575600"; 
   d="scan'208";a="207870205"
X-MGA-submission: =?us-ascii?q?MDFYZFVos9CpK9lvSJ5DP8XfPYZ3/29WyDFUYO?=
 =?us-ascii?q?68CWR61H8z8m7xyp49MSadH6LNNAHvt9JUMZbR5E/D6akaAcAkoRmldC?=
 =?us-ascii?q?BdK2BmlNUhtp97iZp4qPbPOHs2yufw+uDjmO4mAHTS8np7kUD1UmqqTp?=
 =?us-ascii?q?yFCk+UT19FgXpQdYb/ZPtcPg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 10:52:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739353945; x=1739958745; i=markus.elfring@web.de;
	bh=mjZMexpxRGQVOf2DMaZMat+0jXOPqFph5NI7jpZf1nE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=imI/wBN4rQELq/FmO7tt7HdwGlRdpyueFFHaryLOqRGeB9coMan4ziLq1HCJyG9K
	 NBB1Qa6Wf4W170wy26y9HLLneXHKG2UWgVk70LgRRWCA56ITYK8/X4LAw97phxe8i
	 fRwdxwf7JKfzPxeoXze0LFIfmPb7PM7kWo2YFD5qqToqret6gGLPRaTPj4ewJQuF2
	 z1XoLhDmoT9uorcA/1DCpJkeKD+S7uFR8SKkEjxfOX7yVWTMTKW9o4U4As/pkCvqZ
	 U4YkhU4GDyO7axdon4297GUjC7V6UIbvgSZMkhJOBYILkDWB/z31AHRgz9wklqJm+
	 GVWjimjIMMvgP4g0Sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1tuQwe1WKb-00PfKU; Wed, 12
 Feb 2025 10:52:25 +0100
Message-ID: <46c9b8e2-c169-4683-ba65-0e25c03d5136@web.de>
Date: Wed, 12 Feb 2025 10:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Go0OSEJv54PdyebbDGRVZpPX6KJZ8UDrAMQBbEj2B70J4mzT5LN
 +D72jJViKjuhgySAO15lepSj90ZRvTDEClCjxh4+vaRVsVfu+c5j6+OrkKVnfhNJ8K0EMdh
 rST1z7j+f9aMKEYhlbVJKq7BMZWq2nO7Q+PizumdaXLyLnhIZaFIHf6OMohis3BNw+6IUpB
 Kq+Fec971LzAVuBfg6Rww==
UI-OutboundReport: notjunk:1;M01:P0:MZy6E7FKMfw=;fZVILP3i1H/K/c6G2Qmw4MKIAaW
 xlkUSeCErOwgUzb/zuA36DpGeGMTdh2ZBs2Z4iB56fbBjLGLl/GScfM8KtxPx6MvxH66lCOHb
 nHTbhF0mbSXYDVbrxYQgF/3PpVP/Bm2dxPsC1C03t2+FWMtgrjwQzKAzLTv5FCqcvqs/Sslci
 aKuS3k43UlZAFnsGcyUcXl+0IgirD3pG5ZNxeDm/SCSpTiAwDL41f934wN4d7d87Yp1zB9k3g
 y703rEtEH24nB3yU5mnfaf5wl7QQX78TrSSCDofP6HcVh5NAX49sF2j0uC9PE58ay+Q7zliLE
 NbdsPxuwpdrvAPYxog66Fbzzk7jO5aurX1izgZr5IveyjDiMeaMeM13VCIJ50NAT3H+7hdlEe
 U07pBxkX00lesz0CGi6ddK8uscX+rMSpDCfSecZpcgkqmT0az/fC0oqXK0XKuOrW1Z8ouwTw/
 PqZjHCRv8OR2OmJS/8LwgNLBUULf1XJrGYee5fZ6wTHKX0VPub/633oi9yOF01xyLoUmZtD7o
 64mh9ZGM7cTGYpst4vrNv5T5rag1AD/GH6oJyZsYSuzC5vkpAFq8zJ81IzwpxpRKTop4x7VgO
 /EMaw4mXS+0EM3gONhBnwRjEmrSYrC+znDzoDZJlTSky33Tl2Rps6o6mMpNDMyGxzv2Q8oydS
 NQqzZsLxSpgKkxgpwvavHCyM9fYF7vtp4SPwIzZXZfiPh4l2bIhIa7e1Tdi4K2BfwPQ2OKUGQ
 duW66if6ke6h6lf1K2NvzhtOzi3XIctCYwmQQQRQWbshiNKQ0DMqTxXSoPzHCrRUZ6eA799Cd
 cRjJJ7oMKGChg5+wXzVqhIWOXxVobk58mo8Cbhqcj5Ik2kXpcSJKhlJoejJUEcNXwOCE9Bqdy
 pXxIX9WdKvXd09NB/ZbDdmG3Gf5o/0ee0bCo1KMADW32w9kTKNT+P91atIWVUdh4ITPYyHarL
 2vQJQgsijqd5lyu9bueMlyRvHF007Xynidt5i5GqfQ76m3aHdBgcwVvcUWDPeAB9lcMCKtGj7
 DUAaI7wgdxQsb49CiDu+hwLh5O4TEDZ76bxw5DjM/d0jHfXPUKwWt1m/9JbgybpllkTStD2ZO
 R79aj440r2a9i4/SGXNU6oyapTQx56My/6yuxUZdpyw7BzKg1Yea4ORUnoCS2VfMEpHt2Mr5l
 qTerFpbprMYNRaCSBHQchs1w0clKQTGI7MDVq8BVY4z1P+uzSZFbq12iF7r3xwYQuyeXnExnl
 1D2OPwT6XSDWUzIH+bcwN5uya5tVsbPsOtD4yvgwZNJI0HgCtUaAU6RzlsSZdRmwah4Bfi+kg
 udiyi3roArIBiLDmiMLFuYoQ/orQ7CbDPwrjLG5sEFJj1CQ8q6/LRC6imSv9zzIpfWv7v+f7x
 SWnO0cWpcXyiT+FodeTSju8BaefQYhQ0Spsec6r6L5NnhgmwsfRUwD5sntGnQIrtzXtjpHzfv
 SW/+vzRlCYTWKuvVbqaDn/GDxveo=
Subject: Re: [cocci] Profiling of SmPL code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2415
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/46c9b8e2-c169-4683-ba65-0e25c03d5136%40web.de>

> That is not enough to narrow=C2=A0it=C2=A0down,=C2=A0I'll=C2=A0see=C2=A0=
if=C2=A0I=C2=A0can=C2=A0figure=C2=A0out=C2=A0something=C2=A0else.

Would you become interested to profile affected OCaml source code
in more detail?

How helpful would data be which could be determined by tools
like the following?
* ocamloptp
* ocamlprof
* gprof
* perf


Regards,
Markus
