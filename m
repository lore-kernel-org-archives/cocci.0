Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49922C54E64
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2024 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=PIe5OynHst422ok65Mr71jesFrS/EbBKIO2Lj7pYl24=;
  b=k3x9+kra4l4+qJ3+tRKGFSTffZTTQqUmnDhMgzcDGE1yl5g4mAs1nLXx
   DNMf8h0vnAhTiLrpq3+q/m1d1hg2jqDJV3xfDprbUsvjM+FncdOpjTKAh
   gD6IppuO9gkvSzJlF9TX2gsZ1ZtqKawDOXjOFcL/+FOTd4L9yzMoc4bXL
   M=;
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
X-IronPort-AV: E=Sophos;i="6.07,152,1708383600"; 
   d="scan'208";a="158227373"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2024 08:51:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39D50E0149; Mon, 25 Mar 2024 08:51:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 96344E0145
	for <cocci@sympa.inria.fr>; Mon, 25 Mar 2024 08:51:03 +0100 (CET)
IronPort-SDR: 66012ce6_XyRm26L/ymzw4YIJ8fNTNwn9h1F7WrXP6Kuqskaoe9hEzAL
 iNruoq8vCcVOiOJcOqSq44e46ZFOKDU/eomKtHQ==
X-IPAS-Result: =?us-ascii?q?A0ElCACUKwFmhw4P49RagQmECHwDUzIEC0gIgUoCgwKPR?=
 =?us-ascii?q?YZggVWNMYhwgxY+DwEDAQ09BAECBAEBAwMBDYx5Ah4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNgmAYgQ6BJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06ax0BA?=
 =?us-ascii?q?REnNAImAnMBAYJ8AYIqAQMxBw0GsmiBMoEBggoBAQaBWEFOrHUfLCJXgWEDB?=
 =?us-ascii?q?oEaLogMGgEFZYluD4FVRIE8C4JHg1ABAQKCK4MOgmiFToEjilwBhzSMN4FTH?=
 =?us-ascii?q?AOBBW0bEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQAZICwMCGgUDAwSBL?=
 =?us-ascii?q?QULGgIQLCgDAxJJAhAUAzgDAwYDCjEuT0EMUANnHzEJPAsEDBoCGxQNJCMCL?=
 =?us-ascii?q?D4DCQoQAhYDHRYEMBEJCyYDKgY2AhIMBgYGXCAHDwkEIwMIBAMrJQMgcBEDB?=
 =?us-ascii?q?BoECwd2gz0EE0QDEIEyihaDP4IihDwIMgMZKx1AAgELbT01CQsbBiIeAqRAA?=
 =?us-ascii?q?YNFGj9OlROPRYE0oR00B4I2gWAFgVwMiHuBJINVkU0GEy+DcpNEDgaSZZhij?=
 =?us-ascii?q?XOVQIVQgXsjgVwzGiSDNk8DGQ+OOYNhM4ELjjxCNQIJMAIHCwEBAwmFRgEBg?=
 =?us-ascii?q?1qBSAEB?=
IronPort-PHdr: A9a23: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
 35wfhEVxlV/xTxViLNzFj4Yhkc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rFGSea2vmDydH8iJTWPjpgqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:u12uqm8nzAdZTlUSRx+VvxI1QfoHe23Z9Wr3DEDjAElpFZaTTEDFrQ==
X-Talos-MUID: 9a23:IVQnCQitKb38TDzINgcxlMMpLuFyu6SqUR83v4wMq5CmMgNQCzuhtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,152,1708383600"; 
   d="scan'208";a="82984908"
X-MGA-submission: =?us-ascii?q?MDFNGO6lRgigQP5ufL8O+F4+U2ewUr3UjunCje?=
 =?us-ascii?q?pUj1ct8u+uha8UwA1J327ZObb3KMDojxspUW62ar/3XmoUk0XUBx+m4D?=
 =?us-ascii?q?uieBsJjJXlh9XyCSMobY9gQ+7D1X+3EfcXOUHRtYsEffrQq+gzvf4Fxj?=
 =?us-ascii?q?h2HixrQVkQKMxjH6niCanGNQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:51:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711353061; x=1711957861; i=markus.elfring@web.de;
	bh=PIe5OynHst422ok65Mr71jesFrS/EbBKIO2Lj7pYl24=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=umUbFtXaRivl0OLj2T/wQ6ws7tsLCJVoG3Nk6i5yThpt7jMPxImXrO7GqUy7/LZr
	 mzIwcMF5zNfcLeP2u1tteKBFJX4YnTXc+R2l4gNniWDoTmiWKTLt0YSCY2ZiLr2vW
	 wswajzVwsAanY0Ffoa2UB0ywJnSUnNGYOvSR20ekT8tSurSt4kof9oWZ46yHz/XRo
	 F1AmvyzyHOy/moiMdNKr0xJUO7hnVfMgdX6Ppo12DNnK96PDPPbwP17fRJkf/4PtS
	 XzRfH/WLvvzyD/CewcUOjR+kR9/a6DIs+beZ0Q4V2hQxvQXwuID9JMaBPPCIWw06T
	 PXDym3M7ClHlE07ZPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1sTEem30qL-00f8JU for
 <cocci@inria.fr>; Mon, 25 Mar 2024 08:51:01 +0100
Message-ID: <7438a8fb-f647-4036-b37f-52396442f024@web.de>
Date: Mon, 25 Mar 2024 08:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Dupf2aGwJpYZQrDFRzLQVqmM2VUG+ISMzQth0veju7DyaBn+B3Q
 ZeKZxJ5O4gZ6SdJBZl/zuPhAOvRRKezSG/nxcqLPctH8vA+PKGyfCRDjKwo/uHqOljX26bC
 cMRP7ql555pWmzVZ0gltQZSCqy6ZhhE9etnfdOfq1eJY6hiqJDYmg1ojC+KK3p7Ls7kmH3z
 rEBF7PTlojy/kB4rg9YQQ==
UI-OutboundReport: notjunk:1;M01:P0:WoDygMhTnaY=;PYu0xp1kdJytMuIW2AQqYAXbF6Z
 2vnGYAOvhflM3UNmTaS9pK2EQwae0C48ZnWTJe7VyL5sA1i5glJ40V/GZDg27vNaOUjnDUdfz
 yvuiuHwcqKXyoZQF/Wu1xRvRi0QHt5M0rucTj/jxybTGp6Jq6JEmPvrTDiUc0SSr7H5phV+0m
 HBkCeWIzqFo9SRXNno6AzGqbbP2jewBj2owv4uuCkg25za7XU3t1nfs4DIKExVOOepbubJQNQ
 4vmhz+tKaT7QuWQbDTKPpzTR2IAGek/rrm3a9v6L/wpREqV5JIT9pNtyMggaE7+5n7l7f5x5y
 pO1YSz3ygRixIGPA+p2VzO3gaCEV4iGhwHYbyRVDdlC7C0ZjdzTLx8kb6FS7jZihPLJNXtKiQ
 LkVvmJf+GPG/GO6tdz5nZDQswa8h4Wsx0Cvt87KbWXpOdGmYtzNnfRitpRuA6B2dpCAci4aw2
 Tm7n0IbjyZua4g+c4/FkJAPIAZHFQ7t7jTRqbtBOrjGwT3bCAAhzEzEPGxNNAVjwd/sAEcNfj
 pJEVV0dYjGtnY/Qz2zMcS339cbt7/jfo+BKlx3Va1dxhJ3ll3CAYirM0YtMWBfIYT5eV+Nb63
 kcZ8/hzODfdusOfQhKzCC63JphAIEzvS6v1zfNFrGFp3p1mQ1AWWfv+G4/6xaYU821EZwCS7O
 egr+BrFK8Eu3a9QsGDQ/9E1UfGPIUMs83HX8RyQSlqFD+OhpA/biJuF+cUvvVFxSjcBbc8CLh
 PtJaFUsCP6DDrWzsLNUYQX0c+pyaWhKUXyhWLJCYkpHe8nFkoCUgji6acXh3Nen30c5DbS5g6
 AgmFgLYFOZIRvhZ9t+bKxrnwOGCCqrJfSKwEAXt44Gw8U=
Subject: [cocci] Adjusting limitations for SmPL inheritance with
 metavariable types?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1614
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/7438a8fb-f647-4036-b37f-52396442f024%40web.de>

Hello,

I got the impression that metavariable types are provided for which
the specification of SmPL inheritance might make less sense.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/0011af1760e37caada1f9d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L607
https://github.com/coccinelle/coccinelle/blob/0011af1760e37caada1f9d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L607

Examples:
* attribute / declarer / iterator name
* typedef


1. How do you think about to clarify and adjust corresponding development concerns?

2. Would you like to improve any error messages?

Regards,
Markus
