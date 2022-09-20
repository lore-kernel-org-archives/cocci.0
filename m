Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57492C6FA92
	for <cocci@archiver.kernel.org>; Tue, 20 Sep 2022 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8yjVbhCLNg3b0UR7y1WiGGNFKS7BNXymKnn0JLd7oDo=;
  b=OV4ETYmYGUaYV8C7XBIUqDbkC03kK+YqIVF3tWimySLLpC0kaZ8fi1cU
   XF+hLPDzxc7Ic3cCaoPojSNlsFCjCVJ/Ad1zjkiW+eieokNvQxnbFy/ZL
   1KUTsXmrTqq/8dJ1WPTrkRkLusB0z/BlOFc7lPjQzxhwYZRHwLvDmUAUj
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,331,1654552800"; 
   d="scan'208";a="53734866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Sep 2022 22:24:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43F3EE019E; Tue, 20 Sep 2022 22:24:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 143C5E019E
	for <cocci@sympa.inria.fr>; Tue, 20 Sep 2022 22:24:35 +0200 (CEST)
IronPort-SDR: 632a2182_MUDUvAehKNTCaC5DU/LEZpnoQDN5gCQBI2iAZfmryACA++h
 hFGfod7EA/GWzzJ3LM1VMJMcAWfTyuCJBZ08ZAA==
X-IPAS-Result: =?us-ascii?q?A0DAAADEICpjhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIjgVcuBAtFhE6VPYcXhySEWodRCwEDAQ0/AQIEAQGFBQKEagIdB?=
 =?us-ascii?q?wEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOB?=
 =?us-ascii?q?QsFIoVoDYI1KQGDZAMDIx0BAREmAQ8LGgImAgJXBgEMCAEBgnmCbQEDMAesS?=
 =?us-ascii?q?4EygQGCCAEBBoROHywiUoFcCYERLAGLfoMueicQgVVEgTyDAz6IGoJmlQSEC?=
 =?us-ascii?q?CYEDgMZKx1BAgELQjQDFQMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hMFAgJNOAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHE?=
 =?us-ascii?q?xgbGQEFMicQCSEcCgQaDQUGEwMgbwUKOw8oMmsrHRsKgQwqKBUDBAQDAgYTA?=
 =?us-ascii?q?wMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMDECI9B?=
 =?us-ascii?q?gMJAwIkE0h3AjcTFQUDDRkmCAU3HgQIPAIFBp5MowOfCDQHghaBQ4FHDJ5LB?=
 =?us-ascii?q?hMug2STAw4GkgkthwkTj0Egp0WBdySBWzMaJIM2TgMZD44gGYQMii0/NDsCB?=
 =?us-ascii?q?gsBAQMJhUcBAYUeAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vPBksK5LDGDLM+JhBQPXwOzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,331,1654552800"; 
   d="scan'208";a="24236183"
X-MGA-submission: =?us-ascii?q?MDE+JBOP3JCB1uygpQUSssIaDx88zD/famf42z?=
 =?us-ascii?q?F8TyYwR2zwSpSs709Y81RCWRGlmIKeAZOvg8eY6F68xHL9FPEhSX5skQ?=
 =?us-ascii?q?Qe2HFWOP9rvDSsc09Ql8hWg35hdrgO5+YoxnYvC5nhgNCuoLLnfRfU2v?=
 =?us-ascii?q?vKd5MRq2ZFUeJa4hWCwtqPeQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 22:24:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663705462; bh=6bHsvqW4632L2Hq74yJ32KAIjeNsPHmhA3Un2SN2AN4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g2B3SadUxyXfsZAJYN+/3NSnr2zCQVf9XhjuWtAltxVxUQVfGMIJJT6N4IZF5Ogap
	 5wqWNgypmnpIaGj8mfB+K0qsnSur377NsspLpELRKgP/NXVSvFVoDDMsTXx5iTj8yo
	 WoUFB4zsNgSf8SLgVprrJwp6TF5wx1w6CdLHgW9iJcr8b0p0S40AGZI46Q5Vqj1eaG
	 CxjMEYhYzM8vFY6LZLiUe/kPirqdannlLxXHO6H3TtaiMPoMaZRDOxnN6n7qWrKcOn
	 tM3mL9GcrDqNS4tZlWu/BP/4MBWprSr/CTVsoT5VTUooog+YQEZ8py85PnZC9nyyN5
	 FkxfvjVhBsOcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1pDP3a1Q9E-00hMs6; Tue, 20
 Sep 2022 22:24:22 +0200
Message-ID: <92f6a7e6-cfbb-ee05-bbdd-dfa4c9abad4f@web.de>
Date: Tue, 20 Sep 2022 22:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Yuan Can <yuancan@huawei.com>
Cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>,
 kernel-janitors@vger.kernel.org
References: <20220920025820.105924-1-yuancan@huawei.com>
 <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
 <alpine.DEB.2.22.394.2209202211430.2740@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2209202211430.2740@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HNIqxWO5u08zGfskqTTn3vj9OBk0NYgEw5nvm/H5oV4F1aLdhOL
 HP7E/Te5GDC50uLm8oksinhRvwPBtnzBsYaM+eHCJMfCbuOcdLdRG5vnwvs+5KNg1PpT02l
 v3SMVoEpCxDpZVJN9SPbDjARuVQqGlE/AYSyviCkODrvLQkdRUySr4K9N1nGpG7KLtSrNy4
 N2/Uof5BlgZpPY9mrY3MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yg0UEm2DtZs=:UGWyBhQ3KqELvT1wgEO6k3
 mOpbQiEAvh/YKEODG+j2uoWhU2PfOxmeefkhJiPXOtD6yC+dqzMTfYqdzjLIxms9U8tI7Wgic
 /ywAy/kQPNBu6CjhxU+xRDGMKORh1+sf9PZh6AxxzrezubkxyAr864Od7vxz2pQObHnln5a79
 0kPdvWZDrSvzM4LE0s8DFCyAyLT/9zlyXPcwjw9NfX/2C4lKCNJAbZQkVNwv9sfH7Ce/wmzfD
 8fBBYq/G7IljBnUGmlgHzcFURlt2QUTS20enV2v3RChEk3KvQcZCchq69K5Zu95JyJ2MMdeR9
 kO+4kUKqdp/nE5vmgCfFrbhVCTu7VoQZEJ+CCh76X/zE9jt9DIRBTIQH4CV8UxLRzebLq3zcu
 Rf9AwoDnuJvLAcUJ6yVFQG41e1ZwdNiCI72XzopTGJ9fnwJy4Iyh9WEkrzZ4JwHvAhGrhuasU
 xjuQ1q/cftzkDWewEWMZoJ7GxMIQcFX61H/vEctqDf9cEOSodp+tn/BxPk9Ks/6/NH0KPH+pt
 fanSTj/y7FIyBYtReCgnCbwkb0YEZIWeFPW+BejraFPBEbknXD8SCWHsi2Vj4lVSOFAJ3+4Qf
 MejlXQS6Xazssd7UoG8eFqhBCGBcq+Mhbt3xg0e9xOhfm9up9DZ9E14wAGtK5pFfYhgDjlP0g
 h4lwZpAYIcavHp4utbUluKBe09UZAW1+uZTOCT2MeWiJB+cSMcKmlFax/EokD6+o/li1JX5ct
 gl6tT0uO07mskUM2phpf6AQysXF7GUCqHW+Vr55DmH1X12POYVrAuEpqU5YBNLIsTyV5FDwy9
 H2LSeioAGHwjCNHjBs/5kcx7Y23FSk7iWkqGf32cVzdyTRcP4Ybf0o/7qhHV8StiA33EDHczX
 pd9LQNq37ZtemkD1fj1tdipEvSDXbCS+lNhu3pfJRlHNiTj5VOsLV6FmVejj8HXbG+fPK80Jg
 CA6Dpe1sf3apJ/YMB8l0wn+ggA1cD1xOBS+UOWUrp9VD1k1q7hf0xyJEbsc3xL9GV87EAWWny
 LF6Jacs5ffKXIQw3xsAyuyZncxgEAYj8KNW+BIfCerqi7ERCftuTQD9wizGlksHwClUaYHQ6g
 pGVSI4BCNeZvWnYk71nfELmKv/RmNkxj8H5Nbz317mXry65lgG4ngySixWN/b5Kf7oIkW1sag
 m6YLYgKAR3FO/Fn7ne7MB7tBZB
Subject: Re: [cocci] [v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 563
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/92f6a7e6-cfbb-ee05-bbdd-dfa4c9abad4f%40web.de>

>>> +@r3@
>>> +identifier s, fld;
>>> +position p != {r2.p};
>>
>> Why do you think that such a SmPL constraint would be required?
>>
>>
>>> +@@
>>> +
>>> +struct s {
>>> +  ...
>>> +  struct mutex fld@p;
>>> +  ...
>>> +};
>>
>> Why would the source code search repetition matter here?
> He is searching for a structure that is different from the ones matched previously.

How many mutexes (or spin locks) should be initialised before further data
processing can be safely performed with corresponding structures?

Regards,
Markus
