Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83F1E77171
	for <cocci@archiver.kernel.org>; Thu,  5 Dec 2024 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ChAMc3uUGzWaFzF59yQA3XtlN5BAmTfmRwXq3bZ4AFg=;
  b=Xe12THWsO+qJNXdqY2fXlfZZ8uB8o1GdpS5e3xQk/7BEQaWzynR9evsD
   OzuwShdtAJR9xSa7bgpEyTuSe6PSWt40jXpLlNletS8fY5DKLcMGC6X/O
   9NN5z9RAi52ja9wGtWusB6dpLWZ0c36c9aYHpwq4CrFU/fzJYpx9PHq+Z
   k=;
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
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208";a="197482797"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2024 09:57:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA7F1E0D1D; Thu,  5 Dec 2024 09:57:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D4CDFE00B6
	for <cocci@sympa.inria.fr>; Thu,  5 Dec 2024 09:57:06 +0100 (CET)
IronPort-SDR: 67516ae2_qXezw5JUT6o3WayTmmilRUrMgUhflyfw2YsV7UQxD21rZIh
 LP/YZfwbITBWtNfkdSTVjvQ86oZP/wzRRx0wtFQ==
X-IPAS-Result: =?us-ascii?q?A0F0BQAXalFneAQP49RagQmEF4EDVDMEC0iEVo9NgXQtA?=
 =?us-ascii?q?4Q7hzuSNoFqDwEDAQ1BAQIEAQEDBIIMgnQCimoCHgcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABQw4KMYV7DYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgIRFQICVgYVAQGCfYIwAQMOIwewY?=
 =?us-ascii?q?IEygQGCDAEBBoJo13MfLCJXgWQJgRouhWuCYwGKYicPgVVEgTyCAYECPoN8C?=
 =?us-ascii?q?QkBCwcBIT+DHIJpgkOBUIEZgTN2JU2DeYIjgS9oiBWCWoM/ghgofYsFUnscA?=
 =?us-ascii?q?1kyAVUTFwsHBYEqISwDgkh/gTaBUQGDEEqDLoFeBTdHgkppSzcCDQI2giR9g?=
 =?us-ascii?q?k2BJQQFg2mBC4NehFmGKoFjHUACAQttPTcJCxsGPaJlg1AHgQ56ASxKgSMPx?=
 =?us-ascii?q?VY0B4I4gWWBYwyfWgYTL5dDDgaSeph7qSqBfiNscDMaJE+CZ08DGQ+OLRaEC?=
 =?us-ascii?q?75GQjU8AgcLAQEDCYVGAQGGeDSBSwEB?=
IronPort-PHdr: A9a23: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
 CaA97ZT
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:G4tJrKjBXz2S2a+Mrh4Qnim8o3BQXg4ji2hC6mlwRA09TyVXrb
 HKoB1p726StN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOHhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BkWqF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3A6qCixmg5FS9hJdBV0/lp58dBeTJudkOe7Vv1GW2?=
 =?us-ascii?q?BCWtIEeGte2GQ9Z9Iqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A54DU3g+gHEkLc+nCnn479GOQf8pQ6bqkNgMqrZM?=
 =?us-ascii?q?HmZWbB3ZTFzCmgh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208";a="197482765"
X-MGA-submission: =?us-ascii?q?MDHUSvjL8PQO8BgTv7iFHHH62M7KuaivqhJn6O?=
 =?us-ascii?q?dXiU/6UOEiE6GiFcrcyUZc9eBdSusuSnH/i6F371wHYg7y03blnaXpGh?=
 =?us-ascii?q?Rqo1csD8CeRVWua7v1ocTpMUWxYxt3naBlJkR66dr1kJm4G8Wf82aTdz?=
 =?us-ascii?q?nHEFjkQomKSBmVvswf90i6jQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 09:57:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733389025; x=1733993825; i=markus.elfring@web.de;
	bh=ChAMc3uUGzWaFzF59yQA3XtlN5BAmTfmRwXq3bZ4AFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mIrukjIdN9a6Q3SKcbyI8kvem8XqIL6Ep883egI/Y0tc/iNT5Fz8ewb6B+Bzhjdd
	 Fs83TVaD73KHIDXDszM9ynAVsA9iO1CzFjmxXMRJ8HFehggv2THwZxUoZT1eIDHMG
	 xFEKJa+tj0/YC5ii3PT7GU81TvEhDRQhFrz5nGMr7JqNKCOlKKPEJBg/UPKUxaG8h
	 lEISuuE+t+vMXBD7h+ZMD25gJK1BXAHgJ5XZfnMi+rb2O2+/Zz72BZUOB+KPVg+D6
	 y50vwyCYN5SrudUJRW0qji0pzkB/mp4rAbEF6t6P28WOIrUJr/1Pib4iJW1oGweSm
	 7xiRS5+kN0EbZVcPfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1tNmMc3TBj-00CGSR; Thu, 05
 Dec 2024 09:57:05 +0100
Message-ID: <f9e456ad-5b66-4eb1-bd1f-89b0330cfc17@web.de>
Date: Thu, 5 Dec 2024 09:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:++EWYkJlhQDhDcprvqX/WTI9+Vdoy0o0uVp/NL53FPnxTHSqqXK
 VaEvdHB+qTEIZQJCrLOF3BT7CUaHjBXiu7TLNGOfUgba8eUIskzGHu7gcWKHRZDUmr/qmF4
 sy5/uU0z5zcjTMKcbi4DFyJK2DxBbcyRAz5D8GdeyP5C31x/m1JJhxr0dI6uBJj0VVp/VCl
 O3CvdYip6C1jIkxmKkF1w==
UI-OutboundReport: notjunk:1;M01:P0:e+qcbxLe4K4=;YTHAPlnUgPgPxFAh9K3TMlxchbW
 rbFrXU5RcglDZtiYp2aIHDlYrg9ICPL/EH152B+1HzKzSw2vsYEekSiLMi/BQDp9Yw9V0UiLm
 UHy2bOW5j+a4fNOqMpxObT7wcA46cKZXd8QiYsqIDQ7BbK3sCg5hslm1IXGXP7FH3d2XZFs62
 2g2nCfUQ4UN971DJQHwqd8PXmyy9NA3ibNxbbWpcP5LERB9h3WZ5IPF8xhrYY9u1GXkKA2NND
 Vu/027P3EtbQCIJBCRDzGXGhLHY/oR33a6Jq2cG6IM2IkB+EtRIhfH3idMkrtEOXCYl/p1Upv
 uFe7j/kcRE8LEeVr0qIir5n3nSNBmPIYlqeSE4qufRyzQAHkt/Fe+3urasp32EKuK94lhEYIS
 T/Ng5HzP8IGJbe/ZMxrls2oLzAiEyG4Unf3CjGIpoS+UmHsgU0FQpp/OnAHdKLAw1th1dZBkP
 bjBwa6wVNDH0jvZiWe0E6/GDxojBJaVpyIX+IkahMbW3ZPHbYJ+hD299pj/xBEAUWLU8Fh9tE
 jEPVsOy8NbEDhDqKTJV+tLgDUyy4SRS9/ZNDwaFEV1Bc2BZHW9/9UmMLikaMbHDTSiIMPXQMJ
 gKxEbVFqfRTIrCAZPcNMaQAacF/iN/YHj7eSmSiMxPwgYJB33k1nHDQ9s1XULLv/8OaOKAuyh
 3pZ0GsyzEkwOW63kJqb0WK0yD6n4WVcGepQwSu9Pqoyezzqlxj8AHNYh8w5bDA7tj3U1BaUX+
 2j7IiwY3l8rbFlAI7mOIJx7KaHMi3phtAeDgxggtTJcc74jmug8msOhXZKecGozUwvuex3jmK
 MSU99+OiywJP0s2N32lKEAzCNH/0wvzrLVRqy9C6kEqmiuI44Z3ExuJfKLMhKngVeqHTxXmck
 r+V4BA837k9Dl2rfS1mt+2SREc8gL478bvSgjzPxEi4BJxbJKOgQWc7w/btYiUfd+YXIhJPQp
 LNbBYXWCw5FYjR1LLHw1d4uOKa6FlRWv8ZR2fWCJzqf/DW1CTOqqkZfqxrVQaPjiqzHjBHCei
 2UjUX+2VkMKylp54jXlTqDcGQyOI0ToRjB3tkfedH2ypgiEhCWZFbLQb3kY7lX+MYDtAG7VFJ
 8UlTEXabg=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2161
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/f9e456ad-5b66-4eb1-bd1f-89b0330cfc17%40web.de>

>>> From the sample_case.c I linked before the two constructs I'm having a
>>> hard time matching are function names in definitions and type names in
>>> parameter list, i.e. in
>>> static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
>>> neither SomeDeviceLocalCompare or SomeDevice seem to matched via idexp=
ression.
>>
>> * Did you find scripted SmPL constraints more attractive somehow
>>   than script rules?
>>
>> * How do you think about to choose more appropriate context information
>>   and corresponding metavariable types?
>
> Sorry, I'm not sure what you're asking.

I hope that remaining communication difficulties can be resolved better so=
mehow.


>                                         Nothing has changed since my
> first email.

I got an other impression when you mention your special file finalisation =
attempt.
Would you like to share your intermediate development results once more?


>              Coccinelle is a wonderful tool,

Thanks for such a positive feedback.


>                                              but currently it doesn't
> work for this use case.

I suggest to reconsider involved development concerns in more detail.


>                         The type replacement is matching multiple
> times

This transformation approach will trigger further development consideratio=
ns.


>       and to my knowledge there doesn't seem to be a way to convert
> arbitrary function and parameter type names. This is an all or nothing
> type of problem - either all of it can be replaced or a regex script
> has to be used

Your views might be too limited so far.
Some software limitations (which were also reported before) can influence
desirable data processing progress.
Under which circumstances can the means of the semantic patch language
be taken better into account?


>                (clang-tidy with readability extensions also misses a
> bunch of constructs) to convert from camelCase to snake_case.

I am curious if we can benefit more from such information.


>                                                               So
> afaict there's no way to solve this problem without using some regex
> replacement script.
I imagine that such a development view can be adjusted considerably.

Regards,
Markus
