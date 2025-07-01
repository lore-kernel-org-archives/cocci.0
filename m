Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50AEC7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CR84nra88nMb3jX8nCMU8ZuLTsGuCETz/1Ftmd6XLQM=;
  b=ozazWuPgS1byMXA5Y4VZhUR7k7wnajXTwcaO4WNjZKIEN6MY/ezFt/jU
   wCJDOju/Vqt3epbu93tKTDr5S/i/l6PXzBnb49BPWv+l57g0fxs58N9Yb
   SAc1CtV4EnHfNS5hBAZrMep0qwkrzZiA3c8K1tl2EHQOvJeOTpQ8a27Tt
   4=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229871566"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 20:00:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F212AE0AF1; Tue,  1 Jul 2025 20:00:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 01170E0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 20:00:36 +0200 (CEST)
IronPort-SDR: 68642243_c0kwxM1w4J1PWPVVQrsuxevUiTT2HMTUWpcr2gHr2+3bYb6
 ZNrfZn85WQ6vpHSxhb6HomXsDcKGrzZezDUmRaA==
X-IPAS-Result: =?us-ascii?q?A0FYDABuIWRogAMP49RaHgEBCxIMQIQXgQZUMwQLSYRVj?=
 =?us-ascii?q?1CBdDCEO4c8h1OId4NSAg8BAwENTgECBAEBAwSCDIJ0Aot0Ah4HAQRHAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn6CI?=
 =?us-ascii?q?gEGEAEDDiQHr2+BMoEBggwBAQbaXh8sIliBZQmBG4YbgmQBhieEPCcPgVVEg?=
 =?us-ascii?q?TwLgng+iB6CaYImgRaBKoNQNoI4kEtSeBwDWSwBVRMXCwcFgSBDAyo0MSMPP?=
 =?us-ascii?q?AUtHYEnf4FNHIMJgQ6ELCtPgiR1gXlBGT+DVB4GbQ8GgR8bS0ACAQttPTcJC?=
 =?us-ascii?q?xsGPZJhh1+kM6FCNAeCOIFmgWQMn2kGEy+DcQGTWg4GkwKZBSKpGoIigVwzG?=
 =?us-ascii?q?iRPgmdPAxkPjiGEM71FQTU8AgcLAQEDCYVGAQGIDIFLAQE?=
IronPort-PHdr: A9a23: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
 cXT0r3+InFO/oCMlSP5L9fZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:At4JBq8THQ3tw6v8k2Fuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:SpUCI2FNnw53u4MSqmJb+FUKB8YrUEfG0VnhGn6DNmxjcqesHAo=
X-Talos-MUID: 9a23:FThBiAl4JvOM16xctx06dnppJMZM6Z+RVHs3qpUjvsCmFAgpECy02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229871564"
X-MGA-submission: =?us-ascii?q?MDGr8Pvuq30cUvd8vWejwYEhZqGOklgBKmfDDa?=
 =?us-ascii?q?LZkNZATD/IEXRm+xZaLIq1O6MtZrhrCa6ERzBxUCFpmHR+90UNzGAFwH?=
 =?us-ascii?q?0ugqICAlWfOTn54x8gWdzrmhWfoZhPFehF0nZ6hRnElahut/EhH3zNi+?=
 =?us-ascii?q?sLOiWu+rqb1x6s2Z/uaeZc8g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 20:00:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751392834; x=1751997634; i=markus.elfring@web.de;
	bh=CR84nra88nMb3jX8nCMU8ZuLTsGuCETz/1Ftmd6XLQM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=n7QvAOv5zOu4IvwHkSBhFDYSNQilDexGmTCvLnh8uBrJCGWY5X9DR0qBF65YEmRR
	 ZaJLFQm+sMhrmvbG8hqwWZ7gnbUV5jUiGefu/MvZGoHEzc+eMl6QFo0rsnXIcaGsO
	 d0OqjoZ2KoRLFv+v/5Z6lySc7x1I0PFUk83yGG3IiBFjEqic/WoaRlyAl0dxbYnBE
	 pPt2WuxmUksXZDNqFfY8oP9nml2k2+Xu7fTnw4/3dRQv5Dr7EDp+h+qX0H0TWGV0M
	 +Yi23fnlB00CW1UBgXKFLBPpuxw46QG8erydVF4gP2AaKCbnIsNxJf7fbRzUA+kU0
	 4sBUA/Ia24fgcr9MNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyNwm-1uu0462FNU-010Xgn; Tue, 01
 Jul 2025 20:00:34 +0200
Message-ID: <4bb3bc0a-a09d-4765-b3d5-c37b856ebf13@web.de>
Date: Tue, 1 Jul 2025 20:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
 <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
 <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
 <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
 <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:l4INPkEvab5yaFfnUM1bFvsu12dKjUMAOs3NT1FaHu3rykaYoyQ
 hZYNJ06l71fN4irs9o8ESrRQ/xFUNr8D5qulkaU+PMrvQWFRWbN14UDLjOSQ+7iJvniOKoA
 G0wsGL7NSpkMEGfuPaXXxHO6Sv2oGoI9y3A1aQPIAlo6GLJzjxRXzcKdU9YY2H1E+cfz1o6
 OK1a58x8Z6F83WPNUiADw==
UI-OutboundReport: notjunk:1;M01:P0:AylkmCOv15M=;t/T/faY7p1sE8OHaymzq+t8S87Y
 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
Subject: Re: [cocci] Searching function implementations with more than a
 single return?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2846
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/4bb3bc0a-a09d-4765-b3d5-c37b856ebf13%40web.de>

> I see nothing unclear.  You can write { sl }.  You can't write S1 sl S2.
> There exists no representation of a list of statements that sl can bind to.
It seems that such bits of information point opportunities out for further
contributors to improve also the software documentation accordingly.

Regards,
Markus
