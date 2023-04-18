Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B59C77B75
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nvAK+knk2I4kKrbm3+ZmJq6cCMp2W8MjaXkGddfbCqo=;
  b=mKJWHQB9A567Bw+zJxlUCglwfKONJWP/m/60zeGovueVfDLC7aAiLFXM
   LLaREMtwX8EkWCmSSrYBeCKSUFzQEcezkwyPlmywL9tXnlX+3jRFARKhz
   y0l269O1BEkECmHRhK1H1ovgQsSmFmcEOsNWjYGY+m1rc8z3vqlxNatU8
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="103677383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 19:42:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09085E033A; Tue, 18 Apr 2023 19:42:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CC3D7E00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 19:42:24 +0200 (CEST)
IronPort-SDR: 643ed680_IaEVXGKLtaZgOI79GNaQ8ftFPmennYQ7beSfNayHB+BtJIt
 XmOLo/F/TNQFdsL3FrxfbczAX4YABOEAxEmAmqQ==
X-IPAS-Result: =?us-ascii?q?A0EjAAC71T5khwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHYhoMYQwhy6HPohqgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICRz4DAyMdAQERJgEPHwYCJgICVwYBDAgBAYJ6gigBAzEHrC+BMoEBg?=
 =?us-ascii?q?ggBAQaCY5koHywiVIFeCYEULQGNEIM2eicPgVVEgTyDQoQLhBSCZ5ppgTR2g?=
 =?us-ascii?q?SAOgTyBBAIJAhFrgRAIaoF5QAINZAsOcYFJY0yBewQCFEQOGAYOJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj01BgMLHwZWawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPLEQMQjczE?=
 =?us-ascii?q?wZcASkLDhEDToFHBIELfAoGASYknzABAYENxjQ0B4IrgVaBWQyfDQYTL4NqE?=
 =?us-ascii?q?5MMDgaSJZd3IIIuoDCFIYFjOoFcMxokgzZPAxkPjiAZhAyPSD80PQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 JdcEteztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:dGdl9aNZI31x58BcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AfEJ7Mmq5PEXWJwqZK1cWBGXmUforcFLyy0voGRK?=
 =?us-ascii?q?xBnxpdJuwEm6u4ooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A0cafcg8Soo83BMckwBXSi0CQf+VpzL6ANmAmqJE?=
 =?us-ascii?q?hnciYMgx+JjnNvR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="103677376"
X-MGA-submission: =?us-ascii?q?MDEUgVKGAqQ31huhkgQRrYSciIA5bg4hJY43cP?=
 =?us-ascii?q?kiKFX13Npc3Wz+uqN55hGtOqTVzhaQAMa+cnHH2TOn8q2GB2l0ZWdAKp?=
 =?us-ascii?q?UAPDbEPVx6S9tJEP984bPorNOrP28UgxwR23xY9iaB5fKb52vY0xUYZ8?=
 =?us-ascii?q?JV0PsoqUHtCOVejVdzgScypA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:42:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681839743; i=markus.elfring@web.de;
	bh=/WnzS0tH/ObLFPZjeNjXCUCSNkf4UBRJ0fxEJwKUH1g=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=IWOGONWYIUR+dv06Upkawl+6A1vDv2Qcw/nyt9cx6dZLi1cAnoOS3lGeYyJghmzLW
	 1fhgAj63v3xgA0hyYA9yvJh/1OzZgpRmhsZPd1V/KdJA+i8KmAYRsajj5ATTNqpIkP
	 1JndXIk8dN3urQQY3OBvfJAvaMtc5AJNUdGJXw/iUaz4ccxy2jLC6CnHq6vHcId+j1
	 JV9suaJG07XZvxr8qa0cAIZFXm36Ol7OEL0M/c0aaBGO2oByW+Pznq0b7Ue+wmqmv0
	 nGyUZAU1hihp57J6zXxjJdjtrHYt83Lxfn0mFzLRaQ3n8kOwMhzf3N3dotYAbvK172
	 Y3//jlhOiaoYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9vU-1pqQoH2QLC-00XtZH; Tue, 18
 Apr 2023 19:42:23 +0200
Message-ID: <6ba017ab-2d9d-623d-9b55-917d89bc7708@web.de>
Date: Tue, 18 Apr 2023 19:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <aa9d02cd-6178-036d-a785-c8d886dccacd@web.de>
In-Reply-To: <aa9d02cd-6178-036d-a785-c8d886dccacd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYluLEW5GFOWmJ1lRU+q0vnFSe50aajr3Y5RWqW2mjji1ASHHF+
 aQf9mdmLC/wDQ85UdCqQx8aBrWcOLuBOTtCYyOWkVkNlM30SoucdghnaQGQuyBjj0jPgiUq
 g724tfvHCsKqFZDLZHwSdg0MqxgLsH6oH3oyndpyzmP9rRYy8JzC3/p465ht2tfmUExGwFT
 yfJScf4+G0SoOiemvMZRA==
UI-OutboundReport: notjunk:1;M01:P0:lWFPYwmMmHE=;7Uv1tbgId9Z99lqFH4GnnhEF/oa
 W7uX71fUhIb88N2Ty6Msa0v4zpIYiZpS+ZzH9IqNRWsr9lH/xqRqL31uvx5I6i66+YnSBM7yV
 UyPeub5zLOdz8Y89JNptPm3qViQNgjNyWdulbTxn2xFLP43nu9CYccg60DmNdFzdWhIBkhwJU
 cM+GOD0UiEoDR8KXMS516tV+WiGI4OkCQ8rM4mehXE+QPXspm0CTGwaKNA5d7Of6FbhVpE76Q
 gheHz9gPsE8gQEKk7osQsM7AnVdmq54zROXrS07lnXoWwSr0al4LnPbD68pYRTga2+mQ18v/h
 CeNzNYQP0oJrHER3zjrVeHMB5VdLg+rVzAOdDpREiXUPYYZzyfeqDJTc6oi0rfg/gF6vF+au9
 K51bgKICvpG5WgxL1iQMqGKmfs92v8jFJFSqurDOrvwvzBXx2jw0tQ35KGce6f5aSwTNd78qS
 UR8xxkIUrfo9oNloOLCJi5lLCTjj5RRoUIV/AAkwJBM6AV2dtcVjzYGwwnELIobwdyK879ye6
 BndlfBeAIANYUW5ZjQ/xzfw+s4JpphyAE7lRWzFCdnxoMuYJJqrGN3OZ+GNct9DMJwzNCDllT
 f5aORsBlYdUKO5D6Ba8R7BihkrXyo3nYEBR0f7oprsY/XhQpefK/JNtbAnVIaPPhj3MX55qJ1
 lgAuDMtOUYDYPRKZ+zzLbrrFSC67d4SKqV6kE1aMc1AD+RP0eVMGsT+Qpw+y+ptPZY82wbARa
 zQuhT7VfNWeKZNQJ7TBzDJIIsJLPZXAZfcKT7tsT9NidQRHQb8aHzf71HLcPDG8lxtUnFIdVh
 X9U3d0UXg6fiKwrRXYSKjjgW7pfaKpTJ9cgXSUZwzX6Ryucfyt871QmUzUwwi51F9cS653ixr
 z/ScoIAwKh2mKx088NkALWhMzPxQWRcyELCwxorsso2Ex5SivK02ZsxD1
Subject: [cocci] [PATCH v2 0/4] media: adv7604: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1088
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/6ba017ab-2d9d-623d-9b55-917d89bc7708%40web.de>

Date: Tue, 18 Apr 2023 19:32:19 +0200

The deletion of an if statement was requested by Hans Verkuil.
This update triggered further change possibilities.

Markus Elfring (4):
  Delete a null pointer check
  Move a variable assignment behind condition checks
  Improve three size determinations
  Reduce scope for the variable =E2=80=9Cinfo=E2=80=9D

 drivers/media/i2c/adv7604.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

=2D-
2.40.0

