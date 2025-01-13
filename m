Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEC8E7719F
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2025 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PrfQpP75yiuM4H7OxwC1JC1Kolu7fNxLdriiCrhxzKs=;
  b=JjwwPPtp7ja47Y6O8CzBRf6tKL8xav0FmKB/Oe6GtH/KTanBvwuLxMiO
   jSo5cpuHP98ezPjUlc5ReoRZQODRejI1uRFP1hkO3OOlG24HHi0Uy1ky5
   xfqb2L5DCuRW6f9+OQq9FwA+6xtZ9N666hroM6Mpv1cIoIZ4nMhdDqr5j
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202798607"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jan 2025 13:18:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EFA58E0D1D; Mon, 13 Jan 2025 13:18:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 38886E0077
	for <cocci@sympa.inria.fr>; Mon, 13 Jan 2025 13:18:44 +0100 (CET)
IronPort-SDR: 678504a3_91uV3H3MzwX8DbPNqvKG+C0mQHa027MSzQ+S7MXUXQYYZof
 bRayMwCyqwlk2z2Q0c+TW+nvqYHAsqcBGjqxgsg==
X-IPAS-Result: =?us-ascii?q?A0FKBAAsA4VngwsR49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDYnUzBAtIhFaPTYF0gQ6DXYc7h1aEb4QHg1QPAQMBDUEBAgQBAQMEhQACi?=
 =?us-ascii?q?nUCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBO?=
 =?us-ascii?q?gcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJgEPCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn2CMAEDMQe0GoEygQGCDAEBBtpbHywiV4FkCYEaLgGFaoJjA?=
 =?us-ascii?q?YYmhDwnD4FVRIE8gRSBbz6IHoJpgjeETGeIfXiIeotrUnscA1ksAVUTFwsHB?=
 =?us-ascii?q?YEpHysDLTYxJYEnBTVBOoIMaUk6Ag0CNYIeJFiCK2sEBYEtgjuER4RThWSCF?=
 =?us-ascii?q?IFlAwMWEAGDKUsdQAIBC209NwkLGwY9nFyaYCSyeDQHgjiBZoFjDJ9cBhMvl?=
 =?us-ascii?q?0QOBpJ7LodkkGoiqQuBfSSBXDMaJIM2TwMZD44hGR+DdbZsQjU8AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBihqBSwEB?=
IronPort-PHdr: A9a23:L6a2ShU0Td/XFMrXtTB2g5u8LiPV8Kz6XzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBtydsq8YwLGI+4nbGkU+or+580o+OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1vI
 BmssAnctsYbjYRsJ6sw1xDEvmZGd+NKyGxnIl6egwzy6sCs8pB97i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6XUAXGoWlAFIAxXe4xHhQpjxqCr6ufFj1yScIMb7UKo7WTWm7
 6dsVR/olCIKPCM3/W3LlsB9ir9QrQm/rBJj3YHbfICVNOJ/fqzDe9MaWXFBVdtVWyBYH4+wc
 5cDA+8HMO1FrYfyukEOoAO9CweiC+zgxCJGiGH43aAk0+ouEx3J0gM7EtISqXTZtsn5OLsMX
 e23yqTD0DXNb+lR2Tf48IXGdQouoeuPXbJtasra1EYhFwfLjlWKqIzlOTyV3fkKvmac9eVgT
 +Gvi3M8qw1rrTavwsksipPIhoITxVDJ7it4z5guKtGiVUF0f8epHZ1NvC6VK4V4WNktQ310u
 Ckk0L0Gv4a2cTUXxJkjxxPSdeCKfoaL7x/9VuucIil0in15dLywmxq+7FWtxOP+W8Wo0FtHo
 ChInNbQunwRyhHf98aJR/hj80qnxD2B1BjT5/laLUwpi6bXMYAtzqAym5YJrEjOHDX6lFjrg
 KOOckgp9fKk5ur6brn8pJKQK5V4hh/gPqkoh8eyH+A4MhUVX2iH5+u8zqDt/Uz4QbpUlvA6j
 q/Uu43AK8sBvK62GQpV354j6xmhCzem18wVnXwALFJYZBKLlYboNE/VL/ziEPiwnUygkDZtx
 //YIr3sGovBImXdnLv7Y7px9UxRxBAuwd1d/Z5YF6wNLOr2WkDrtdzYChE5Mxazw+biENhz0
 ZkRWXiMAq+EK6Peq1CG5uYhI+mWZY8Vvjn9JuMr5vHwlnA1g0IScrex0ZsRc3+3Bu5mLFmBY
 XrwntcBFn8HshQmQOzwlFKCSSJTZ2q1X68k4jE0EoynAp3HRoCpm7GA3Sa7HphNaWBcEF+AC
 3bod4OeW/cNci2eOMFhkiYcWbi7V4AhzQ2utBP9y7d/MuXU/TEXuo7i1NVu/O3SlRQy9SRuA
 MiH0mGNSXt0nmISSDMs0qB/ux819lDW8rJqkudKCdtdr9BOQAM9KoXfzqQuCMrgSxnTYtCHD
 lWhUNGhHioyT/o1wtkHeUE7HM+t2FSL1C2hCL49lrqRBZVy/LiP8WL2IpNYwmzFybJpol0oW
 MpJOiXyo6dl9BXIQaPNnV+YkamCaqkWmiLAojTQhVGStV1VBVYjGZ7OWmoSMw6P9YyRDiLqS
 ravDe9iKQ5d0YuZLbMMbNT1jFJATfOlOdLEYmv3lX3jTQ2QyOaqa4znM34YwD2bEFINxiUa5
 3WbLk4TAim7omTRJCNjHxTjbhCk6vFw/UuyVVR81ASWdwtk3rux9AQSgKm5QukQw6lClSMvs
 TRyE36i0tiQB9fT7xF5cvB6ZtUwqExCyXqftwF5Ocm4KLt+g1cFbwltl0bpygkxFYhK18Qnx
 J8z5Cx1L6/QkFZIdjfDmIv1JqWSMW7quhamd6/R3FjalteQ4KYGrvoi+R3lu0myG0wu/m8Cs
 ZEd2maA5pjMEAsZUI7gGkcx+R9gorjGYy47r4rK3HxoOKOwv3fMwdUsTOcizx+heZ9YPsbmX
 EfXGtcZGtPoBegkgVmvYTobMeoU+KN1d8Kqev2a2bK6af56lWHuhmBG7YZhl0OUonAlEKiSh
 clDmq7eh1LUMlW0xE2suc32h41eMDQbH27kjDPhGJYUfapqO4ACFWapJcSzgNR4nZ/kHXBCp
 zvBTxsL3tGkfR2KYhnzxwpVgA4yqGakhDD+4jh6iTAvoYKA0SaIz+moJ39lciZbAXJvi1vhO
 93+qtkAX1WzKSUtmgGk40nS2KVR4qhyZTq2Iw8Ab239KGdsVbG1v7yJbptU6Z8mhi5QVfy1f
 VGQTrOVTwIy6yr4BCMewTk6c2rvoZDlh1lhj3rbKn9vrX3fcMU2xBHF5dWaS+QDljYBQSB5j
 3HQCD3ed5GM9M+XioyFn+SwTWOnWbVMfCOtwY7IuCag5GJsCAGyhLjpw4ehS1Jll3akkYAzH
 SzT5A7xeIzqy7i3PYcFNgFzCVnw5tA7UoByn40shY0BjH0Th5Gb530Cwi/4NdRW3767bWJYH
 2dRhYSPv068hws6dyHspcqxTHiWz8p/asPvZ2oX3nl49MVWEOKP66QCmyJpo12+pAaXYP5nn
 z5bx+F9jRxSy+wPpgcpyT2QR74IGkwNdwnljReV9JaTqKtNZWCgWae93gxykJryadPK6hEZQ
 3v/dpo4SGVV5998LUmK/Xn98IDid/HPYNhVuhDewHKix6BFbZk2kPQNny9uP2nw6GYkx+AMh
 htrxZimvYKDJjYl7OejDxVfLDGwe9IL92Snk/NFhsjPldPKfN0pCnARUZDvV/7tDD8CqaGtK
 VOVCDNl4n7JHL3CAUmA5U0go3+HGsKuMGyLYWkXys99TQORYlNSikYYUVBY1tYwRAWt2dCke
 kBk4DscoEH1oF1Ax6phZRz4T3uarxyidzM3DsGWKhYPqApF4iK3eYSXvOd0Aj0d9YaqqxaVb
 DWSYQgRS2oOXwSSDlTndNFC/PHm9O6VTqq7JvrKOvCVrPBGEuyP3dSp25dn+DCFMoOOOGNjB
 rs1wBgLW3cxAMnflzgVLk5f3yvQc86Wogu98Sxrv4i+9vrsQgfm+YqIDfNbL9xu/xm8harLO
 fSXgW51LjNR15VEwnGtqvBXxFkJlyRnbCWgC5wFsjPRCr3dkOlbAl9Tai9+MtdJ87Np3gRJP
 p2+6Ju93bp5g/gpTlZdAAa4wIfzP5NMej77bQqUYSTDfK6LLjDK3cztNKa1SLkLyf5RqwX1o
 jGDVUnqIjWEkTDtERGpK+BFyi+Bb3k88MmwdAhgDW/7QZfocBq+ZZVShCc13KZyq3fEL28aP
 hBjfkkLorDavkY6yr1vXndM6HZoN7zOgyGC8+zRMYobq9NuBTlo0f1X6jI2xvEGiUMMDOwwk
 yzUoNl0pligmeTa0TtrXi1FrTNTjZ6Kt0FvUU083oZNUzDI8UBVhY1/IwsHrZ1pB4+200ix4
 t3Iib61NzpItd7Zr5N0Og==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NXXCHKMoV5xsxcBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:j2sOLW7KqF2LhxVF89ss/XM6PIcPcm3klFjMPBO6Km9jcJvLYArF
X-Talos-MUID: 9a23:FGmtRAg0X9UrXjomDK6EWMMpC9ZkuLuiEG80qdZbppjZJCctHyeAk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="106190639"
X-MGA-submission: =?us-ascii?q?MDGSAaH8qOs3gNktBK3O02mjQX3FaOEjS+TqYW?=
 =?us-ascii?q?K0b9alp0U0UW/9Vq3wQJ/CdXhAeM0iu8agWjV7b47zmQCBz5ig5Y2Jr8?=
 =?us-ascii?q?yKjhyYFCzs3zr0t80vZOkpaVE8G4t2ubCVkEDMyX75k7aU/0DFkjE5YJ?=
 =?us-ascii?q?YUPzXdY9NWU+JNE3eYWm9OBQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 13:18:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736770710; x=1737375510; i=markus.elfring@web.de;
	bh=PrfQpP75yiuM4H7OxwC1JC1Kolu7fNxLdriiCrhxzKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ULI54weZc7WSUelEQDtmpNiH9MyiPHoWEad6KpX/pXXrorl/k2AKid3PkC6ABBXL
	 +PIcNX8oSYsoxL5tcBZ5l1nykzmdBjbUBZgh9413KfB9rM5ZhrI6Xz2PvRUgr8I4s
	 AfWCFA8HgMGnG/W8zKYDbpAh8V8/Pb6dOAXGInvgMJUvxKlz1aYUJExz+3h8gAwlh
	 1iVJd+ABVIUlANTd0cTDT9P6jNqMdAq+M4D6HAj/lShjS5crXNZSpjkCq//Zy6Slz
	 4lWhKmrrulb24wuRbf2w0Klq0DWGNRqetetoTN2zfcFNgvj2vYYl9TfYeacHyA+jJ
	 CSST7I7qYlIhH8AhFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.22]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1tsqQ40Wms-00MhQE; Mon, 13
 Jan 2025 13:18:30 +0100
Message-ID: <a52a1503-f02c-433e-b459-e608211c8b65@web.de>
Date: Mon, 13 Jan 2025 13:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, cocci@inria.fr
References: <20250104141414.114971-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250104141414.114971-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D5Gq/udjN7sZE4fciFnBfzJV4HA/6Yxkp7xyG4fxzFb1yHEjn4Z
 UOJVvTHzHzgq3M640Ru7/DDxk+0dQ3yrxy8sUvmOp+OzyBm8tFWp8dJOgoZc4xx4h9WvmfZ
 bJBCrDwpHnsduWo7wni3lnmKuEo4YPR2hUxdp6ZCQmlER1XI/3S/ya5d6fPm75vzgb0NX6r
 G2u5UKrP8ijRssN+i6GjQ==
UI-OutboundReport: notjunk:1;M01:P0:nP20U41ffq0=;02Qswk71EZQLrihs+owtSZ2EV6x
 TrtN6DW2FVNca39KI/An8OPsUT8BctYkoFg/iFX0XNK6N51En8bcB4cHs4MrO5re+/FVsyXJh
 i7xwTzq/z8eTGG/wYo3VkLIj9D959IjRfmdbsEf0Juyl8cx1KRbuxp7HUq26/0ZrvcIXx9GN4
 GxDYOw6LYaehurn9JsYqA/bw+1V5e4duA6PLYxalA/ZqLVTmFvq+cqxiYjDqqWKVJ0enalmws
 P0URfN0QxLI12+7Oss58HwhgW2185zWfaZ5L2S5PT0/7VfMvUOq0GIbEzGzEEGkHxT2AwIr2y
 BRMMqKrlRA+pKXltxD8Er88Lf33Rtma5QNCD9DrIfcT5BxkiUiD3Ge//6llRv1IWl3+NjkJ4f
 +ZAZmGpaN9J5rG/KhIPqA5HBiVt5SIeW+4YguVUYwkpoQBh6fPh5FJbeB7N/lqlKH9L9alU7w
 c6T8tzHQBUpyobAC08tPqBUz0SPbZcRVUyAPcZQWzGFNS6jDFuBBhfRrCjDvfQuxuUT7v79RB
 8INgzMvoi+aq9WzNyDfp9vq1VOG4g3kqKIhtvKorkUSTW8P9sKuV44UFXe05t1X/8KjyiVDIf
 H1AjJikvie6j8nwzHkYhjb49PW4HeWLYO2kV0WDxJy7ozvwSLn71IZZRJcdHOj5ZGVAWGRWiB
 mIa/92MAL68kKSIdIGwbNfXxJmRAlQEjA2XemEE1FPq7rcUEj9zFpuq/KshIkejXRnbj64rGm
 p23jmsSbKLFJTMI4Z3aooh/mWzb9DOGQstXzuaJ151QJbfVxZqr2pLpFVVsAcEwe4uzqvnyic
 p+rxo/bU5pbeS5sgczEkbQFbasm5Vk75cuuowJu1ljI6nNR6mHPaG2tQi24mvH1IUr4kZvYBA
 7TLNW9Zdi+DAAMB1aoTb9TCvQ2zLGGXZmlfsIUSajxNUR61wOcVO1K++hewyAEkhFunnKGSWg
 yNo8US9kMBVhcM6Fyj3B2UlZBcT+yn9ra5K4monoJ3s+7M/i+BZWR82tJkZ5wFVmvMq3p0agY
 VF3xG1s+MUK4SF0r9QWBBnRZWQgJqO04LQxZvMxeypE8rSS77aTaYQrVlXfLZlqt10i9XN3Wz
 ozm2szIW4=
Subject: Re: [cocci] [PATCH] coccinelle: platform_no_drv_owner: Handle also
 built-in drivers
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2200
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/a52a1503-f02c-433e-b459-e608211c8b65%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/api/platform_no_drv_owner.cocci
> @@ -10,12 +10,21 @@ virtual org
>  virtual report
>
>  @match1@
=E2=80=A6
>  @@
>  (
> +	builtin_i2c_driver(__driver);
> +|
> +	builtin_platform_driver(__driver);
> +|
> +	builtin_platform_driver_probe(__driver, ...);
> +|
>  	module_i2c_driver(__driver);
>  |
>  	module_platform_driver(__driver);

How do you think about to avoid a bit for duplicate SmPL code
(by using nested disjunctions)?

Development idea:
(
(builtin_platform_driver
|builtin_i2c_driver
|module_i2c_driver
|module_platform_driver
)(__driver);
|builtin_platform_driver_probe(__driver, ...);)


Regards,
Markus
