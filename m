Return-Path: <SRS0=SyX8=6E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385BC3815B
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 06:30:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907532078A
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 06:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iyT1tsGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907532078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03K6UTrQ006694;
	Mon, 20 Apr 2020 08:30:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 27AEB7763;
	Mon, 20 Apr 2020 08:30:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C00AC7459
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 08:30:27 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03K6UQZY009591
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 08:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587364224;
 bh=9f2DDdjvE7E39GxWg53JEGqBLLE1WxjFXVMuLx7LvQQ=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=iyT1tsGvUrVVbzN0ZuPDI77Le4iKs9uLY7VFaiYF2PjnG5ZeRSzbDziElNyVB9OBv
 xYH4sac2IYGQWg6GoeBQvDfbQGC86ePZx1xdsyJ7eRNlR0oJDPGWH7Luh4EO69JIUO
 SPm7lLUx6Wye8c8JFUbijEviLjl9Jux2uw2c5MsQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.153.203]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpf3q-1imQli18Mg-00fVrz; Mon, 20
 Apr 2020 08:30:24 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
 <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
 <alpine.DEB.2.21.2004161444300.8125@hadrien>
 <735a3c61-695b-a857-b0ce-8999b04644b1@web.de>
 <alpine.DEB.2.21.2004161627300.8125@hadrien>
 <fc9f592c-ffe9-947e-3777-8791d4952daf@web.de>
 <96a828a3-d977-e5d9-b7a8-10c976f41cea@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6a49e69a-75b6-52de-a468-8396d16a1304@web.de>
Date: Mon, 20 Apr 2020 08:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <96a828a3-d977-e5d9-b7a8-10c976f41cea@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:ryj/s08qcNv1xWPpjqBbiFZ6WgSQQMyJVF+hbMDAey4TLzYfNrp
 A+xkfHrc/IzzBrsbR9BmH3Wae06AbnefpAk+w3I99rP1+m/L2G0G3zoTOBE03PWvoFU8hGQ
 5PN8cazsGYPiU8D/Ii6W/yIWPOuV7GoUWl4WT/eWHSJbHET0EvSoxqfNfE6J1SiOgtIjx0g
 g5C2Y2J+lFtueznl8hbMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zme/G/nHmuw=:XoAyAsTC9daeKdef/8l6pj
 OP3UZ6GUlF+uqQc8+i3NjXA2ESrcOS/VL/ZU2ejo4WACbB/SwstSCpgPibIDpyiE/Vb2/gD6s
 DM2Ai+MXc7ZUZKfqJpBzYl4NvvOuUzcscUHHww53Wd3DhgM4E2sC15U83YxQ79RDtc2K4H1Ul
 zPRyYhkuV8OZLjQYL1yE9+XZczNQV6LaHToqtdj3AXtKA/+0ABRqR6qytUsosWnoQ2gfTL++d
 +4eKpwvSOrjWEYA5bxihJ4w29xwHkg000TNdiacsT/M2buH00iVUoB0UcyOLbNA2ggOvnxjR6
 FGsGSt1cS54Al4YNmOSLy5JPz5EmjN5eqSBNCbILB9LgJ+n8NAvV8S6DSCYH0Iy3hj4WsKYQ0
 +LvZpLQq1+/bu0LLibWRqoBXN9NgdWHZdjA0ggKO5m2DpchvGMp5QaaTj54ZM9KrgRHrvkUi2
 j54pTSM+0CJCEV7sarSmr8WYv/kL47ucGEl/eTpSA58DYNlr+vBHPzzOPFgLOQ6H/vBEZuUDm
 AvF5pQKAL3uBqw4oPmVw22Fhu1EovfO9jI9ZNO12MFG9BzjahXkku+IFzKLuXGgFV9Cr3NS69
 aJ38oBWPoDXtQs2vgOXkrKlc6slUzePUGmxa0uRjMmmVg0fOhc+tkUp163DKsFm7v40kSvhG7
 3KK/GaEgDJ+VohY+p7pAp+Us62Yu7xCCx/XuswMcfiOiJ1ulUoNJUoEgDO3uIAeMRg1Ee4fnz
 oNPEQQkbM7PPqXjH8aIPtDFDb10ZYnGXPHqXXxsKIfaEMjB2nDipqVlVNEjRMP0xWXLU+wXO1
 biHOpXqX5kph1EsUV+aKBWpnuB2mCTvdSHizLJ6HE1dAOwQ6xHBUTo/v0dkNGH5N9PcPRwm+t
 ovCB83nXR3SAE+mhD1nheB3OdXCO4SIkQiIgaIUzkJ0B+JPcHemIe07eURiBIN6+pjLxWLINI
 eGkE7BSKwtj0lHcpqmJ9YPxaRJf9s8/Wf59+pjj8MaBOPGpRmaCQCquNZGbwFsa9Yi5wZgt9a
 kV2+Buu5TvyE2HTgFkOGSfrrJRZIulBIp4M2BP0RZgtG1i4YzmNCFbW2BwydUREc58QmcoFLo
 2Uh5dN28gfW2Vntuv5V/sz6+VhqtfBDrFgLB1aP+Gd49Ys0lD6DGbgMLYYWg1PECnqZ9iFlap
 IowrTUbNVj97bTLVy+Pa140lFMOlFy9WWOfkU1ZbgJdjED7NHFlKdF1OfgxRQYRswwUjYuiWJ
 FcBo1PebA411bprmU
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 08:30:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 08:30:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> Another possibility should be taken into account for source code variations.
>
> SmPL script example:
> @replacement@
> expression base, device1, device2, index, private;
> @@
> -private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
>  base =
> -       devm_ioremap_resource
> +       devm_platform_get_and_ioremap_resource
>                              (device2,
> +                                     index, &
>                                               private->res
>                              );

Such a transformation approach can work to some degree.
Thus I would expect that it can be reused for a case distinction in the way
of a SmPL disjunction like the following.

Another SmPL script example:
@replacement@
expression base, device1, device2, index, private, resource;
@@
-resource = platform_get_resource(device1, IORESOURCE_MEM, index);
 base =
-       devm_ioremap_resource
+       devm_platform_get_and_ioremap_resource
                             (
(
-                             &
                               device1
-                                     ->dev
                              ,
+                             index, &
                                      resource
|
                              device2,
+                                      index, &
                                               private->res
)
                             );


Test command:
elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch use_devm_platform_get_and_ioremap_resource10.cocci ../Probe/i2c-rcar-excerpt-20200415.c


Now I wonder again why the known patch is not generated as expected so far.
How would you like to clarify this software situation?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
