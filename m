Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543CBC0218A
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6PT4bB+NgtSxNdMtJN8hG/9Q2f+F7xoU4jq4AUY9ujU=;
  b=YpEo9L23q6t/mukCICGfUw6DHD9lm4C5c10P1NA3+o1FaoG0zpLZh7Nt
   aQ1Ogg4Aggf0tw/Hbv5hiRE04qIwhhu86JCHJgXTaoqiyOPmD5E4a6i3Z
   jYt3Y4RxxnSXGyR5l3QMo51etMxgMrFO1ctCvAP4RtsQBTJ4bwBSlGmzF
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
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205198367"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 14:50:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9937E0D1E; Mon, 27 Jan 2025 14:50:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 037C4E0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 14:50:29 +0100 (CET)
IronPort-SDR: 67978f24_I7SHpEzn8js0QKP/6Ffg91UstYnuh9G+1EnbcZrNZC/xGvw
 AYz5SdCsJuW2eLBcx4ra6NjgBAPjLAuE3oCJtNQ==
X-IPAS-Result: =?us-ascii?q?A0GYEACcjZdngAwR49RagQmBU4JEgVczBAtIhFaPT4F0M?=
 =?us-ascii?q?IQ7hzuHVoh2gVaBfg8BAwENQQECBAEBAwSCDIJ0Aop1Ah4HAQQyBw4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBF4Jng?=
 =?us-ascii?q?jABAw4jB7VReoEygQGCDAEBBtpbHywiV4FkCYEaLoVrgmMBhiaEPCcPgVVEg?=
 =?us-ascii?q?TwLgng+aYNag1uCaYIzhE1noFZSexwDWSwBVRMXCwcFgSlIAys2MSOBJgU1Q?=
 =?us-ascii?q?TqCDWlJNwINAjWCHiRYgitrBAWBLYI7hEWEUYVeghSBZQMDFhIBgyd5HoFNH?=
 =?us-ascii?q?UACAQttPTcJCxsGPZ1sgw2BboEfgT/GNDQHgjiBZoFjDJ9cBhMvg3GTUw4Gk?=
 =?us-ascii?q?nuYfCKpC4FuAjGBXDMaJIM2TwMZD5JOxmNCNTwCBwEKAQEDCYVGAQGKVYFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 sfCnuT/JWUam+8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SSw3hqyBKU4H5sip6FRWKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:+ptsS2HhgUrwk2ZoqmI+0nEbXeIhSkHX1Wn5G22kKGxjbYC8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AVZc8iQ0LL2fEVkCihZ4eX73S0TUj6L68FW8Dvr4?=
 =?us-ascii?q?8/OqBaQEgBRScqAroe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205198349"
X-MGA-submission: =?us-ascii?q?MDFxvbanjBRYgzfmYKOTtQtcdncdtffTfqaZAm?=
 =?us-ascii?q?4rqomtxEMYigilEOlZFIxiwbxJ91OnA9NcCP9d+UWV2qYI4z/Qv81mmb?=
 =?us-ascii?q?LjuDmqFza/BnHaMdRHjnsirDvYyD3drJFsEuHxZPeP1Udd8+IHLANSuV?=
 =?us-ascii?q?guoyAa2S5ZmXqOIvb6NBYZwA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 14:50:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737985827; x=1738590627; i=markus.elfring@web.de;
	bh=6PT4bB+NgtSxNdMtJN8hG/9Q2f+F7xoU4jq4AUY9ujU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UA1KlXcx0eO8GwQEZ26kgmtAOqTemjltJS5nXz9Xc1Q3lip9y/wg4VADMikpji6B
	 deuNGBVNx2sr1oQDVZcg9J73B+HHgpcDquo1VjqjHS4uQTWmIvE3viaWGi4xhFvk1
	 SQJWBmxPIGBiDh5zs1sleHGLDGSVOiqmMif/tm976yyyqokfqyNAo0qOWviX6IoXV
	 Fc/xC6AyoBd+dLDL0WRI1wDjUltseSyoowHmLOz0h1MonDgI7IO+BnyWJinj1e21j
	 uoHMYJ/k/V8W59FkSYDNe+1128Q7pcP0yhRtG0RB5nOAO8COAt+8gzXqdXQ37pGTd
	 m6a1ZlzkeN6w9Vo10Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.10]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRQD-1syx5w3hCZ-00gh9v; Mon, 27
 Jan 2025 14:50:27 +0100
Message-ID: <9852c8de-8208-40cf-bf5f-8293284e2a69@web.de>
Date: Mon, 27 Jan 2025 14:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
 <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
 <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com>
 <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
Content-Language: en-GB
Cc: Ricardo Ribalda <ribalda@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3b3hgPma/meOpvYnQGjKRh17QJj3STsrDYrLddhk39SOoWy9txa
 V3xCEZPAc33I2HEBVHjIjZfXZVJnv7ro+Hb4yoXjce72EAtGBXmB3CIbQiy9p5VrFqbDUrV
 AkgJv7XZzryjco3y65TbleW6q5BCTAyprl/yv/sL0VzxmnBbCMOdM5rV56lbnfijVDSKXKf
 MZJHamRJ3YwIZfsxkVyrg==
UI-OutboundReport: notjunk:1;M01:P0:Fhu7S/B/lhg=;qJiIwkTLrqcRULdEBol/D5BIYpZ
 f3MIiCeKXbactfw+VcvziJgacuVm/0d+x/04eFXun2b51V8I2IOtDx9F8JcQxKR4Ol80modhu
 SZvPUcHmbC0W7LetxQ27VGPrB9n7HZOhl9u0E9VgtENIvx6DBvpGi31OR73afXL7hw3AQbz3A
 qMBD9Cs/WQ35mRvOZML0K1Kb8lAsuIyVtTUYh0dBT9LAbht4JT0W1vH9KBxx1mlYKYcjJd8YL
 GSz++KlJvNBoDX58uWacigu/O4BlIA3AY/2M1oqSjWW1uTseUn1ItVWcCbFt5tr47cCEwmyWz
 K/V/hF3yWxsMRMxque7D+KGTNYikX7uM/4mzgP7rAD6gx4Vj3yGeNCDmWT+YZLNXFijA6FbyX
 agwDDz2TRDUGLa/m1XuWwHMaiDA0nt9nS0rxUjH/pmJcZcFJ8kDr/IsPCbGwyoNeiSBfgRQkN
 TgMvj/Jn9mWbKTdjla6Dod9pwq4gZ3Bf0EHKnR7mHeiZ1mGD59kUAS/p7aJ0MsfcV1g2aVZ+s
 89bz56hrwDBzgdvWKvr6Wv79G74ZmoNAWqJ7RZr0XrYjCIzTPDWpLRI0sPN4LVWsdSi5vj7hm
 LvmsvkisDWiyfLD6gg5WiwdH35fRJs3Xr7vWwcP6Yl7wekLb3VoX5Idn1Vw3BNzAAfeLZJvbB
 rI56ZUgnYILFsHo4o+1Hc3zXnxq8JeObAonZYA3FRZRDKYUQo1eqSjMTnZtdrHnkrPejj01BQ
 qEklJ2UvIkj7AqUh4D0dufRAqJUUwjUe6ZJFSEkIsLaH2GCb2wbHAIp6wQ+w8qiQNya/CpSm1
 rmgsIbuV82lCgLjUO9bctblV14dWADkxvKpfplnQGrfQjOqvSq1X3FgJsQO99f8d786BlfxKL
 +166m7ER4EU8HgIHUCPeV//xFP0URb2n6661HroessoH9vG0zPDDjj9W0yZeYUfls1uvg3jFn
 xt8pRUG02bjRhC8jhvDPMaHCwSi8WEjJd5abbJSA0EHsi7OLVW4KLxQ0+Tnmi01BT+BNKv5p+
 eDWNBQ5mGWl3bLgWznp9KZ86ffG/AWVAhp+duxQLo6v9hNhkQvTmrMMJoGe67PVJ79NevA/Mv
 djl1cS24XEZcVKIXpYRv3/hPXUQHTm5tX4cTU6xQI9jFtRoTHMLzomwDkUVurPKJPvoephJlQ
 BnNhmqnChEYHTp3X7eEzb9oInZehFRfCZiCn9UqGdfQ==
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2224
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/9852c8de-8208-40cf-bf5f-8293284e2a69%40web.de>

> Unfortunately I still can't reproduce the error.

How can we stumble on different software behaviour here?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch --dir =
drivers/gpu/drm/panel -D report --no-show-diff --very-quiet scripts/coccin=
elle/misc/secs_to_jiffies.cocci
virtual rule report not supported


Will additional test cases become helpful?


> If I manage to reproduce it, I'll merge your patch.

I hope that better solutions can be applied.

Regards,
Markus
