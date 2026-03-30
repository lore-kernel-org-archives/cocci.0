Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649D31061B09
	for <cocci@archiver.kernel.org>; Mon, 30 Mar 2026 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ksGMWVgTj439WNxQ8BWun5kSwbRUT/HD+koM4VA1MO4=;
  b=Bp57fHtcf3ahyrZGM0+dI0Tyrnm5HwJoXyxq72sfAD2aXriiEvoX3aSP
   2UDWl35ARfxRx7YOe/WTtkgkNh2tK+T6iJq5Xcxc829+j5EjFamQ/Z1sQ
   solSPD5ryFJxJyhoAFLMGGPmlFJqzAHvdRih9Bm9RzQGaRk8DlrCyyUa4
   U=;
X-CSE-ConnectionGUID: h1huENDHRYyoKdayWQjyPg==
X-CSE-MsgGUID: H1+NM2TgRaWLSrycr53wPA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,150,1770591600"; 
   d="scan'208";a="270182667"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2026 17:16:03 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 71F1281D73; Mon, 30 Mar 2026 17:16:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C193A81D56
	for <cocci@sympa.inria.fr>; Mon, 30 Mar 2026 17:15:59 +0200 (CEST)
X-CSE-ConnectionGUID: dAoO8O/sQfOKI7CTg6VYwg==
X-CSE-MsgGUID: MbW2iOGhQOCNxndwtT40uw==
IronPort-SDR: 69ca939d_EsJLtdQCMFYIzrzRQZnVDDySDewq1YGD8fbCK4YkdsDd/7I
 3rOXydgZAJz05i/sf6i8yVIvjuTXFy6B3QcOJJA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E8BQAlk8ppgA4P49RagluCP2gfXjQEC0mEWI9TgiSEO?=
 =?us-ascii?q?48RjA49Ag8BAwENPREBAgQBAQMEggyCdAKNJgIeBwEENQUNAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBAQIEBgECEAEBOwcOO4ZPDYJbgSxlCTgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFgI9CkQBAQECASMdAQERJwQLCxoCGA4CAlYbA?=
 =?us-ascii?q?QGCfgGCIgEGEAEDDycHDbgVgTKBAYIMAQEGgmnXex8sIlmBZwMGgR8vhW6CZ?=
 =?us-ascii?q?gGKbycPgVVEgTyCUjE+gmECA4Iqgw6CaYImgQ6BEogJh2xSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSNDA4EGIw88BS0dgSMhHRcVH1gbBwUSISpzhhR5Ay5eGg4iAjlcSj4KA?=
 =?us-ascii?q?VIFggUCgSA1AgELbT03CQsbBD2MfCmCLYFBpzWhRTQHgjiBZ4FkDIoulT8GE?=
 =?us-ascii?q?y+XUg6TC5kGjgmbOIIAIoFcMxokgzZPAxkPklSEYL42RDI9AgcCBw0DC4VEA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 9/SiOTsJT0E/9+GpaMh
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:y0MWrqiGmQh2yjSJcW42mx7hPHBQXgQji2hC6mlwRA09TyXqrb
 HLoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhXotKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:muMMum3jdIGtxuOLMVqEUbxfFukiVS36i2zpLWibKDlCdLLLd26P9/Yx
X-Talos-MUID: 9a23:QalhpQXjdeUDTs7q/Brmu2tjE+ho2oOFLlALnYoah5XcKDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,150,1770591600"; 
   d="scan'208";a="142735028"
X-MGA-submission: =?us-ascii?q?MDHFwG9nctJgIGBKYnTfVOZmt76nZAUO80q1NU?=
 =?us-ascii?q?4QMN6dclpP7Z+fuzVkzRNbywSk5/+zgWY9FQjyUToo2qCtY3QkEmuOmh?=
 =?us-ascii?q?//o9MBge7juBvyY/PsEa7kYC4y00hUCa8DPxcvOYcle+dw3E7ry2cfNc?=
 =?us-ascii?q?URdcD0q4AdX3Cwk+cVRQCIdQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:15:41 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1vDtYt3O27-00zlzS for
 <cocci@inria.fr>; Mon, 30 Mar 2026 17:15:40 +0200
Message-ID: <e46bee9b-0a5f-4e6a-80d7-1fd3c5ef71d0@web.de>
Date: Mon, 30 Mar 2026 17:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <51b9e38a-7e91-4c39-86d1-25da2c6af376@web.de>
 <5c3257fb-1e91-46c0-ab00-f105ccb437d4@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <5c3257fb-1e91-46c0-ab00-f105ccb437d4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CcMQTefCy4wBARjL3h2TTO6BAP3qmAmUhyZCfdOjQBLbTd1QZnX
 z6Xjud60tPBdtrfruimKzEyX07gSme+E+1OS3ZUPLcneVGCzgz/gWMPvxGve14tgqNw4IQN
 BTCfSlF/GuTYuQsjtA7ioab1qsC24fDbP3ucHsOTvFA5qxkNaRYfTFSkX43MAUYtDpssO0s
 V2uc58+g8zfRGD76RQMoA==
UI-OutboundReport: notjunk:1;M01:P0:7B50fsAA16k=;w0VbZpu5GuG9H1thjLa94H/OLzg
 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
Subject: Re: [cocci] Logical consequences for applications of SmPL
 conjunctions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3468
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/bUkUQwz1-o6nBN-iFuqk9Q>

> Will clarifications and development ideas evolve further also according to another
> SmPL script variant?

Conjunctions have got properties which can be well-known.
https://en.wikipedia.org/wiki/Logical_conjunction

An usual goal would be for a source code search
that all conjuncts would become true.


A) SmPL code can be constructed which can never succeed.

@my_test@
declaration d;
statement s;
@@
(d
&s
)

Would it be nice if the Coccinelle software could point out
that the mentioned code contains a specification mistake?


B) The conjuncts need to match entities according to common categories.
Some entities are even supported as key words for metavariable types.
Bigger entities can be constructed by a combination of smaller parts.
Will it become helpful to reduce code repetition for this use case?


Regards,
Markus
