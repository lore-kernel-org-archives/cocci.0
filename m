Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C21C0218A
	for <cocci@archiver.kernel.org>; Thu, 30 Jan 2025 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KdJEKQoDRN65SjSq6gwE0dLuDygJ9gU0ijN5yV+av9I=;
  b=cDpe9ovl9eiKhJGu3s2diei1/W856AWQLKsjkSc9gvQ53CaUqL46TjaU
   sO8nxOSvy5IXicCjWjZlv1UAJFKoE0Y3+c1nSQ3BSxh/GVyvb1vGvwHdT
   rRs7T5kVlopDRG1um7L+Umwvo5ze6DCMS7uof+EC0DSSkWtpgE4YzpQoy
   s=;
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
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205820034"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2025 17:13:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1361E0D1E; Thu, 30 Jan 2025 17:13:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9709E0260
	for <cocci@sympa.inria.fr>; Thu, 30 Jan 2025 17:13:35 +0100 (CET)
IronPort-SDR: 679ba52f_j5E3hyK6b+5dyNoiiNjHDChOrczp0Rp2Hw+JhzkEWACbucJ
 NSiUelcXKgeRqKylSUE0XwOCRrWxWzSap5sGkHw==
X-IPAS-Result: =?us-ascii?q?A0FWBgBJpJtng07ASNlaHgEBCxIMQIFIC4JEYnUzBAtIh?=
 =?us-ascii?q?FaPT4F0MIQ7hzuHVYpMgX4PAQMBDUEBAgQBAQMEhQACingCHgcBBDIHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V7DYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjBBkBAREmAQQLCxoCJgICVgYVAQGCf?=
 =?us-ascii?q?oIwAQMOIwe3VX8zgQGCDAEBBtpbHywiV4FlCYEaLoVrgmMBimInD4FVRIE8C?=
 =?us-ascii?q?4JHMT6EQ4NbgmmCM4RMZ4lziHeOcFJ7HANZLAFVExcLBwWBKUgDgREjgSYFN?=
 =?us-ascii?q?UE6gg1pSTcCDQI1gh58gitrBAWBLYI9hEWEUYVdghSBZQMDFhABgyd4HIJZH?=
 =?us-ascii?q?UACAQttPTcJCxsGPZ5AqySibzQHgjiBZoFjDJ9cBhMvg3GTUw4GknuYfKktg?=
 =?us-ascii?q?W4DMIFcMxokgzZPAxkPjiEZhBTIBEI1PAIHCwEBAwmFRgEBijuBSwEB?=
IronPort-PHdr: A9a23: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
 dXF0q7+em4qzg==
IronPort-Data: A9a23:h7+P1a4MCh8/eGL1pmSUYwxRtPfDchMFZxGqfqrLsTDasY5as4F+v
 mYaDTyEOfbba2HxftBxaYTlpEhSvJXUzIQ1Sgc+qy4zZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtaQr414rZ8Eky5K2p4GtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj69tICWIHAtMmwcl6L3t3x
 foINho0bDnW0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/HtacGeOTtIUeg2dYasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw8grI9fBvuzKJpOB3+JS0AsbQdeLNed1ctxamo
 l6bxnjWHjhPYbRzzhLeriL03b+Q9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GRjkehUtZbA
 14V/yA0pO4z8laqR5/zRXWFTGWsuxkBR5xPHud85AzlJrfoDxixKE4BbQ9+NuIdm8IYXwUa0
 E+XterrLGk62FGKck61+rCRpDK0HCEaK24eeCMJJTfpBfG8+unfaTqQF75e/L6JszHjJd3n6
 xynxBXSap0WitMXkbq29xbLjlpAR6QlrCZkv207vUr/tmuVgbJJgaT2sjA3Ct4edu6koqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2QMJxrmvwpiP7JdwPiN2bGKuPGplUEdMOS
 BCD0T69GLcIbST0BUOKS9nqVZ96kcAM6/y8Da2JNLKinaSdhCfcoHE2Ph7Pt4wcuEkrl6Ykc
 YyWGftA/l5KYZmLOAGeHr9HuZdynn5W7TqKGfjTkU/9uZLAPyH9dFvwGADXBgzPxPjd+F2Nm
 zueXuPWoyhivBrWO3GKqNVLcAxXfRDWx/ne8qRqSwJKGSI+cElJNhMb6ehJl1VNzvQPxNTbt
 GqwQFFZw1fZjHjKY1fCIHN6Zb+lGd41oXsnNGZ+dRylyloyU7aJta0/TpoQeaV41epByfUvc
 eIJVf/dCdtySxPG2Q8nU7/DkKJYei+Gvzm+ZxieXGBnfrpLZRD4xdv/Tw6+qAgMFnWWsOU9k
 Z2B1yTaY8ExeCV/PunradaE7VC4jV4Cks1cAmrKJdhyfh330Y5IcibesN4+E/suGz7imASI5
 l2zOggKgMXwuKo3zYX5vr+FpIKXDOdOJEpWMG3F57KQNyOB3G6c7aJfceSPJxbxaXjV/fi8W
 OBr0P3MCv0Ls1JUuY5aEbww76Yf5cPqloBK3DZfA3THQFS6OIxOekDc85F0iZRM4btFtS+de
 EGFoIBaMIrUHvLVKgcaIQ59Y9mT0f0RpCLp0s00B0fH/w5ywquMVBRDHhuLiREFFoBPDqEe/
 b4DtvIVuiuFsTh7FvadjytRyXaAEWxYbYUjqaMhIdHKjigF9wh8RKLyWwHK5KOBUdFuCnURA
 yS1gfPCjotMx0CZfHsUE2PM7NVnhp8PmU5rylMGFlXUmej+p+QW2SdJ+m8dVTVlzRRg0sNyN
 FN0NkZzG768wjdwiOVHXEGuAwtnBhaJ3mDU1H0yi3z/c0mkckfvPV8NE7+B025B+l0NYwUB2
 q+TzVjUdArDfebz73MUYlFkofmydu5B3FTOt+7/FvvUAqRgRyTuh5KvQm86qxHHJ8cVr2+fr
 MlI+NdAU4HKBRQykYYaVbbDja8xTSqaLlNsWftipaMFPV/NcQGIhAShFRqDRdNvFdfrr2mDF
 M1cFuBeXU+f1QGPjAwhK4wiHrtWpMMttf0+Iu7FBGheqLaOjCtbgLSJ/AjEuWIbadFPk8E8F
 4DvSwy/AlGg3Xt6p0Kdre1vGHaJXt0fVQitgMG36LooErwAgsFNcGYz8Ke+5EvNFA1r+yOV4
 QDxXI7N7ulY0Y83tZDdIqZCIASVKN3IS+WD9j6ogelOdd/iNcTvtRsfj0vOZSB6DOA0YMtls
 Jiwq/v14R/1h6k3WGXnhJWxLalFysGsVu5xMMisDn1lsQadec3ruT0vxnuZLMFXrdZj+cWXf
 Qu0R8+uf9ozWd0G5nl0aTBbIikNGZbMcabsiiOsncuiUiFH/1T8E+qm0nv1YUVwVCwCYcT+A
 zCpncee3IlTqYAUCSIUA/1jPYRDH2bifqkbbPz0iyiTCzi5o1GFu4a6ryEa1xPwNiCmHvr5s
 LX/fTqvRCTq7euMhJtcvpdptxIaMGdljKNiNggB8tpxkHahAHRAMe0ZNo4cB4pJljDpkqv1f
 yzJcHBoHBCVse6oqvkgyI+Lssaj6u0y1hPRIzs04wWLZi3wCI7o7H6NMMt/yy8eR9ch5LjPx
 RIiFrnYIRW7hJ1kLQrWzuLumv9pn5s22VpRkX0QUKXO79I2HrgAknBsdOaIueorDOmV/Hj2y
 aMJqayoja11pYMd0SqtRpKNJCwkgQ==
IronPort-HdrOrdr: A9a23:hffUFqtojo1VkbzQdd5pGy8x7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:xspU9W6VQXusSmauC9ss2mgROfEaLEPm43r+OXaID3Z3YoSXYArF
X-Talos-MUID: =?us-ascii?q?9a23=3ACqlwvQ2s0OICo3217ISm40w82jUjz/2cFEUCr9I?=
 =?us-ascii?q?6o8CtZRJ0B2qkkBura9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205820022"
X-MGA-submission: =?us-ascii?q?MDEk9juugOCEYpeG+ntpWi/v07USF68XPjW3Nt?=
 =?us-ascii?q?tx/pjbDYlyfdprPPGRSQz2DNyD7dNf8Sitna9KRHaxAcSE5fRkkraA4x?=
 =?us-ascii?q?SghaPRYMsoGuFcA0A4j17QiKtNqL10Pt9XG1hJXkR0wDm7JkXrX/LpRi?=
 =?us-ascii?q?vOodNEdNQOGvFgdZRMQ4dwfw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 17:13:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738253614; x=1738858414; i=markus.elfring@web.de;
	bh=KdJEKQoDRN65SjSq6gwE0dLuDygJ9gU0ijN5yV+av9I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OwPUSmekBFYzzvUccNw7jSWxILsUmmlVzKvfgkjkZsYyXa8FGmk2cOyKHf6g7WFh
	 ZKAQ7gxOvH86g4c0DKH6QF3Wz8LrPzJwalF8oEKb6HvzvnnKVcBNp4ELtgGtzggwe
	 BTFCsgp+l4wU7TsX2isoqk1CblLgl8bHtlfzRsQsUsoianLw/or71LjLpTei8EMYT
	 NIp+mnGzEJc3ZEfEFrs7spZpeGz9OZFMwgD5PHLRGEOqFunS/KkIYy+Zhv3FFf60h
	 0tqH0KFYNpOCgLvoSwLyg2z2dK+6yw63Bl+lMctn+oYR913vDKS8gW9M+XRDqNgjb
	 5nOmV2NUY4YyggScQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCqb-1t6f7R1lXD-00pWrc; Thu, 30
 Jan 2025 17:13:34 +0100
Message-ID: <ca320aa9-a7e5-413f-8164-060ff9d50068@web.de>
Date: Thu, 30 Jan 2025 17:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
References: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
 <b2b1e1bf-af3f-c7b4-e278-798578b02442@inria.fr>
Content-Language: en-GB
Cc: cocci@inria.fr, Maxime Ripard <mripard@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b2b1e1bf-af3f-c7b4-e278-798578b02442@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BIpUSkDVRLNpwlQEHqeePsqzJ+5ByGkIv2CmD28M2DPllLPRt9E
 yPO4262bYfz1V3ZRmJODhvlca/IgXv5bCxIvHSWkvCDqc2pHLVNFEFRvnkNrLZFt21OREL2
 t57Tt6MPmWfKBOeEoMNURKGHY6uDcr7dyOT1jP+mCgLVTIU7rkj33yNMOrEYaHVb02vDGPp
 /PnOl6JLFF4LpZxsg5Qgw==
UI-OutboundReport: notjunk:1;M01:P0:+E+LR4gKDwc=;oSiZ+Kj363PP7+hzMGu9erEcAWC
 wGmU12D5ZFNhz1i5c0jwdOf4T8e852CMEM24b4JPzFXcROdutRLE+SxASXlsrXGyahiu55ZRo
 cAiE5OQXL/VBKXLmOz7HUOE6mimJXD2BS5JmIXwkSh0IleliChWUo5MdzfxTOe4RZ69j/pM4a
 /tiMozh5XGDVArLL3ZJy6u8h6mb/JXld6LG+HIoS9wjrf36oilA9x7Tx64flukA2yWh1qYQO/
 zd0MF5Zo1+ISQAHy831z/w1vM963B3WVypjfe7tEzwBPGA38KYNGLV7QwPZtAXaIQuLW2FcZi
 FUn6MC+cVsJw1INq+tElikQ7XjoQVMjDr8HCZ9LNKqVWQnldtXL3e7/g54gal9iTMbEECU0LI
 6443pOk/jyMJu+zve/HTAsHsqFgXEEukAHTKTuO7prLHi14C1BaWVEJqU+hYnOA0E4TJd9nqb
 HRCr2UY0RlrL9hDGUWVBjBuVxIBknXaKRr7Oq0JR4/kMfzZw3OJcv5pcyfQg2hw9q7lFg6iZt
 DXMF/igIsCj9Ynn+jeojtGnwx0gKyefu0BIjoqfX/0eo1ufYQONceJvUeCstTI9YDrwlnhO6A
 kGr7F30KQSkwXtfCfSmZg/Z93kMxPbXnSiq4DEXVYd779EmOAI7Mt81HLakBLeyIVzdZOzZyR
 Vpsihr/llwpglxrsBxaAGprvCv19v01k30zLT+o448JX8OPfRdF8N46yAECyy7VBuTYVE1Fo2
 Rz4u4XTHpvjMZyaApWVvv8lJ848jSDITQ8VCabS+Kdce/yVo51+0ovQV0LekNUo8STh/OoA2N
 udaiRSV278owPRv2PPTpo3rf7CZdEoiFYdSWoMsPgKvA6g8UjMxuIzXzdxEoRy0M7zO8lXwXU
 e0o+BnTRw3uVV2kDmXCBjBs5fESi8jnobrHM61MG4pgOHwre2H8m0YkVS7Iv3n23eDu+1aApk
 agFuRXV1XtWXIaHjFDz/Y4YzE3UB4tWlCms7aqRhDx5oG/xQqSM53j9U8Cnt0jlHKgCaml9xb
 F70nyskrFZ+pIBH8FpO29zIfV6G5biQDkJ6T+1oruLZPCCn3V75RFpnRAOLDKyxzWKwGcGQrn
 eFwc+couv6oM6dGTECNtiiazNBJr/T3wQWfUnaVCoGS7KRHQIaqkcJ9TqsKJM7i/TpZiK8EwK
 jXGMLehd2Px9Fk1P1V7eqUtqToafa8b47uPMktKKUCA==
Subject: Re: [cocci] Help to match variables with different names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2324
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/ca320aa9-a7e5-413f-8164-060ff9d50068%40web.de>

>         struct drm_atomic_state *atomic_state =3D old_bridge_state->base=
.state;
>
> You have made state a metavariable so the declared variable name has to =
be
> the same as the field name.  Probably you want to use something other th=
an
> state as the indentifier metavariable name.
Would you really like to indicate that it can be problematic to use the sa=
me
identifier for a metavariable (in SmPL code) if it is also used as
a variable name (in C code)?

Regards,
Markus
