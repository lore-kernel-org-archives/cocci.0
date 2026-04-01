Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5115ED35162
	for <cocci@archiver.kernel.org>; Wed,  1 Apr 2026 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qzI0fRe+Z2Qc6gcA7EieghbqdeuA+93ItHFe4XWydrM=;
  b=vvUhnRbKzwSC4WiaSb/mkGkMDsN2x+LLIxF+tjRs5MAmsVAXByHhVvpa
   wE7QsSYkDEj2eLWj+X9Vra6pX22n/A96ygCrFEllkmoNpLe1BqeTc8tGl
   A+01pNpSSl62oJBNgPwiDMNIr2/nWpK2PplqxyLDJuGWcZc/swMZVWE8U
   M=;
X-CSE-ConnectionGUID: Rh319998R92zDkzhiEOWcQ==
X-CSE-MsgGUID: b8rK8nmhShqFa2z+/+UvJQ==
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
X-IronPort-AV: E=Sophos;i="6.23,153,1770591600"; 
   d="scan'208";a="270526952"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2026 13:26:04 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 992EE81F88; Wed,  1 Apr 2026 13:26:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7724B81F88
	for <cocci@sympa.inria.fr>; Wed,  1 Apr 2026 13:26:01 +0200 (CEST)
X-CSE-ConnectionGUID: ZrqH/bRiT5OK5hcNTz6gkg==
X-CSE-MsgGUID: FOp4GRD5Ts289tynbf3/3Q==
IronPort-SDR: 69cd00c9_YavWi9hhtjXb+SHII8PNkIgrKDWBkVSOkzcXeEJ6CqZzoXz
 BFePoQ60se5vPdJ4OtCpTwfjB2xMqdGqpnIylZA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GeGgCt/8xpgA4P49RaHgEBCxIMgWsngVYCZ4FlNAQLS?=
 =?us-ascii?q?YRYiB6HNYIkhDuHPIdViHmBVoF8Ag8BAwENFAE5AQIEAQEDBIIMgnQCjSYCH?=
 =?us-ascii?q?gcBBDgCDQECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?TsHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLC?=
 =?us-ascii?q?xoCGA4CAlYGARQBAYJ+giMBBhABAw8nB7VagTKBAYIMAQEG2mQfLCJZgWcJg?=
 =?us-ascii?q?R8sAwGFb4JmAYYxhD8nD4FVRIE8glIxPoRDg1uCaYImgQ6QbFJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBI0MDKi8tIw88BS0dgSMhHRcVH1gbBwUSISpuhVp2Ll4aDiICOVxKP?=
 =?us-ascii?q?goBUgWCBQKBIEUCAQttPTcJCxsEPYxhKYIuyjs0B4I4gWeBZAyfbQYTL4Nxk?=
 =?us-ascii?q?2EOkwuZBiKpH4IWDIFcMxokgzZPAxkPjiGEM8QYRDI9AgcCBw0DC4VEAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Rfv+eKgodKc9FDnmR5yCtuPyJnBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3A7Suwd2qxihoDpB2VyV1ILdTmUfI/a12axk3RHxK?=
 =?us-ascii?q?fKjtpQ5upWwGf+6wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A5v48kwxyMAWltqrUpdAJX5FW/ZyaqIqJEBwiq7l?=
 =?us-ascii?q?bh9LeZX1sKjGXgm/wGbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,153,1770591600"; 
   d="scan'208";a="142943501"
X-MGA-submission: =?us-ascii?q?MDEBJOB2489ZGZsn0JYIUj5MkJ4aRbbIWHjGk4?=
 =?us-ascii?q?89ngEXi3sIWdt9ZkrTIXKeWEOR2aF+fTq6M5jpR+ccKUQiiCocqMkRz5?=
 =?us-ascii?q?Bt7t9TsQZ+D1k3dCBqGDxAd2VtrlNUNN5HubSjCVfS51zkAjh3avqcOc?=
 =?us-ascii?q?dCuLtnavn3HweC3cwmbRDmoA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:26:01 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJTC-1vFfQb3h50-00spEd; Wed, 01
 Apr 2026 13:25:59 +0200
Message-ID: <3fb716ce-70c4-42f5-889c-5ccbfcc020e6@web.de>
Date: Wed, 1 Apr 2026 13:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <51b9e38a-7e91-4c39-86d1-25da2c6af376@web.de>
 <5c3257fb-1e91-46c0-ab00-f105ccb437d4@web.de>
 <b3686b73-09a8-4b10-b860-5a49b9462b11@web.de>
 <628489f5-4d5a-b1c5-fcbc-278648b52462@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <628489f5-4d5a-b1c5-fcbc-278648b52462@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GZgo3+45pyczmyT1GKfEQmCVILs0EoLv8lkQm/6AXK1XU4rCcbo
 E5yBGlFbl60xmumj0ndk4CGMMOmtnArdAeAYXiNcJ1l5yDYCQtpbQlGSmJb20WvoQU1Id8e
 L2STm+n3q8bs/5NLeIkRnbMmoHXzRIro+YTEFfmIFYF7rqGohLV/UXJONtIK276X+tB3tQN
 c5I+2rAeBdZQVLcwJv06A==
UI-OutboundReport: notjunk:1;M01:P0:MFz/e5C9FNo=;9jmNjiblXeWUO5M/0sjLabeh81Z
 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
Subject: Re: [cocci] Logical consequences for applications of SmPL
 conjunctions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3471
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/rwustWFbio8ImZs-ohma3Q>

>> @duplicate_metavariable_type@
>> identifier x, y;
>> @@
>> (x
>> &y
>> )
>=20
> Certainly it does not seem very useful.

I hope that presented clarification approaches will evolve in more desirab=
le directions.

* Can the Coccinelle software help any more to point similarly questionabl=
e SmPL code out?

* Would you find logical consequences apparent then?


>                                          But maybe there is some need to
> have two names for the same thing.

This is obviously the case for other source code search variations.
Identifier selection would become more interesting accordingly,
wouldn't  it?

Regards,
Markus
