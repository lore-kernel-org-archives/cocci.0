Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F104AC27C55
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2024 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Mwfleuz/kb7Oh1JTpmyhQay7cXMamxZ764v4CytyrDE=;
  b=T8/mak6RPxxp3j9sfWM5Mfl/Pe9ygVf61f7FfAqPttYtRQbdCwrVVkNH
   Ig50oAanCV1vRgXAthsH3LUOgqlo7lUFxqidKZliQwFnZabY3CzCh4r5o
   6wrr5/qkjObxWqw51GEc4DyuqNBcteCI39xQBRnd/rWz474q2TWYwoZr5
   g=;
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
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="169505209"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2024 11:21:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 23A79E0133; Fri,  7 Jun 2024 11:21:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 94139E0035
	for <cocci@sympa.inria.fr>; Fri,  7 Jun 2024 11:21:11 +0200 (CEST)
IronPort-SDR: 6662d107_3PeUJTtbdk0gB90CTg/J0cpIvL3kbzDmePoAHgrUpN00jq6
 c+sg4X6TLuxwXEEMESyOtsCt6f6hcc7zMc9u9xg==
X-IPAS-Result: =?us-ascii?q?A0GRBAB30GJmhw4P49RagQmBT4JEgQJUMwQLSIRWj0iBd?=
 =?us-ascii?q?TCEO4c5h1CIcYFWgUA+DwEDAQ1BAQIEAQEDBIR/AohjAh4HAQQyBw4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4V0DYJnARCBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEBAQIBIx0BAREnBAsLGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfIIwAQMOIwexBoEygQGCDAEBBtpZHywiV4FjCYEaLogxAYV8hEAnD?=
 =?us-ascii?q?4FVRIE8gwM+hEODW4JpllCDE4ImiXgmC4pLVH0cA1khEwFVExcLPgkWAhYDG?=
 =?us-ascii?q?xQEMA8JCyYqBjkCEgwGBgZZNAkEIwMIBANCAyBxEQMEGgQLB3WBcYE0BBNEA?=
 =?us-ascii?q?4E3BolrDIMHAgUhgXQpgSSCdwhDbBWBCQKCZYFrDGGIEWOBEIFBgWYBT4Ehg?=
 =?us-ascii?q?W1ZJWUdQAIBC209NQYDCxsGPbARxUc0B4I2gWCBYgyfSAYTL4Nyk0gOBpJrm?=
 =?us-ascii?q?GUgqGqBbAMwgVwzGiSDNk8DGQ+OOoQUyklBNTsCBwEKAQEDCYVGAQGDWoFIA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 sfCnuT/JWUamzo11c4bGtSSN8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:6eGByqqV5pq0UeXD8O3l9SkaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:vHFX82BzbqWYHJL6Ezdt5hYtPtIATmDAi2nLExCTVHdzWLLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Ay9dUTg11h7SV8ibBsnijM7GyqjUjs6WFGHE/tsk?=
 =?us-ascii?q?8te7eEQ5+PCy2s2zuXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="169505197"
X-MGA-submission: =?us-ascii?q?MDFPukxSpZpteMtkxBf4HqjKeF4+0ao8J2iOVe?=
 =?us-ascii?q?fYDvTCkXAtzLRFKNUVFtQhINJrxL7yQzQuZkZpaPdU/Hmu6cu4EbGM20?=
 =?us-ascii?q?m8U2aLmp+4o7ImYbDNJlhe2shOvNTxLauxlavUTNQCUNeRRzdKree0O+?=
 =?us-ascii?q?AInlMYq0XgmeCNbgMISwBixA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 11:21:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717752070; x=1718356870; i=markus.elfring@web.de;
	bh=Mwfleuz/kb7Oh1JTpmyhQay7cXMamxZ764v4CytyrDE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fha1FZw3d59YRWcGxpHhq9KAOfgJDcTB69XnPrUnXiisMgiOu0bplMHY9P1P6j8N
	 /Q0Ks8Y7kOSkWDXhpn5mkjKjbbbxTQyU47+XzWiG7BFiKFphY+P6ByNWCWbWFqR9P
	 MgGR/xZI7FhOkh6kFLpXWgs8vWlQ7gYfcC1h842ycURQJOXxFndw87WXzLDQwQrBf
	 7dt4e0QjSWCXxeBTtl0KaGN0PNimKqNInsAw96YYKfmG8DkeCCgMGvZu7R96keW7M
	 Fbr10FZ5JCXncstau+SMoZ9pc9Dx8HiVvX1OroD/VUXaSkqNpogjzDDsrlmglWYTo
	 +Uo1xmBdHxTUby3eJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3ox-1sBxYX1QWN-007oby; Fri, 07
 Jun 2024 11:21:10 +0200
Message-ID: <9d79a2de-10fa-479c-b720-1c4a2f51782d@web.de>
Date: Fri, 7 Jun 2024 11:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3n85O9CNk4ZNZ6s0Cfl5GYa8CQy//4pHgz/p9dphUhjH6+RWJvp
 QDPNSFcQ5rv0RADvsWRni4zMW3G7aYTw+rl/9ZS6HTuhruQwED8oYJFMBObZxoSkFbkkAUB
 283dL0IprnuJP1Z9DsPgq3RU0JqroePsGc7gTs4hqcxQA/bfwDvcYkyptgmSjr0n7X2L/4G
 w1hP11XM/luVQkJ82AYtQ==
UI-OutboundReport: notjunk:1;M01:P0:61oZFAYcRTE=;sJwqrjssad/HZTlc3gEi6vmN1k8
 z4sjn8IZOYiucpput0iRml0QyF5nnTpb7xeIQUoCreszfpCgDrX+rCpOuTb3A0cBJ+Icu/yN1
 mTAxNYrFAJboUDEua9nphrbrBmxLvZ0zYw+OQ/2ZnnN90o2Pe7gmXmHNxhAQ+gyZqSiIMuKGP
 M/fNgCGPfA5fofwftoqP1tSDA+rHGdEijxomiqNqm2zbSN3waqRgs7ZRxy51GMcFuAiOP8vxx
 j5eS+p3M0lwRZVbzyy4Y0xRC8AwrhQIL4z90z13edzYMk8lGpgHiWB2F4RMDgLjaC/nd8jrtc
 GMWwagQSGxeZbnryIPTBnjWiAtw7TE363/WtH0xzEUhgvs9C6alqhMUNHmRRE4wJDJpNG0chX
 HyTrspjKqMX0OEGeIuV4Say/MFiXYPILDbFYzKCSddKYcsjwutCqMZsKVAHIhlcLh8Ilo8Ym1
 r1Zo3kUNkDhwsl+l9t3mJf0b35lMOX1XsqlNrzAHStnSm+tHmNZKXZ6rYCY0LFBx4Yh6Q2xAg
 05qcCZKCTr/pwF65Rn7b8v5jg1GXCZ6JMRvnaPtH//u9Fr+w6RvMYaIvbwc4lXxUZe6ukc3c2
 SjkzNVzpEH+NXzGVAT07Se2W+KIbi23DRq6cNQFWpLaWDuvM+ZlKpjFP5fJV8WXJ0nubYb201
 Z0n7AiGksGefXZPY3djDxszEhN0WxgWCWcS8PcLiBqKXAU2lCz6wy94xBsmr5Se2UqUiKoWEY
 mxz4GwANflyazkaC0vezlSlxxL1U9+EZ2DGT3HnH0vcgqEVBwNkgu7gryLMoxZKfcVuytUeMt
 efz0GXCPvI2rNh3Wj/pyKRFeoXlOdKnuU61+9R4nIwc08=
Subject: Re: [cocci] Increasing usage of spinlock guards (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1778
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/9d79a2de-10fa-479c-b720-1c4a2f51782d%40web.de>

> I'm not the one to decide whether we should use cleanup for mutex locks.

Would you become interested to support the conversion of another tiny scri=
pt
(like the following) for the semantic patch language into a corresponding
SmPL script variant which can be used together with the tool =E2=80=9Ccocc=
icheck=E2=80=9D
any more?

@replacement@
expression e;
@@
-raw_spin_lock
+guard(raw_spinlock_irq)
              (&e);
 ... when !=3D e
     when any
-raw_spin_unlock(&e);


Regards,
Markus
