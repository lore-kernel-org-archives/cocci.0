Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189C0CCD184
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Eg6Hbw6O1b2QWrO96DITb1Q7AGQ7cXA5vIO4pP1FlIo=;
  b=fsAz77usSgxQJR9IMGQcstBpGaQlTlC4etpjs6PICdCiJQyrzpLLEVCp
   wiJFcZxx+kXDLnP+ujKglIRX9dAxo91b1FJRDGrpKPTIGiIVAiI94G3xE
   ml7KLP833Gr983JFzNQj9PcunMDLRJRdry2fV0GRRw+ubbwUJjIt5N3nv
   Q=;
X-CSE-ConnectionGUID: xURleNm2R3u8uPyj7xv0pw==
X-CSE-MsgGUID: oeOM7Y54TWu/cqPnr7E2Fg==
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
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245013348"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 16:38:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 34242E0CD5; Sun, 19 Oct 2025 16:38:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 90B55E0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 16:38:00 +0200 (CEST)
X-CSE-ConnectionGUID: TI2+5v6AQKq27Vedlh/B9g==
X-CSE-MsgGUID: LrRKZVqES56NcnagjhHmgA==
IronPort-SDR: 68f4f7b9_8T1fmLlX5kxVYbxHfhi0wOvXfOYoUW78gQsS+tEvtqdAA7h
 JT/AngI4bhgh4nkr5B0Kvc8JrZzqpfQzBXXP3+A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FuAAA69/RogwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4FAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHVYh5gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEhQACjEwCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBEScPCxoCJgICVgYBFAEBF4JngiMBBhABAw8nB60hgTITboIMAQEG2l8fL?=
 =?us-ascii?q?CJZgWQJgRwuAYVsgmQBhieEPScPgVVEgTwLgkcxPogegmmCJoEOl1tSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSBDAyo0LSNLBS0dgSciHxwTYD0XQINJGwZoDwaBExlJAgICB?=
 =?us-ascii?q?QJCOoFpIgYfEgIDAQICOlcNgXcCAgSCMYEQgikPhkICAQttPTcJCxsGPZM4h?=
 =?us-ascii?q?TAlphWhRTQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBiKpH4FvBi2BXDMaJIM2T?=
 =?us-ascii?q?wMZD44hGYQaxmdBNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 vEelQZ0J+ggpm6E3g==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nvW5V6orMX+dIm3fq86JKsYaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:EtssNW6ZjVyE5mCBY9ssyG9OWZ07LFTk726KfHG1BWJpD5fERgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AlxD+ww/Pf6elglK2gO2eJS6Qf+Ny2YecNlkgqsh?=
 =?us-ascii?q?YncKCPCNyOxeYgx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="128611154"
X-MGA-submission: =?us-ascii?q?MDHZ33GxNR1YT5NToaa+DJkik9DzG36yDAvMNp?=
 =?us-ascii?q?mrjGaiMm7Znp96QdOzqZ/bHNHXac/61CJmTdvZRt/DVp93CqkbKJ8mZ4?=
 =?us-ascii?q?+QYLkvqtvmVdo4Qgle5F95aGU9hj6JkgMVugJm08nymaMZI78q25jE9B?=
 =?us-ascii?q?GbygbkND+X2+vrVpV1xAg/Kw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 16:37:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760884664; x=1761489464; i=markus.elfring@web.de;
	bh=Eg6Hbw6O1b2QWrO96DITb1Q7AGQ7cXA5vIO4pP1FlIo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oyvOxf/sFzDOaf8U9VFF79nquXmUWqsFeTVjnnCqVEPxVpwt+dTNsSXmCwwuACCW
	 XgnYMROZHbAPg22AGIWBC0n9eOmZpPqjd/U7DGazeS6JYTkm6CEE2tgVHp5+jPqGb
	 ahisDmJ2evKOxfrwqb8VeCZkEf6d6GWdqcUuacnVvHY3XVX9WTflLlRwUPuI86ayr
	 HVDsH85T/COVQtZT3WxJD2tfB/AdQfNIXpHfUBSonVnOK7dIKuhMgXUG37IS1KAwk
	 XZebgg/e1Kp3T6+fo3QAHEuIkKPJt3Wk9/cbDVq5c2uYjjd1CVeZbXKf9RCCftLUz
	 JvyndKOcJq8MWW7mQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuFD5-1uKrn322O5-012IuZ; Sun, 19
 Oct 2025 16:37:44 +0200
Message-ID: <769428aa-9801-4805-bfc3-cd789f7541d1@web.de>
Date: Sun, 19 Oct 2025 16:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
 <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
 <c55ea172-2c1b-4bbf-b5d4-e2d421e18b1f@web.de>
 <e5b2ceef-31a0-a54-dd74-c4dcdfcba5a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e5b2ceef-31a0-a54-dd74-c4dcdfcba5a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WwRqFLUuIQFp/8XgfC2iBNH1IH5rr6DSincC++0RphnfPzP0QOy
 9aZ5OH0WZjof6xUUSkvyseBW3EYbBZwdh+g6irjO6m/UmHpg4/0P78ESkwtnW3w71SJ9uEj
 3GyC6859REq4XYch3lRaeBGIcH/tv3yvoX55uPkC4FNF7ZN2eTffK/iX7eDMX14OnqRvR+3
 EH1emNPhp2c1gycLy+CWw==
UI-OutboundReport: notjunk:1;M01:P0:pUJ8tt/k7eU=;p+yekGW3oI/2ExPe6gDpUWs40ov
 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
 SomKj2g1pq1llixcTZ0BPIvM2v9Cd0zVTwY=
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3080
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/769428aa-9801-4805-bfc3-cd789f7541d1%40web.de>

>>> If you don't want them to match the same thing, then you need to use a
>>> disjunction.  In the first branch, the same metavariable should be used
>>> twice, and then in the second branch there would be the two different
>>> metavariables.  The match should only be indicated for the second branch.
>> Does such a solution approach indicate a data processing requirement
>> for multiple source code searches so that anything would be excluded finally?
> No idea what this means.

How many searches would need to be performed for the evaluation of
SmPL disjunction elements?

Regards,
Markus
