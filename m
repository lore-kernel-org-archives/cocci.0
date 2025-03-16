Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B9CC282DE
	for <cocci@archiver.kernel.org>; Sun, 16 Mar 2025 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vAff0aee3rul/N7q848YKkFuTPRfb8ln1tKjMsKXO74=;
  b=HrE/wCJ1Du/soS1owPlKQUvqoygebD7huQLp41nZXVMEiqXIkec8h8Ig
   xwpGACi2rjpfukm0jqPcHo1zfAHAhX5DwPZZG2Z21tq8o3Lq2U+EhZyIe
   TlsiKD7w6NN9ssPrRau/y+eDAY0oP80mC/fJTTjeNlGojk6FS7cG3FpNi
   w=;
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
X-IronPort-AV: E=Sophos;i="6.14,251,1736809200"; 
   d="scan'208";a="213081417"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2025 09:51:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25C77E0264; Sun, 16 Mar 2025 09:51:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 91A9CE0260
	for <cocci@sympa.inria.fr>; Sun, 16 Mar 2025 09:51:04 +0100 (CET)
IronPort-SDR: 67d690f8_lMc8YE3sLmkUXSV7axGPNkIba1T+o1cPqA6G6CvGlpgxdvn
 /FWXHX7gAjG7XJ+y50HygFEhPg6wsNXuNLOevcg==
X-IPAS-Result: =?us-ascii?q?A0H1AQAAkNZne07ASNlaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPUIF0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACix4CH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiIA47h?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsODAImA?=
 =?us-ascii?q?gJWBgEUAQGCfoIwAQMOIweuM4EygQGCDAEBBtpcHywiV4FlCYEaLgGFbIJjA?=
 =?us-ascii?q?YVsO4NCeicPgVVEgTwLgng+iB6CaYIzhEBnmXePdlJ7HANZLAFVExcLBwWBK?=
 =?us-ascii?q?UMDKjQxI4EjBTQKNziCC2lJOgINAjWCGyRYgihqBAWBJII2hDyEP4VQghGBX?=
 =?us-ascii?q?QMDIgGCMG91HINLdj2EYS1QgRcdQAIBC209NwkLGwY9oymGUZg2Aa9UNAeCO?=
 =?us-ascii?q?IFmgWMMn14GEy+DcAGTVQ4Gkn0umFAiqRGBfSSBXDMaJIM2TwMZD44hhC3Id?=
 =?us-ascii?q?kI1PAIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GxIBhqu+HAczV01DL14gZT/G7skDotV00zEX/kB9WHVpmwKj5q
 OTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BkWyF+rgboOWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3A9MUpXmhwaPZnI9RIXdx5MLvhYjJuaSXikU7pBAi?=
 =?us-ascii?q?CVThoeo2wDnSc1Kojqp87?=
X-Talos-MUID: 9a23:G80BewaRHDAEauBT7zblohhhCdpS5+eUK2wks65XkfWBOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,251,1736809200"; 
   d="scan'208";a="213081411"
X-MGA-submission: =?us-ascii?q?MDEX3robqply4Ujngu6D3mp+XnYJrAJkpsRU6I?=
 =?us-ascii?q?vO1s3Rc/lsi3f2CT/v9UD24cZrJBofwR5PGf+Drz2wMcAXY18fIweCX8?=
 =?us-ascii?q?i3f96i+de2d5ddNopzccrJBFWXjcCicxUNokRQdpnRlLh8czI0CktySn?=
 =?us-ascii?q?ckM1a8/H+4lpjHI+JQ43XvAA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 09:51:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742115052; x=1742719852; i=markus.elfring@web.de;
	bh=vAff0aee3rul/N7q848YKkFuTPRfb8ln1tKjMsKXO74=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kFF1x8+K7f1TIYXk0J+TiVaWSoeXR/8crYCPBZT7nQqSx+9n/KRHGSaflWlhV3SL
	 rF0raJ2ppRNwHcmqeoJXyh/GP1iyajQfaWxBN0nRBgpsySmexLFXUG2yU4iGVfwmc
	 hwo8kVkskaKkZ4GzOj72GjBlLK+lrT1fTg2ebchAPk0OpOQ4m/UJq3zX0B3apz7Lo
	 pza84namq0tJ5k/hKW0c+1w9YoMMqhN9r913vl38cJ84eoL7YnQiJTvCle73jfXM3
	 oI5sDjFOUZGWg/R+X5A5V3cwQomhe89YjU3rpgrB6rZD2yE893yyMXmItS0c7qH9r
	 y3/22mPeosHnm9NYyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.60]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1tXW870xxT-00MepM; Sun, 16
 Mar 2025 09:50:52 +0100
Message-ID: <aa403b90-5479-4beb-92f5-d8f33773b923@web.de>
Date: Sun, 16 Mar 2025 09:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Gleixner <tglx@linutronix.de>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew@lunn.ch>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Gregory Clement <gregory.clement@bootlin.com>, Guo Ren <guoren@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jiri Slaby <jirislaby@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Samuel Holland <samuel@sholland.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Talel Shenhar <talel@amazon.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
References: <20250313142404.896902416@linutronix.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250313142404.896902416@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xy3Yson5TdObRf0N/SURy+6vxAvi28ZaIz75v4YI+eFy9jMgCnf
 Nzzrrbxs9TbdI8aNEkVBN0pm/+AjvKzYWB35d3jBTmQCen2t/NcOLq74GfuHRBR5kInFWYF
 /BY7ks2CCn5+dNXw9Lxc1g42YDcW3mTycO4d+sHuwHv0GjKRzUd/gz9q6ar+IY/nlbPY+ia
 TH3mSFg1etUtX5E8SV8VQ==
UI-OutboundReport: notjunk:1;M01:P0:51w44oArk1o=;k+F4f3IFOUW1k/lwqjQc2MCr+q5
 A7JWSZqr9NWA3sEmtLYW67m4maYYgRRtB7g/jcYBfDm7ATQJ0eeR387AIrXQZ3yzW7c0oYfkL
 lJ2bEKewl0Cs3JCXcS6PvkORhnIt0dYXnBdyeZigCCy3GLDnqtHp/dQG1leoyTeq0nQrKogdc
 WZUlAwux3ZMVD9rNRPNDaO+MmczK0ZQZFOysIWd6Vzd/MlmOUtP7WY6I+qoV1U0DACjEjyhEE
 4kiC/3vVW80/iszCy2hnCXoGuh9v4aTPaa627iFeOMd0fz8KNoTlIOd5tOCrSvW0QMlTFoJ+p
 FpVfzq9gqDUKxhFQ3p5HHdGDaeQf5OODQcFC/84lxCVA1KlzNDhyb6N4mWvJQ3QJ43zYqQb3/
 8E+SsMWc/yWB6XrhXLqjvAGy6SdjD7zYXqZJ8I0D0Us6V+YIVsIo+srYTz18+m59zQW2jSsIa
 1iHC+MCEYo9+FyM+C1al50f4JqH+BOg/kuJQnilpoNZ+S8Wc0J1Gxb65YDAswG9u3S7Z+YEay
 MA20Roj3WrvPdHC/HcRGi221ctojkkC/Tix8geBr7mfHN7KA0RowqLyPtaSl5abuvNtzzTYjH
 +brQRKH/BwcRWoqaOpiFDCnkHJ9XB9n+CpSsJSjWvYVDWxAYfacmz42XHL9vvxZa8x6Trmvgv
 iwR+u/5g/AdrCQwXgCetoftuB/gAC3I2qY0BtDqwxebA6aliwipsu/qLn+GKLdmH0xBwLs4hE
 +QkNlZkbNlLcGBbxZCjx0UWx13lMpIrDUx/L6eiSWDuei1vUhP0gpLnS6ecML5n+5IBJLj12L
 yymOc3QXUwmnzQJvdReDmBhcc/ucOtl8NPzkDQZdn0yh3netXZ/2//9OwMH9+1YCMWK85ECUO
 MV8At6h0JQYzIKRwyY21aVa9lqCQuHUc+2ASib2DxOQg58/VTImbYAqahEK6HU0a7Ve44Alyy
 bM7iyP2oT2XwfxJCgKMOJ4IktJ3L5cdCzI/8n1eB9je5LvLDJFSWLI+Tf6Ic/hQhnr8NlB+7b
 Zu4FYw5vjdGCr73mj8h7eQKBCyvAMZn5aWWryYFVrGvGZXTjNLrCd6jpYJL15TqcVy8Xtmxe+
 ZPKKoRL97+bdWl2LRcEECsyGreOtln9dFvpcF4M/n4ZP8WgahtAszgWsM4PWdjkbQ8yRtO4dW
 CyhAIJPXmbXN2nsgltIqTlDJ7z8LmGD8uBKHws6/EXGw3xMlm5MP6Hteq22+AXcOoTKO8Ytao
 KTkaZRtTJQT+ysvHSKLi6xwueOIjLblW5nmkAkg76NulgrG+dS/MpB6vURfOSj//XRGHOtFK9
 T0XBTi5HwFwesqkrthpC253M+vKLSwL6Z2y95OIE8qTlbD+I2R4SOMBPTNMrkp5ebYjFAZcy8
 P1RPI3UAMfmvn5nzPN47C6Q9xdWGvPTTyoj8zYJ0zv+Fa+bNZYfLjnhuQ9/OTxlEGjE/ooQ50
 xtRwWaun4IFJ3FNJUZLFHpiiKYZTOVrJuxRlg9mkxQuwi8/Bp
Subject: Re: [cocci] [patch 0/7] genirq/generic_chip: Convert locking to
 guards
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2585
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/aa403b90-5479-4beb-92f5-d8f33773b923%40web.de>

> The following series converts the generic chip locking to lock guards,
> which reduces code size and improves readability.
>
> The conversion was largely done with Coccinelle.

Would you like to share any more from your evolving collection of scripts
for the semantic patch language?

Regards,
Markus
