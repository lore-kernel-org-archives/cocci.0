Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C1FD0651
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
  b=QFca2wTutXVSK4dFpPZNBvEQdRgMbvHk6qlpU0XKbe29ILKjmEDOp6JY
   2KisysViXvyFIHViMeJZcuRZKr3OX5vMbXvbqyLkqJKo3Tb9nMUC5OpKx
   gnRwSo3GL8aEvI/JEkhsPOPHzf0IMao9xjbQO1jblE5xFcPoL0f/WxdrR
   w=;
X-CSE-ConnectionGUID: M/EWe1PbSoSfT19C3P08AQ==
X-CSE-MsgGUID: JUs6iAkITfOSZWrss/H+hw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267314494"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 15:38:33 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AB278819C5; Wed, 11 Mar 2026 15:38:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 932EE81977
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 14:16:09 +0100 (CET)
X-CSE-ConnectionGUID: 1FeTkX5HQBOAhLZFCmQWzQ==
X-CSE-MsgGUID: s01obhU/Q5ebFSet886nSQ==
IronPort-SDR: 69b16b1a_rXD3bUsbNzY0mmMMutm+cRMw8o951aG6fBr7CCx69czYSvN
 XXcANkS0gMhdm59vx0X8e7WwitgQkE9I+18GiyA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EsAgCEarFpfLbdVdFagQmBUIJBgWYzBFSEWIh7hliCJ?=
 =?us-ascii?q?J4agg4BAwEMAVEEAQGSLAIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABASIZBw4SKYZcgmIBhAABBRIRVhALCwMKAgImAgIhE?=
 =?us-ascii?q?gEFARwGEyKFVAOjDIECQos9gTKBAd4+gXAJAQsBgQkuhW+CZQGBcINqGoR6J?=
 =?us-ascii?q?xuCDYEVNYJ1PogegmkEgiKBDokKiXMmCR0DBwcODR5GDwUcA1ksAVUTFwsHB?=
 =?us-ascii?q?V5FQwECAYEFI0sFLR2BIyEdFxQfWBsHBRIhKgdeY3iCAQ+GZwF5Ay5eGg4iA?=
 =?us-ascii?q?jpcgQYLWgWCLAIcAwtiCz03FBtKjmI9gjMCgmlkNsZkCIQegWSgDjOBS5YHk?=
 =?us-ascii?q?xkuh2WQc6kWAgoHBxEkgUsHLIFcfQhsBoIwTwMZD9seQjU8AgcLAQEDCZIeg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23:dxjcYRAFTlNPIyozT+vmUyQUkkoY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua4xygeRFt+LsKMUw8Pt8IneGkU4qa6bt34DdJEeHzQksu4x2yEGPouuJHa/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 hq7oR/NusUKjoduNKU8xxXNr3ZLZu9b2X5mKVWPkhnz4cu94IRt+DlKtfI78M5AX6T6f6AmQ
 rFdET8rLWM76tD1uBfaVQeB6WMSXWoPnhdWDAbL8Qn2UZjtvCT0sOp9wzSaMtbtTb8oQzSi7
 rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2VfQslRVjRBAoKiY
 IsJE+oBJvtTo43kq1cTsReyGQygCeXywTFKm3D2x7U33OsvEQ7E3AIuEdEAvmnKotjrKKgfS
 vy1wLXSwDnfc/9axTXw5Y7VeR4hu/GMWrdwfNLQx0YxCQzFlEmQopHrMDKVyuQNr3aU7/BgV
 eKolWEntR9+oj6yzcorhYnGmJwaykrY9ShixIY1JNu4SFN0YNK9FZtdtiKXN4hsTsMlWWFot
 z83x7sbspG0YCYE0o4oxwLDa/OZaYiI5AruWeWRLDl2hH9oeK6zihex/EWiyODxV8i53lZUo
 ydLltTBtG0A2hPc5MWEV/dz/kas1SuS2g7c6+xJJUE5mKTFJpMn37U+lYITvFzdEiPqnEj6l
 qybe0U+9uS29ejrf6/qqoKfOoNqkg3yLLgil8ilDek7MgUCRXaX9fqh2LH54EH0QrtHg/srm
 afDqp/aP94UpquhDg9VzIkj7xG/Ai+j0NsCnHkHKEtJeAyEj4T0Il3OLu30APShj1i2nzdrw
 PfGPrLlAprTNHTMjLDhfbNl505dzgo808xf6opKBr0dJP//QEz8udzCAhMnLQC43vzrBMh+2
 48AQW6PB7WWMKLWsV+G/OIvJOyMaZcauDnjNfcl/eLugWUkmV4dYampwYUYaGq4HvRhPUqZf
 2TjgtEaHGcFuwoxVu3qiFmYXTFPYHayWrow5isnB4K+EYfDWoetjaSd0ye8ApJZemFGB0uXE
 XbocoWEQ+0DZDiTIs9niDwEVKKuR5Uv1RG0rAP6zaFoIfLO+iIErZLjyMR15+rLmB0v7TB0A
 NqS02aOQW9uhm4HSSI40LhloUNj1FeN0rJ2juRdFdNJ5vNJVh42NYDfz+BnEtzyVB/Nc9SXR
 Fq8TdWmBjYxTt01w9AQeUpyB9KijhXb0yW3AL8VlrmLCYQs/KzT0Xf/OdpzxmrA2qU5klYmR
 9FANXe6iaNn7wbdHpbHnUqBm6axbaQc0jbA+n2fwGSToU9USBVwUb3LXX8HZkvZs9D55kTaQ
 rG2ELopKgRPmoa+Lf5yatztjE1eDNfqONKWN3qxkme2QBGT3ZuFco+sd2hLjwvHD01RvA0e5
 2rOCBkiGiq7o2XTEjFoXQbgbk727cF6qXWmXgoxkVGJKUp72OzmqVYumfWARqZLjfo/syA7p
 mAxRQ7ltzq3I9+Jpg47Ob5Zfct4+lBMk2TQqw16OJWkaaFknF8XNQpt7Av1zxsiLIJGnIAxq
 W8yihJoIPeX3V5baxuc3JbtKvjSdDnxuhe1ZP2ewUnQhe6f4bxH8/EksxPmtQCtGFAl9iBo3
 tRPzz2B94nWARASVp/vX0Af+B1zprWcaS44tMvPzXM5F66yv3fZ3s4xQusozhH1Z9BELKaND
 xP/CeUfDsmqbfIpwh2nN0Jeeu9V86EwMoWtcP7uNLeDGuFmkXrmiG1G5No4yUeQ729mTeWO2
 Z8Zwvae1w/BVjHmjV7nvNql0YZDLSofGGay002GTMZYe7FycIAXCGyvP9z/x9NwgIToUmJZ8
 1jrDk0P2cugcx6fJ1Ln2ggY2UMSqH2h0Sy2ql482z4ko7CD9CjPxfnyMR9Zam0NQ3NtzB/tL
 YWyk9EGTR2wdQF63BCh5Ev82+1avPEldziVERoOJXKvaTgyCPjV1PLKecNE5ZI2vD8CVe29Z
 QrfUbvhu14A1CilGWJCxTc9fjXsu5PjnhU8hnjOSRQ75HffZ8x0wg/SodLGQvsElDULSTNkz
 yTGGkSxJdmu8MuZkb/Mt+m/UySqUZgZIkyJhcuQ8TC242FnG0j1kP2+gMHPFQk8zD++0oc6V
 mPPthm2MeyJn+yqdOlgeEdvHlr17cF3T5p/noUHj5YVwXEGh5+R8BLriE/LOM5AkeL7ZXsJH
 3sQxsLNpRLi0wtlJ26IwITwUjOcxNFgbp+0eDFe1iU45sFMQKCaid4M1SR4r0Ck6x/AfeRwh
 DcaxOUj7lYVhugIvEwmySDVDr0JHEZeNDDhjFzSt4H4/PgRPjz2N+HgjgJ3hrXDRPmarxtZW
 Wrld5tqBiJ24shlcRrN3HD19oD4aYzVZNMXuAeTlkSl7aAdI5Ywm/wWwCt/bDil7Dt1lqhh1
 0UohMHg7+3lYy138am0AwBVLGjwbsIXoHT2iLpG29yR1MapF4lgHTMCWN3pS+ipGXQcr6eCV
 U7GHTsip3OcAbeaExWY7RIsoH/CCYztKmCLOHQDzdJvWhSbDENaiQEQGj49m9Rqc2LijNyka
 0p/6j0LsxT3pxZW1qR1JgXjX33fowq2ZzEcR52WLR4Q5QZHrRSwU4TW/qd4GCdW+YekpQqGJ
 zmAZghGOmoOX1SNG1HpOrT9rcmF6eWTAfCyauffebjb4/ILTO+GnNj8t+kutybJLMiEOWNuS
 uE2ylYWF24sANzXwn0OU3BFyH6LNpTG4k/6omou8Ii+6Ki5Alq+o9vSTeIIYZM3vEnp5MXLf
 ++I2nQjcW4BhM9cmyealOhBgAxAzHwwPzi1T+Za6XaRHvyAwvcFU0ZDM3Ehc5AWisB0lghVZ
 5yB1IuqhLAohKZnVw8dDQ6z3Zr3Lc0SfTPnZAufVh2FbObafWWTkZOwOv3ZK/UYjf0K5Ue54
 W7JShO+Zmbfz2GxBULoar8EjTnFbkZV4I/vfBwwUTq/FIq+OE/8a4E/mzQyxfdcamriE2kaP
 HA8dkpMqufV9iZEmrBlHGcH6HN5LO6CkiLf7u/CK59Qv+E5SiJz3/lX5ng30d43pGlNWeB1l
 S3Or9Vvv0Duk++BzSBiWQZPrTADjZyCvEFrM6HUvpdaXnOM8BUI5GSWQxMEwrktQsXooLxVw
 8PTmbjbLT5D95fK/pJZCZGEcoSIN30uNRevEznRTUMEQTOtKWDDlhldnfWVpRj35tAxrpnhn
 oZLS6cODgRkUKNHTB4/RZpbcM0kO1Fs2aSWh8MJ+3ek+RzYRcEA+4vCSurXG/LkbjCQkbhDY
 RIMh7L+N4UacIPhiCkAIhF3mprHH03IUJVDuCpkO0U7rUhX7D5jX3Ev1ljlbQ6z7Xk7Gvu9n
 xpwgQx7K7dIln+k8xIsK1zGqTFl2lE2gsngiCuNfSTZKa6xWcRICHOxuRFhaNX0RAF6aQD0l
 kthfmShJfoZn/5rcmZljxXZsJ1EFKtHTKFKVxQXwOmee/Qi1Vk0QsSPwEZG4a7bCsInmlJ6K
 9ijqHVP3w8lZ9kwd/S4zE9hyllWm7LLu3H41aY22gBMfy7lH0udfScJvAoDMbx0fkKV
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:VIuoda0ohm7fDFnRQQqkVgqjBC8kLtp133Aq2lEZdPWaSL3nqy
 nOpoVr6faaskdoZJhNo6H4BEDEewK7yXcX2/h0AV7BZniahILAFugLhuuSoAEIWReOkdK1vZ
 0AT0EUMqyNMbEVt7eE3CCIV/kn28eO662liKPzyH13XRh2Z6wI1WoJaDqzIwlZQE1oCZIlCI
 GR/KN81kCdUEVSQMD+KHdtZYf+Th7w+K7OUFopAxYm7U2pljOn6LnzFly90g0FWz1ChZcOmF
 K16DARJJ/Ijxhz8HGsslPu0w==
X-Talos-CUID: 9a23:XNy3sm7bBpLbLomudNssrWAZJsMVL13k5lD5I2uKJ01scYKHcArF
X-Talos-MUID: 9a23:SiDHmguFFOBikBSvjM2nn2k7M81o3uOXVU0Hv64Lp5nUaypLAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267293387"
X-MGA-submission: =?us-ascii?q?MDHKwpyoewtNBk23FmDQ5aVGOYxOKTj8CWgCJx?=
 =?us-ascii?q?XF7s4jyY00rMPCTGUSKEZUja0smav62W5Q/LNxxMI0aWwFhYVEWfDteT?=
 =?us-ascii?q?nqWLCi5fP3E2ssb8YZMCkyHxQ7c9O1uKWCFcVn1gwmqE56PwiTvmGEWq?=
 =?us-ascii?q?S+AHosTocMWmUDlU3fDLw8iQ=3D=3D?=
Received: from mail-vk1-f182.google.com ([209.85.221.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 14:16:09 +0100
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10524068e0c.0
        for <cocci@inria.fr>; Wed, 11 Mar 2026 06:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234968; x=1773839768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=vP0mEmWtzXeG9hR4pzeP0SicGTIapq/XqtFl5+cnTBHaEWTLw9rl95RLjRDkvPCL3K
         QKyEv4MuQkdr8f6Rqc+yCU8HnqZ901lBpTm9CxMF0xn/qHzY6N9eNHQBeXs01k4b4JRM
         tBEmCOKEA3WH/1WC6uOi37wccczOTfhBE+C2JN76MvYG8XpCca/DsPXE+fi9qVWdh8Zl
         IqgZzqmb7VuNb9juf6JnmG9KK+ABOURzySZFs07ZvhGkItID4+B3quZgNvIiFlU/ix23
         LMdeOuB/WxCtBD9YTjI47Xfr9MwNxUCf+y82NS0PIOHZSJfYbBLhzsju/cXYZNlZ/WWt
         j45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXgVvRppz8rwCVzRbI9OfKnf81iOmGlSdukqvPtydYGR+1hwTO3DYwBduZtPNAtNK5YfePBA==@inria.fr
X-Gm-Message-State: AOJu0YyGYKMYRxQagEmU4MzrVGwPWr+raKsks+vIXO5Zs7+Ou/o4Ekou
	ZBKpciGTKtvEx4tV9Wwplzn1hSL1nvAzNNIsaLvWmLHaDH30gXadjT/l9rbHeDi0c8I=
X-Gm-Gg: ATEYQzxGNdFSNQFioDrjTWVoJcxOUBJNNgxMCCQ40Nfg1dJ/e5Tk/I269roRj0SQlwV
	Zx80aBrFdOpgdngu64iWZC80zRceSBDUeGiRfuHPtrVfEHG5S0pM25oPlgRC86mCjx3FXk/ib3q
	NReiRm9cYaXUQgT+Kxv77nD7aJf/72Z9ahcjsEh+7dmiHPQ8hhOBBOLUADH7Gqr4/42fdlY6phi
	YJXmd7r2YKn9L7CmaqT3m6daHCaL7WM0Ul7WXvSI7qZvjVK07+i6UQL5UVhYKxCdDBNgZy9GeVT
	UicDKuDQbaqTYohRFGMlVkd6dRskijLJXL3MRSiTxRtAYWfypQ7e71MwHr6Ksd5aJX6oWOjsZyV
	pMEHVJHklPeO8w6i7Yu4xDl1rLyFC7coZujynAuMGrf5qXXR5dzdE+laRxezbQrjCZZga08uPvp
	pjsWrl1Dn6W1ELzPKpIwD4uqFKA2rc64iOkNyMHTpOEH8Eqk3nYWWctIQnn1T53Orj/t7+uORcS
	X0=
X-Received: by 2002:a05:6122:4b14:b0:56a:f5d2:286b with SMTP id 71dfb90a1353d-56b47476003mr933910e0c.5.1773234967728;
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b461c905fsm1077400e0c.0.2026.03.11.06.16.07
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56ae58f3fc6so6631437e0c.3
        for <cocci@inria.fr>; Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7lCGR7KhmafXG85t7yE0NPxyqdlsnsuB0G7mt0Up4mU7K5pf6bALJMvE09k61SXIaj8UqFg==@inria.fr
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Loop: cocci@inria.fr
X-Sequence: 3414
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Ny98jSfBi0jd06OxwQu02g>

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
