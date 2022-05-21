Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CCDC433F5
	for <cocci@archiver.kernel.org>; Sat, 21 May 2022 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9VzJObCQmhR7N0U7K5aY1xjcpeKpAeHiRbn14OAc0Xg=;
  b=ScgvFFag7THUkq3WLyiYJT58FX3lLK8PMxTLqFJjka5nfrsvtPtLX2wo
   0Nj0zk0LanDBlelH4Hj3SzzDb9XAmudsa3kqEz029NeCmzH2QRQLrwyGZ
   HPKIDO8DgGD7clCpXRLi1vX4eIJ3+VysZhTm1bn/m2Hpdht9JlORbm57U
   8=;
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
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="37455858"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2022 15:11:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E7D1E033C; Sat, 21 May 2022 15:11:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EFADDE0094
	for <cocci@sympa.inria.fr>; Sat, 21 May 2022 15:11:47 +0200 (CEST)
IronPort-SDR: /8s4dyR8B1iItxt6bK+v76J/GzEZqBDQDkDtLIH/y5doyrHElnESABxGGQxbVWLjgIr3ez9AI6
 hy5y2jJaJ4PmdOw0LXxMPqVrYd5j/f9dkEPkqpn3j84Z92aDG9hTv6YWV849yy+ci8YfxwSKkJ
 1HW1LceYORX26CoEL2BWAbnRkkGqT5sNlZ63JrIhR5MEfxZakg1JeZsO9/zmZlAiZn4fSIlnj1
 vuJGVsBw1iDKTWCIfkT8yk0bbenRc9mkmejYgIuC7wk7VDFJYB89XdIMNducsnOvoPxFayEpAz
 rYzUhLN620D8HWAYsEhrXXBq
X-IPAS-Result: =?us-ascii?q?A0D5AACN5IhihwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIFTLQQLQ4ROjmiNT4cbhFKHTAsBAwENPwECBAEBhHgKAoU/Ah0HAQQ0E?=
 =?us-ascii?q?wECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFN?=
 =?us-ascii?q?gZeBmQEgUsEgXQLNA2CNSkBg2QDAyMdAQERJgEPCxoCHwcCAlcGAQwIAQGCe?=
 =?us-ascii?q?YJjAQM1q1eBMYEBgggBAQaESh8sIlKBXAmBECyKGS+EGycQgVVEgRUnglMwP?=
 =?us-ascii?q?oEPg06DPYJllXIoBA8DHDI1EoEhcQEIBgMDBwoFMgYCDBgUBAITEk0GHQITB?=
 =?us-ascii?q?QcKBhYOFBwSEhkMDwMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxgJBwoDHQgKH?=
 =?us-ascii?q?BIQFAIEEx8LCAMaHy0JAgQOA0MICwoDEQQDExgLFggQBAYDCS8NKAsDBQ8PA?=
 =?us-ascii?q?QYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXBgICG?=
 =?us-ascii?q?VgKKA0IBAgEGAQeJRMFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIAggnG?=
 =?us-ascii?q?wcWGR0ZAQU2JwYLCSIWBgoiCwYFBhYDJFEnBQohBiIBGwKXXqYQnl00B4ITg?=
 =?us-ascii?q?T2BQwyeKQYTLYNjkm0OBpF1LZEMhS4gpxCBeIF+MxokgzdOAQIBAg0BAgIDA?=
 =?us-ascii?q?QIBAgkBAQKOHRkeg26KLT80OwIGCwEBAwmFRwEBizsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Rjp0CKIJ3jznc6exFE+R/ZMlxSXFcZb7ZxGr2PjKsXjdYENS1jAFn
 TYdXGrTaf2KajPwc9FyPI7ipx4GsMPRz9RrSwcd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXlnU4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhvfN6y
 t5IkrmMSQ4pZrXlv+oDfSAAOnQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RCvLwtXicXq
 LpEQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacucH/iXtYIFtNs2ruJ0JNaHP
 8wmUhlydjrrYRFQN0UTDY1ryY9EgVGmLmEG8QvLzUYt2EDXxRN41LzFItvQcMaDA8RThEeR4
 Gzcl0zyBRoRNfSE2D+d+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeRqG21WdlaD
 Gko+iMu9bAb00K1YOCldkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYeMbTKU+dpH1QXO
 k+1c8DBWW036ObOIZ6J3ufI92zuUcQABTJaPUc5oR05D87LjKxbYvjnbd95FLWvk934cd0b6
 2/U9XNh71n/peQC26i9uG9sVyiwupXMRAMv6W3qso+N6wRkeMi6aobu5VWzARd8wGSxHgfpU
 Jsswpb2AAUy4XelynTlrAIlQuvB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RGO4lsOvcMIYyD3Pcebhr5d7ex1ncAM8vy6B5jpgiZmPsQZmPKvoX0/OxXKt4wTuBJwyPxhU
 XtkTSpcJS9HVfo+lWTeqxY1iPFyjiE42W7JQ53nhx2ouYdyl1bFIYrpxGCmN7hjhIvd+Fu92
 48Ga6OilksDOMWjPHi/2dNCdTgicClgbbir+pw/XrDZfmJORjp7Y9ePmuxJRmCQt/8I/gs+1
 irhARAwJZuWrSGvFDhmnVg4OeyzDM0m9ClrVcHuVH7xs0UejU+UxP93X/MKkXMPrYSPFNZ4E
 KsIfduuGPNKRmiV8jgRd8evs4FoMhim3FrcMy2gaTk5XphhWw2Qpo66JFSyrnFWA3rlr9Y6r
 p2hyhjfH8gJSTNiO8CKOvih+FW84CoGk+VoUkqUedReIR2+8IVjJyHroOUwJsUAdUfKyjeAi
 VSJDB1eqeSU+90599zAhKalqYa1ErIiTxQAQDSBte67bHCI8HCizIlMVPezUQrcDG6kqr+/Y
 eh1zu3nNKNVllh9s716T+Rhw5U46oa9vLRd1AllQC7GYln3WLNtJn6KgZtGuqFXn+YLvAyrR
 gSQ99McNbjQYJHpF1sYJQwEaOWf1KhIy2eIsqlveB33tH1t4b6KcUROJB3S2iZTG7tCNt93y
 +kWvsNLuRe0jQAnM4rdgy0IpX6AKGcMD/cuup0AWda5jw021hddbJaaBiKvuMODbNBFM08LJ
 D6IhfOe1uoGmReYKyI+RSrXwO5QpZUSoxQUnlUMEFS+nIaXjPEA2hAMoy88SR5Yz0kc3u9+U
 oSx25aZ+UlTE/ZUaMl/s6SEHgZcGFuG90a3x1ZheKg1iaW3fjSlEYH/Eb/lEIMlH6Z0YTVRu
 r2VoIogeSi/Z9n/h0PeRmY8w8EOjrVNGsnqh82tWciId3X/jfwJnYf2DVc1R9Db7Q/dSaEJS
 SSGPAq9VEEjCRMtng==
IronPort-HdrOrdr: A9a23:qIZwqaF6ZrUcOdKMpLqEzMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="37455855"
X-MGA-submission: =?us-ascii?q?MDFzEoRki+SL2jiwaOwICNLEc5QzFGVcsjX355?=
 =?us-ascii?q?spulZiVPs0sZmxXSTjbf78NGxmMMEfSuisNBJhljjELXrUFL7N9xZ0TR?=
 =?us-ascii?q?8idVzBAXtPlQIJsbE/ybXwz86oCud5B9qCF6O9IzOyrRWalh1af0xwyl?=
 =?us-ascii?q?wTG1WqfjBnCUkAuqFZz9uXMA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 15:11:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1653138701;
	bh=qUfqlh97uyrHy3YjIaU8pHbunV3KH95Qd+IinouNpyo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=CAuBkp+4uwbxZcH3dI71r6p51jENuExviSV4z8x2RhlNIYe5Al1rhAB0vHHtklH8n
	 WzXbfD0OA1/7eFD98/U8f4l+DSvuq4SRfCbWCEyYHurqWNHVXYNlGMvtA410q8K1Ay
	 8YIp6LePPrqkcRroBSuXsNfGzMcNFZoGTePTl91g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.75.192]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1ng6o52xOe-00wZwy; Sat, 21
 May 2022 15:11:41 +0200
Message-ID: <5b0fd9a1-e0df-999c-52af-ba4e4eca6ef9@web.de>
Date: Sat, 21 May 2022 15:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Phil Edworthy <phil.edworthy@renesas.com>, linux-clk@vger.kernel.org,
 cocci@inria.fr
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220517133556.6934-1-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+dFH6Rm750e5Ij7Fo8BOo2vAwW7FPLVBqc6SV5SMwFOxr3yHYCL
 JoXmrKBePdlmjnfFXsehWRrQjzoiwOGVtLg+rT/Jq4+QQJivmAjU1lFmzAWXOKcnF3k1g5g
 /lQtyvmIwuHTdWT0EOkqcQydSMGUpv+pR1dWZp9HLBknU9h4z4BoJoQePUdAKZzBhkFndvt
 Wr2FbAdYmQknEJ65gLT0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bVLSfgMhJtk=:ONtUc6xuadTMflOmO7QCcT
 X8vQbZ4/cOGmxfHc/GLkt8hoYL/+BO2+qj/RkIUCAhHm2hTZyHGb8NEevxaOyvSI9GFMl4Wcp
 90JTEV3zd9pkBNRbgdDrYopuCvw0MXibbrswvYZCqHs1sRUKS4kFYLsem3ICrXve2BL8wag41
 t6XQ6c7BkhU9DWw/DhI1wSVY/Xbd5lUMyh1vBtRhNElKeCQgoPTPG98KqfvrzZb3fQQYU2O1f
 dAYEVvr37bfKaQ624Z8nN+uXr867XN3Sw+b88DlL0avFCjdeCcfiWk1TW99FnUQ3lGBtSObZA
 RYwbeLRcgfXU+Q3dADcjfoFBNwZp8qgRgtIMT6/C0EjTiyds2Hrwz46gcMpYO6H8ieV69DHLw
 Kpb7EkbCxCY+vkVetGUNS8PV61jHBp2AycK3b4W6SOwBCoyP2noKGcf1BadAhdMu5UYiF5G+i
 fIvn9a8eUMl8bsBug/IQBsLi3vyMWL5jXZZnbUfKlNAAjXLHg/PGjEBcLtT+22eC+IbOu5t6l
 zBMf9IzFRz4rnZHtPwwlNr8MQCgx/dtUnrAL20BX8JNkZ4ab6gdzRMcfJ+IAnIQynQevN1VxK
 W8kqTfnJTqQPVcnNCRx0uOAYrntyDhNS3TPEPoTJp7ilAp/ud6mPWjP+HdnA3ygRnGMMMM+5G
 PUoqEceBMD5H+W8SR6l1G10q9pEYXqjeDN5SQptNz9ph4A31YdTun+sO/nBkU+7jaLwgI9PMV
 Q9hhVGOIhNyt+hqIRYhoSBfhmAaaXDAERgJ8y/qqhnFU7zhO8jT+6YOuMY1EhOtutST33C8Zh
 ihE4dbuTwG1za1zSwLm8BrcCMWcfuhiKVnNy29UWc+XesghNIT1WwuigOsYMP+b9teGE9a33r
 KO/qXfULUTBjHklsXK2MwwViUZCzI8aeTM3I5cGaxN+mTBEyn0CYPAZ9e8l2nQlAOmi+n24Cu
 64c/O7x0Wn04juAHpKQP+W+XcuoBpHmV2LI0ujHaMOK2rYcUA7fRakZYXJdr51XV/GC18X5HF
 xCfxSHAQZdzCDsM2dEi3jgKmL7V3rtaT9rqu0EXKcsnCdIsMUB/4sLrGLxti6LHbD5dzN6q2J
 iVoBX1VrIxtjpr+TPeEgMdgt3Pl4SQaC4Mn+1Rs1GibjCk68bIC5zmRhQ==
Subject: Re: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 408
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/5b0fd9a1-e0df-999c-52af-ba4e4eca6ef9%40web.de>

> +@r depends on !patch exists@
> +expression clk;
> +position p1,p2;
> +@@
> +
> +if@p1 ( \( !clk \| clk != NULL \| !IS_ERR(clk)  \| !IS_ERR_OR_NULL(clk) \) )
> +{
> +clk_disable_unprepare@p2(clk);
> +}
> +
> +@script:python depends on org@
> +p1 << r.p1;
> +p2 << r.p2;
> +@@
> +
> +cocci.print_main("clk_disable_unprepare call",p1)
> +cocci.print_secs("Unnecessary check tests",p2)


* I find that the variable names should be swapped for these two function calls.

* Will any message variants become more helpful here?

Regards,
Markus

