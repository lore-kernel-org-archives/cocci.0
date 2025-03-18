Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE18C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fPbw+jCIi4mWSMjTCFwvssdsDOY0KZ2mxvtSajYVP/o=;
  b=Yo02iP3HizJaz7/tZJWVC3laUaDfYAlImtr/059bjl1P9+15SfxePEdS
   UpPZqQ2xPFA+DhqpwJ9gp8GvEmGKhU4j3w0LqUiXF4BxdcIBfWA00crcE
   I1bAN3p1WV7uME3JxZ65Mtp9+VhS5iV/+mGYsW6daSqLZgAojKATc+kKs
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213449131"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 11:35:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E013E0D1E; Tue, 18 Mar 2025 11:35:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D7ECE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 11:35:34 +0100 (CET)
IronPort-SDR: 67d94c77_tKYib0gfkrKmOJ6XqB8EveHfusO0oLE3Bp5VEgy3UG4uu1F
 33hruZWeuQ7X94czVSfbM76loCCG8dJUhxUwzqg==
X-IPAS-Result: =?us-ascii?q?A0G3AABAS9lnjaCSqVFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgSsrNAcISIxzfIhbnhSBfg8BAwEIBUQEAQEDAQOFAAKLHwIfB?=
 =?us-ascii?q?gEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5B?=
 =?us-ascii?q?Q4JMoV7DYJiATOCFiwNfgEBAQIBQAEBNwEECwtGVgYTgwKCQhIRB61OgTSBA?=
 =?us-ascii?q?YIMAQEGgmjZOIFeBwmBSAGBV4QVgmMBimMnG4INhD8+hBs9hi+CM4UqjliIH?=
 =?us-ascii?q?JMjSAqBFwNZLAFVEw0KCwcFgSlDAzUMCy4VI4EiBTQ0DjgpgWNpSToCDQI1g?=
 =?us-ascii?q?ht8giiCF4I3hD6EQYVQghGBXQMDIgGDH3UchD4+hGQtUIFNHUADCxgNSBEsN?=
 =?us-ascii?q?xQbBj5uB6IZOogCRqRYoXGCP4FmgWOfZRozgUuCJZNWDpMDiCmQVaRLhGiBZ?=
 =?us-ascii?q?zqBXDMaCBwUgyJPAxkPjiEZhBS2c0UyPAIHCwEBAwmPaTOBSwEB?=
IronPort-PHdr: A9a23:QpWhTRKZve+/vgrqSNmcuAlvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSQAd+CurptsKn/jePJYS863d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbghGmjaxe69+I
 Am5oQnMucQan5ZuJ6IswRbVv3VEfPhbymxvKV+PhRjw4du+8oB++CpKofIh8MBAUaT+f6smS
 LFTESorPWMo6sD1rBfPVQSA6GcSXWUQiRpIHhPK7ArmUZfrsyv1rfRy1S+HNsDrV780WDCi7
 6B2SB/0jSoMKjA0/H3LhsF2kalWuwyqqQBhzIHIYYGVLPt+cb3bfdMGXmpKQ8JdWzVcDo+gc
 4cDCuwMNvtaoYbgvVsDtRWwCwmyCu7x1zFGhX353aM93esuDQ7I0xctH90MvXnOttj4LrseX
 f6zwaLVzTvDdfRW2TLl5YbRdhAuu/+MVq9yf8XP00kvFgXFjlqNooHiODOV0v4Cs2aA4uV6S
 +2vk2AnqwVvrTS128gjlJDEi4QIwV/L6St32pw6JcGkSEFle96kFoNduS6GO4drXs4vXWJlt
 SU0x7MIpZK3YiwHxpo6yxDRZfGLb5aE7xb+WeuTIjp2i2xpdb28ihu280Ws1OPyW9S13VtMs
 yFLkcHMu2gO2hDO8MSLV/pw80O71TqS2A3e6/tILV01mKbHLZMq36A9lp4OsUTYAi/5hl/2g
 rKXdkQl5Oel8/jrb7P7rZGGLYB0kBvxMqE2l8y/H+s4Ng8OUnCe+eS727Dv5FX5TKlWgvEvl
 anWq4rWJd8epq6lGw9ZyJwj6he4DzegztsUh2QII0xddBKGiYjmJU3OLej7APuimVigjTZmy
 vTcMrH8DZjAL2LPnKrgcLph80JczRA8zdFb55JaELEBJ/fzV1f2tNzcFBA5PRe5zPz5B9Vl2
 IMeXXyADrWEP6zMqVOI4PkgLPGWZIAJoDb9N+Ql5/n2gHMngVMdZ7Wm3YMLaHCkGfRrO0GZb
 mDig9gbFWcKuhEzTe3riF2HSjFTfWy9U7g95jE9EoKmDJ3MSpqjgLybxCu7BIFZZnhaClCQF
 nflb5mLW/AQZy2OI89siScEVLikS485zx6irg76y7x9LurV4CIUr5zj1MImr9HUwDMv8T19R
 +CUzGiJSykgnH4MRjZw2KlgqEh54laFy6lxxfJCQ499/fRMByA+PJCU7+FgCtb9ElbGet6HY
 F+rWtuiDHc9Q4RikJc1f09hFoD63Vj41C2wDupQzuTTbHRV2qfV3nyrYt14126Dzq4qyV8vX
 spIM2SiwK957QnaQYDTwA2Cj6j/U6Ma0WbW8Xubi3KUtRRfVAd+eazIRX4baw3aoIex/VvMG
 oenEq9vKQ5d0YiHI6pOZMfuiABBQP7tEN3Te2y1liG8CEXA3auCObLjYH5VxyDBEA4EngQUq
 G6BLhQ7Dzy9rnj2CTsyUEq3Owbr+69lrW+jCFUmyAeHKUFsv1as0jgSg/HUC/Ya37Ze/Twkt
 y0xBlG2mdTfF9uHoQNlOqRae9I0plldhyrfsERmM5qsIroH5BZWehlrv07oyxR8C5lR2ckso
 nQwyQNuKKWemFpffjKc1Jr0N/XZMG73tByobqfX3BnZ3rP0su8I7P02g1zupA+tGwwu/jQv0
 tVY1Wed+oSfFBAbAtr6Vkc68QQ/pqmPMnB7vt2FkyQwb+/t7GeRvrBhTPEowRuhYdpFZaaNF
 QuoVtYfG9DrMush3V6gchMDOulWsq8yJcKvMfWci8vJdK5tmiyriWNf7cVzyEWJomB7TufG9
 58I2/+c002LWn2vxEfkqc3xlY1eMHsVGmOx4SHpHIBVa+t+cMxYbAXma93yzdJ4iZn3Xnde/
 1P2HFIK1viifh+KZkD81wldvagOiUSugjDwjzl9kjVz67GawDSL2ePpMhwOJm9MQmBmy1bqO
 4m9yd4ADgCkaA0glR3t4kifpeATo6B2IUHaTF9GeyWwI2wqXqart7WEatJC89t46GMODrX6O
 AzEDOej+1MTyGv7EnFbxSwnej3ioZj/kxFgyQf/ZD5yoHffZcBs1ELa7d3YS+RW22lOTy15h
 D/LQ1mkaonwu4zKxtGa7r74Djz5BfgxOWHxwIiNtTW2/zhvCBy7xbWon8H/VBI92mn93sVrU
 iPBqFD9ZJPq3uK0K7ECHAEgCVni5s59Aow7nJE3gcRa3nwTiL2c8GIJlWq1PdgRiuruKWEAQ
 zIG2Yuf5wzs1mVqI2qHw4+/WnjXka4DL5GqJ2gR3Cw69cVDDqyZuadFkSVCqV29tQvNYPJ5k
 2RV2b405XUdme1MpBs1w3DXHOUJBUcBd3+J9VzA/5Wkoa5QfmrqbbWgyB80g4W6FL/b6gBEB
 CSpI9F7Q342t5khdguWgDqpt+SGMJHRdY5B5kDSyU6dybIIddRp0aBWzSt/ZzCntCV8mbRg3
 U40hZjo5tDdeTc1u/zlZ3wQfjztOZFJ82m03/wFzpTKh9j9TM0mRmVDXYO0H6LxVmtM5LK+a
 1rISWBnzxXTUbvHQ13F4R8//SiUQ8Lxb3jFfiFDn4g6ShfPdhUC20hRVTE+1PbVDyiSzdf6O
 Ad87zEVvBvjrwdUj/hvPF/5W3veowGhbnE1ToKeJVxY9FMK60DQOM2YpuV9ekMQtoWmtxCII
 3eHah5gCGZVH1TcXxXkNP+14MXYtfKKAeyzaffDKbmDsu1RUf6UyInngtIgpmjdcJzTYD87U
 aVeuAILVGsxA8nDnjQTVyEb3znAacKWvlb0+yF6qNy+7OW+WA/r4tjHAL9TPNNzvhGu1Pfac
 bfO1WAgdWgej81UlhqqgPAF0VUfij9jbWyoGLUE72vWSb7I37VQBFgdYj9yM81B6+Q92BNMM
 IjVkICQtPYwg/grBlNCTVGklNuuYJlAJGW0OnvOCV6FMLnAKTCBkKSVKeusDKZdiulZrUj6o
 TGAD0rqJSiOjRHsUEzqKbkUySaRegdbpJn7aARqD2WlQN+sOXjZeJdnyDYxx7MznHbDM2URZ
 CN9f016pbqV9SpEg/97Fj8J/j9/IOKDgSrc8/jAJ8Ncr65wGiot3bE/gjxy2/5P4SpDXvAwh
 CbCsoskvQS9iufWgjt/DEge83AS2tPN5Bk8f/yDpt4aBBOmtFoM9TnCW0lM/YI4TIey5uYIj
 YKT3KPrdmUY+oqNr5FHV5qOcMvVaiJ7Y0ixX2CIaWlNBT+zazOFjhQEwqvJpi/J9sBo+MCrx
 MpGS6cHBgxsUKpEWwI8QIBEecosO1Fs2b+D0pxS7CLn/kOKFJcA5pmVDKrIU6i3JjjL3+AZP
 FNNyLf8Z+z706Xy1lRsblQ8kImYQyI4vPhIpXEkdlds5UJHtmN7UnV1wVDibA7r7HJBTJZcc
 TY/hxNwZelr+Dq+uj8K
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Il5QbKoMiKI82V6LLM0fuQIaV5rgeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5lktQ/exoX5PwPU80lKQFnLX5WI3MMjUO11HYT72KgbGSoQEIXheOj9K1tp
 0QCZSWaueAa2SS5PySiGmF+pQbsaG6GcuT9IDjJhlWPGRXgtlbnnxEIzfeKX5ZACF7OLtRLv
 uhz/sCnAmPPV4zRv6AQlkpNtKum+H2
X-Talos-CUID: 9a23:GBvD7WyJnI5Sd9vjka9iBgUMNs4bU1rik03aYB//GUhiR7eXcXKprfY=
X-Talos-MUID: 9a23:+e7h3QlNbGfZGCK1I3KQdnpuOPVw8f6BVHk1gKRYuOCkHihUFD6C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213449118"
X-MGA-submission: =?us-ascii?q?MDFNJXHG/pq2Nd0qPtaQJ87aE6ysVR1GGl3nNx?=
 =?us-ascii?q?3rbZ84zDiCJpvQojcN4i6Xu1tRyQApoDeolPlHfvfamTFmYdixMO91dA?=
 =?us-ascii?q?3f0u0C/4DZ4oe2Zdn1SFrSryt3arkb6lqlL49I80UttV3IrgYeF1y+/a?=
 =?us-ascii?q?m5k7Pfxf6dkP8TWubafkqD4Q=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:35:34 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742294133; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l5jPvkfJR63o/yvucE9/PtatmSNMplbXJfRRfmLAoZe8agzQnYEg22OhA1Zzd0Dksc
    GvVdFsjuSWpy3s6ykgn3+THV4lC+6cbGjUJdMHALgRKeyGbh76mNJFFq1meP749FzqVZ
    gmSbvfxsPUViX91erEkgQMWhtDIPVHrCDlfC4ttlu2rB1125fThVg+dkmsBB1Dxihl88
    MqG8Sre+GHQDoDJ6K1LSF059gqgdVYb9obCce7ycMgJQYL23aG58VwqBHXLoq8/CdNt1
    LwBH+4nIZ/rCAnxCDG6t/DC4dy+8NozaYeVsTANSPekbqlx0yMCyWXVSCCU69CHTQ7cq
    0Nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742294133;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fPbw+jCIi4mWSMjTCFwvssdsDOY0KZ2mxvtSajYVP/o=;
    b=VDqLBbNpVC5zrH1gqXefcdL8T841X74GoKrdGP8uRAvO5U0qK3dMi8d1hobC1y1MF/
    bCPRJCWKZgTA2pncMEkJPr9CcowdtO3QG7cmzxixOOqOMyDpJ/CaMfLgA5+kefQ0fnyd
    egDX7cL3mpHSN1460F9Qgj9esIYRZESXnxOyAIr1KTvoHnjrsuIc+sT7xuwT8Ofc7tjq
    xo+xCc9Jww6rO9gT7FryA6AVfaSYaDsK/KSYU22YmvE5W1nw9ir3ViTBzd+jhL00A7po
    NedFdwlJf2aHZChIXXhk/w5pXcusfb1Rg2kMy2ftbrG0WO7Yc/LZoKvUpTV8SfHHp0Gg
    4LUA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742294133;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fPbw+jCIi4mWSMjTCFwvssdsDOY0KZ2mxvtSajYVP/o=;
    b=gas432gYv6EKHEdt6XnepeK8D5UrgAZr7dpyM9isruMm1UvjFsGQ1i6uesxrIAS2kF
    RSS9XYwO0q2U/w9dxT9qBVlCjHFviI08PaNi+c4//xSmP9qHM1rRuPaSk4JgUf6bRp8C
    ZqCIKjwiF7QoSAEwgOAIVzZCTvPnjr5OGowEH0e/SnW+Lgm6G6PlwMubPPs4b/8mlSX5
    j6ee45Pin1gsbkHqRp5KgwrU1FP4eXnibwwSve2aKNMJuN52eVdVIEEigGWqH5ERCtmO
    mQDdDCVJszYdHOebCPjpnlfWnywNgrqgp3UdKGQE/GIYetk79D40nGLDENWOxET2sE/R
    cn9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742294133;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fPbw+jCIi4mWSMjTCFwvssdsDOY0KZ2mxvtSajYVP/o=;
    b=4psEDaTzDvA/XgoFK9a8NR4gEAyzdlkAirWfHGreF35OxPpJgS2YtXdOG/yh7gAgP6
    MBo7Y/NBaqAAeIsLdpCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12IAZX0pC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 18 Mar 2025 11:35:33 +0100 (CET)
Date: Tue, 18 Mar 2025 11:35:25 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20250318113525.0f04ad6f.olaf@aepfle.de>
In-Reply-To: <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
References: <20250318111305.281abcca.olaf@aepfle.de>
	<2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KoTfy.jgv3xR6Li_lMuUW48";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2611
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250318113525.0f04ad6f.olaf%40aepfle.de>

--Sig_/KoTfy.jgv3xR6Li_lMuUW48
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 18 Mar 2025 11:19:44 +0100 (CET) Julia Lawall <julia.lawall@inria.fr>:

> No, we don't want to do that.  The idea of bundles is to limit the
> dependencies.  We don't want users to have the be highly integrated into
> the OCaml ecosystem.  Typical Coccinelle users don't care about OCaml at
> all.

I guess they do not build from git, but do 'zypper install coccinelle'
and be done with it.

Everyone who is thinks the tools needs to be build from source has to make
sure everything required is available. Both zypper and opam make that easy.


Olaf

--Sig_/KoTfy.jgv3xR6Li_lMuUW48
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmfZTG4ACgkQ86SN7mm1
DoBwnQ/9F3TuTab7FF8+2sQUuNvckRbQcJmi12DZTxXXm8bJ36W/Tr/RzvzdjwpI
+4bGH2nvFUR/m7I1VkkXx9ygOCf7LoBpZBF+CLPCuBnEv8e+IHrOkvlQyEgS/UPJ
FmPrBvilsMehTZi3Wk/q6Id/xc+2KxprKCKHXT+jh2ZeaFAB8hEEBzEB2xVs0JS/
Vht2KeoZ+isBOQcDx4X66lN3XlAiXgRMfMVQOsOjl/q+Wy2Pf73Y36gm9GhOjWBa
Lz2YosvFnYSsbVNvnC88nT1lFbEBMD2XyK8B/nI8M1F0QjzSPuuaeE+oyWZGCazv
Xkx/tGVHUr4sdnRZbJwodk5Pc1s/7kcldQfgHw8QJTnTFIw/5uWOCgHmR/7EtVNF
HXDqxoxgcwh4wXzEe7lx2mZbKu1vUEfOXwQ/G3fUijTKLZRiEbJWRzwl3iMdOUMi
oVfWYAa26vS3rXcSlSUuCfQxoeaL4Xg32cJN5l/lOkD1FC2QRFPql5V4J2ZbaSjB
VNrihoVAwX3pE8pAC9cV90xDlWsmAM7yVNKFcohfFcrCNXgV4wUIzgySV8ySg94Q
avXMCN8VPsX1fw4ATMjZwIXQ8Yd2XHzZIkTOe4lPPvUt6s78mYZXjxzEtuVyobkB
L53jwJv0DCcUqvS2Z6IU8T3rBvYr1MhtYIxIk+aa4sejgqSEwHA=
=j+W9
-----END PGP SIGNATURE-----

--Sig_/KoTfy.jgv3xR6Li_lMuUW48--
