Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55076C32771
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=P+0rFxpwWubfD18qeCcJ2JkUqXLWGZy08LJ+w9lpdM0=;
  b=lwF3++CfiuBiPDtbYMYOV9VOJkMZhFkOzjfiy5HusBkOoVhGTBEuneRr
   C5jd4sUKM1jleecvNpQfzrjccDJa2NXore7PRviBWzyJdJ8U6cQoAnLJB
   KQt8xKrxLNhddRtZILIVgwWIjA03UVsw60747WABh4gb88i7JGr8Xdwr8
   4=;
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
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="55024022"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 21:35:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4385AE028F; Wed, 28 Sep 2022 21:35:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 76521E0076
	for <cocci@sympa.inria.fr>; Wed, 28 Sep 2022 21:35:04 +0200 (CEST)
IronPort-SDR: 6334a1e8_5Kp3OjWFbi0GegdIJlxaeOyGQwpuN9eTQrJyPwrIaszgGuY
 KWawZiZeDn9+YmWlWv4Uz7nL2NEnjmB+iqAON1Q==
X-IPAS-Result: =?us-ascii?q?A0DWEgCDoDRjhwQP49RaHgEBCxIMQIFRgiKBVy4EC0WEE?=
 =?us-ascii?q?T2Ob4F3MYQnhxiHIgOKMIF7CwEDAQ0SASwBAgQBAYR7CgKEbAIdBwEENwMNA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNg?=
 =?us-ascii?q?jUpAYNkAQICAQwXHQEBESYBBAsJAhoCJgICVwYNCAEBgnmCbQEDDSMHj32cF?=
 =?us-ascii?q?4EygQGCCAEBBoROHywiUoFcCYERLY8veicQgVVEgTwMgkcwPoREg1aCZpR8h?=
 =?us-ascii?q?EomBA4DGSsdQQIBC0I1GAMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHE?=
 =?us-ascii?q?xgbGQEFMicQCSEcCgQaDQUGEwMgbwUKOg8oMWsrHRsKgQwqKBUDBAQDAgYTA?=
 =?us-ascii?q?wMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJDwHWDoBBAMCECI9B?=
 =?us-ascii?q?gMJAwIiW3UCMxMVBQMNGSYIBSMXHgQIPAIFBlcTAgoSAxMPBimdRMNoNAeCG?=
 =?us-ascii?q?4FFgUkMnk4GEy6DZAGTAg4GkgqXDadpggoBEIFbMxokgzZOAxkPjiAZhAyKL?=
 =?us-ascii?q?T80OwIGAQoBAQMJhUcBAYR/AQE?=
IronPort-PHdr: A9a23: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
 j3ni6/5bjtPoYq8wA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xPj9S6uA0gFLAInUq/GXGXr67skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="55024019"
X-MGA-submission: =?us-ascii?q?MDFxsABCRT6SuGFNbwiBiK9pEtOrj0TuZPHt7a?=
 =?us-ascii?q?1Mttih7KD8BhPbVSWCyP2+JeiPq2HYc9TtDdZuYYIlUEz+osTrAT0gTd?=
 =?us-ascii?q?uDGW8w2dc7eKcKrxza20oF5I+f8lPtIy1HVIneNaiJ4QJOjD6AfqOMeM?=
 =?us-ascii?q?DhZ17BTHUoVgc4auyqbuEvOg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 21:35:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664393694; bh=P+0rFxpwWubfD18qeCcJ2JkUqXLWGZy08LJ+w9lpdM0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lp34uJ4S2HwaRJMNzTtBzeOKeTkXyoJEkH2bslmguqSnyk7Mh0Io9wWqWm4iorc9G
	 UeqOmnKlcG99uFMw5N23pw495DHOjGY5xRkydtCWCIrwIk9h21nlhBQHTIn4fp6WKw
	 lJCpUtEtPjXNlXWfeSWu02shUfXijVOqY8x15jKQVxRQdtLvkmygZwTVGMXSGJnpZa
	 rfynUtwmvfGdUCCYhv48mcDrIsKEVT3i1NL8S8b0BWwH4yWVK4Yrla48IupVmON59V
	 GCTatWzNpHkL3p850t58vVAHDpHKNB79fmOP3vJ2pC6ddJb8GcIfpTXatcKiLg2CNA
	 FQKKzRObWS5jw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m9H-1oeS2n2U6d-0014JZ; Wed, 28
 Sep 2022 21:34:54 +0200
Message-ID: <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de>
Date: Wed, 28 Sep 2022 21:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
 <alpine.DEB.2.22.394.2209282125470.2984@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2209282125470.2984@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YS1aTUOlvYR9U/j70g2jAuNWnPMznCZRBNkDJogZkE8Yp2pRlek
 tKp36gIbbwNPZUUXmAs6RHRUcEcaMFvZmCVGEVmbIUBT8msewoRprO6CgA1N/LI3TgAi1nP
 Pth+HTmvH9/gchQCikm66k1wXae7st+MyAgQrCGGbOIK6oD22ESad7gqfxa30visKPCswsx
 ce1IVOydPk1/XtTVgS+1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQb0SvWGeiM=:gV7mtfz38YKMsnlIXISfJF
 m0Tq8385j/GnezYu+V+IY/2Y7KzI+5YsRk76FLcB/RTeaRqZjZfB5u2+F7igXhYqLlrA4RbJc
 mdmJV2eC0ZtIGgXvaJpta0ZzSnIO7IH10xxp6wU5xW8FfbUoorIWsI/oj922OQ5/AcPshNtik
 2sTmfBjKpxw96Ph0833O/cOpG11VGv5t9me+2CRodrXRuKKEQo+AKq9VvuaJY4j9PsN2Lh+UL
 ziiO0jrgAsyH44wnUnSQhz3jkC93EccD6nsecIjLj29RtuXO7RHAq1YN4EcuB5vCD7GhAfKle
 mX6bU210hVTmX++vZXzl9CFDnvMBw5ZRnpQeNYFSD2DT86v6lh+rsWYNmKhggBubMBjRItNW+
 cKAhJxhhbQghitWR8VNzJFMgHlateAPobpyj7yscjjSpgTjmdbtSWHOKxZXdCpiT32Mm6bke+
 P2LX1jogHNyvNfwnTpwlkdQdMNA8fyYqXFtTkYpex1W+h7S3wz6z1CqIll7mcGZWmOYFU2nQI
 cRqbtHXdjUcW37Z8ugVRdcaPiXCEnyW//wDQLBNzcYQAozoY5zzgEADnabhT7mnzWF5db5Bfe
 w0HwsGkMxZRa3ChthP9e0PwsBdLOMWcp/kp39cP7Sz7PTMcTMZTIAFPsWZGj53YwuI7a3uFus
 V3TRusajGDJ8rpXOBYjFvxKQV43qlvieg0sR27oE0A29Q71wqLNu0XovgYcjdqhWL3J29rSVT
 KPekhrQfBFU6eq+B2dpJGCLBIL1NQN+YlSQdeqF9lBH2jUxecQ6XT/lVD9/XQ3FLBqabG8keG
 g4HVu4xjZGHjJU5J1LxTfduBSinYuBtpdHy5FKsx8PBkaaJzOG6HxumaSxwmBUg6KEaiXDMUX
 0UMDH0Uw6frqsYI+/xt07Tx4ofsZ8jmTo3w3ONtT4q6EMR41oGFaGAv8Iy4BnliDhtYUWq3z3
 KhPCRZuw1oheUVAVSZfa/tpF9Wfq/71nViF0edDAO7kshoKA8jMwe4ZJb3CdRQP+JwLdGDpqh
 dDwobf5oI0PsNDUUfhpPdcgqmPkVXDBRHSzLdGRTW7srTjT+hxDOCczsqZXkLDlqXz33vvmit
 7TitjkO1z5c42YHBDvLgZAtuU4+ZtYj2dxM07YY1gMkQmGnhe6VZeJr/gV4IAlwZgHLHSm/xO
 qFlq3p4/tt4JopavcjdSsLCCtC
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 600
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638%40web.de>

> t is a metavariable that gats bound to the type of o.


I would use the kind =E2=80=9Cidentifier=E2=80=9D for the metavariable =E2=
=80=9Co=E2=80=9D which is connected
to a known data type.
I would appreciate if the usage of your SmPL code can become clearer.

Regards,
Markus

