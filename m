Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC30C4167B
	for <cocci@archiver.kernel.org>; Mon, 27 Nov 2023 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2Hcv80CdSnF/baZXAWp8nrzVbbDJsvAbt4c/9hvD3kA=;
  b=C5t8LHhjktN1ApScXb9zcmL7B9dWAlWqcOZgFCqbjBVBi7D+NVUs+Dc2
   qH5/4d3yDTMBBGSlChoHhhzFYGdf6m0tyJSCEmAhaiwv54MtQIfMaoFAy
   3cs4jshqjoP2vFeGH0al2O+MvWe5I3qojqJSpo98jtFoCMqN20otGkW8a
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,230,1695679200"; 
   d="scan'208";a="138753875"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2023 14:26:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D956E0CCC; Mon, 27 Nov 2023 14:26:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B8C7E004E
	for <cocci@sympa.inria.fr>; Mon, 27 Nov 2023 14:26:27 +0100 (CET)
IronPort-SDR: 65649903_zOgAze0I3N0zsp8lN3cAtGEihWIBRJakmO6xqA/fl6zzy2E
 oNOn3M8CXof4OHU4IKC9WJrdLUhGwvBw4go3P8Q==
X-IPAS-Result: =?us-ascii?q?A0EyAAAYmGRl/wsR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4B3NWMAQLSIRTiB2HIIIlhDuOfohvgVaBQD4PAQMBDT0EAQIEAQEDAwGEf?=
 =?us-ascii?q?wKHKgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE?=
 =?us-ascii?q?4VoDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQECR0IBBAEjHQEBESYBBAsLGgImAgJXBgEJCwEBgnwBgikBAw4jB?=
 =?us-ascii?q?w0GqxWBMoEBggkBAQaBV0GtPR8sIlaBXwMGgRouAYgMAYVZgzt6Jw+BVUSBP?=
 =?us-ascii?q?AuCRzE+gmEBA4Feg1uCaINshTYHhiaOeF0iBUJwGwMHA38PKwcELRsHBgkUG?=
 =?us-ascii?q?BUjBlEEKCEJExI+BIFhgVEKfz8PDhGCPSs2NhlIglsVDDRKdhAqBBQXgRIEa?=
 =?us-ascii?q?hsTHjcREhcNAwh0HQIRIzwDBQMEMwoSDQshBVYDRQZJCwMCGgUDAwSBMwUNH?=
 =?us-ascii?q?gIQGgYMJwMDEk0CEBQDOwMDBgMLMQMHKVVEDE8Dbh8YHgk8CwQMHwIbHg0nJ?=
 =?us-ascii?q?QIyQgMRBRICFgMkFgQ2EQkLKwMvBjgCEwwGBgkgBA4DGSsdQAIBC209NQkLG?=
 =?us-ascii?q?wY+AiefZoNlYlmBBcYhNAeCMYFfgWAMihaVDQYTL5ciDgaST4gZkCcgjUeab?=
 =?us-ascii?q?YFjPYFZMxokgzZPAxkPjiCEK4ELjjxANQIJMAIHAQoBAQMJhUYBAYNagUABA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 BI72FMWXA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4GMn36wPpb5KCbwVJIDgKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AygOZy2ixMeJoe9L21B+OhUO5DTJuSCXm0lXKMVW?=
 =?us-ascii?q?ELWtFYb+lb3myqbI5nJ87?=
X-Talos-MUID: 9a23:8ZPUwgVDxC/uATfq/CDSoDE+ZZpU2P+JOHo8v8lXle/HByMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,230,1695679200"; 
   d="scan'208";a="138753862"
X-MGA-submission: =?us-ascii?q?MDHvF+RI6M3/GLV2VGU2FUoPxD3H/3TXt2baFa?=
 =?us-ascii?q?I7CETOu1H/g3rIB4+l4sPoPL+hcZZP4Seyf9Lbh+mCZTj7InGcrtNRP1?=
 =?us-ascii?q?JNVAjS3pe5u7Kg8N0PvL2eH7Lw9m4PKZHfnUaKkUiTvC+AC5sQFZ3pIp?=
 =?us-ascii?q?xw6/DrQGFgeQ7AJxrbpPe7EA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 14:26:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701091578; x=1701696378; i=markus.elfring@web.de;
	bh=2Hcv80CdSnF/baZXAWp8nrzVbbDJsvAbt4c/9hvD3kA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KHd7iZOZV0Ce5cvfm9DHWkHY6l1EN7oznJWizb7ABcsRYGNnpNzS618wP2zzZruq
	 6HZYZX24vBffL/0Ool1YhrIhYEs/+lNJRDIoBirZDGhPf3l/yx2Dioav5qUjxms8U
	 yOInkauCNq5fl+3po4OC4wBgb94IGD0iDiqCwTIYbsSGkmTVk0aLF+tTlsAzaGGbO
	 AfzS978R2CZUuxH8gT8yDLZMCtqqzYOnZcWVgCoLShkdACuwSMiAbDiDA3uVEQ5Qk
	 VgjiVcEtpT87JY11e6HQwtmyJg/ilTIuEisn6z4zgdfaJbXcG3wqWWVUkJSiI51Uo
	 bh/FNftp4mA4qVpHkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1r7L2r0hkt-001vQg; Mon, 27
 Nov 2023 14:26:18 +0100
Message-ID: <7a345205-9c37-4c0c-8844-a986be7369e9@web.de>
Date: Mon, 27 Nov 2023 14:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
 <1d511f1f-4cab-433f-90dc-a6f4e9d3fa7f@web.de>
 <alpine.DEB.2.22.394.2311262136020.3149@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311262136020.3149@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jNB1bOKra4jdOxR2R4KX7WZre1yaciZmTQgwmwLwnoxDpqasJ8
 xnTCMMfpFE2GedtluFicHaYrcqrdO8tjQMBHvkjh+04amC7cg9xUaNWuRQbsjl/F4cg7Iky
 83tlysEED3MKl1DKD/pB/A6MrUzT9gagS1C2phRsBQITnwW90Ob5R+N/ZuZhZVsIljKKa0a
 ohSUDdQ4X8kxJncihYKjQ==
UI-OutboundReport: notjunk:1;M01:P0://VB4qxAoYE=;rupXcKGpN2iZCXlKV3uK8sIq0Vn
 gSJ/pggAa4cYHpXPRLwXcR2H04YzEFL79h97wd5QczQNKGG0SBeTFZRJqXuWqvtfNSy1/sCtc
 YC6Y104XL+G/OJu9so3DGvnGervMzJCV/KaTB7+PY929UjiMdxSu5VgvK454UQ7CviKRrWJzW
 8FVAFJse9p/gQT3ZM0ECqzjXtlTq3+kctv7CM+d3UdX1PeCefdFhdZl5ALcW0eagfGCM8bO2n
 JSPBeZzT0RRge7JOcPlZ1t8wKs9Hy5YVAjj68SaiuEiQPWOD5sKjAIyKnIbMJ3mMnoBLLUsd7
 8M41OD0rw0/lgXexwKsEKtgwVUtY3gXoIHv2UdgXyAhoNC9WhYsKMmGJ6UwDqkskyfCdLKxqI
 bYAALK8KALRD4QhBxKlMtal0s0K8VMD9JAYLKME8pbHVW2gk6HIsENE8mfL2//0AHDco3d/rx
 M+ZElhmRbh3BfkqcSmUnGtuKmtj13nbPFTlNYSO5U2HH15pM1GewmDWuxQymblfJiPrforrun
 DU8gix41OieBIsE+RZf/q6Uoyf6u/2w306ihuOHpYen1u+JUehBftJ74Ub7cRo357QTlxXI/9
 iD0PVY+YijpazEHb6YQDSzUH/kzggI6JLkLRQOAcWyvaEVFWLBlflQEzel69a9SNbF4kZF38w
 UOjhfBsKRZWesLr33D2kuP4Ti5M2p9F2ASA4msnvtVRZIvtYhBDKxAxUxaZj6veWxHsd53xv7
 3nyBaZ++Tm40d8Ui5PYKG/wfadHWxPlmEtPBgfaxX7iX1ZCoiFLdVBNLLt/xKm1Q/778ThRDF
 ++ZmNGMuLA3jMMGKSW3B1jkw6NP9TIob6t1md9FxF9Gzc2qWcEfIUdNL7QAs7NVNWtWWBqZtn
 iFKva6uXNxI19HnCObrMTpCl+AItqGxp7OnZ3dV6q1dr1uo2dQOm+/JZ8N32yyuUnAtrLg5+x
 zr4+aA==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1339
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/7a345205-9c37-4c0c-8844-a986be7369e9%40web.de>

>> Would you like to reconsider the representation of shown number attribu=
tes
>> as text strings (instead of integers)?
>>
>> How do you think about to enable the usage of an integral data type her=
e?
>
> I odn't want to change the interface.

I hope that circumstances can evolve into more desirable directions.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/07e1ee1eca39bf5282882=
6d1ac773facd47491b6/docs/manual/cocci_syntax.tex#L684


> If you want numbers, use OCaml.

At which place are available data transferred to the evaluation environmen=
t
of the other supported scripting language?

Can it be determined anyhow where questionable data type selections (like =
=E2=80=9Cstring=E2=80=9D)
are performed so far?

Regards,
Markus
