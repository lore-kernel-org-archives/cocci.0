Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9ECC87FCB
	for <cocci@archiver.kernel.org>; Fri,  1 Aug 2025 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=omi3eZeOvrkxG2b04CqORoVWXW84NfAaOhzD9dfErgU=;
  b=KAnsuJtOd9gxi7SQKcA467LmogVj7rT+CeNQiwnU13k04bqPLV9vseMq
   nBMy3CFnbhwkhoPM/GwGcKlDqswbV/BJBS0PQ8ygVWNS6BhfHRVj0JSAj
   q9nrspe80yvW/VJJbyD3k+NNh8ZujiLLxJHn0NzdBzkKudTyqWaKatF3E
   w=;
X-CSE-ConnectionGUID: 2T2hbLrhQNWrEKhRo8gH/g==
X-CSE-MsgGUID: tYjmcxnxQNGSXW1pqjYHyA==
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
X-IronPort-AV: E=Sophos;i="6.17,255,1747692000"; 
   d="scan'208";a="233844519"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2025 10:34:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8B2BE0BE9; Fri,  1 Aug 2025 10:34:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B15F1E0171
	for <cocci@sympa.inria.fr>; Fri,  1 Aug 2025 10:33:54 +0200 (CEST)
X-CSE-ConnectionGUID: ZRqqRf+rQS28I0MBaqMobQ==
X-CSE-MsgGUID: KESqlWVWTZa+GMcTwzQtaQ==
IronPort-SDR: 688c7bf2_zdo3fyNy0sYfdwiTY2XZz/3pVxRPD4Ign+5QHDRsyaJCfEP
 P/tPLZ10VT1kZgX9mEAvMO/8RdPQMmmg/IMfPAA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HkAADCeoxogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAQGCQoEABlQzBAtJhFWPUIIhA4Q7jxGIeYFVgUAWJwIPAQMBDUQKA?=
 =?us-ascii?q?QIEAQEDBIUAAowbAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGFew1JARABggcBgSReSAEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARQCDQczJAEBHgEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn4Bg?=
 =?us-ascii?q?iEBBhABAw4kBw0GsEuBMoEBggwBAQbaXh8sIlmBZAMGgRsuAYVsgmQBhieDQ?=
 =?us-ascii?q?nonD4FVRIE8C4J4PoJhA4Ffg1uCaYImgRaDY40FiG5SeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDAyo0MSNLBS0dgSd9gw2BDoQoK0+CInWBeUEZP4NTHgZtDwaBFRoeLQICA?=
 =?us-ascii?q?gUCQ0WBYBYHBhhAAgELbT03CQsbBj2TUoMhCHonFgJUJ32XFq5igQo0B4I4g?=
 =?us-ascii?q?WeBZAyKLpU+BhMvl1IOBpMFmQYijWaTRoFuhgWBbwcsgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQzN4QpuUdBNQI6AgcLAQEDCYVGAQGHVIQvgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:duP2RKxbq9ZmD/ZUHPc0KrPwvr1zdoMgy1knxilNYDZ7Wendv8
 2ih/gAz3bP+VAscVsOsvXFF6WNTHjV/5wwwaR5B8beYOCGghrXEGgG1+HfKlLbdxEWidQtsp
 uIH5IOdOEYJ2IUsS+C2njbLz94+qj+zEnKv4rjJhVWIz2CApsIh2xE4mzyKDwNeOAsP+tHKH
 Pz3Lsjm9PuQwVtUu2LQlMBX+TFurTw9a7OUFotGwQ77g2DllqTiIISayLovSs2Yndqybcm8W
 /K+jaJgpmLgrW2zhfd0gbonu1rpOc=
X-Talos-CUID: 9a23:gahEQmGLCb19ef2dqmJVzlcNIM5maETmlifxe2qSAH9MT7esHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3As7yPRQxqNavCRwiI/OnDAHZaMw6aqIeDM1kJrqs?=
 =?us-ascii?q?5h/uNdgNVMAuCng2rS7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,255,1747692000"; 
   d="scan'208";a="122595078"
X-MGA-submission: =?us-ascii?q?MDEJvSCiXOzHXWJTrKQRS9GqrMoo2esFZRur1W?=
 =?us-ascii?q?NiMDLAHLCJV31gtgFFQ9r9crw5NQoGOzLKvTbtcxJqA9K7SQYa3Y+jn6?=
 =?us-ascii?q?No1WO2UXdJLULwZfhld7x2E3U/ynncghqXOSYFlbLne9dOjX72oiHai0?=
 =?us-ascii?q?vW3m0lOuSOhrsspatEnwMC5w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:33:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754037232; x=1754642032; i=markus.elfring@web.de;
	bh=omi3eZeOvrkxG2b04CqORoVWXW84NfAaOhzD9dfErgU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Obq2yT1gMSRTU28Oj/pQXLdyBZEZbMQZ2AAzD9e4m2KbTX66N28GwMuhfRaTjECF
	 VwIoN660XQTjzbSL8yIDsqcdTw5knSNqHYxUMtXhZOBL2Clmd7a68tlVPdffJSLUp
	 XiOgw2/iVWBvSGQ3yrtbzmXLZI0opR/kStVWCk+JH2F8n0joRf5jTddrmuiCJpQz6
	 DwQuhRl40EPwYtAFZJiH30HG1kfbpOCU/YLm+EJyZ4b56TLJrGv9gQbI8iU5KeDkR
	 FBtV5afvFuHxiJt0neGbjDSQGOdaZuh8IjsPZzMVsPD8UQdP55FH1fEbgFcnGFEI4
	 Qu0XukYPPSsnR67W3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1uaLZ43WdZ-00sqwB; Fri, 01
 Aug 2025 10:33:51 +0200
Message-ID: <5b6b8953-f85d-4413-bd0e-33fab81dadbd@web.de>
Date: Fri, 1 Aug 2025 10:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CMlN6OMQMXkmOlWo6AjjLF3LxIyypR7f8Qq4k04mQTMQFNRp5rh
 i67s1QwoqXE+aZ6eAmaRxs5tqymYsaXWTHN6lo3h/j5e1APd5cJ7r54fg0s/Ic0t3OD4Lsa
 kU2FxYoJ70nhhHZYueE0IIX1SMHcwYEmLPXkY7y3IcaqA5GRo0zssxAbE06nqPWBDyvRJlR
 ApeNl1gmEuAV0zfmMMOiw==
UI-OutboundReport: notjunk:1;M01:P0:T8JaFWg0H+0=;buEPI6rkPruFTvU1Mb/ZnZmWIll
 +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
 QJUJwylHxEmgk+5zK71H+DU=
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2924
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/5b6b8953-f85d-4413-bd0e-33fab81dadbd%40web.de>

>> Would you get further development ideas if the source code search appro=
ach
>> (like the following for example) would be more general?
>>
>>
>> @display@
>> expression allocate, release, x, y;
>> @@
>> *allocate(x);
>>  ... when forall
>> *allocate(y);
>>  <+...
>> *release(x);
>>  ...
>> *release(y);
>>  ...+>
>=20
> What is the goal of using <+... ...+> ?  The only way you should have
> multiple releases is if there is a double lock error.

Really?

Would we become more concerned about any use-after-free here?
https://cwe.mitre.org/data/definitions/416.html
https://wiki.sei.cmu.edu/confluence/spaces/c/pages/87152153/MEM30-C.+Do+no=
t+access+freed+memory


>                                                        If you want to
> search for double lock errors why do it only in the case where there are
> two locks involved?

The relative order of the searched release operations can be clarified bet=
ter,
can't it?


> If you want to check for lock(a) lock(b) unlock(a) unlock(b), there is n=
o
> need for <+... ...+>.  Furthermore, you need to check that there is no
> unlock of a between the lock(a) and lock(b), likewise no unlock(b) betwe=
en
> lock(b) and unlock (a).

The source code search approach is obviously improvable in various ways.

Regards,
Markus
