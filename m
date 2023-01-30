Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C963CC54EAA
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Oclg9zg430GavmhCm1MgADPl/BR8nrtJSwOxKKO5uA4=;
  b=aC2B7mrgV91vboU3kPJUbxhYGdpicOMUfrfPZuHr/0t/TZ3cnMm5+9ZR
   yzbU9ALXIzZOTe9SA2rgJm+yl0Cvk/7XGp+JtaUZ+szcJlJTdoeCiXI70
   knvGyn5L3OBsqSHj4QdP6WVFlsUoiJNETPGznaBHI9YeGsLW7aBhm8jDx
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="89979621"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 08:59:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CBAB3E743F; Mon, 30 Jan 2023 08:59:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CB63E743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 07:32:40 +0100 (CET)
IronPort-SDR: 63d76487_leLZJ1JvRzIz75ad9R2Bsw7zHodvNKr2bCaqQvJAgCTRu5d
 MScL+/eE73ETCDLnZonBBw7YCdSd5n2x9nqtwsQ==
X-IPAS-Result: =?us-ascii?q?A0HfAQAOY9djjEYpCbBaHgEBCxIMQIFEC4ItgV4rAwQLh?=
 =?us-ascii?q?RSIfogkEZ0sgX4PAQMBDUQEAQGFBwKFJh4GBjAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEAQECEAEBAQFARYV1gjcpAYN/AQIDI1YQCQIYAgImA?=
 =?us-ascii?q?gJXBoMRgyMHAY0OnBeBMoEBhHOaZoFngRQsiRGIFUOCDYEVgyo+hESDWIJnB?=
 =?us-ascii?q?IEIklKICgqBOXWBJQ6BRoEPAgkCEUgsQDcDGSsdQAMLOzIKPzULC0oQGxobB?=
 =?us-ascii?q?4EGKigVAwQEAwIGEwMiAg0oMRQEKRMNJyZpCQIDImIDAwQoLQkgHwcVESQ8B?=
 =?us-ascii?q?1Y3AQUCDx83BgMJAwIfT3IuERMFAwsVKkcECDYFBhs2EgIIDxIPBiZDDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBTQQvgWIGKSafMYEWgXAaXjrCeIN/gVKfGDKBRKdrl0+oE?=
 =?us-ascii?q?4FiOoFcMxoIMIMjTgMZD445lik/bwIHAQoBAQMJjCMBAQ?=
IronPort-PHdr: A9a23:KCRjsB+A1shXf/9uWXS3ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Y
 QqGvqwm3QKBdL6YwswHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yeC/94fObwhGmTaxbrd/I
 RWrpgjNq8cahpdvJak2xhbVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3U
 bJXAjImM3so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RTKv5
 LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWGFPXNteVzZZD42/b
 4UBEfQMM+haoInzu1QAohWxCgaxCu701j9In2X70bEm3+k7EwzL2hErEdIUsHTTqdX4LKEcU
 f2pw6bS0D7OcfRW1in56IjIdRAqvPaBXbZtccXN00YiDB/KjlKOpozhPzOV0f4Bs2aa7+d5U
 ++klmEopR1rrDe12scslpfGhpgTyl3c+yh0w5g5KN22RUNmYdCpE4Zcuj+aOYV4XM4vR31kt
 SckxrAIt5C2ficHxYokyhLBafGKd4eG7w/hWeuNLzl1hnRoc6+8iRaq6UWs1+/xW8iu3FtOt
 CZIncTAumoP2hDP8sSKTuZx8l281TuP1w3f8P9ILEA0mKbBKpMt3rg9nYcJv0vZBC/5gkD2g
 beWdko6/uio7PzqYrv8qZ+GMo90igb+Mrk1msOhG+g3Lg8OUHaf+eS8073v50P5QLRSgv03l
 KnWrozaKNwGqqO7AgJZyIIu5wywAju7ytgVn2ULIEpAeB2djojpP1/OIOr/Dfe6m1mslCpry
 OzcMbD6HprNKWbMkLPhfbZ68UJcxgszwchZ551PEr4BOu78WlfttNzECR80KxK4z/79CNphz
 oMeRX6PAqiBPaPWq1CJ6PggI+2IZIIOuTf9Kv0l6OX0jXAjg1MdfK+p3YEWaH+iBPhmLV+Zb
 WL2gtgdCWcKohY+TOvyhVKeVj5ce2q9X6Mn6zEgCIOmCJ/DSZq3jLyA2ie7BJxWaXpcBlCCC
 3e7P7mDDtURbCObautojTUAUfD1SZIl1BjosAblwr5jBuvS4CwR85z5gotb/erWwDUv/jU8J
 MOQ12GKBzVwg2gBbzQx0aR/pgpzywHQguBDn/VEGIkLtLtyWQAgOMuZlrQiYziTcgfIf9PSD
 U2jXs3jGjYpCNQ4394JZU95XdSklBHKmSSwUPcOj7LeIpsy/+rH2mTpYd5nwiPCyaIop1IhT
 89PMiuoh/037BDdUqjOlUjRjKO2beIZ1S/J+n2EyD+KoUpReAV3XKHFWjYRZxietsz3s2XFS
 bLmErE7Kk1BxMqFf7NNccHshE5aSe3LNt3EZmK2hny9Qx2Py7eMa8zkeg3xxQ37D04J20AW9
 HeCbk0lAzu55nnZFHpoHE7uZEXl9a9/rmm6Rwk61VPCaUopzLez9hMP4J7UA/oOwrIJvjsgo
 DRoDR682dzREd+Juwtmeu1Vf9o85F5N0W+RuRZ6O9SsKKVrh1hWdAoS3Qum0wh8A61LlsUur
 HRswgszYaOU3VVddi+JiIjqM+6fIW3z8RazLq/OjwiBjpDHvPtWrqtg+DCB9EmzG0Ev8mtqy
 YxQ2nqYvdDRCRYKFIn2SgAx/gR7oLfTZm884ZnV3DtiK/rR0HeK1tQ3Ce8i0hvlcc1YNfbOE
 BL5GuURAMWqKOtslVnjPVoUeftf8qI5JZbsc+aN0YagO+tknDXgg2UNs+UfmgqcsiF7TODPx
 ZMMxfqVixCGWznLh1CkqsnrmIpAaFn+B0KZzi7pTM5Ub6x2JsMQDHu2Ztaw3pN4joLsXHhR8
 BiiAUkH0YmnY0jaaVu1xgBW2UkNxB7v0SKl0zx5lS0opauDzWTPxerlbh8OJm9MQiFrk17tJ
 YG+i91SUlKvakAlkx6s5ECywKY+xuw3K3TYSG9DeCXyL2YkXKrx/ruObshT6Y855CBeUeCye
 1efGfb2pxoX1T+mHnMLnW9lMWDs5sy/wEQp7QDVZGx+p3fYZ8xqkBLW5diHAOVUwiJDXy5gz
 z/eGlm7OdCtu9SSjZbK9O6kBAfDHtVedzfmyYSYuW61/2pvVFe7gvu6stbgHAw61mn11pM5H
 TWNtxv6boTxgu6+LOluVkJvCVv87Ix0G8st9+l4zIFV0n8ciJKP+HMBmmqmKtRX15X1a38VT
 CIKydrYiOT88GtkKH/Bh4fwV3HGh9Bke8H/eWQOnCQ088FNDq6Qqr1Chyp85FSi/0rXZrBmk
 zERxOFLijZSivwVuAcr0iSWA6wDVUheMyv2kh2U7te45KxJbWereLK02QJwh9ekRL2FpwhdX
 j7+dPJAVWdo6d5jNVvXzHDpwo/tYtzQas8Iu1uflBrEj+8TJpNw3vsGiCx7OH7s6H0oz+lo6
 H4mlZq+vYWBNyBs5PfgXUAeZ3upPoVMomKI7+4WhMud0oGxE480HzwKWMCtVve0CHcJsuyhM
 Q+SETo6o3PdGLzFHAbZ5l01yhCHW52tKXyTI2EUiNt4QxzIbkhCiwk8VzI3mp4+UA6rjp+EE
 g8x9nUK61j0pwEZgPpvLAX6W3zDqR2AZD4uTZiYMQFbqApF6kPVNoqQ76ggekMQto3kpwuLJ
 GuBYg1OBmxcQU2ICWfoOby27MXB+eyVbgJRB/DJbLGOrqpQVqXQrXpK+oBh8jKMMYOBPys6Z
 xXa8kRKR3V5HNnClnMETCETlyWLYc/J/H+B
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zLCav6x52QeG7vNdkDKJKrPwEL1zdoMgy1knxilNoG9uA6ulfq
 GV7ZEmPHDP6Ar5NEtOpTniAtjjfZq/z+8X3WB5B97LN2SLhILCFuBfBP7Zslvd8kPFmNJ15O
 NJd6BgCMe1KV52jcn77ATQKbwdKaG8gcSVuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="46309108"
X-MGA-submission: =?us-ascii?q?MDE6jhMbsTbOb2DVYd9ZeB68mr/xsel0qAkj1S?=
 =?us-ascii?q?g7hYR7kvVvrmKflVBxIrFg5AAquBBMdeg29bmAMVflnAoxKD0A5yn56d?=
 =?us-ascii?q?Vvx/4ckH5NqtIR1CUwanQu/RC4Ino9/XfHsS85MAdtlqVe9+7RQiMhkz?=
 =?us-ascii?q?rvskO3E4KuAMTYXumBG2npZg=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 07:32:39 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMNiW-00602U-E7;
	Mon, 30 Jan 2023 08:32:38 +0200
Message-ID: <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Date: Mon, 30 Jan 2023 08:32:35 +0200
In-Reply-To: <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	  <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
	  <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
	  <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
	 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 842
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/3f376cb31e9050d005417809a9fa51d92cdc57d6.camel%40coelho.fi>

On Sun, 2023-01-29 at 21:09 +0100, Julia Lawall wrote:
> On Sun, 29 Jan 2023, Luca Coelho wrote:
> > On Sun, 2023-01-29 at 19:55 +0200, Luca Coelho wrote:
> > > On Sun, 2023-01-29 at 18:28 +0100, Julia Lawall wrote:
> > > >=20
> > > > What version of Coccinelle do you have?  Someone (Kees?) reported a
> > > > problem with the collecion of header files at one point fairly
> > > > recently, and I think I fixed it.  It should be available in the
> > > > github version of Coccinelle.
> > >=20
> > > This is what I have:
> > >=20
> > > luca@kveik:~/gfx/linux-drm-tip$ spatch --version
> > > spatch version 1.1.1 compiled with OCaml version 4.13.1
> > > Flags passed to the configure script: --prefix=3D/usr --sysconfdir=3D=
/etc --libdir=3D/usr/lib --enable-ocaml --enable-python --with-python=3Dpyt=
hon3 --enable-opt
> > > OCaml scripting support: yes
> > > Python scripting support: yes
> > > Syntax of regular expressions: PCRE
> > >=20
> > > It's the standard one from Debian testing.
> > >=20
> > > I'll try the github version.  Thanks for pointing out!
> >=20
> > It seems to be working slightly better, but it's still not finding all
> > the occurrences that I find by calling spatch with all the files
> > individually... :( I tried the latest head from github,
> > 87350d742df39d847b15af39865329c2fe23460d.
>=20
> Could you give a specific case that idn't found?

Sorry, false alarm.  I was running spatch by itself on an inner
directory (.../i915/display), but when I used find, I was using
.../i915, so there was one more match happening there.

So, it seems that the latest head _does_ work fine! And I'm gettign all
the matches and changes that I expect.  Thanks!

I really appreciate your promptness in responding and helping with all
this.  I will probably come back with more questions soon, when I start
trying other rules. =F0=9F=99=82

--
Cheers,
Luca.
