Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FA1C433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 19:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6WesJHMBvf8R4P/t4jYoiWxCvmi1Av/N9X5ZDrHxVXU=;
  b=k+XrMLmT+q+c/LA0XuUI/UO0epHvQKWpMIfKiX11GFtaEzscC4VUteru
   vIL4EbcqA0fYSvNYdHkkKSGGR3y7utebGS5M/idJp7h6kYl6dgrjtdZwr
   h1QaEmozjl7JMBzHwfgBRajxEohWDqPwZQmbmVXSNrcVd1hRKwcK0URgS
   I=;
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27310084"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 20:05:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B465E01B9; Mon, 21 Mar 2022 20:05:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B685E0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 20:05:19 +0100 (CET)
IronPort-SDR: ScZ1SI7wdxQ2fZkXBfGFF8iWDJbZLs1P+zB6kTJoNN52sulBBvtGEk29hyN8hnojT8HNHBMm7k
 lnS0c84kOv5kHN2xGOEmER+uwhpWV8LR1esE2omH7vJqY5T7GaAXAN9erg5N9WyUski9xMZsTD
 zwA9LCmqoQ/bqaS1pQdFtLNShHAPCg3RC7ttw69F2Ycep8bd2Pb3b/O8zi77uIeroGPXTXn5DU
 zf/OY4NKDp8h9yRi/ERGfjSRgBKUKJh/XxrnRMahrrh8Pouk29aq4QH6SlO4MRizHhrXPVKGHb
 MG6vhB+axb2FBDJDBQcUMQKP
X-IPAS-Result: =?us-ascii?q?A0DvAgB4yzhihwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCgiZ+VysECywYhFSOc4IohB+OHYoogXsLAQMBDTUJAQIEAQGCEoJ1AoQ8A?=
 =?us-ascii?q?h0HAQQ2BA0BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JB?=
 =?us-ascii?q?QgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEECwsODAImA?=
 =?us-ascii?q?gJXBg0IAQGDAAGCZAEDDSULrVKBMYEBgggBAQaBU0GCNB8sIlKBWwMGgRAsA?=
 =?us-ascii?q?Y5IJxCBVUSBPAyCRzA+gmMBA4R4gmWYdlcCpCueRDQHghKBOoFBDIlClE8GF?=
 =?us-ascii?q?C6DYpJbDgaRbZZbjRWZbYF7B4F0MxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOH?=
 =?us-ascii?q?RmEDIRhhUtANAI2AgYLAQEDCYVHAQGMKQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:8ENX+a6a90p+AsXr8vDUkgxRtBXBchMFZxGqfqrLsTDasY5as4F+v
 mBMDzjVbq6CYTD2ftB1bInno0IE6pTdztRqTlRo+300Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yio+pWFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 McOk626aSojAoDrgLwNQRVjCD1fMLITrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW9LN0nra+GemNpXTsFJj94gMdKtEYcRoHBmwhnGAPxgTZ2rr6DitIYIh2tq3qiiG96PY
 eM8awFMUC7pfh5xY3cqNrMCodyB0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKg0fPcaDyDyI2mCtg+XVlGX6XpgTHfu27JZXbEa7w2sOFFsJWFH9rfTRZlOCt8x3O
 Q8yyyAOgKIO2WuzFsnvUyajvF+JoUtJMzZPKNES5AaIw6vSxg+WAGkYUzJMAODKUudpH1TGM
 XfWxbvU6SxTXK69FCrBre3Ixd+mEXdFdD9YDcMRZVZdu7HeTJcPYgXnYvsL/ESdq9rzBTj6y
 i2QxMTVr+hN0ZdTv0lX1WrHjjOqopHPQksN6AzTTAqYAu5RYYm4e8q35FKd4fsowGelorup7
 Chsdyu2tb5m4XSxeMqlHr9l8FaBua/tDdEkqQQzd6TNDhz0k5JZQahe4StlOGBiOdsedDnib
 Sf74F0Nu88LbSD3PPMqPepd7vjGK4C/RbwJsdiLP7JzjmRZL1HvENxGOBLBgTu3+KTSuftiY
 M3AGSpTMZrqIf06kGTvHrl1PU4Dn25njWLVWZ3hyRm7mbORDEN5up9VWGZimtsRtfveyC2Mq
 4g3H5LTl313DbOiCgGKr997BQ1bdRATWMGtw+QKJ77rClQ+RQkJVaSLqZt/INMNokigvryVl
 p1LchQCmQKXaLyuAVniV02Pn5u0BMch9y1nZXJwVbtqslB6CbuSAG4kX8NfVdEaGCZLlJaYl
 tEJJJeNBOphUDPC92hPZJXxttIwaxmhww6DZnL3bD86dp9mZgrI5t69IlqxrnZTVHLvuJtsu
 aCk2yPaXYEHGVZoAvHWX/TznVm/in4QxbBpVEzSL9gPI0jhqdA4KyH4gvItDdsLLBHPmmmT2
 wqMX0UHqOOLr4JsqIvFgqWNroGIFepiHxMGTjeBsuvsbXHXpzPxz5VBXeCEeSHmeFn1oKjyN
 /9Iy/zcMeEcmAgYuYRLE4FtkfA06ezpquII1Q9jBnjKMw+mB748cHmL2c5D6v9EyrND4FLkX
 0WS5p9FNL/PNM68SAwdIw8sb+Ki0/AIm2COvKpvfxigvHd6rOidTEFfHxiQkygDfrF7B4MSx
 7tzssAh7QHi2AEhNcyLj3wP+mnQfGYMVb4r6sMTDIPx01N5z1ZffdrDByWw7JzWM4dANUwjI
 zm1gqvehu0AlxSYLCdpTSDAjbhHmJADmBFW11tcdV6HrdrygKNl1hNm9zlqHB9eyQ9K0r4oN
 2VmX6GvyX5iI9u1aAl/s2GQ98VpARqE5gruxlFPmGCxo4xEkIDSBDVVBApP1BlxH6Fgkvxz4
 7ySjmroOdovVN+kxTM8ACaJtNS6JeGcNWT+dASPAMmPWZU3CdYgbmlCekJQwyba7QgNaIEra
 AWkECucqUE2CMLIn5AGNg==
IronPort-HdrOrdr: A9a23:TH0NuaFthmKyUbxspLqEzMeALOsnbusQ8zAXPo5KOHtom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h0AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="9183420"
X-MGA-submission: =?us-ascii?q?MDH5FXlXOMi3daOSwJK6mYLV7fXdggBcvSTv2I?=
 =?us-ascii?q?JsSniiy0gGmi85TkdF7wAEwqxf/cF56aqPoTHpnPwU/rwv+t2vdQum6o?=
 =?us-ascii?q?xig+r/7eMqqL8F1jxrIxBoHz8dWymyXA3/RStSXPst8k0UYn1PMqS6U6?=
 =?us-ascii?q?lMSaS7oo91s4x8Uwsv6J9nDg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 20:05:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647889517;
	bh=6WesJHMBvf8R4P/t4jYoiWxCvmi1Av/N9X5ZDrHxVXU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=ahzaAmeOMqpi5/7Fj6uSy4GZgbiPtiZ3FyaNRhc02i898I1NcM66aH1cuslwX6PzJ
	 Nh2FkKvmDC7HXMFGrQjlL0cHJGLY2K1Xsc1iJLxI/Hy86WthmzWgpexM1HwGqIa7B8
	 tpKdaoKVElHCeGgPiPnt60iRgy/Zp0IBLZer9rPs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.154.81]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR0J-1oOL0K2MEP-00sO9Z; Mon, 21
 Mar 2022 20:05:17 +0100
Message-ID: <82e3a75b-3749-e07f-0cd3-578624883f1b@web.de>
Date: Mon, 21 Mar 2022 20:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <ac59aaae-6e1d-a5e6-e568-2049dc961f93@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Thierry Martinez <Thierry.Martinez@inria.fr>
In-Reply-To: <ac59aaae-6e1d-a5e6-e568-2049dc961f93@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EfcXEW7O70ROX0WVhgFZG6lk3RQii8K48/tTim4UOrV4TN2mQiN
 DuNzAiFvGH7QcwQX9WijaTX2NhOzc3fMlvwcIvWfEpaBG/SLmclKbAGFBBBevwp7983kQip
 REVuHNiUQuCHRp2zZFwldNffRY9T4tn50HuMLSJ8kaIeI66zBevqW6PsruJktkJ8e8hT21x
 3qsqFzaNZ9E/mM16cfzKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QKZzLzS/qjQ=:NKTibRbcAlk43KK5gfiWB2
 tPc9YtWoizrMXPWcN0LO1zCC5vcxL+0ItuDcww5UT/AacxI5t6PP/zwtdHNW4trKwtDLcz9XR
 yBSfzi2s9znbyix9poenrrSgqrJ2syFbtmPQhir5d8zwrJyXwbDJJIr2zu4T/mzkAIapXnxqW
 Oawj1yxdLREgcyeeNXm5jwVnetuW7Psbx3pjqnnPNod1mOdKSUNoqnwjtc+TgKVk9tKlNQghD
 +Y3M2EHbsPVbnaG79b1zQ9qn1fFGngyo9zOdyuhOj0Me3Pm+P4f4sMzTmlMMV5d6kbgkkGyYY
 7IycjzgzKEDQS5qol0oE4OqSgy05mKYc9KSqPw76hyqiys6nqNiTN5lWgbO1CgO8ma0TD7lQS
 qstoDeUPzUtM0ToeW219cflvGtCcBhjTP0MSMR+t3WkNVf+c05urG+zqsfede9ASgAuU/m8rp
 O1ynqw/X7pLdaDbxo9h6qn9IZM90HjSclzzt5ZUaKVkZOA7OX7YLt4Sh9C9OcQt5ryosi9A8L
 PQacFuIERWBezmywiNX2fF/Xn8y3JLCPovzPXnrIZXwsfRBKXTsCgecQGbYSIiN50a4rLPXxQ
 kocv2qlX/pSteHK/V+A6NztYU3RL/lWKXzNI+aAS8E5pWHZCpoMZIthSNLyZTVAXGM0fI090i
 tDgHoUZ9kBAuBQ5LvEowvwKipmZvRIyoC0NiY3Q4C5QkaeEQEPw8mZukUb0NCWZJ9zqAXPrtd
 PjovWnr2LjCpOplI4HeL0/CFdpbvk0tFrPeffHlC5op5YXIGDy0zRPGTp/YXsNX5cmhBmal0G
 75UjqtDHLD3KXAt93eVKJHPoFzmP69tn1HChExMmCiWwi8bVYjmwexVIVxj4tZRJPzV2H3c6N
 RqU1fdulZB5QVDB5CqkzTsNWo9NOnOQVTQuPsT4rZZkhvfb9gejiE/H0B+eks9it5vyol/s0q
 BH3OYuL84IVt7+v0hwqhSUFWdWCxYrMbpKz9nFB+DnT0Eo9vXklGqrtm/YE7Pyzzot3EGXpmJ
 HW6mNwFSZJP4BVgdenIyer2N9MCI7+5+YJhsf6n6L6tgVjYtkThx4KAecL5dJw0MDs0mfP2nU
 0tqfG4gPJKCOEk=
Subject: Re: [cocci] How does Coccinelle call a script language from OCaml?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 279
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/82e3a75b-3749-e07f-0cd3-578624883f1b%40web.de>

> I'm curious how easy it would be to add Perl,


Corresponding development efforts depend on the level of system integration
that you would like to achieve.



> since that is my most comfortable scripting language.


Two scripting languages are directly supported by the Coccinelle software.

Various other programs can additionally be called according to your data processing needs,
can't they?
https://ocaml.org/api/Sys.html#VALcommand
https://docs.python.org/3/library/subprocess.html#popen-constructor

Regards,
Markus
