Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46087C02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6LEUvMsSikCNpT2KPGt37nkSAvYM159qpPNL+ReVKZE=;
  b=kSPgUhm7UTnXIjdmbFVGubDD74KfIJw42rrXgmJIuzf8BmahgRdi/Rrt
   cwN7XXSh5M9hDiOOCpG23IhIzGCM3cH9yzXouZ4pgFgwwTyeJhRriT6Gy
   p2LZokC1yhO8mzPUCtCJeIl+DZid5gSuZQf1Bb1Hj6sxniKpg5lu0yj8V
   8=;
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
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206924783"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 14:00:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2C125E0261; Thu,  6 Feb 2025 14:00:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D68A7E0261
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 14:00:19 +0100 (CET)
IronPort-SDR: 67a4b263_TMtQSXutqQkqgRDdizou/zhLXz+qsQdswQz5pfUwVZoQk+S
 /XcfEtVL1GPJ+wXIcvW63AqwqMI3kLAXcmT+KuA==
X-IPAS-Result: =?us-ascii?q?A0H4EQBbsaRngAwR49RaHQEBAQEJARIBBQUBQIFTgkSBV?=
 =?us-ascii?q?zMEC0iEVo9PgXQwhDuHO4dTiHWDVA8BAwENQQECBAEBAwSCDIJqCgKLAQIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFe?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIwQZAQERJgEECwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ+gjABAw4jB7AmfzOBAYIMAQEG2lwfLCJXgWUJgRouhWyCYwGFa?=
 =?us-ascii?q?gE7hDwnD4FVRIE8gwM+gQUBhxiCaYIzhEhnonZSexwDWSwBVRMXCwcFgSlIA?=
 =?us-ascii?q?yo2MSOBIwU1Cjc6gg1pSToCDQI1gh4kWIIragQFgS2COoRDhE2FW4ISgWIDA?=
 =?us-ascii?q?xYQAYMhehyDXRAdQAIBC209NwkLGwY9nwGHF5QHkVChOzQHgjiBZoFjDJ9cB?=
 =?us-ascii?q?hMvg3ABk1IOBpJ7mHwioz2FT4F+I4FcMxokgzZPAxkPjiEXhBbHZUI1PAIHC?=
 =?us-ascii?q?wEBAwmFRgEBimmBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Z81l/6xHpGrjB9nBvQf0KrPwBL1zdoMgy1knxilNoERuA6mlfr
 OV7ZAmPH7P+U0ssR4b+exoVJPsfZq+z+8O3WByB8bAYOCOggLBR+tfBMnZsl/d8kbFmdK1oJ
 0AT0EIMrPN5DZB4foSqzPIdOrIiOP3lpxBFY/lvg5QpC9RGtld0zs=
X-Talos-CUID: 9a23:Z8Yt1W3PgHIuCo8x2TKKI7xfBu0GclzA3U7qAEqHEH55Z5C/FEKV5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AqVrnIw/8xwyFLJX9PEfK2uiQf/pvyby2KVhVqqU?=
 =?us-ascii?q?DnJnbaitdeG7NizviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206924773"
X-MGA-submission: =?us-ascii?q?MDG0CchvAJAP9TmdfjkLjaiVgNfgC2lT7nMiFA?=
 =?us-ascii?q?8RlLQPqtVuHaq4bD/wnsW+f/fHxjmzbwhf/LcpXZClnOp+BEsHc5O9kM?=
 =?us-ascii?q?UdhJyIXHOqe+gAUd+dqBu7uIXc1Ma00wN1LWOAYrenFzrdIzEALHg2Ef?=
 =?us-ascii?q?oDaiWOYPok8zTWSEXXh6dl8w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 14:00:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738846818; x=1739451618; i=markus.elfring@web.de;
	bh=6LEUvMsSikCNpT2KPGt37nkSAvYM159qpPNL+ReVKZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i/ERFEQ519ydGbLD9QH/WO6otdprs0s29SpR0hV4RQjzKTPNkHiqk9rR1s93cCO4
	 dpfPbd9Nx8wK6TVQQGHDdHYTSS0tjoKcp46cozqi4rIRskcG9wB5ufGAzoDCKcJ9k
	 +X5hDvosxBnSdJv5D3be0h4xW5G35XKRpzvrQ4IIt69XxFz4dlcoXLllKo1ng2q1I
	 o4/p/EGNMTWtdqmJVYz36uRGBvmt9rj8BjZWVxLAl2mRzl55knDXrYHVu79jFdr8O
	 Ak2jYJ5ECdDHM/Eq+41yZrXMc1xH8kOt+UQrGCDvLHsajwAaH5VqMWa5dxCVuqiDy
	 dvhyLGFkf+snPd3yrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.8]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4NDQ-1tEyRg2O2Q-00urKz; Thu, 06
 Feb 2025 14:00:18 +0100
Message-ID: <7ac9ecc6-0fa7-41d3-96e4-fe6fc05ce33a@web.de>
Date: Thu, 6 Feb 2025 14:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
 <66addf31-2af9-457c-24e1-a97367d84d8f@inria.fr>
Content-Language: en-GB
Cc: Johannes Berg <johannes@sipsolutions.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <66addf31-2af9-457c-24e1-a97367d84d8f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:huY+AB4mR08q6VBQd9Addz2LWeNaLwMY5eH7mz165aIZ9tpddyU
 +qtGWu7h3F88f5rpHRIXmEvJyKu4w8ReRx3NNqRiKQa73dnGZJ3oXrjFSjLlZfGg2uso432
 uYDkW/R5145WeX0saz621kKJdUiiZGuM0oJi3n7GD2eM75L9ODbOrSgmTW623Ny0BmnRXoP
 Q5Kgr7craeBbxP/M/Kzxg==
UI-OutboundReport: notjunk:1;M01:P0:rPeeiT7xex0=;JVtMjWlssmYnZp1aMYYaQF5NJlD
 ZFElBvtMLPHq5SZU+EZAjN8p5FMV4WkYlAJb3NoxfN5Hv0yZvylBKqCj6sPUHZuSIBw+muP0q
 4HdhX5rkgEqZjqS9sqa1t1B7QHGAF7mKLgy5IpSEASEigkIAwx9DvGA2UGg1UAo2S0HW+QpDP
 0n6wNfXC908LSL3AnBl/TAIw+ar2AaEZoQs/bLMVgPihSinN3X99LswDZRIEfBEkc24BXagoY
 dcAopQLwaYcq6qOZvle8z2GZ5GRBw6ur+mDMDIzHTX6QloMysrfIghf/RdIJ+MjICp0k/El6F
 MkUn96zHZ7B7EdwB2yijv7Yh9lm7uytJOUB520oTuZ9uI6mle/kMfk+tedHRqHOd4oB/IaC71
 y3Q+zWRLk9TCvwKx6isP66fwvotgvWYwldxxL8MPyUxG1/k75SlYEtq1aLDptAWc2n3m3IPcA
 xxp2c4Sld2P6ORGT/dYyRMt//Z3Z8I6O126ytr5spuocDYJhIfkkdu6hMyd1MLWs1TmDLCSFC
 hiwilMe+BEGrF/45Ou9NJqjjUv27GMv7aKUj53ZSk4idsIB+G+08wlw6QqCvBNtzc00/pDpO6
 Zq/ZQfExqmP1tNYuZx465xuf9JFwePwXJGcy1UC4Dsu1Kcs08LDWvahvd++EBEem6xpMwyRre
 WVDV4lSa/OlbCefyo28LrF/Nah2oEcQ9d1mF2gAeicldkEIOmF2ARD6w0RIjUrFJsdPY+MWuG
 +7SaEX0f0qZeyv0U2aTIBLUDIGYtcd/jp3txEw2zU2GFdI5t7y0qKS5kPaK9VXXRzQc7uL67L
 lo2k4Yio+1dQ0tZnzxXFeKoC71jJHjv6XDJbUgKLsLZsiVs9TFZrBUHeEotZI13GVQagL3n9Q
 CNkGAI0ke13PxzYeumfPaj7WmF2dc1P3rbLznC7rrsYt5020D77rA7zVxz9njrffI4TRMFT/0
 GrhmkYMIduBsb93HSraPNweFCJnQ2vpl20+o1YlHj1OZ1gMutOObgm9YW8EE+2zL5cP+IJEst
 tJOvXp49BpPRKdNjeondufAIoiOrFzooo5RbAMdGXAKWuQ+J8+1eoBygkb4C/QdDsxZVXkdsO
 U7o0Y7PIMKP2Jw5X7rXZ8RCge7V7mjD3N0qIA3F2CxBLBWwTgn6+nrxam1X/zemoBg2L0Zfzl
 bZ6juDEraFNO8wDY/z8sXRvKtdXrKkAFcejaNViN4EIdKR6JfTGcx1+1yZYIx9E7RQdXg0NpD
 2YVlQtC8xwmhQ4GADrT1jEAsbmPKrLBcPUtUQY9jzKpPFbf7NUlCiIhHfc/uEeTCJfxtPwG8y
 q11wOJmi2YFRd45LyOtoLbWNGsCpwPneV5Fw7TZ/dExqUzcgipEIbn2UFi+AfGY8v2LCpbwzC
 6qL46+GA2UpJtyxocgesXZffLFAjviD6pAt5s5d8iOstiQmjqwQh+4UArmZYMgsZWGlZXdDgc
 +fSIGDC7vkTSy6MKhbBR1oEy1WZs=
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2361
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/7ac9ecc6-0fa7-41d3-96e4-fe6fc05ce33a%40web.de>

> This looks like it could be related to the bug that was corrected and that
> leads to the performance problem (ie the old implementation was faster
> because it was incorrect).

Would you like to become more precise about technical details
which influenced software run time characteristics in special ways?

Regards,
Markus
