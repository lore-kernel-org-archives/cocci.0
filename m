Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7229CD5BB1
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=F9EpXMJIyQl286Eo4qCjZeIz4cQv1kiIiwC/WKPtvyc=;
  b=dRjH9GjEMVy/u41f13ZygmjRreOe9Ams10zndaP9XwaM7yFKR8+SOFX5
   HI4raHor3b++ZzOx8hlBbIcwKu2qNxajbhjVHyHeULqU8ru6pfKe2zsLG
   6rPIy6FOh92aA5x7IT5t0s0nzhRLP6tJT4+XJCOUl8UQskIoxZswC3PjN
   I=;
X-CSE-ConnectionGUID: 2cEfaGOrRbO3aogy6kklqw==
X-CSE-MsgGUID: exN7KOuOQSijeX8Q8XSNHg==
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
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="278234632"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 13:33:32 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AF73F8634E; Tue, 26 May 2026 13:33:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8B4C680E84
	for <cocci@sympa.inria.fr>; Tue, 26 May 2026 11:20:23 +0200 (CEST)
X-CSE-ConnectionGUID: t1E1EoNMRT+3VcmAgx+TVA==
X-CSE-MsgGUID: xdTOl4FxT66EleAc/jZ6rA==
IronPort-SDR: 6a1565d8_ODpdtUGkblwI6Yozh9JI5leJtQ6D2k5chDL+p5bEsKx7rqX
 gbPMuB+mluHpTzUoN1TEd6fjH+BiL3wKDhDwLYA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FZBAAtZRVqgA4P49RaHgEBCxIMhFGBCF40BAtJCIRQj?=
 =?us-ascii?q?1OCIQOEO48RjEwCDwEDAQ1KBAECBAEBAQIDAYR/Ao0zAh4HAQQ0EwECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABATsHDgoxhk8NgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?kdEAQEBAgEjHQEBESYBDwsaAhgOAgJWBhUBAYJ+AYIiAQYQAQMPJwcNBq9lg?=
 =?us-ascii?q?TKBAYIMAQEGgUYFDUHYTR8sIlqBZwMGFYEKLoVxgmgBinEnD4FVRIE8glIxP?=
 =?us-ascii?q?oJhAQOBXoNbgmmCJoEMjmFSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BIyEdF?=
 =?us-ascii?q?xUeWBsHBRIhKm5KLhoDAw0hNVlAOAoBRgWBZAKCGk4jLwNOgS2BbwIBC209N?=
 =?us-ascii?q?wkLGwQ9iz0aD4JHSyE4gV4nxnc0B4I4gWeBZAyKL5U/BhMvl1IOkwqZBY4Jl?=
 =?us-ascii?q?TOGBIF/I4FcMxokgzZQAxkPjiEMFoQTgQvMfkUyAgkyAgcCBw4DC4VEAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 hFOzb6qdOwu
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:2SMZja2O3MEh3dHL29WWiQqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AmG7W1GoVotS/eIsxvFq8xMfmUdx8XyTwy1H1GXP?=
 =?us-ascii?q?7UlhiTZSaWRysxooxxg=3D=3D?=
X-Talos-MUID: 9a23:l53LVwmlFYwuFpxVypCNdnpyOPtP5/iAGHxTz7gCtuCPci5CZS202WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="147568848"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHLKi3OKmYUhRiH4yEpIkRaLxwf0ZVFFGq7eh?=
 =?us-ascii?q?Jbt1LNJ03F3nbOE25UZs23cqmo93R23xP5Xes+AS5GsZi8xayzOK+vHG?=
 =?us-ascii?q?qC5WipCNl3jsqjMcRF2UE/c+WvqQ/IDjzzY4KOybg6H4tlr6I5KxtwdF?=
 =?us-ascii?q?Ln0QoZmWWX24CDkrm0pbsdsQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 11:20:23 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrLL-1wfECk1ciR-00Qy5B; Tue, 26
 May 2026 11:20:21 +0200
Message-ID: <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de>
Date: Tue, 26 May 2026 11:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pierrick Philippe <pierrick.philippe@irisa.fr>
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
 <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
 <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ded4IVI4i6y6zC/+ccygZ2xOO0+WOPON55jeLfxgiscrFzfIFQ9
 U+nW8d2UAkJKVEOOUJkuFr9082uA32Bsnjyh0IZOjW6IHjujLrMpesw99Eud9kXThsl0+qC
 K4zTUtv0Pf+9ZkAAJVpCPFbdeKN1I2pMN4v1H2zUz7aCPYG5ioVtWl4PM5SCha9xkk8jmzF
 a4O2RR+RdxH7Eewios3ug==
UI-OutboundReport: notjunk:1;M01:P0:Kq1tL2yd3Qs=;Q5GGgzSO/hyOg0hpITA9JCqhJzv
 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
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3524
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/M5PGHyboZ__ohjB49sK98A>

>> Also, Coccinelle requires you specify a complete term, not just the
>> subpart of the term that is convenient for you.
>=20
> I think I understand, also I do have a question regarding the `declarati=
on` keyword of the grammar.
> Is there any way to access inner information of the declaration?

The programming interfaces can eventually be adjusted.

The semantic patch language supports also kinds of metavariables which ref=
er to compound data.
It would occasionally be nice if subitems would be directly accessible.

But it is possible to express desirable information requirements by the me=
ans of SmPL conjunctions.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/1bff7651118fc65c269dd=
8dba7f7d4a30fbc72c7/docs/manual/cocci_syntax.tex#L1050-1054

SmPL conjunctions trigger the need to indicate data constraints in a repea=
ted way.


>> This again fails because you have only specified part of the memcmp
>> statement.  If you want to put a complete statement, you have to put th=
e
>> whole thing.  I think you can also just put a memcmp call, without the
>> semicolon.
>=20
> It worked with the whole `memcmp` call statement indeed, I probably misu=
nderstood the `...` operator then.
Did you interpret SmPL ellipses as code placeholders?

Regards,
Markus
