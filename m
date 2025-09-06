Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DABCCA1002
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hLzGmR2vM2ayNnm2zi0kw6hlIRt4BLIMpI972KHGRn0=;
  b=n7i6XdQLswt6X1sv/Pl5v8rXu3uFy1/Tax2BJCqGdAtFrtcnpBtZXjsU
   kZaQw9bp+xSgbXA2JiP9QeKUEK/sMn8oy10e4lzVWv4iLNyLP+G5lxGI5
   sD52vVrW15I80vSAHMcihabXFQHTm99UsAXKd4w3ClKTSuczFr1BQ3VsE
   Y=;
X-CSE-ConnectionGUID: V4guVqnURZimN73f+LYiPg==
X-CSE-MsgGUID: XKJIZmiOTPmyGLEpmT7pXw==
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
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237803812"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 10:01:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9650FE0172; Sat,  6 Sep 2025 10:01:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F162EE0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 10:01:02 +0200 (CEST)
X-CSE-ConnectionGUID: r/leQsSpSk2EktKsqqeOQw==
X-CSE-MsgGUID: URaAu4cbSZSX27n2r1ozlg==
IronPort-SDR: 68bbea3e_wRAOjOShl3Fl8ZOVBwm4apyjOz12CZZqEAZnCUTnIM2Nor/
 rD/HMa2MUsrSnWaH72qWgpvbf2GwvTLzOwL+iLQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G+AAAi6btogwsR49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YI/gQdUMwQLSYRViByHNIZfhzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIIMgnQCj?=
 =?us-ascii?q?CkCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBOgcOCjGGTw2CW4EsgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEAgEDIx0BA?=
 =?us-ascii?q?REnDwsaAiYCAlYbAQGCfoIjAQYQAQM1B7FIgTKBAYIMAQEGgmnXdh8sIlmBZ?=
 =?us-ascii?q?AmBGy4BhWuCZAGKYycPgVVEgTwLgng+hENNgw6CaYImgRaDWIxZgneIRVJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIEMDgQ8jSwUtHYEneYMHgQ2EHitPghpygXQ+GUCDUx4Ga?=
 =?us-ascii?q?w8GgRUZSQICAgUCQz6BbSIGHxICAwECAjpXEIF9AgIES0ACAQttPTcJCxsGP?=
 =?us-ascii?q?ZVzgj1zg2rGSTQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBqlBgWg6gVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIRmEGro5QTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:dPwIyq+tBdtC9i/bpetuk+AGI+orL9Y04lQ7vn2ZOiYlFvBw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhP1ICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtsJ
 uIGJIfNDSfNykZse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AIrNMtGkBP7wGybh+xA98MC3wktzXOWeayHrpOHS?=
 =?us-ascii?q?gMmUzZb6JakSJ4a5DqtU7zg=3D=3D?=
X-Talos-MUID: 9a23:8H04jgRHVtaFUAlQRXTRvjhLKZtj6Z+cM3BXzpNcoZCDJyh/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237803807"
X-MGA-submission: =?us-ascii?q?MDFDubswTIcA4aQEKGvFsuz/9FdudEWy+QOQeM?=
 =?us-ascii?q?osTqvQcJ13Reid4CqQ3EhFB9MY8vtFSUYA+pC4Sp+2rBUuiKdY9k9bm9?=
 =?us-ascii?q?xAG2/wao262yeCMmzJm1mlYJuK78lezr0ByyEI8ri2qCarf/73jJ470y?=
 =?us-ascii?q?qes2S5UW3y++oUoqJwJ5sCTg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 10:01:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757145661; x=1757750461; i=markus.elfring@web.de;
	bh=hLzGmR2vM2ayNnm2zi0kw6hlIRt4BLIMpI972KHGRn0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oYv7VmLGtRYpFte99I5AwO9r49d9uKm9uSaAW2JYnNbHQ+xrq1X9eyondkLJGJNN
	 nMf5yg9OHlc7Y1z1C3tTsVaYVyINGPIaClJh4buSBbxBiwp9oRoROHepH0TRmBsZ3
	 /qnOPTDpb+QkAi7XXwEy43yL+3nazUh+rDPbuu2h+eCF1vftFsAKWznrVgZqgWj01
	 8kmTjKTXl+xd1ZgzUHuzquEwGfbD8V8RsTFbk6zYWjtAFK7aq6iZ8opCfacvnIy5k
	 JE23q3fTmpuqMx5Tk557T9XKZBDgj3ysQMcPKMr0k8hChAF2602kv9AmQzM9DHTwD
	 lfjQ5o9ZxvYzxRuPZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFs1t-1ufekc13DL-00Fkh9 for
 <cocci@inria.fr>; Sat, 06 Sep 2025 10:01:01 +0200
Message-ID: <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
Date: Sat, 6 Sep 2025 10:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eEJOsdbBrVayIRplnJ11z0+TlDb/UmpUgqptzSz+Ilp3J+mFANL
 XWE+HdmbpP8SdMgQays9NfqMAHgmyCBlJcjgQNP9Xz5/9nG2ohmt3vJpvgyXSRbUzfwHPk/
 WXC8LrgZxM84/VwIZeJuT+vtkuvYjCiqNE9KvReNVaIWAUxZwdezikBJ5hM+hCsYwOgUKZJ
 nvwhc4oEAfeM+7uGsuoJw==
UI-OutboundReport: notjunk:1;M01:P0:ZLJhWW/RyF0=;9DmdYThDcFzokher9GempF6CRqi
 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
 wVlPx+aQp51OYfK1dIllp1G82lIV
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2996
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/f798ce14-0401-4116-bbee-2b78ad0f774b%40web.de>

> @display@
> expression e;
> statement s;
> struct device_node * dn;
> @@
> *dn =3D e(...);
>  if (!dn)
>     s
>  ... when !=3D dn
>=20
>=20
> It can be determined then that the software =E2=80=9CLinux next-20250904=
=E2=80=9D contains
> 80 variable assignments where the object address might not be used any m=
ore
> after a null pointer check.
>=20
> * Would you be looking for corresponding improvements of such a source c=
ode
>   search approach?

Such an SmPL script can become another bit more generic.
How can be achieved that the search for variable assignments will be repea=
ted
after such a statement was found?

Regards,
Markus
