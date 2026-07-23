Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA93C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y+eSaDxt3Oy3svRwCwnnMubzPU6lsf5Q8Wmnj1h35P0=;
  b=fdtOAyqbDVxlODVT1KLGljTX/AGY1QF/yarZ5W6tLLETawVP/7Kq7yQH
   VQ38X1sbNI9GuOHJ3zIOOKmdS7XjylHqi8UM7TLAksQ3Rh0RnXnqMOnzh
   vUAzVenSpqzzeQ33dtTHOW9lj25fqNIlXLdHUbPpOP1hJQ+T8XUA3K+7g
   Q=;
X-CSE-ConnectionGUID: mMZu+ov7QpimLEdANSTHHw==
X-CSE-MsgGUID: iZrCTBjeSzG+Uh+3zQoF5Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734137"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:41 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 97C9D803FA; Fri, 24 Jul 2026 10:54:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9D5F481964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:25 +0200 (CEST)
X-CSE-ConnectionGUID: D4WBAnBhTqqds3pZ1VE6MA==
X-CSE-MsgGUID: YwVM91/cRheZ0q769bsOeQ==
IronPort-SDR: 6a6261bd_bBaRl3+JGC5Kw4YRnao4+XHmXRSTdEzWgddDarg4EHNg4uZ
 t1WLFgZ+aixINvInzPBnXLpVnj7+o2K9OhqrG+g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfCzYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEiABDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMUgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhH6CH4IGM4YwBIIiehKSKgEHBx8SCAEcBggCAkgVEgMEA?=
 =?us-ascii?q?wQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhICKQoDI?=
 =?us-ascii?q?AoLEg8DDQYFFQEBBwYCAgMBBAIEDAIJAgIFAwEDAgQGBAMDBAEBCAICLQMBA?=
 =?us-ascii?q?xkICQgCCwURGAwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCI?=
 =?us-ascii?q?QQdEQgDARgEAgICAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkID?=
 =?us-ascii?q?BcCAgIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFA?=
 =?us-ascii?q?gIKBgkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDB?=
 =?us-ascii?q?AECAgEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDB?=
 =?us-ascii?q?QICCgIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDF?=
 =?us-ascii?q?gYDAwMDBQECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDA?=
 =?us-ascii?q?wEDAwUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDA?=
 =?us-ascii?q?wcBAQIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCA?=
 =?us-ascii?q?wQFBQEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHA?=
 =?us-ascii?q?wMDAwMEAwUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECB?=
 =?us-ascii?q?AYDBAIDAQIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDC?=
 =?us-ascii?q?QMDCwICAyECBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBA?=
 =?us-ascii?q?wMICxgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABgQ2CKYFRA?=
 =?us-ascii?q?QEBpE6gIUkeCQEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwkkeEPgIKBwcRJ?=
 =?us-ascii?q?BKBMjqBXDMaI4EBbYFJUAMZD5IjzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:01Bk1RMtDJZ1y9h0lL8l6nbaBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvqsr1AaCAN2DtLptsKn/jePJYSQ4+5GPsXQPItRndiQuroE7uTJlK+O+TXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1zI
 RmssQndq8YajIt+JqotyBbCv2dFdflRyW50Kl2fmArx6N2t95B56SRQvPwh989EUarkeqkzU
 KJVAjc7PW0r/cPnrRbNQxOA6XcFTGgYnQdGDxDK4x/mUJjxtDD6tvdm1ymBIcL2V7E0Vi+84
 KptVRTllT0INz898GHQl8xwkKdWqw+vqhBj34LZZpyeOeFgda3BY9wVWWtBXt5QVyNfBIO8c
 5APBPcFMepBsoXxu0cCoR64CAKxBu3g1yVIi2f206MkzekvDA/I0g8nEd0MvnTbo9r7ObwOX
 e221qTE0S/OY+9K1Tr79YPGcgohofaJXb9obMTe008vFwzcgluSt4PlODWV3fkJvWeF6OpgU
 /+khmk5pAFyrDivyNoshpfVio4J1lzJ8SZ0zZ06Jd29UkF7YNqkHIFMuCGdMot7W8UvSHxnt
 ygm0LMJo4K7fDQUx5Q9wR7Sc/iKfoqV7h/tWuucJTd1in1hdbyxhRu/70ytx/PzWMWpzFtHs
 ypLn9vCu3wRyxHe5ciJR+Vy8Eu81jiC1A/e5+9CLEsplqTbM4YszqAsmpcXq0jOHS/7lF/og
 KOLd0go4Oel5uv/brn7u5OQK5V4hwXkPqgzlcGzH/40PwcIUmOG4+qzzqfj8lf8QLhSjv05j
 K3ZsJfCKMQevKG5AgtV3p876xa9EjuqydoYkHYIIV5fdxKHiI/pO17KIP/mF/uwn1OskDJzy
 /DHOL3uHInNI2DdnLv9ebtx8U1RxQopwdxB+p5ZC6sNLf38V0PpsdzXFB45Mwi6w+b9D9V90
 5sTVnyMAq+XPqPSrEGE6v4zL+WQYIIYuy3wK/cg5/H0jH85nUURcrWu3ZsScHy4BOhpI12FY
 XrwhdcMCXsFvg0iQ+P2iV2PSiVTZna3X6Ik/D43EoOmDYHZRoCsmrONxim7HodOamBAEV+DC
 W3oeJmcW/cQdCKSJddsniEcWbiuVYAh0hKguhXixrVpM+TY4jcYuoz91NZ2/ePejRQy+iZ1D
 8SZym2NV2N0kn4RSz84061yrlZxyliE0ah/jPxYEcJc6+lVXQc9MJ7Q1/F1C9PzWgLEZtqHU
 FmoTdu4Dz8tUt8/xccCbFt4G9q4lBDMwzKnDacMmbKTC5I46rnc32D/J8tl0XjLyLQvgUQ+T
 stULW2miLZw9wjNCI7NlEWUj76ke70E0iDCpy+/yj+soUVZWUhUWLrMWXQ3Z03MrN2/6FmGB
 4OuDrEuKUN7xMiEK61FZ8eh2UlcSfHlEM/DeG/3kGC1U1LA/bORZYqiWGUU2m2JE0gZmgA7/
 nucMwU6QCC7rDSaRHZMElLpK2mqudZvoW+nBm4KhUnebVJw3qap0gQYifyVV7UY2bdS/G8Dr
 DVyVHW01M/MQ46CpANqYb90e94x4F5bk2neslouEIanKvVZj1gRNiR6uEWm9RhwDM0UnMsko
 m5wlFIqePKw31ZIdjfe1pf1bO6EYlLu9QyiPvaFkmrV18ybr+JWsKxQQzTLuQioEhBn6HB7y
 5xP1HDa4JzWDQ0UWJa3U0At9hE8qauJKjIl6dby0nthebKxrieEw8ggUeYmxBi9JY8HaPLUP
 AD3GsweQcOpLb9igECnOyoNJ/sa76soJ4WjfvqC1rSsObNtnzyokD4fuNgsgmqD8iN9TqjD2
 JNWi+qA0F6hUDHxxEykrtixmY1AYmQKGXGjzCH/GINLTqh7fIJOEWX3ZsPrmpNxgJniX3Me/
 1mmb78f8OmufxfaL1n03AkKkF8SvWTigyyziTp9jzAuqKObmi3I2eXrMhQdaCZNQyF5gFHgL
 JLR7ZhSVVW0bwUviBqu5Frrj6ldqqNlKmDPQEBONyHoJmBmW6G0u/KMeclKoJ8vtCxWVqy7b
 zX4AvbwoBUUznm7RzMPlBg0cjirvtPymBk7wGORIXBvrWbILNlqzESX79jdSPhNmzseEXMg2
 H+HWx7mZofvoYnH8vWL+vqzXG+gSJBJJCzizIfa8TC++XUvGxq02fa6htzgFwE+ly79zdhjE
 yvS/3OeKsHm0bq3NeV/cwxmHlj5voB3GY9wj9Fo3MlBiVAVg5yU+TwMlmK5YrA5keruKWEAQ
 zIG2Yuf7Qvr1lA5dirRltLRWXCUw88nbN6/KDBzuGp1/4VBD6Ga66ZBlC1+rw+jrA7fVvN6m
 y8U1fok7HNyb/ghgAM21W3dB7kTGRMdJinwj1GS6Nv4qqxLZWGpeLz21UxknNnnAqvQ6g1bX
 X/4fN8lE0oSpo1yM1zCzSerstm1KPHfaNsSsluflBKIg+VOKZ03n+YHnmI9YTO77SBjkbdly
 0AylZih9JCKMWBs4L60Dns6fnXuasUf9yusxadSk8CK3py+S5BoGzEFRpztHrqjFDMfs+iiN
 h7bSmVt7CfGX+CGQ0nDtBQDzTqHCZ2gOnCJKWNMyNxjQEPYP0lDmEUOWz58mJclFweszcinc
 UFj5zlX6ESrz3kEgu9uKRT7VX/S4QmybTJhApWcIhRLtFkavxaFGcOb5+N3WSpf+9fyyW7FY
 nzefAlOAWwTDwaJBF7tI+P2vYGRo8CXA+O/K73FZrDE+ok8H7+YgJmo1IVh5TOFMM6Ca2JjA
 /MM0U1GRXllGs7dlmZHW2kNminKdcLeuAak93g9sJWk6PqyElGKh8PHG/5IPN5o4RzznaqTK
 7vamnNiMTgBnpIUmS2XlP5GhgNU02c2MGDzWbUY6XyXFPOWyvIRVkRLLXs0bZQtjep03xETa
 5SD0oqniu4m1qxpWwkZBw6mx5/hZNRUcTvhbA+VWhbTbObadWOXkZOwPP3ZK/UYjf0K5Ufu4
 WnJHR/pZmbfx2e1BULobL8EjTnFbkYO4NnvKRg1WzSzEo60OFrmbroVxXU32eNm3HqSbTxFb
 WUkIR8d8OHCv2QF3L1+AzITtHE9I7uKkXvBvbWIdMpE47w2XGxinuZeqhzW0pNz6ydJDLxwk
 SrW9Jt1pk2+1/OIwXxhWQZPrTBCgMSKu19jMOPX7MsIX3GM5x8L4WiKbnZC79J4Ft3ivbxRw
 dnTheryLjlF6dfd4cobAYDdNsuGNHMrNRehFiTTCUMJSjuiNGeXgEI48rna7nqOsp0zsYThg
 rILQ75fEUQ3T7YUVhgjE9sFL5N6GDgjlP/TjcIF42a/sAiERMheucOiNLraCvHuJTCFyLhcM
 kFQkPWocMJJb9O9hxAxDzsy1J7HEEfRQ91X9yhobwtu5V5I7GA7VGo4nUTsdgKq5nYXU/+yh
 B8/zAVkMoFPvH/h5Uk6Il3SqW4+ik40zJ/ogj6fbWSpdP/hDalZDiP1sw46NZaxEGMXJUWi2
 FdpMjvJXecbl7x7aWVikxPRo7NKEP9YCLVGOVoema3RaPIv3lBR7C6gwAUUgImNQYsnnwwsf
 5m2qntG0A82d985K5vbI69Rx0RRjKaD1sdH/u80yQ4aYU0K9THLEMbtkEMNP7giYSGv+740g
 eRjsz5KeWxJT/hz5/w2qgUyPOOPyy+m2LlGeBjZCg==
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:oMXKyqxWkfDXxlMm/P6BKrPwCL1zdoMgy1knxilNoNJuA6mlfq
 eV7YkmPHrP4gr5N0tQ/uxoVJPwIk80sKQFmbX5Xo3SJjUO2lHYSr2KhLGKq1aBJ8S9zJ8n6U
 4JSclD4bbLfDxHZKjBkWuFOudl7t3C3q7Av4jjJrRWIT2CqZsM0+4AMHfjLqS+fmd7OaY=
X-Talos-CUID: 9a23:Rg7i/G4chjO4LAb6Xdss2BIrMOkjWH3h1W7cOBSgOz9XZeOwYArF
X-Talos-MUID: =?us-ascii?q?9a23=3APrIm4Q/RzHpYztpx/jnB4YiQf/Z33YH/UQcGq5U?=
 =?us-ascii?q?LiZGdanIhMSy6gQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667111"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEpfxvdaTWhJXYA++GBtIbBsuL7FdzsdkxU0d?=
 =?us-ascii?q?YI2cm84ccNayXRLX26Z+57LkggsQmQrmNd05Ug49itsnvCibVBZitFy9?=
 =?us-ascii?q?TdFsSQfwHzA6CkIDUG8r5PDRYCY7a69Ih3PPSdBA/lSUrkatMfQ3M4XQ?=
 =?us-ascii?q?JoEe/MVAw8dwMgfYOljv3rtQ=3D=3D?=
Received: from mail-pj1-f44.google.com ([209.85.216.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:24 +0200
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1051129a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832443; x=1785437243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+eSaDxt3Oy3svRwCwnnMubzPU6lsf5Q8Wmnj1h35P0=;
        b=oJAlA1qps1jMsgXnBX5UflIyYyTYldgMbBSK0rb/ezUhlVljdCSM9kUGcsLFFVUdB5
         QiGN2OpMdV7RX8cIsa3OyR3KkfJopxVNZ66jUeaqLBQ+Q0pdtHOpoNROwKYSkBMXdOoV
         oHSGlyg1VKQSWjr5insT0Im4vlelaNXc2C/4MlO+KbUDsg3unqVDqRKb68EeVqmN7BLL
         ssdoIUNoXi6sl+is8hVklQ4KW06ZWhGI53Rq7BNc11zH45ubccfoa2xQzv8GqFJNWbAk
         JSThxCBxXhAjowDFbLtauf9VmwuF6fe3rORy51ebSFV8CfaD/tyQcWu8F33Z1F4XRL2O
         iu9g==
X-Gm-Message-State: AOJu0YyX3ZxAjgrn283okoQ9+XyodHYga9kJYrJvGA2jiFkYbF8tO+HC
	ZGp5eIMAz1uQw1lqrwgOMxdakK9mz5IbjYdY76ppxbSVNJcHhLM4lYkS
X-Gm-Gg: AR+sD12bJoetgoxI6g4Tt/Y/qRDI+0H0KCAnDfUBO0uVqkXpf1B//V+1cBz37FLdYmI
	iV/RD4ZYQhxzIwOTYXbYWPRR+EnKq2ZODu9WcrENjy8inlH7/lkH2yYQ2Y/6h76AHdlhtkGWDxJ
	BZZIgeaR86UirunwMsVn9voSFza5AifCEktsHTzQefXx+qLitas/qbm6lCbqUfhywHBIvDwQqIo
	fNc8xpu4OaQCpcGsf3NK6QxyA0n4pRf6NyP3NwniGbELrAjH7gDgMINi9Bu+7Lc6W9NDPQ3RtQd
	93Xr67sOTjuWyFV/hVesetJvH+H7aMb/x5KGADOvMyWCgxYRi5pBtSo3lRWas/MJ26u3P2Zd68Z
	kTZajnvz9XTX9YL7gdutPO2kjzmcwuXf+tEbWoiSRZ+o19ylw0wUPoPMbmZUx0ltEiUK0XpYb
X-Received: by 2002:a17:90b:3d43:b0:38d:dc13:6f94 with SMTP id 98e67ed59e1d1-38ec6649d4fmr4940781a91.37.1784832443347;
        Thu, 23 Jul 2026 11:47:23 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:22 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:37 +0900
Message-ID: <20260723184538.3888637-36-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 35/36] cpupower: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3629
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/HPgeJiXohcGc6cE2l_bXBQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 tools/power/cpupower/utils/powercap-info.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/cpupower/utils/powercap-info.c b/tools/power/cpupower/utils/powercap-info.c
index e53033488218..88a5edb76315 100644
--- a/tools/power/cpupower/utils/powercap-info.c
+++ b/tools/power/cpupower/utils/powercap-info.c
@@ -47,8 +47,6 @@ static int powercap_print_one_zone(struct powercap_zone *zone)
 
 	printf("\n");
 
-	if (ret != 0)
-		return ret;
 	return ret;
 }
 
-- 
2.43.0

