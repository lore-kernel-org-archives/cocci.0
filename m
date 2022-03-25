Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F32C433F5
	for <cocci@archiver.kernel.org>; Fri, 25 Mar 2022 21:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=x15kn4JzhGyax1ZeJ+VgPkd/+jN9Uh9CWC21P/xSYOQ=;
  b=ZzW2waSOyscbaV//yCw3wPXrR8A+FPeSPrPdvmGxLAD/J3lhsJgUREw0
   3P39MbNmIQVDg7kkw+126sUP44nqER9ob+tgMFh1MD67J3oDHyCL6XXJ8
   FZpXpgb7Q/Fd2iwkjcPuUapCDndDF3YmFpV6btRvErctHJCOjk4BCFfim
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
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28207477"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2022 22:33:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57017E4370; Fri, 25 Mar 2022 22:33:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B4E93E436E
	for <cocci@sympa.inria.fr>; Fri, 25 Mar 2022 22:33:36 +0100 (CET)
IronPort-SDR: REvLlKcPU06igY5kfjUaeizrVaSqUT4PWqgPsB0sc6LaVmU8O88SIqdP91yTI44OsByvxPMps+
 4SpARRUa4+vKfay9WiNJLeuifJuiAM6u/CiaFz7NZ7p7Mhq4U8uVGxpE42cnz7r1zuvepHUtrS
 IW/u9j6jflSYM1UNDQbCh2gyr6AW7Bp0MDDqgzMgzUh1jWqsF+K04dsjK7A5BBNl5fWN89vRdj
 fuwbwtGxLfqsba7/JTI9FYKVI7v6Yc2LbatEjxygEe6rvmkt1S65jlhuWQYNYfcxJkELx3BbEZ
 NgshKuQ4I0TgZfh2HKXIpA57
X-IPAS-Result: =?us-ascii?q?A0DnBQCdND5ihwsR49RaHQEBAQEJARIBBQUBQIFaAoImf?=
 =?us-ascii?q?lcrBAtEhFSRG5I9iiiBewsBAwENEgEBIwkBAgQBAYR+CQKETgIdBwEENwMNA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2B?=
 =?us-ascii?q?l4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBDwsaAiYCAlcGDQgBAYMAA?=
 =?us-ascii?q?YJkAQMNJQuwBoExgQGCCAEBBoRIHywiUoFbAwaBECwBjU96JxCBVUSBPAyCR?=
 =?us-ascii?q?zA+gmMFhHeCZZoSpC2eRTQHghKBOoFBDIlClE8GFC6DYgGSYA4GkW+WXI0Wl?=
 =?us-ascii?q?FKFG4ILAoFpMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmDWTOKLEA0OAIGC?=
 =?us-ascii?q?wEBAwmFRwEBjBcBAQ?=
IronPort-PHdr: A9a23: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
 YZIVbJRElA4RKtyNw==
IronPort-Data: A9a23:Ov0Dz6+TlatcB76zmmtdDrUDrniTJUtcMsCJ2f8bNWPcYEJGY0x3z
 2QfUW/UO/3bZ2OkfNAgOtnnphxVusDTz99lSQtkryBEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 omv+5a31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zm
 dtqrM3qWD4VIordgsQtXDhzLAZlBPgTkFPHCSDXXc27ykrbbz3zzv8oAExe0Y8woL8tRzsUq
 rpBd3ZUN3hvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2QtYUAg2tv2qiiG97uX
 OdHVgRWbCjuIEBFZ0VJLYN9k8a30yyXnzpw8Q/J+/NuvQA/1jdZ1LHyOd7RUs6LQM9PlwCZo
 HjH9iL3GHkyP9uUwjut6WOpnuaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc4NRD
 FVFoDsXkbQV5VaLftbcdCKfu0fR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO65ReqdsCi
 Qbhoj/5OdB8mODNFSnHqt94uRvtaXFFdwfucAdeFVNt3jX1nG0kpj7iJjqJOIuyiMH8Ezjt2
 VhmRwBj2elK1abnO42B/V3GhTaloJSMdgA84he/Y45IxgZ+eZLjeIGir1TWhRqhEGp7Zgnc1
 JTns5HAhAzrMX1rvHLWKAnqNO/wj8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaN5VMIucMLYCb0MfAfj2eN5yICkvmI+TPNCaG8UzaySsMtHON61HwyNBDLhQgBbmB2zPhjY
 P93jvpA/V5DVPg5lWPoLwvs+eZln2g/w3/eX5b201yu3tKjiI29Gd843K+1Rrlhtsus+V2Lm
 /4Gbpfi40gBDIXWP3eGmaZOfAhiBSVqXvje9p0HHsbdelcOMD97V5f5n+h7E6Q7xPs9qws91
 irgMqOu4AGl1CWvxMTjQiwLVY4Dqr4i9CpiZnZ9ZAzANrpKSd/H0ZrzvqAfJdEPnNGPB9YtJ
 xXcU8nfUPlJVBrd/DERMcv0oIB4Kka0iAjIMyf8OGozeJtpRgro/N74f1KzpXdUUXft7ZMz8
 ++6ywfWYZsfXAA8XszYX/KYyQ/jt3Yqnu8vDVDDJcNeeRm3/YUzc37xg/Y7LtsiMxLGwjfGh
 Q+aDQ1G9/bAqck5/YCR16yDqo6oFcp4H1ZbRjWKs+zpaHOCpmf6mN1OSueFezzZRVjYwqT6a
 LUH1ez4Pd0GgE1O7dh2HYFr+qRitdHhkLlXk1Z/F3LRYlX3Ub5tLyXU3cRLsaERlLZVtRHvA
 xCK/cRGf6qEMoXpHQdJdgYia+2C09ASmyXTtKhkfh+luXUvpLfXA19POxSsiTBGKOUnOo0Sw
 dAn5Jwc5Tu5h0d4Kd2BlC1Vqz+BIyBSSakhrZ1GUobnhhBykwNHZoHATDD76teDZowUYEUtJ
 zaVgovEhqhdnxaTLSBsSCKVhecN144TvB1qzUMZIwrbkNTyhsgxgE9b/wMxQ1kH1R5Aye9yZ
 jNmOkAdyX9iJNu0aBWvnlxAGj2twDWc/VHtjUQEnivVQiFEk4ALwHIVYY6wEIIxqgqwvQS3O
 JmHxWyjXTuCkATZwH4pQUA8wxD8ZYUZy+AB8fxL2+yaEpN8bTeNbmpCo4YXg0OPPP7dT3Era
 QWnECicpEE72eMtT3UHNrSn
IronPort-HdrOrdr: A9a23:e6tHQK8eamnYiCif4Rxuk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28207474"
X-MGA-submission: =?us-ascii?q?MDEDyHxeqlqW7HdfnCZgqcxKCmTWF8+E15/rJU?=
 =?us-ascii?q?yYhlXbRRMLJ/U5kOFvdRMq3+6q3ytBRvLa02JffbW1SaIINw6wXX0E6e?=
 =?us-ascii?q?D4Qzyk4OkBvmTiXOsoa0o9oit4l/NmNTk9bn2jcBX0hpALXihgg0UllD?=
 =?us-ascii?q?SHJBW/vwJlEC0Xh5PxBtXcCQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 22:33:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648244015;
	bh=x15kn4JzhGyax1ZeJ+VgPkd/+jN9Uh9CWC21P/xSYOQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iKlGDa+H/e8daftqWTnd+hyX+6VToNLQcPbjG+dO4ww0kGIKJc6dtn5LK/oaqnanZ
	 +7pGBMqZznv9HyrYIOaeSh5AXgd8bMTaEhAvlLu+xpEHkmzgwFIvrgf5n6wjNhpzB9
	 EV+zDB4icSltHtim9AHEb38SoHwPJdY4nbrezMtU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.176.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1nkq8y235X-00MyBb; Fri, 25
 Mar 2022 22:33:35 +0100
Message-ID: <ce21e395-344a-e58a-4213-69f62a96cb6a@web.de>
Date: Fri, 25 Mar 2022 22:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
 <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ekWlHv3+x/2U6G6eEIvIsTt9hL0Enw4uUGXY0zfq5nnDiBAYBXI
 0e4QbrIE1/Q9qPQkAZ3tnzyYXKDTQILxQxShNNsheikqUQ0zPl51dM6XBpjClZc7o5aKEI5
 ZjRcNDZ5FJlIssohUOYBkTkGJSpmmJZvJsIP4+gKP+e2JLXBA0Yg2+to/3ND5uWfK+TiYjA
 VGNL2k2nb6/QbsHU4FqUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D9yEZesflFk=:VVBO0nmmqvnEmPzw9KRkpX
 Joe3esRktRPAfb5PyG9p+rgTgEYF3nbrNmv66F1Zs1Kj0ONm7ipIbVu90Jicq1Qn9YpaZTcBf
 uxuZZCycdUho/1yWgAuh97vjH6q5Evghum7GJsa9sIkmv62FwdrFp0/V/ZnjPBsu2TYiXmTlt
 LLItWtPfJcQdeIBqidS2dbcKgHRID7mSu+7ehJtH7Fa3k2wlu0iCEPwV4wCz5w0qoLFcqsGFE
 EHelYNprT0iekaRKJIZgmLyOL566mYBL2BvC/vngqOvXyhkP4hEv5bmB3Rki/7mrLxvjEHcxw
 Ag8+gQvX4qu5/egx3T8hLw7GQUXC+mnHEO3uoEcxc67puz/cK76Ts1RmEBZQk2qUCz5GUpr+l
 e/YwVQTI5Vz1K+i/fiWTgn5rx7gCvUgBywshJWioOF8pWj+MYjis3cxqBEGLUwWcztv6UgWGd
 ALln+P82iPjATiolcJEtpVZ8Ox3RrzAxOXIseudzNlK/RQk6DwdDgyFbSv+S3Mx57VeRw8PCC
 rLhGt66rSiCKHNOw6QQAC5rUVEmYfyDKqbdMABwCzSDZDbbTSdp0LkkqYXZaOYgOFnwB21WmM
 a1xBLpCwaUSwCwgEmm3zu18USRmUiaHKUkKRmw32IQmhLQQcLC0SeJ1aZe23mR5RIqvKRtzyQ
 2R9Ckl6bdqQATv7reKsieex+7CLz2GNNlGCUnqdD0YFcTO1jYP9v0yzFQvrWsRk+c80qeS9kR
 hn3+PgPerN1YPA5SzStqszdpcJuKoq2yKL6V5TDuMpBfxRUdOrOiz2pdTuNt2j/P0jLhZCBsy
 brdDSkLEzhDz/O5Nfi2FlQp7J30fSLiQNkJTrBsLJme34gpR4SKHKwLZW9P2pvwYNEUhnaZmY
 9LCdIvFbDlR6c2G40dq+NoUJWMwK4eq4P8JkFpF4+qKPJdB6T2W+xNw5R6a0wOVL++pXDM48A
 4jhQ6+AFlHT6SsjmONGfa+gf+mcEa24j2gQqp3cFZuahzoA/U6/kXGwk4669nV3BqiH4a/t3a
 uaDQcc+mLJiObM8u6j2NaNgdUl9lu97Fp+iHhuRdP0yGQDlkuFMehzJWP/aefswGpZOkj1HqS
 jCJELE+ZpJWwE8=
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 289
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ce21e395-344a-e58a-4213-69f62a96cb6a%40web.de>

>> https://en.cppreference.com/w/c/language/string_literal
> constant char[] x; ?

Does this SmPL source code search approach include also the enclosing quotation characters?

How do you think about to improve the data processing for captured parts
(together with supported scripting languages)?

Should it be avoided to repeat any data format checks according to string literals
by SmPL script rules?

Regards,
Markus
