Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2E1C0219E
	for <cocci@archiver.kernel.org>; Mon, 17 Feb 2025 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iWMaV0pVZkMOHdSjixXd5jEGM6hTWZOrQPgbdV7xusU=;
  b=CJBRKnjahSvwKkeqxbaiiwJGAbJG0AkvebdIdASdnLjRq8bOonYJBzEz
   qDKjB1bHt9VKb7qzMVQVyQjdeAsPzQf3nXkSEMwyp8LMH+0GpXBClbCYW
   TLpcTeJjcK+1flAE1YDWTCFmxTn5D/qqEoCel207iNUQM9+eNpZZmXZAB
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,292,1732575600"; 
   d="scan'208";a="208605809"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Feb 2025 12:28:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9315CE0D1E; Mon, 17 Feb 2025 12:28:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A2BA7E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Feb 2025 12:28:26 +0100 (CET)
IronPort-SDR: 67b31d59_8cbZoVj5ngTiFrupjifXj8oOQ8hZyHrux01p9+hwpoe0ITs
 LxVhprb06MvSFT5n9u/SrTX5nJH38aLg1nWfAMg==
X-IPAS-Result: =?us-ascii?q?A0HoCwAKHLNnfg4P49RaHgEBCxIMQIFIC4JEfVozBAtIh?=
 =?us-ascii?q?FaPT4F0LQOEO48OiHWBVoF+DwEDAQ05CAECBAEBAwSCDIIuRgKLCwIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgkBMYV7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAEBAQIBIx0BAREmAQQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn4Bgi8BAw4jBw2ufIEygQGCDAEBBtpcHywiV4FlAwaBG?=
 =?us-ascii?q?i6FbIJjAYYmhDwnD4FVRIE8glIxPoJhAoFgg1uCaYIzhEdniWeBGodQh3yLA?=
 =?us-ascii?q?1J7HANZLAFVExcLBwWBKUgDKjQxIw+BFAU0QTqCDWlJOgINAjWCHiRYgitqB?=
 =?us-ascii?q?AWBLYI6hEOES4VYghKBXQMDIgGCMXB4HINWgTmBGx1AAgELbT03CQsbBj2fc?=
 =?us-ascii?q?D2EJIECGwwYIAJvNFqTLYM8r1A0B4I4gWaBYwyKKZU0BhMvl0MOBpJ7mH0ij?=
 =?us-ascii?q?WKbKoFnOoFcMxokgzZPAxkPjiGDejPGCkI1PAIHAQoBAQMJhUYBAYpwgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xVuoAK2eBy/ALdTJkgjUTQqjBQJyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ/uxoS5PwJ080lKQFlrX5Uo3SOTUO1FHHEGgA1/qV/9SDIVybygc178
 4JH8dD4bbLbWSS+PyKgjVQZOxQo+VvnprIuc7ui1NWCS16YaBp6Al0TiyBFFdteQVADZ0lUL
 KB+8tuvVObCDwqR/X+IkNAc/nIptXNmp6jSwUBHQQb5A6Hii7twKLmEiKfwgwVX1p0sPwfGC
 n+4kbED5eYwr2GIyznpiDuBlNt6ZXcI+54dYGxYw4uW3TRY0iTFcRcsva5zUkISamUmS4XeZ
 /30l4d1o1ImgnsV3Dwrh331wb61jEyr3fk1F+DmHPm5df0XTQgFqN69PBkmzbimjodVetHod
 F29nPcs4ASAQLLnSz76dSNXxZ2llCsqX5nleIIlXRQXYYXdbcU9OUkjTdoOYZFGDi/5JEsEe
 FoAs2Z7PFKcUmCZ3ScumV02tSjUnk6Ax/DSEkfvc6e1SRQgRlCvj4l7d1amm1F+IM2SpFC6e
 iBOqN0lKtWRstTdq55DPdpe7rHNkXdBRbXdG6CK1XuE68Kf3jErpLx7b0voPunY5wF1t8zn4
 7dWFRTuSozdivVeLCzNV1wg27wqUmGLEvQI5tlluNEU5XHNcbWDRE=
X-Talos-CUID: =?us-ascii?q?9a23=3A9j0/rWrhdjmLmaUGDQoJ+UnmUZAqdz7b9lPgGBC?=
 =?us-ascii?q?1EXZEbaK6eUaR4Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:aVi5iASGUbF27hBKRXTgvytiDfpm7523Jx8fuJA7gMmKJTdJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,292,1732575600"; 
   d="scan'208";a="109301434"
X-MGA-submission: =?us-ascii?q?MDHZe9PiIVi1e2vmTlbi9ShJyPthQwpIt7phiq?=
 =?us-ascii?q?mAayFK/GkyIRraVVvbYsXO5/+OvjTM5rcoIqML2kZAUA8SaDZ6UkVFwp?=
 =?us-ascii?q?whpLMEdE+m4FfMjQlm5CcO/iyK+BO1KD3v10SnOE+f8w676cQ914Ihh1?=
 =?us-ascii?q?a27e8wUAZ7L+QAo9MOQgLHbQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 12:28:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739791704; x=1740396504; i=markus.elfring@web.de;
	bh=iWMaV0pVZkMOHdSjixXd5jEGM6hTWZOrQPgbdV7xusU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wm+rTiQrjzsKwFOFjXVadgAyk/v7swhEmtrUBeuN8s3aA0P13ZBUJUgabWXvDnZU
	 BagAWS4EobGkJd+6wvd2ABP3mE2YxS0KPwHY/N/YXVdkb1aGST36/ST7HxqyQqveL
	 OBNvyTsK3I6y15c7YW2rGkEH+pyJZCYK7YU61hDusrjazB2snMAq4c/l+gUtn2qGW
	 R+H5pyZD9TQ5YLBG/NgphbUPDLmmPD/Wui5kCsdQtzYiC5i69US/ek1i/2RwhaTd9
	 pvS1lf2f2470SKdHAESjV+Owc0fJdEQgtEp1zB1UWUTfKxLLYfwTqM6QzyVZcBeEk
	 AF0GaAE2tb8ZYrXeaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.56]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxpiU-1tQuwQ0NZ8-00tFjR; Mon, 17
 Feb 2025 12:28:24 +0100
Message-ID: <edba78c9-128d-42e7-877d-38b7da09f5c0@web.de>
Date: Mon, 17 Feb 2025 12:28:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
 <alpine.DEB.2.22.394.2502152149070.17391@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2502152149070.17391@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0IxrI0wquu7a01i2ZC2f0GPGMAvvUHSc1B+uGwtJjpSm01gVZ/
 Znadn/d/t1UEZjXLSNRPYeY8FqZFS1j3KeLgRGbpydLM9eB9S7XEeH3K7cSGcJxHE/pdpTq
 GZ3OZ5ITd8yz41b5djUVCCBdrWT89LH2Hqf/sKHdBc6C9Uy5+H0a1p28tUnvQE3Lp4OG74n
 gA9Pfx2VxOnsS6HQ4aIBA==
UI-OutboundReport: notjunk:1;M01:P0:IN8tW885+XE=;y75uLeITm5ItefbKdI0+yS/Xfp9
 o7Eczq9nfwyQH8IMHuXg/5lxgsuu8icRD6qTRF+1z7zlGUMiRhjeHhgQ3ztoEkp/nf3YStoxx
 vYj9poddVQtZtzqv7sTo+vLFAl7880Ot9hqOdsbEpaxSj6DivJLoSqlkF4BZobXKKTnqZ1+9F
 V5bcrD3mObWdJdPplFwUNON/mphEg9HK42Kl6s9RhjNwLzggOcLlJx0meGZPkhUBqlLVrIFf/
 VvL2Nypa32jdEgxbt2E28rfNJ4WAKTFCfVOrv3H6eLxvXaMStSk0n01ugQF2m+QJolDBdAZDh
 uiw+ZAbPbDoidzQD5c6xjp+obZk/UcKbjtV9uIgxaCpjKW/rWTlek5ICWkhERdOzE0zx4Y/sV
 lMe0UoMA3rUelHnc1EIGdWQVmfgIJQE4pZCIlikwKGlQDVfJ6pCsLPK06ajt/HGay8qqOFj9O
 Gi6oz2iSkQic5SwwxCJlIv+ztbS8uGlT8dBqca4UmEDdjJDiXvS2eqhpCqj6ifW0sQTPJWOHk
 dU+cC536Uhx318OswWlEBPigyJ74I3boitFSnciDQtJ/wl/v9ijF5KaVUic7lJ4n92YObSMXB
 TEd9L0xswvn8XAP0Tl5zdYacgDSC7amR14L4rgKTQ5SlLQHqIQeV+LSz27401uU1Eo1ycTUmi
 3/JtX/WgznkXhtN4j9sxKyDEWXAx0iQtqfZHHGs6dpD3l2AvpoC5qfy0Ao2Gw8MFApelZTXHj
 J/w1I4CKqno2XzNtWKA8wYPWLkX+G0166sKz8z8q6D0WLgYSLi9TsTYfhFbyn/b+xCyQd7zss
 EmLNqygBdPn7mYo28T4OkJLidLvmOUfQsSH9Auk0+7ea7U0Gyz5TwUqeEaMjDGvMgtKfaeVJM
 ug6ssroYBRJLlOI39OsoruXHgYp7zJLjKlxGJi3kpE9wkkFl+bol4secmFIjZQr0FoybJ0xOx
 6Ak16hTlFecK9fCYtrWPgvCHZvB9uVaPEDjccB7YqcQDC719r1O6ovq60AWEUas/Rdx0vcWLW
 m8Rzzr0aaSfOJ6qyImeGJB1cUwQ2gdnEOPfZ+zWaKajjJ9mw98j3S5M3G+4LB/h80+DVZI3Tf
 0qN+R09bTdWwy1tmM7GcPEZ54kd+/Qu/V0iBfw0arxo+AO4vFd+NleueTKkP4R5HSAIaqwm61
 qCLufixL2I16eIuHITNY0CpQwZYXIW9h+oNPTd6yjE2KEoLMsYslCspHeZxR0oTpkWP1LHqwQ
 lFX1a+V6+uS+qEq3g7RTry1XlHH8YctyOaH92CH7fxySskx82SwM7dc/vcIGYXJJYw3PnLpnG
 u5NjO2e1rlNnLjkShxFwDe073QsgVq5c/YhXVoaeFC3UuCxhSRZeOmvturD729xni+63ANe5Z
 ZSoAybXQlux7izSOQB0SwYM18DTqUzbZs/f0WwQB6nr1ZyHYDVb7j8DThvQSyUtqsQjLMfXjb
 j7k8kB3xalt3y3odtnng/3Vj4SKIv3X5B1GQiqQaV1jn5x6+WBZ4iS0hFpu8ubg1926k8Xg==
Subject: Re: [cocci] Software evolution for special handling of pointers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2425
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/edba78c9-128d-42e7-877d-38b7da09f5c0%40web.de>

=E2=80=A6
> Then, as compared to what I previously suggested, I switched the branche=
s
> of the & in the last rule.  This parses, while the other way doesn't.

Do you indicate an open issue here for the handling of an SmPL conjunction
which would be similar to my bug report.
How to fix a parse error for a detailed SmPL disjunction?
2024-10-05
https://github.com/coccinelle/coccinelle/issues/379


> This seems like an undesirable feature, because the way I wrote it
> previously had the S1 pattern marking a place of interest in the first
> branch, but we may as well follow what already works.
>
> Another issue is that if S1 starts with *var, there will be an already
> tagged token error, because there is one transformation that changes *va=
r
> and another that adds magic_init(&var); just before *var.  I guess
> having *var as the start of S1 would be unlikely.  But this is why I
=E2=80=A6
> There would be a problem if S1 matches a free(var) as well; again this
> case seems unlikely.
How will source code transformation concerns evolve further for
affected implementation details?

Regards,
Markus
