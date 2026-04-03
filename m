Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4C7D730B7
	for <cocci@archiver.kernel.org>; Fri,  3 Apr 2026 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=93gqg98aikkWCGSLrhasmh503AY9E10XBKac6XvWi0I=;
  b=VpUS3TYyZ6AJEuf4ctGN2dRvoZCCBtPQw3U1FSuUT9R+qTZn1ltMVwIs
   27gU9IZSNAaDdbjEomLgOaHuj741SEs9cvIRH58FObT+vwRuf38cbQbmW
   hoRjfZ+I5bTX5jmw5qd0h2HvvvMkf40WmvOm7AmX930tyRwxAAkOPYL13
   Q=;
X-CSE-ConnectionGUID: ikv2OD7BS7ayKwD5rm59cA==
X-CSE-MsgGUID: aQZt5v10Q5+mBvj00GJB/Q==
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
X-IronPort-AV: E=Sophos;i="6.23,157,1770591600"; 
   d="scan'208";a="270875339"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2026 10:00:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8D03B81ED6; Fri,  3 Apr 2026 10:00:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 602408052B
	for <cocci@sympa.inria.fr>; Fri,  3 Apr 2026 10:00:38 +0200 (CEST)
X-CSE-ConnectionGUID: +lRgzLgySwO8IzkwYggF+w==
X-CSE-MsgGUID: VOypH267SQKhGqym8DMyVw==
IronPort-SDR: 69cf73a5_rPVrWOAqytdb0sZjSeV83sZW4pSCsC2WvymViwFjaMJc5u+
 3sCneeZjgxsU4ZcuEQB8OHPcSBaFJhOB/826Vog==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GHDgBncs9pgwsR49RagluBVgJngQdeNAQLSYRYiB6HN?=
 =?us-ascii?q?YIkhDuPEYpPgT89Ag8BAwENFAEBJxEBAgQBAQMEggyCagoCjSsCHgcBBDgCD?=
 =?us-ascii?q?QECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQECBAYBAhABAQE6Bw47h?=
 =?us-ascii?q?k8NgluBLGUJOAEBAQEBAQEBAQEBAQEBAQEBAQEWAj0KRAEBAQIBIx0BAREnB?=
 =?us-ascii?q?AsLGgIYDgICVhsBAYJ+AYIiAQYQAQMPJwcNtDaBMoEBggwBAQaCadd7HywiW?=
 =?us-ascii?q?YFnAwaBHywDAYVvgmYBinAnD4FVRIE8glIxPoJhAgIBgiqDDoJpgiaBDohKi?=
 =?us-ascii?q?AlSeBwDWSwBVRMXCwcFgSNDA4EGIw88BS0dgSMhHRcVH1gbBwUSISpuhRh2L?=
 =?us-ascii?q?l4aDiICOVxKPgoBUgWCBAKBH18CAQttPTcJCxsEPYxDKIIvgUGCaJJpkWShR?=
 =?us-ascii?q?TQHgjiBZ4FkDIoulT8GEy+DcZNhDpMLHphojgmbOIIWDIFcMxokgzZPAxkPj?=
 =?us-ascii?q?jqEGoRgvx9EMj0CBwIHDQMLhUQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:Pxw4RKzR084H2CLJaNW4KrPwIb1zdoMgy1knxilNoG9uA66lfq
 GV9sjzuiWZtN98YgBEpTnEAtjmfZq+z/FICOsqUItKjDOW3FdARbsKheDfKn/bak7DH4VmtJ
 uIHZIfNDS9NzZHsfo=
X-Talos-CUID: 9a23:2eQdOm3dwdfBugDsaMvrQ7xfWcQffW/5w2brPGjoKHRqV4yaRnHT5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AE4104Q9lzGjLMphCrS7BzlWQf/lP8ryOUh5Sqqw?=
 =?us-ascii?q?lu+adJCkgFxKMsiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,157,1770591600"; 
   d="scan'208";a="143152897"
X-MGA-submission: =?us-ascii?q?MDESDomJXc9gj3B4d1JgNK7WYmQV3RvI6T+CQs?=
 =?us-ascii?q?GRisB7YxN4Y6K8xsExF2J+o2AvsSVux3Kvsl/QCxqzdtPHm5PfVII6w4?=
 =?us-ascii?q?ABOMeaqc6kQj0hV6crDmBh3sU36gdDSot/xbyrD4sc37zgq8o/7hVcgS?=
 =?us-ascii?q?d0aaYcePyWoEtpC9fefjcvpw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:00:37 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB80-1wDUra36PW-006OFB for
 <cocci@inria.fr>; Fri, 03 Apr 2026 10:00:36 +0200
Message-ID: <c85de6a0-06b6-4d32-95ec-a9962e6a107a@web.de>
Date: Fri, 3 Apr 2026 10:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <815c88e4-44bd-4a9e-b25c-324e953decae@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <815c88e4-44bd-4a9e-b25c-324e953decae@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:colgUGNn6XE1u3Luz7NX4929lrTYgAgIQEtos5O7lqhRlssnh/D
 m44xaiwDTfXnQzgHcGQBz29Flo1Hjc4wN2JRcuJ7UkT3haIC0UTOoisI+Sx8nNtsKmGtCiL
 6fM8D1AKz088jF7+dpF37vRAqoPGx4xZi1lsJ/V/xigjc99Eqrksk6sM+uVH+Z1+rnnIY0I
 uFc5ZAC1wFFbqCIQhZN/Q==
UI-OutboundReport: notjunk:1;M01:P0:vsBgR1yIq14=;GFAA3u1dmgHXrSZ0EU1pUzf3mYM
 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
Subject: Re: [cocci] Evolution for data reuse with generic SmPL metavariable
 types?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3472
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/S1IOQRzghGMF7k1DSz45ag>

> How will development interests evolve to improve programming interfaces accordingly?

I hope that corresponding development resources can also become more interesting.

Another view might be helpful for affected technical details.
There are further case distinctions possible according to the handling of
metavariable types.

* Are they converted to tree queries (by the Coccinelle software)?

* Is it distinguished then how many data processing would be relevant for
  leaf nodes?


https://en.wikipedia.org/wiki/Tree_(abstract_data_type)


Can any confusion be better avoided around variations of query trees?

Regards,
Markus
