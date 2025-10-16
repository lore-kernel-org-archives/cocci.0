Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4659CCD193
	for <cocci@archiver.kernel.org>; Mon, 20 Oct 2025 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WoIwPesL5XpR61/TvXRYE4HZ1QXML3AmqwHjRG6wUdA=;
  b=NuSuzksFAus00rhUcld3SaseyyTRijYqA4qC/KlZ7o3+frPRfU68mjwi
   Eul5BRe0IqyM8b0U6ajli8ub+oUYeApNFq5zp3PQsaFVfvpvtoKoc+IyZ
   W6ofWZvcPJTUxt6OGaeSP7vYsX17j8RXfKpPj3kW39KAKLKMLf7wOAOkh
   U=;
X-CSE-ConnectionGUID: Ri3NYvcpRku4O0TTSTCuOQ==
X-CSE-MsgGUID: ZhRyU7NeSmyMqKWRGcU5mA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.19,242,1754949600"; 
   d="scan'208";a="245166551"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2025 10:45:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2A6BE0D73; Mon, 20 Oct 2025 10:45:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AFD02E0171
	for <cocci@sympa.inria.fr>; Thu, 16 Oct 2025 08:17:14 +0200 (CEST)
X-CSE-ConnectionGUID: +soSBTzAT8auDvwiFssAeQ==
X-CSE-MsgGUID: bT5hpWlPQz62cf5/CPwSng==
IronPort-SDR: 68f08dea_y26rBgrQ2DhDTgywzS5lQwLAzwu+oNMpWXNlNr8SrmPtQMa
 s7yZOvrSX/YiFPdEwXzo9z8jXEeEZ9RQohxBXPQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ErAAC5jPBogTOAVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYI/gQhYMwRUhFWIHIc2giSEO5gKgVWBfQIPAQMBCwEBUQQBAQMEh?=
 =?us-ascii?q?HYKAoxMAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBIhkHDjuGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQMSER0BA?=
 =?us-ascii?q?TcBDwsYAgImAgIzAQUBHAYBEgIBAR6CYIIjAQZKAwSkF4EFQos+gTKBAYIMA?=
 =?us-ascii?q?QEG3CWBZAkJAQqBCC4BhWyCZAGFY0SDQ3onD4FVRIE8glIxPoRYg0aCaYESg?=
 =?us-ascii?q?RSBDoYwil+GJlJ4HANZLAFVExcLBwVbRRAzAyAKNC0CFA0iDxoFLR1zDCgSE?=
 =?us-ascii?q?B8cE2BUQINJDwwGaA8GgRMZSQICAgUCQjqBaQUBHAYfEgIDAQICOlcNgXcCA?=
 =?us-ascii?q?gICgi6BEIIqD4VsAgELbT03BgMLGwY9kxCGSimTJJFUoUU0B4QfgV4GDIMAn?=
 =?us-ascii?q?GwGDwQvg3EBEpNOFJMFLodckHwigjamPgIKBwcRJIFEOoFcTTCDKk8DGQ+OI?=
 =?us-ascii?q?YkTu0pBNTwCBwsBAQMJhkiLVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DL0LnKHiUkNPEYjPpLqELceALOsnbusQ8zAX/mhsVBpeadyAiq
 mV7YgmPNHP+U4ssQIb6K290c67MALhHP9OkPcs1NKZNjUO11HYSb2KgbGSuQEIXheOidK1tp
 0QF5SWaueAb2SS5PySiGLIcOrIguP3i5xA7d2/854Hd3ANV0gP1XYBNu/WKDwQeCB2QbQ8UL
 STj/Apm9NiQxgqhwaAa0Xtk9KsmzQDrvPbXSI=
X-Talos-CUID: 9a23:GRtsLWDaAkobH336E2p883U+JtIMTi3U0VvOPE6WEn1ARYTAHA==
X-Talos-MUID: 9a23:MYSAtQYisdjbDOBTvQOxhCldMP9R8fr0A05Q1r4+pPKCOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,233,1754949600"; 
   d="scan'208";a="128340456"
X-MGA-submission: =?us-ascii?q?MDFLHi+QY6bw8ebwBRvjYfip1pNF/fDzB5Q+4X?=
 =?us-ascii?q?yEAT9+f/y4wzRzdxn/i2Q5VCE1qY1huRo7WOcI0e//52n58UPGQv2iks?=
 =?us-ascii?q?ofuKNTPy1Sa669zOXUmduLicpd8q8pwAOJH+d9SaIV0j+xu4776EYkYB?=
 =?us-ascii?q?eSSjQJcmQZ9XnCVAAWf/uGmA=3D=3D?=
Received: from mail-wm1-f51.google.com ([209.85.128.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:17:14 +0200
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710653ac03so347525e9.2
        for <cocci@inria.fr>; Wed, 15 Oct 2025 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760595433; x=1761200233; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WoIwPesL5XpR61/TvXRYE4HZ1QXML3AmqwHjRG6wUdA=;
        b=GoDhODubUb2bySWFSTjirs3Ymr4F05hD+qHvyCYITYxTJVA2AzpMwG/Cy22/gEY58v
         jcUNH03ylHy+luGFJLXriNRqSnJB5ymJxg8g+wLfaVV0CFNW58isD14PGMnZiWhhyhG5
         Glah/aA5ZYZXTyAkRIjkN7fLQDFHx6+i6tQc76Xe47cgBOQmFWLysNMG2KO+3IzaEt6p
         XutffzWZRhxiLVyIBr7vsk3aSAabcVJnSGpKAAPNfwwcG3kdZkivMwtilV7S9ZenrIDc
         UwY01xEABksoLbu1EQ89oji1/KicRp0JjF4yEvH5DTB0TeOn/IX/v5Ut81/LxC72z9wu
         Lh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595433; x=1761200233;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoIwPesL5XpR61/TvXRYE4HZ1QXML3AmqwHjRG6wUdA=;
        b=QELsN1fl/9HNKpsY+ST2TpNLeAH50StbzBrcvFj46/OGaR77MPPGRDYYD7XuDfjC/n
         mZcMZrptkXlI45DqfhmsXKQw971RBwto0EnDcfqr00iQWOIvSBT6fsTk9FwPdptcQBtD
         AzKL+JkliSv2AmtmvfwXIoFKTTgazqUIoht9g58niKayuptwyH6J4Ve5RTgU4+76Ch8d
         yze236gQ3bbeE+GX0MP+Sy9YQb8SQeVtVg85qM/2wrDfe4vKekKW9SbQOSc337krc3dl
         7al8NWAHi/PPmNK3PRZ1GJheVa6MEdbc3WwZCiGZ+gNvMZoSMk6Ppv94lsAE2Z+FYg1Y
         ClyQ==
X-Gm-Message-State: AOJu0YxG9Acz2YpCrpwv++M0v3SY7ZhQy0qp68EF/kXQ2ObUJOW+UGNH
	jJ4ax1SzpHGqatvjb3hTQB+99mUtPmUXcotBXII+XFEsXMCEzlq9XFz0Bpw05N/kel4=
X-Gm-Gg: ASbGncuxWmw3nDK0bZLPLjKC76w4eDQHHv0/loEnJsGSxRfKtyt3hlqf0HeouckCqoO
	WBTvyzvTQAgVWtSlnCnZmqzel8vPgROWoHSsu13etczr+KUrcF3mMw6B98XY6ToB0PWboITSh7P
	zn0Ghy2oVo3uuT6rBzdpLVsFdF6+So3Shc521+zvEUzXb/k8D5ch5tVuJlx1gDRa7Rtdl1xiMlJ
	q7b47ZNBJMbEr3BqjrdUNVJmSerag0GAyxAPQroLia8W0edeVtN7WepGn/UJmdtp8oIKVpQZezl
	buMcAI3o9j1pDICFJ5sEWHAENFflwJio11Gw/swqsaWSWEYLPVv9PjealLnqY7mRfXhxhf/7CsE
	sWn8RzluaQTg4ZxKA1O/NwroO/ijBf+nEUTnsMVZBadVBUB0rqVWNuhvhbpuhNSGXytfh2tzhCC
	oEETpDCTtj7jLCdJl25Q639gyaoUHsYWDxIMo=
X-Google-Smtp-Source: AGHT+IG/IYomOG5XaNPBZPm/Glkc9oa077sabUFANBbP3yRl+yJ/TdbVQrDC5CKEbYhdr97UhgnaGQ==
X-Received: by 2002:a05:6000:604:b0:3f3:1695:7c49 with SMTP id ffacd0b85a97d-4266e8e0af6mr10653642f8f.7.1760595433112;
        Wed, 15 Oct 2025 23:17:13 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ff65596csm1598217f8f.24.2025.10.15.23.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 23:17:12 -0700 (PDT)
Message-ID: <df04c765-5db1-42f8-946a-e56739e45d7d@linaro.org>
Date: Thu, 16 Oct 2025 08:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org
References: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: of_table: Update Keywords for SPI
 device ID tables
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 3088
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/df04c765-5db1-42f8-946a-e56739e45d7d%40linaro.org>

On 14/10/2025 17:12, Geert Uytterhoeven wrote:
> When adding support for SPI device ID tables, the keywords in the header
> were not updated.
> 
> Fixes: 347b564599fb01d8 ("coccinelle: of_table: handle SPI device ID tables")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
