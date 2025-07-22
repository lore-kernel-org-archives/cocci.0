Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFDBC83F27
	for <cocci@archiver.kernel.org>; Tue, 22 Jul 2025 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2h0vKLBTqgqrxW08wHluunPO56skpyvItCeYhuEC7Vg=;
  b=SB3AD271tejb5zxxgOqh2bsIxY9CK7Obe+21zyi6FKLg4/ZIDrivqeKR
   UTx8p78apiUlS7G0avWY5oPnCghZiXgWSuT0jg2NxJRZ/vzsWp/S8gwEu
   H1Cv0GDz7qihLxnQ5a5uMRcLKI+aowpfKFH3LNalVAtIx4sBgv5t1qfIk
   0=;
X-CSE-ConnectionGUID: +INUOZZZTtK8upa5VH6qaA==
X-CSE-MsgGUID: /zcXfX0SQRC5gzoMHVKa0A==
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
X-IronPort-AV: E=Sophos;i="6.16,330,1744063200"; 
   d="scan'208";a="232556533"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jul 2025 08:22:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35B6DE0CD5; Tue, 22 Jul 2025 08:22:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98AC5E0171
	for <cocci@sympa.inria.fr>; Tue, 22 Jul 2025 08:22:03 +0200 (CEST)
X-CSE-ConnectionGUID: gr0xFROfSumRmNB1D5hQxQ==
X-CSE-MsgGUID: IYfPIvvkQsyqgnbeCA5dVA==
IronPort-SDR: 687f2e0b_q9vxX3X0yzrxjfNNFS+1UMceslEm0ZVCL9PZlRXrafLsjaY
 sgsfslC5pKHyTy1RadPitqcG/8cAoYGn255A5gw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GEEwA+LX9ogwsR49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CCJIQ7hzyHVIh4g1ICDwEDAQ1OAQIEAQEDBIIMgnQCjBMCHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOCjGFQ?=
 =?us-ascii?q?QczDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScPCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn6CIgEGEAEDDiQHsCqBMoEBggwBAQbaXh8sIlmBZAmBGy6FbYJkA?=
 =?us-ascii?q?YYnhDwnD4FVRIE8C4J4PogegmmCJoEWg2WVFFJ4HANZLAFVExcLBwWBIEMDK?=
 =?us-ascii?q?jQxI0sFLR2BJ32DDYEOhCgrT4IidYF5QRk/g1MeBm0PBoEYGkoCAgIFAkNFg?=
 =?us-ascii?q?SNAAgELbT03CQsbBj2SeIMfgg93FSqlMaFDNAeCOIFngWQMn2sGEy+DcQESj?=
 =?us-ascii?q?RKGOw4GkwSZBiKpHYF+JIFcMxokgzZPAxkPiTaEaxmEGsEjQTU8AgcLAQEDC?=
 =?us-ascii?q?YVGAQGJZiwIgUsBAQ?=
IronPort-PHdr: A9a23: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
 V0EzOGgRWzyHoj8xlAkdVRw2ojHSRK4YA==
IronPort-Data: A9a23:yRjV7akksnja3ixgt/YD3Dbo5gxtIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZCGrXOf3fMWOkLY10OomyoBsO75bTydFjTwE++SE3EltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRG/yhTreCYn0sLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMS31GWNglaYCUpKrfvdwP9TlK6q4m5A4QZnPaojUGL2zhH5MrpPfcldEFOjGuG4LsbiL
 87fwbew+H/u/htFIruNjrbhf0QWdaXZNA6Ih2A+c/DKbs9q+0Teeo5iXBYtQR8/Zwehx7id+
 /0R3XCEcjrFC4WX8Agrv7a0JAklVUFO0OevzXFSKqV/xWWeG5fn660G4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr+2smKKVcM5ivdkmFszNFtoz53FZ3QiMWJ7KQbibK0nLzdpfwSt2mc1EW/rTD
 yYbQWA2NlKaOUIJYwhRUctWcOSA3hETdxV9oUiWuLFxzmzd1g1335DyPdCTdtHiqcB9xxzB9
 zqerz+kav0cHP2uxwKk7Gyvv/TehCz9Uo85PeC0yNc/1TV/wURIVE1ODgvkyRWjsWa1XNlUK
 mQP6y82pO4z8laqR5/zRXWQpHebtxoYc8hRFucg4UeMzLDV6kCXHAA5oiVpbds7qIkpSDZs2
 lLhc87V6SJHv6fNWVyn0bmvsDaIPA4/dENfZRYUdF5QizX8m70bghXKR9dlNae6iNzpBD39q
 wxmSgBh393/auZUjs2GEUD7vt66mnTeZiIYjjg7s0qg6R5lIpGobcqk5DA3DMqszq7IFDFtX
 1BdxaByCdzi67nTzURhp81TRtmUCw6tamG0vLKVI7Ev9i6251modp1K7Td1KS9Ba5lZImazO
 hCP51oLtfe/2UdGi4coPOpd7Ox1ncDd+SjNCqCOP7Kin7AqJVbWp38GibC4hTqwyhZEfV4D1
 WezKpr8VS1KVsyLPRK3QOEayvcwy0gDKZD7FfjGI+Cc+ePGPha9EO9bWHPXN7xRxP3c/W39r
 YwDX+PUkUs3eLOlOEH/r9VMRW3m2FBgXPjesdJMTOefL2JOQSd5YxMn6eh4I9Q990mU/8+Ul
 kyAtrhwkQCk2yyYc1TXNxiOqtrHBP5CkJ7yBgR0VX7A5pTpSdzHAH43JsVpL4o0vvdu1+B1R
 PQjcsCNSKYHADfe9jhXKdG3oIV+fV75zUiDLgi0UggZJpRAfg3u/sO7Xw3N8CJVMDG7m/Fjq
 JKd1yTaY6E5eSJcMOjsZsmC9WiB5UompLoqXm/jAMViR0H3wY07dw3zlqAWJu8PGzXixxyb9
 V2kPjYFl8bwoqse0trAtYabpaiHTsp8GUt7GTHAzLCUbCP1wEuq8bViYs2pIw/PcXzSw7qzQ
 9lVw9XXEuw1rHwTv6VSS79UnL8Dvf3xrLpk/yFYNXTsbWXzLIh/I3ODjPJ9hocUypB34QKJC
 1+yoP9EMrC0OeTgIl4bBCwhSs+hjfg0uD3j3c4ZEXXAxh1c3eS4CB1JHhy2liZiAqN/M9olz
 ccfqccm0VGDpSRwAOmWrBJ/1jqqFWMBYZUFp5tBIY7MiygX8H9gT6HYKBfL5MCoV40RHGgse
 iSZlYjTtYR6n0DiSUc+JVLJ/OhahKkNhix08U8/Fwy3veTB19AK30x30DUoTw5q4A1N/MBtN
 0NKaUBkB6W80A15pcpEXmz2JQBlASed203uymkmkH/SYFmoW1fsckw8G7ep12II/11MegN0+
 Omj91/kdjLxbuTd4zAXW3M5m8f8TNd0yBLOqPqnE+uBAZM+Rzjv2Y2qWkYltDrlBpkXqHDch
 Ow34tt1V7L3BRQQr4I/FYOe87YaEzKABW5aRMBe7LE7Jn7ddB6yyAqxBRiIIO0VHMPz8Gi8F
 8BKDeBMXU7n1C+x8xYqNZRVKLpwxPMU9N4Of43wHlE/spydkyFItazB/S2vlU4pRNRTyfwGE
 L3zTA7bMGKshipzoVTv/e1kIWuzZOcWaDLshN6V9Po7LLNdkeVOX3xr7J6KkSS0CjZ3xzOVo
 wLJWIHOxcNA14lHvtXhA4dDNSqOOPLxU+WCz1Hqv/8TNuHwENr8mD4UjnLFPA1mG6QbdPoqt
 LaKsf/xhFjkupRvWU/nupCxLYt7zuTsY/hyLeT2M2t/sRaZfc3Rvys45GGzLKJWnONn5sWIQ
 xWybO2yf4U3X+hx6WJ0aS8ENTogEIXyM7ndoB2io8S2ChQy1RLNKPWl/yTLaUBZbio5BI3sO
 DTruvqB5sFqk6oUPUUqX8pZOp5fJEPvfYAEdNer7DmRMTSOs2O447DnkUIt1CHPBny6C/3F2
 JPiRCXlVRGMqarNncB4sYtzg0UtN0xDo9IMJ2ATx90nrAqBLj82HbxIe9FOQJRZiTf725zEd
 SnAJjlqQzn0WTNfNw7w+pL/VwOYHfYDIcr9OidvxU6PdiOqH8mVNdONLMu7D6teIVMPDd1LK
 O3yPlX1OQWthI5kT6Af65RXRAuhKuzynho1FYLVyqQewCryxZ0V2XYnEAcluenvDZTWjEuST
 YQqbTksfax4IHId1e5/dnQTFBxxUPYDCdk3RX/n/eszcLl3AAGNJDMT9g0zPnA+gBw2GYMz
IronPort-HdrOrdr: A9a23:jvsL2qrv0jTj6V9N2Y6FTugaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:3LPf52C2/H8IbX36EyZ9rF46IOcrSWDY9nL2CRaUVGZQWITAHA==
X-Talos-MUID: 9a23:Inl2cwZ3dWcRMuBTlg7ivBB8KsRR+LW3B0YHnL4v5sW6HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,330,1744063200"; 
   d="scan'208";a="121900835"
X-MGA-submission: =?us-ascii?q?MDGGQa/jPfahg71NYPtedJrfJSwn/He5kpST0w?=
 =?us-ascii?q?F5pkmjtDGCBozMRTIiTc8Oz6nEGFdGLlI6DCJAbPPSbgO73Hdxvy9J7p?=
 =?us-ascii?q?434H2iHLsC44cENDhcAtQP909HalyP9cD0P/Ifx0Cv+kX6O9Bdw71/K3?=
 =?us-ascii?q?hwHY4URqS65pnlrUbYkx8+VQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:22:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753165322; x=1753770122; i=markus.elfring@web.de;
	bh=2h0vKLBTqgqrxW08wHluunPO56skpyvItCeYhuEC7Vg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EcR+6cEi1rd3xCP+HXSaXxjxQupH2vAd8oOUiT64ese9VT4CkDdMUWQJKxF3RVoV
	 BgB4Q0EUATgE6811KmCMqF5MAxZTG2AIcOZaFtU/RbCL3sc0CKKRuP84PJONB2446
	 Xr0BDhLmd5LWVPj2tgCQwE6YU0u/1By8UbYfLQYPyHGZIjekbSeOh0XQKA0KDcG4C
	 zCE8pp/qjb0MpQ0KIeeJKw4EC4B9Zocp1dQSIe+Ja7tGKi24TQkIt/1Whb+ZWFaPn
	 tW55yCfTlA6ghsl1/3ZYYULjTwnl6kKB80IFVEuzqxU0npXvXGTPFtLyK4LNX/8df
	 Dg7QjN3j4Ag00V9AZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODmV-1uFhui3vdR-00XW7C; Tue, 22
 Jul 2025 08:22:01 +0200
Message-ID: <31912b3f-2630-4aa9-9632-609dbc4772ce@web.de>
Date: Tue, 22 Jul 2025 08:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
 <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
 <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
 <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de>
 <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de>
 <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr>
 <9154fc36-842b-4797-9b55-397cfdcba283@web.de>
 <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr>
 <457ef653-08a3-48db-89ba-6f0e9153e563@web.de>
 <195a2f45-af9-495d-694-673f7e5fb35d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <195a2f45-af9-495d-694-673f7e5fb35d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:foEPzUXbR61WJA5xCbxHjkiyAZYfFHRzxnvSHZM3QPsmeeTfvB5
 9yH8iE3VUsxbov+Z3o+THck1cATSNDgCf27RMOuF9Xdj8D3LmzytKyeGRXIViYgCpXScQk5
 OB13i+uQ0MU2CWvx+/rPJsZhBbnT3ki+fxOg2Q1o7uS4DhVZyOJv1iODqCk0ukruno8bCqq
 iVBtOF/wrrpL+VMsi9beg==
UI-OutboundReport: notjunk:1;M01:P0:2dZrFV4D0CI=;o3QMNFkKhe2C3rgM4JltrUP0hpP
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2897
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/31912b3f-2630-4aa9-9632-609dbc4772ce%40web.de>

>> How would you determine if extra parentheses are actually required
>> for a part of a recombined expression?
> The pretty printer looks at the context to some extent.  If you have a
> concrete example that illustrates a problem, please provide it.

Would you dare to acknowledge consequences from (temporary) software limitations
also for the discussed use case?

Regards,
Markus
