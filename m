Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B51D13572
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8gYvdKcm+66MLewnAUzVbQwfRuIcU4d9BmLNFhGqXtE=;
  b=LRb4la434Tfmcg9z2GtGj1aFezhKSdoXiIgtdm0OLfgYt/0XaSUnG3y7
   6F7ngpHslkCMey0qjVapwEkrUi5qyuCaumVfPOZgcVo3Y1GVlKSvyVnC1
   zlbSAYIxKXE66HsyBYU+S8YUKufawzlNmdLgn2btPbr9miZetmFbxDjHM
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190932816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 19:04:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35584E0D1E; Sun, 27 Oct 2024 19:04:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F3BB0E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 19:04:17 +0100 (CET)
IronPort-SDR: 671e80a2_5f6HQuWoOx8nV1DhYJZAAW2qLDylwxXlUVlECkklxY47/7Q
 72iy9/OY9vEDmQ/rycK9OiBkU2b6jKN1vNi+Smw==
X-IPAS-Result: =?us-ascii?q?A0EiAADlfx5n/wwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFCAgEBAQELAYJDB1sbWjMEC0gthCmPTYF0MIQ7jw+IdYNUD?=
 =?us-ascii?q?wEDAQ07BgECBAEBAwEDgUmDNwJ3iTACHgcBBDMGDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQKBCggLhTVGDYJiAYEJG3QBAQEBAQEBAQECAQEBI?=
 =?us-ascii?q?gIBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BAREmAQ8LGgImAgJWBgEUAQGCf?=
 =?us-ascii?q?QGCLwEDDiMHDQavMIEygQGCDAEBBtpbHywiV4FjAwaBGi4BhWmCYgGGJINCe?=
 =?us-ascii?q?icPgVVEgTwLgkcxPoJhBIFeg1uCaYJVkDtokUNSexwDWTIBVRMXCwcFgSsmL?=
 =?us-ascii?q?gOEblt/gTuBUwFGgmZKg0ccgUU4SYJNaUs6Ag0CNoIkJFmCUIElBAWDOoI2H?=
 =?us-ascii?q?UACAQttPTUJCxsGPZtQR4JGgRsTLMg4NAeCOIFlgWMMiieVLgYTL4Nxk04OB?=
 =?us-ascii?q?pJ4mHcijVyVE4YQgX0ngVkzGiSDNlILDg+OIYN6M8wRQjUCATgCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGLMYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:PpICJassJsbGDRSiim1MAUDvtufnVJdfMUV32f8akzHdYApBsoF/q
 tZmKT/TMvqOZjH8cooiOYuw9ktQ6JPVnNIxQQNkqn1hEX8VgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsspvlDs15K6u4WtC4QRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJHsfO50muf13OFAQ7
 ecECBUTYwLdpMvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWh235om8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PtvsjOJnFUtuFTrGOD3fOerWdptok+3v
 UzvoWbeCzIZKNPKnFJp9Vrp3IcjhxjTXIsNHbm83uxrhVeJzyoSDgcXXB21u5GRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVdwO3qXuOvxMGc8hRFucg4UeMzLDV6kCXHAA5oiVpbds7qIkpSDZs2
 lLhc87VOAGDeYa9ERq1nop4ZxvrUcS4BTZqifMsJefE3zXinG33phfIU8olD6O/yNH4cd01L
 /ZmswBm74j/T+ZSv0l4wbwDqy2hrN7FQ2bZIy3JC3m94FoRiJGNPuSVBJuy0RqEBJmURB+Ns
 RDoXiRYAP8mVfmwqcBGfAnB8HxFKRpI3P0wTGODx6Ucygk=
IronPort-HdrOrdr: A9a23:0IeGBqlCxgOgUnQdTgbN1mlcITXpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AA6ZeoGlyIaP1XNGE4lDsjUygIffXOUf0ymfuYFS?=
 =?us-ascii?q?4MFc3UKaJaXqO9bE6sOM7zg=3D=3D?=
X-Talos-MUID: 9a23:fsPxvgan989mkuBTjR3qvxB+K/9U6ou1JmlTk7IPmMqYOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190932814"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDHtivr0ub6Cq8MBuw1vTcB9I6NDC6XafzrxTK?=
 =?us-ascii?q?19YEneA/oxV0QZKvo7TWbidencqj5jbxjwvK6TzK0Af0EBgf9C1HJ+ST?=
 =?us-ascii?q?AcAsGwgAeFqtLM1uVQTUwQw1vuLITDjyo+X1lAeiD3rEmD+IlU2Hg+nL?=
 =?us-ascii?q?Vw0aPnQJmbSIeKcek2SmHjRQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:04:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730052247; x=1730657047; i=markus.elfring@web.de;
	bh=8gYvdKcm+66MLewnAUzVbQwfRuIcU4d9BmLNFhGqXtE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m4Tbk024qI0BzKrOzhWnffqnzOKVKB5nnhvh02ZZ3VK6QGalpzz4AHgdapi2ZLtj
	 Ei35LV0QTM3TKD9ik0qCDBDxLaSdVAKUqLmxou/r7dYK43TLwlAEQHZ7Sa9TjtBKd
	 xMZV401DEMzSkI92HUivCuCv+B9wecss9FSqIPO0i14OMuBlVkYm8DqU9jE4JWM24
	 sc7eiXZLXGfYfoSvdvaZDyqiv90DjD96nkDZsHm3NT+GxgxpoJevHaDfFyeX1wHvo
	 jRdxEOD2386F4PRjfN6S3m7JitOVkQNHNt5kieJbD/t1JJ6DfJRA5M5aggbAM+SB2
	 50ZVmPffkOzxUYrmEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrdC-1ttesI42OG-017l2J; Sun, 27
 Oct 2024 19:04:07 +0100
Message-ID: <969e72bb-ac83-4765-ad33-722d6e02aa53@web.de>
Date: Sun, 27 Oct 2024 19:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
 <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de>
 <alpine.DEB.2.22.394.2410271833310.3498@hadrien>
 <f63293b2-94a8-4c2e-933c-5b2f94f64bb2@web.de>
 <alpine.DEB.2.22.394.2410271855000.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271855000.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ILz0HVOB07vnEBPsIpZeFq+p1JzjFqoaekt11l2A5oqnoqyPeo4
 LPIf2/PygsuFHdYlASXRgrd5cKSuSxVF6p+kF3F4/xSL71cAvs+n+L2orBzQvwRVHGra4OE
 lcZFQa/RncGqr9NFyhJBOAg/IfKWOXzEw78fiqe+dy0q06ANF7A+AiyQKwqs/9UubLf5vje
 pJbwVmzOy2i8ij2Gs1HqQ==
UI-OutboundReport: notjunk:1;M01:P0:9RZ5S1/pyjQ=;pbJm2XLe+51MuhRaJsxxxWPziGr
 6kvqUrd4tJEbCLMgvslwXShwlH4wgKTIzFxokKd9bsmBYE/U/yDqeLMiC1Ws1GRZivqHKnaRO
 L3JxG/fQ7hyWcckE7Po6xOz49uoZvf44Ry/zWnhRB9JXUNJcgQrUtZ99ZfOPrFJTzqPMU+xnM
 enereXZaGslXamEpIqB3100tMndHlRKtFx1HjcVB4yYs+wU+Cd73tk1K0ndjvpo23qhfeVRpW
 xqPeDgyfi3mgIRNNLo0Ee2SPtUco0p6Q7TiEkHFN/UiuP5wuv0fZhz+VmwQF27HechyO4aaAi
 m/cEXzO0e/MEAGu+oZPDaciMVuiTMuxtGhGEvT40ZXnx4wZm3psNzotL5vo6VeJ7XAHC5a3f8
 XNlwGZP2/kyHGCfTcyHcyfw6eLnQyp5dTcVFz7xHUYgNaSY4/5VnbeOe3hcoW0xwiCLRvvsHm
 gHB7vgwkpQ+a9n8aNmr76k4VS2fdNFaZxy54aoyx37k+8/vPZq0lvwqm7hgM83q2bEt0Vg/3i
 19q/FgSt3b9pAScbDy9n73vMGR8OAFjx4I+qJEexRSYwbwchKLXegvLJEeHTynHnwE5a8tA5K
 1ba3+1dJJrDN37HUtg/tkVFXAPlv+o2r7jsdSrLQv6tm/OPz8jRMRTKt+xJdsxtf1qqj29HRu
 oDGG1LVEQJRoyh5Nh8F/ZkZfLMIS3egDNx0HAz9thyZvOq5gum6Yqdj3nuK2T06fomiNCm4qW
 2YpOAfEM+S0/szYbDUNnn+d5iyvEgBnKqzfnJgdu9k4WljiYo4L/ot2DCmLBUYzJE1OQxRThw
 RTsCGWSoQzKy9SPMSPr+ZWIA==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1953
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/969e72bb-ac83-4765-ad33-722d6e02aa53%40web.de>

>>> Coccinelle doesn't report on parse errors unless an option like
>>> --verbose-parsing or --parse-c is provided.
>>
>> How helpful do you find the following information then?
=E2=80=A6
>> parsing pass2: try again
>> ERROR-RECOV: found sync col 0 at line 49
>
> You can look in your file and see what is on line 49.

The definition of the function =E2=80=9Cpci_is_66mhz_capable=E2=80=9D is s=
tarted there
(after six calls of the special macro =E2=80=9CEARLY_PCI_OP=E2=80=9D).

See also:
https://elixir.bootlin.com/linux/v6.12-rc4/source/arch/sh/drivers/pci/comm=
on.c#L49

Regards,
Markus
