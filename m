Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9C3D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=luCZRCCjMlT2+2KzjnAORBCDCJ8bEDoZoE5MSYb1IAs=;
  b=vEebfVaxyhbVLT2x2Xqv8/dF8+AN9et1vS8h8HItGcBOd0zrx/wEPKAk
   MkjVrTH58mbuPiayqnSEGok4glSreoD54CSzM+hWKsxqB0kcNPskvsWht
   AGSyE/x6iFG67bxdRViQNxqaHge2+gstvssuDZRPqegRlwKSzb9xA9Kb4
   Y=;
X-CSE-ConnectionGUID: oDx7XwN5T2SGhWGpG1ESOg==
X-CSE-MsgGUID: jGTLZa4KQt2bAWL7aYvBjA==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251893104"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 16:10:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9DF0AE01A8; Sat, 29 Nov 2025 16:10:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 80F44E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 16:10:14 +0100 (CET)
X-CSE-ConnectionGUID: LNauP7auQLWG5rzbV39lGw==
X-CSE-MsgGUID: kHfP3j4KTtOL9nJpP1FPCw==
IronPort-SDR: 692b0cd6_LmrB71FxpaAyPbJmDYvqFeu3NwCzo3gA/zz7jI/KSgoSVMz
 ABCZUl/Q9yeGYKBDgRLVDozFuHZATOfO8P4iprQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFAABCCytpgwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8EAQELAYI/gQhYMwQLSYRVj1OCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IFMQIJ0AoxlAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAToHDjuGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVgYBFAEBgn6CIwEGEAEDDycHsWOBMoEBggwBAQbaX?=
 =?us-ascii?q?x8sIlmBZAmBHC4BhW2CZQGGKYNDeicPgVVEgTyDAz6IHoJpgiaBDplWUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwMqNC0jSwUtHYEjIR0YEWA9F0CDSR0GZw8GgREZSQICA?=
 =?us-ascii?q?gUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gLgQkFLoENAgELbT03C?=
 =?us-ascii?q?QsbBj2VDVCDM4IQI0sgpE2hRTQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBiKpH?=
 =?us-ascii?q?4F+JIFcMxokgzZPAxkPjiEZhBrEeUI1PAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 0xv4jY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:o82D/a9aTb9D0EMOB4Vuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:uuyLgWDHj3do/ND6Ew1B/VMsRck4S1ni4yrKMUWGUjdtZ6LAHA==
X-Talos-MUID: 9a23:zHmnTQmlL/9l+FR7cI7AdnphFMlQuKbyK3wRtrFXveucDXVeAxyC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251893101"
X-MGA-submission: =?us-ascii?q?MDHo4tRmG3vJCbBY/Ql/Pb25qznlyWNg34sXyZ?=
 =?us-ascii?q?znLX6K6svDcTiz/OqL8Q6qFQgcukshJsAbM/ZIi5jgnaEkwldpMbCIog?=
 =?us-ascii?q?ejTJ+ysthgpzAEcBQoBN3+HE7uav6vjI6xP1M9cUsxFWLU6SbtBJyY+O?=
 =?us-ascii?q?OGtt2CQ2GORd6LpzxvjFSsvA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 16:10:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764429013; x=1765033813; i=markus.elfring@web.de;
	bh=luCZRCCjMlT2+2KzjnAORBCDCJ8bEDoZoE5MSYb1IAs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dnHjWDdmUEAE/bR7nkcVbue+FniH6gQEV60Ta8OPTLsGWWBtGYtx6cSpybg/fV8r
	 l/F2IXmRVWUHvYAdAp4T3K2iKfT6SPPdpio87kyhOumrC1Z3nvxGzu7ER7LsYihWW
	 4Sbr7fk5lJFkrHGET8Ao5DakjDNptDlwo0Ka78vjCKOtNXhBjk11e2AZF3bBnF9n+
	 nidX4nkGpJg+8yudAmG69r88RobU89hImiV5yWSTpL3vTeYISWO7Gp+XKeaHHYWcb
	 +/uITnHw3pMiKSKOiBa18yeU/ud1UPTf5JYjn99qKAGEwRDvm5pVfiuKloesfi4tM
	 DvSpJdZlpkJGMF/W3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1viPwE36Dr-00SULn; Sat, 29
 Nov 2025 16:10:13 +0100
Message-ID: <58565b75-5ea1-4c3e-b470-9d320c159b3b@web.de>
Date: Sat, 29 Nov 2025 16:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <24d6e1ac-0dcb-4334-bc44-65c3012f7764@web.de>
 <cdd549f-17ec-1dda-8f49-2fbdb9cf4439@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cdd549f-17ec-1dda-8f49-2fbdb9cf4439@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oQOMM/FMiQTDMBfFsCl0Ovotk4JTCUae2/+B7QmRS3NeZOTDybt
 EVErMdJBvzcQqvaQ7P/vJdiV4VHSM7+x/msRYeyCEDA4rOS4XlEk0tcrynX5HTffzGVeuC/
 mtRIfl2kHkwczWdRThLxzxYcFB5stalLwuyNyfeRyfKSNdBRqZZQK9e8aDsWeyRgiblm4iY
 I7MJrhETwkkMs1yFsWqCA==
UI-OutboundReport: notjunk:1;M01:P0:ap3qtPkAPwo=;GxNWX+27pmUFnhVZnKPCKZfhd0U
 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
Subject: Re: [cocci] Questionable macro expansions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3211
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/58565b75-5ea1-4c3e-b470-9d320c159b3b%40web.de>

> Coccinelle expands macros when it has them available and when it is not
> able to parse the code without doing the expansion.

I find this information relevant for further clarifications.


>                                                      This is not
> controllable by the user.

I suggest to reconsider such a view in more detail.


>                            The only thing you can do it perhaps provide a
> different definition of the macro that better corresponds to the results
> you hope for (or just remove the definition of the macro entirely, which
> will cause a parse failure and thus no results for the affected code).

Will any other software design options become more attractive?

Regards,
Markus
