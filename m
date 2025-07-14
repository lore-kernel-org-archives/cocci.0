Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE61C83F17
	for <cocci@archiver.kernel.org>; Mon, 14 Jul 2025 07:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BJQxT/ZVBVpFc6PAvSb2iE5dEcpK6xsac4K281Q/0sw=;
  b=QDE1FA0IDUxyofUVqGcFdjUSMEZP8Oh65myybrN7lPHMkSPA2k2lxxkx
   do3oV5G5VdSSDQz98zDl8BOSRNIK9Kor4/PkWK5L5mJZDlzQSQXmRyISj
   t/1EEoE7kv4PLGcpuzz3LDKeUByk/P2i4FghUFLs5bkQoCLZGwciIPZ9E
   4=;
X-CSE-ConnectionGUID: yIf3TG+XRjyS0vVDpoGyaw==
X-CSE-MsgGUID: P6eoM4pZT0yADeR6IWDhGQ==
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
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231543511"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2025 09:27:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7093BE0261; Mon, 14 Jul 2025 09:27:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1348CE007A
	for <cocci@sympa.inria.fr>; Mon, 14 Jul 2025 09:26:56 +0200 (CEST)
X-CSE-ConnectionGUID: yjH4BycjTV6TRvkp8TGguQ==
X-CSE-MsgGUID: gzXM+0/iRtGg34Tzo0MALA==
IronPort-SDR: 6874b13f_YNITmbkm6sWSmY0qLZ0jeLKQH6AGOSM4isGzWw3AP1SBf1I
 NxV9aHnWqf6dLbUa5E9QzYbrlCjyofU0Gz6PB/w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FUBgCjsHRogA4P49RaHgEBCxIMQIQXgQAGVDMEC0kEB?=
 =?us-ascii?q?IRNj1CCIQOEO48PjEoCDwEDAQ1ECgECBAEBAwQ4gVSCdAKMAwIeBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERJgEECwsaAiYCAlYZA?=
 =?us-ascii?q?gEBgn4BgiEBBhABAw4kBw0GrRaBMoEBggwBAQaCadd1HywiWYFlAwaBGy6Fb?=
 =?us-ascii?q?YJkAYYwhDMnD4FVRIE8C4J4PoJKFwSBPAEBbYMOgmmCJoEWg2SNCIcoUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwOBDyNLBS0dgSd+gwqBDoQnK0+CInWBeUEZP4NTHgZtD?=
 =?us-ascii?q?waBGBtKAgICBQJDTEACAQttPTcJCxsGPZIogx4ISQ9hWIElpTOhQzQHgjiBZ?=
 =?us-ascii?q?4FkDIoulT0GEy+XTw4GkwKZBowOgXmbNoF/I4FcMxokgzYfMAMZD44hDBaDX?=
 =?us-ascii?q?jOEYLdtQTUCATkCBwsBAQMJhUYBAYgggUsBAQ?=
IronPort-PHdr: A9a23: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
 yY=
IronPort-Data: A9a23:enq2u64eawjz25kvl15qKAxRtP7DchMFZxGqfqrLsTDasY5as4F+v
 mNLXWqBaK6CZDf2c4gnOdnl8EpQ6sDQxtA3QAdl+C5gZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjVAOe6UaicZ30ZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvzrRC9H5qyo5WtH5wBmPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAfzsCa+v9T2Ms0MS+7uR3R9zxC4
 IklWaiLdOscFvakdNLx/PVvO3oW0aVuoNcrKJUk2CCZ5xWun3DEm52CAKyqVGGxFyke7Wxmr
 JQlxD4xgh+rluCWnJiqQetQuJofFtfoJNMjlX599GSMZRomacirr6Ti4NhFwHEvi8oIEfu2i
 8gxM2M1Kk6aPFsWZxFOVPrSn8/w7pX7WxhRslGIvuwa52bJzQp++KfgOpzZd7RmQO0PxR/F+
 jmbpzqR7hcyO86v7HndtXOWmsDAxn/HSoVKMZSc36s/6LGU7jdPWEVNBQTTTeOCokW5UNleA
 1cF/zIn66k07k2iCNfnNyBUu1aBuQMAHcVdGas25Wlh15Y4/S6IBEhYZC9KauAY6vMMWz8yh
 mOmkM7QUGkHXKKudVqR8bKdrDWXMCcTLHMfaSJscefjy4a6yG3Upk2WJuuPAJKIYsvJ9SbY7
 x3ikcTTr7AUkNJNyKixu1zK695NmnQrZl9vjuk0djv7hu+cWGJDT9LxgbQ8xagbRLt1tnHb4
 BA5dzG2tYji962lmi2XW/kqF7q0/fuDOzC0qQcwQsN9rG3xqib4Ld44DNRCyKFBbZhsldjBP
 x+7hO+tzMMCZSbCgVJfONPoWp90pUQePY6+CayNBjaxXnSBXFTbrHk1NRH4M5HFkU8qlrp3I
 przTCpfJSZyNEiT9xLvH711+eZzmEgWnDqPLbillUjP+eTEOha9F+xfWHPQNb9R0U9xiF+Fm
 zqpH5Hak00HOAA/CwGLmbMuwacidCVnXc6t8pQKLYZu4GNOQQkcNhMY+pt5E6QNokifvr6gE
 qiVCxEGmmnsz2bKMxuLYX1FYbbiF8Q353EiMCBmeR7i13E/aMz9pO0SZrkmT4kBreZD9P9TS
 +VaWsOiBv8UdC/L1Q5AZrbAratjVi+RuySwAwSfbgMSQbtcVi3S29q9fgLQ5CgEVSW2ks0lo
 oyf7ADQQLtdZgE7EsrmUe+jlW2wmX0nnMNzQEr6Dd1Bc2r88IVRCnLQj91mB+ouOBn81j+h+
 ALOOighpM7JuJ0Q3OjSoLKt9qOFMrJZMBJBPm/56b2WC3HrzlC7y9UdbNfSLCHvamzk3Y6DO
 8NX9qjYG98alg9ot4FcLe5a/Zgm7YGym44AnxVWJ1SVXVGFEbg6H2Kn2/NIvahzxrN0nwu6d
 0aM29tCM4WyJ8LXPw8NFTUhc9i8+6kYqhvK4dQxBXfK1it90b6EcEdVZj2nqihWKplrO4IEn
 8YlnuMr6DKEtxl7Cebe0xho9FmNIEcQDIQhlJURW7HwhiQRl1ptXJ37Cw3N2q+pVeliCEcQH
 2KrtPLwvIgEnkvmWFgvJEfJxttY1MgvuggV7VosJGapu9vih91s7iJw7AYYcwVx5TdE2tJVJ
 WJEGRBUJ6KP3jEwn+lFfTmmND9gDS2j2H7a6gU2hkjGaXK3R0rxLGEZEsScznAzqm5zUGBSw
 +CF9TzDTz3vQvDU4gIzfkxU89rYUt1781z5qvCNRsiqMcEzXmv4v/WIe2ENlhrABPExjm3ho
 c1B3r55SY//BB4qj5wLMauo/pVOd0ncP01He+9rw40RF2KFeD2S5ymHG3rsRuxzfc714W2KI
 O0wAPlQViaO9jeE9REaIq8uH4VavtAU4Pg6R7e6AlJe7pW+qGJyvYPy5xrOojYhY+9TnPYXL
 qLTcDO/EVKsu0ZEpl+VrOR5PjuXXNpVQiz9w+G/z8sRHb0hruxHUB8/w5m0jVqvISpl+BOY5
 j3CQ6rsy81j1oVesI/+GYpTBwiPCI3SVcbZ1CuRothxfdf0HsOWjDwsq37jJBZzEYYKftZKy
 YS2r9/82X3asIYMU2z2n4eLE49L756QWNV7H93WLn4Auwe/Q+7pvgU+/l6nJaxzkN9y4tetQ
 y26YpCScf8XQ9Js+21HWRNBEhoyC7XFUYm4nHmT98+zMxk61RDLCPiF9nWzNGFSSXIuCq3EU
 wTxv66j28BcoIFyHyQ7PvBBAaJjAVrdSKAjJszQtz6ZMzGSuWm8mIDezDgu1TKaLUO/MpfK0
 cqQDFy2PhG/o7rBw9xlopR/9E9fRmp0he4rOFkR4ZhqgjS9F3QLNvkZLY5AMJxPjyjuz9vtU
 Vkhtof55fnVBlyosCkQ4egPmi+aAfESfMj0LHol8it4rstw6JyoWNNcGuVIuh+auQcPCMm4J
 NtY9nCY0t2Z3MRyXehKjhCkqb4P+x4Zr07kPWjinsa0Dxt27XDmEpB+NFIlaBEr2P0hWKkGy
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:osYbKa/tSrg3TjN7vGNuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re+8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNSftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3ADZdmKGi0o6tEiKSUwyX2BRAyqTJuY3/9kF3BKE2?=
 =?us-ascii?q?ENzhVcqOWUQ+s16x5qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AvYpw8w+RmvnE9H6ar9mx94iQf8h604HtUAcMq4k?=
 =?us-ascii?q?ptJLYCT53YxK0qB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231543506"
X-MGA-submission: =?us-ascii?q?MDG5OWVuoHrkfXMAVgbbvYnrDIc1ggPiHLGTPX?=
 =?us-ascii?q?Gwz4djLMoxj5q1W4I07UEEbL8RIioTKHr+xDIiTlqChz7iV7g8B4p9oI?=
 =?us-ascii?q?K4CCiBnsH2NZPFjZGriN7N4z5XbwginNakcSaO6Rcg3/V6cbxf67XPjl?=
 =?us-ascii?q?URgfJHfAhLxuRi4w5UOqLS1Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 09:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752478006; x=1753082806; i=markus.elfring@web.de;
	bh=BJQxT/ZVBVpFc6PAvSb2iE5dEcpK6xsac4K281Q/0sw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OzEXBJuv/woEJT19WPwP0F6GAhgv0V+zfEgG0eRJ76szZe1I9hcqpoEvF3YJrHuQ
	 g7SUG6rebt55LH5rtU2+x/E4IElZlRNhSJKarBFhAB3kWy4q9qPmSK3l031H5tGBX
	 dA+ey1kLriZt3jAxpWMkItrcnYlERX1Lhhc2A2NR5lEest7OqVwYd5qsUo1oh8NnR
	 Jk/r4seKFkjLz9JRuSLwOtttZu5kxStWl90PyiHEdQ97iI7+oVTPDG5ZvVnyMYh9j
	 PgVcnqrw+2WiPeBgM0fhHvaIzlN0JjL7WBf8hYbtwBx374jrmZZNZuDTHPf7Ylw84
	 Neyh8bAj65hMGkhruA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgANG-1v7WjC48Za-00leE2; Mon, 14
 Jul 2025 09:26:45 +0200
Message-ID: <8b094c79-c6e5-4398-a2a9-37e9d46a46e8@web.de>
Date: Mon, 14 Jul 2025 09:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Cc: Yue Haibing <yuehaibing@huawei.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <89cd029d-b68d-4d9d-92da-ff2ee2bcbe10@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <89cd029d-b68d-4d9d-92da-ff2ee2bcbe10@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m7IupZcKE5s8K/hx8lDiq33C0V9vk2YvnN/JaOhwZceb0kruAdE
 cV9VdOB7c8l0GcGDTe6075tMQnnfZlElHU+WWANEKC3F2oETj7MOSJbnSn3iOcjU6JSqCTs
 sGfL19VAuBpQ+Occtg11E8bL6aW4GqXUlkFdAenKsYhTZpQEBGGf3nzQhU+EjOM3IvGlHrL
 zSlIcMqBMPeBbUnCyo0uQ==
UI-OutboundReport: notjunk:1;M01:P0:8pA9UMr6ln8=;mrbBInid3IuWVSSHCBKYahYzs/y
 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
 e8Xpg/Dc4vkbAQ=
Subject: Re: [cocci] Deleting duplicate condition checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2866
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/8b094c79-c6e5-4398-a2a9-37e9d46a46e8%40web.de>

> Which software improvements will become more desirable for such an use case?

Will another script variant for the semantic patch language become helpful?


// See also:
// [PATCH net-next] ipv6: mcast: Remove unnecessary null check in mld_del_delrec()
// https://lore.kernel.org/netdev/CAAVpQUC-mV=SuNNhKbpy_1Mbh_sOs856+oNqDVJ4KcLjhDh2kw@mail.gmail.com/
// https://lkml.org/lkml/2025/7/12/336
//
// https://elixir.bootlin.com/linux/v6.16-rc5/source/net/ipv6/mcast.c#L786-L813
@adjustment disable braces0@
expression e;
identifier i;
@@
 void i(...)
 {
 ... when any
 if (
+    !
     e
    )
+   return;
-   {
    ... when any
-   }
-if (e)
-   {
    ... when any
-   }
 ... when any
 }


Would you be looking for further source code layout refinements then?

Regards,
Markus
