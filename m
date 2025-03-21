Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D41C36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vJYWovga3sCCg7yjjpD+8W8WhUQnLQkACj7yw6V3FtQ=;
  b=qF31YkgAWT4Fmah0xQRlf+2uCKII5JrBQPLPUUCYhZDnlF7dYDUYu1EV
   l1rab1wWj15otH2IiDqysiYN5wuP40DCyiagYD1Qr9nzl92fX5f6nnCOw
   R0sE95SvUtIvD8gKm+d3E7aE7fiuVfMUtrEStikaBTt/aXoQrua3CWVha
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
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214142283"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 14:52:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27BBDE0D1F; Fri, 21 Mar 2025 14:52:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 79FBDE007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 14:52:17 +0100 (CET)
IronPort-SDR: 67dd6f11_QYbJ4H+FERVS2tLrPQOinn7rYhMCOFuLpLgED3Z6psM+N76
 s1LPyyVQHOcuh5InJpLmALSbwL3L2B40tnQkKjQ==
X-IPAS-Result: =?us-ascii?q?A0EWAACTbd1ng07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDgVczBAtIhFaPUYF0MIQ7hzuHU4h1gVaBfg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwSCDIJ0AosiAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBAToHDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBA?=
 =?us-ascii?q?QIBIx0BAREnBAsLGgImAgJWBgEUAQGCfoIwAQMOIweuQoEygQGCDAEBBtpcH?=
 =?us-ascii?q?ywiV4FlCYEaLgGFbIJjAYYnhDwnD4FVRIEVJwuCeD6EQ4NbgmmCM4RDZ4lOi?=
 =?us-ascii?q?FSHVJBjUnscA1ksAVUTFwsHBYEpQwMqNDEjgSIFNDQOOCmBY2lJOgINAjWCG?=
 =?us-ascii?q?yRYgihqBAWBJII2hD6EQIVQghGBXAMDFg8BgjBvdRyDFjV1PYRjLVCCRR1AA?=
 =?us-ascii?q?gELbT03CQsbBj2kCoU+E4JLxkA0B4I4gWaBYwyfXgYTL4NwAZNVDgaSfS6YU?=
 =?us-ascii?q?CKpEYFuDCeBXDMaJIM2TwMZD44hGYQUuwtCNTwCBwsBAQMJhUYBAYpUgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:j1MN2q+c5ioHDK/pIm9uk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:hul/6WECwlFKxn3eqmJ36HEONJA8VEfk4yqAO3adNTxiYrqaHAo=
X-Talos-MUID: 9a23:uo3O9ArI6ugl4oA6uywezypgMP9swJ6MMW4Io84XicaDFDwoNR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214142272"
X-MGA-submission: =?us-ascii?q?MDFsIf6oRew0Nqf8HOPTq3OgdKy7N5SUcMoxll?=
 =?us-ascii?q?wStEtef8T+750qE5tz9rwfLr+Qr9/Z9AEshdmHpuEwagf+6TnNr2/YbK?=
 =?us-ascii?q?Wk28nRPslVPXe1FgdJK6+NoUTatYs85eWAop2o1/sc8b/NgIFK8yj0Wv?=
 =?us-ascii?q?FtnBvWvU2F/gBv8O3/gTSZLA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:52:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742565136; x=1743169936; i=markus.elfring@web.de;
	bh=vJYWovga3sCCg7yjjpD+8W8WhUQnLQkACj7yw6V3FtQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UsmaZ2uFdu16dOLlHwXgtC6CvSBswFsk0DlvvEb78EXaOdWJvGqf7Q9yotPxWfC/
	 vG+V7PXLhDNfgDl6RV+2e6nODT4FcBqbEfzLivqWXLH3HZ5Yet8GA7bvMAEg3T4xK
	 361izk4/I2AiUBa/UY0j45EI9tusPTxvOjqh7084RUviAksljoMMf9Rn56CS7Uf+n
	 LJBKeCS9xRpF+a5VB/6EUNgm1pCCjDhLHAdCjtg1f7hFYro/IiSEIR7MCZHziKLTA
	 YfDdGc600nONPDq7MStN7KO5ggFuJe7m+gHa5XWpgaCbGb+9tdCKR5t7jVF3AGqTx
	 pzHC6W/cC7rGjX1HRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1tV3Q128R7-00i9un; Fri, 21
 Mar 2025 14:52:16 +0100
Message-ID: <b9d7b554-f17c-4813-9b3d-546e2e5711fd@web.de>
Date: Fri, 21 Mar 2025 14:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr
References: <202503180924.2135CF8FD@keescook>
 <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
 <202503182023.D7C4D91@keescook> <8714afb-4938-9beb-9f0-4a4972f4b81@inria.fr>
 <202503191424.2FA8A7E@keescook>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202503191424.2FA8A7E@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SePpeWx08h6yO/dRyn2ajFiGpQjivGOorExd3cD0eM7+pgTQ4rZ
 CcuGNk41NuLfGff+Q1DO0V2vGVaolYDAGOh76D+AOZpOCjAFjccdsjqCRCTXnf2lvPNCW/6
 sMnCY7QJ4DJHBO/i5uTTCKR4EKVu1s2ouSVnBMjHPTqabGu7zXw1wiHIKwW745HBjWuuTJn
 GwXfEYEjC1U/524dbwBig==
UI-OutboundReport: notjunk:1;M01:P0:7CqmXf7LcVo=;wLkiId2fP7RDcUj2O24ddlR7Lyt
 zxJ+RBw5hKcEEV2yJMec7YEPRGVHbifxx0wT13Zw0YJWPCsqSXcVb+jkZ9dtMCaoyudRLNUSV
 //ogLqc5T0QnQ1PeMgqr/XcswKYIff6OxcZrkLekkLw0Tyi1jCMMr5MpTK5toLNC3gpcXfXA/
 F3ZqFKJoUkzYhRxL2vSSlD20UvTbu1fGN6gAjD8U8pxIXEINHe1s/BlMQTNdX3QgiagJmn/Wr
 nO1ZTB++hOupQc9cpQhKaE655H4TXaL9T9xneT10DU3BzSf9ndOmwhF7Ww+UaiHlsqYnNqqFm
 w3LKoC8AZck0CyecKvNszfdNvAD0MSdR+HLAx2pxaC+0zz+AIrD3Vd/6q+3E0yiOWdYQDiscg
 wkXpG/jzl6U6mvRVl+ARqSW7DUXEFDL79Qc1I65B54Dm7tu8VUqVvhQ1AYnAAaU8E89VMBv9e
 VkjHhNTJ56Zyvyut8XZUUoNjbSp8c1O4vXm0Dy0FTAEnQbSqbfLkr3xekx0Ir/THqwr/mOYdW
 REeNzEEUSvK4dJyCnLG7uxKpSNBG5v+OUNz18XebOjPPyW9RoiU6vdvr/SIZj4I406BLrZZDL
 k1kdiaS0R9bJqo4oPP+FfFKIEvgZCiAPzWbXQWS6wJipjqEcS5/wRjqaatTwxy4bi6llmH3TP
 x0VbH3FApjHQHFNvmJiXnEpTDVUTbbQwutJOBVy9EIX210SAmODy0maLHEWmihBbA0pkDDtZs
 Rh73jbYT/7w5LnumyEPvwjp7iWypRd35HaWXgjVJ84yM2tnDSpGC8MkRNt+VVe15yh+byZUyG
 UlQejbNlwvjQpgiAFclhtb1iS58v1nEaJMD0tf02UdyqEtT89D0ug+nvw91Nc8pDDfYzAZe7L
 4nGVnz8HZxB+AYlkUmXDSWtRWa/eXUNZfM6HVry5NPKSeh4DVOyG5osZj/iskMFEbw306EunH
 vvnYOQuuaCARWkTT+KrXRxTiMS3GhY8rXYF3+YFQLYHTW3RzYmd1hVP9rZLyEuSxeNJvU7IpE
 wYNeMPw30GpYSF4AeAW+9Ai57NpQzykIVaK1fbfCjdUBGkbLoBumCSP/pNvm5pxjqvjcGbw1O
 KUxEtAaEO0XXy2JBkgc3PxYll/XWGJuUxH/giNsoLU6Hy5W8Y5ffOEoaQObsyTFQ5eRQWiIbq
 xGnf37FIYb4rtRuMIEqCfrXvqXYhdmZ9+x+uCqC86x9rU8/1CudzmkGIc+rprmZ/eOcbgNQE2
 H5YQ6xnHhEY0qPYvUU0DRl5E9W9gn8JEnsQTmnqiaLs41yVXDHexBuETLAUmNe2OBxzdn3EH+
 o+iaIqPh01TLbj5lJ3wye7Hxk8d+gK30Sn+Za9Sl7P3x+oWx4Lb+jMTFKYrpqCuMYepaniHVE
 U0Z7ryQsnpRqvGmDtYCF0IfBxivcYVE2jaVj+jf9OdZNuZGUNvOEk5iNGZgx2rYmETrfH171x
 Qo0OIQFWpG+pnV9Mkc7LX+oWgJd+7Elno65btYm3s3n+1tyNF
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2671
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/b9d7b554-f17c-4813-9b3d-546e2e5711fd%40web.de>

> minus: parse error:
>   File "scripts/coccinelle/api/kmalloc_objs.cocci", line 55, column 34, =
charpos =3D 1235
>   around =3D 'TYPE',
>   whole content =3D -     =3D ALLOC((sizeof(\(\(*PTR\|INST\|TYPE\) \& TY=
PED\))), GFP);
>
> How do I collapse these three into 1 rule?

It seems that some software development constraints hinder to apply SmPL c=
ode
in more succinct ways so far.

Regards,
Markus
