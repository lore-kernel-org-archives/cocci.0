Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82AEC54EE9
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rPxtlGfjnzpe85Up59f66AJZ8EmegDoUVAi4A/tDYr0=;
  b=iuwOOlJmFi2qUp9WFmkIGfkoVRSWaul8ccZ4SPDLpj6hvSYfxWWG2aps
   J0LeOcpkU/QBg3dQnO5rbyjOABLNHvou8s4h0QKpJJPsoGzyrxTjTOgUK
   4GHFP6A0skMo4mxcLkivBfpyQU8bz43lw/uC5mnaAcZOTBNrXtqBxRYzT
   o=;
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
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="54107473"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 20:11:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC4F0E0236; Thu, 22 Sep 2022 20:11:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3CAC4E0090
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 20:11:44 +0200 (CEST)
IronPort-SDR: 632ca55f_5eBW7MsLU9MboK/KLgh7g0UDHrP8zBsaIblfPdhBZwnnmis
 zCNUsvhFMRq4K9IanirtvY00jELYIZi7NbFjqaA==
X-IPAS-Result: =?us-ascii?q?A0DJAAAspCxjhwMP49RSCBwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE+BAEBCwGCI4EBVi4EC0WETo5vgXcuA4QmkxaHUQsBAwENNwgBAgQBAYUFA?=
 =?us-ascii?q?oRsAh0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBG?=
 =?us-ascii?q?QkXBw4FCwUihWgNgjUpAYNkAQICASMEGQEBESYBBAsLGgImAgJXBgEMCAEBg?=
 =?us-ascii?q?nkBgmwBAw0jBwysDX8zgQGCCAEBBoFAAYMNHywiUoFcAwaBESwBjACEKCcQg?=
 =?us-ascii?q?VVEgTyDAz6CYgOBOCeDVoJmlH6EHyYEDgMZKx1BAgELQjQDFQMUAwUkBwMZD?=
 =?us-ascii?q?yMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EB?=
 =?us-ascii?q?QYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFMicQCSEcCgQaDQUGEwMgbwUKO?=
 =?us-ascii?q?g8oMWsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDB?=
 =?us-ascii?q?CgsAwkhHwcoJjwHWDoBBAMDECI9BgMJAwIkE0d1AjcTFQUDDRkmCAUjFx0EC?=
 =?us-ascii?q?DwCBQZXEwIKEgOYVINKAi+BK2OSW449oD80B4IXgUSBSQyJZ5RnBhMulmcOB?=
 =?us-ascii?q?pIJLYcJE49BII0cmi2BdySBWzMaJIM2TgMZD44gGR6DboRhhUw/NAI5AgYBC?=
 =?us-ascii?q?gEBAwmFRwEBhRkBAQ?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:K/1pYa1sujpLOf2o6p2W8gqjBJYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQdKZW8kZxBno3lvgxQpOxRGttdBz4SMHfnLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="24447012"
X-MGA-submission: =?us-ascii?q?MDHM0h7zqO3rIfzSVGYTIhp9DVW1iJxd0U5jWA?=
 =?us-ascii?q?aV0JKtBoSgXx0FG+hZWt91RxJwqTHF2DJjNSL6Fnk7RjGeegffzYm+MR?=
 =?us-ascii?q?JuQHYGtOtZYLDoWlZnsmQ4ZE+zOx/la2uV3mTX17PzxQfFd56850ZaLg?=
 =?us-ascii?q?inXd5VDYSu8XsG0cpvvd8jug=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 20:11:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663870292; bh=97KkUgVYkzmUc5aCYtSJxi1ZESq2yXiEUHBPgZ8igNA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=ooseZNULJuUWoReBvCw2GhuKelfV5n0L/zRYuStdC6pSeJUgm1rMeRpHNeaLkokZ5
	 0j6eNqfwIOlDinf1C1M98R3f2bTGxQbuQ4amaxyCUew3mHPHGyJ4mQCd+H+2iQUOLs
	 TJNvnOG3CcLkyLjEN17IKSu0glKhTO2k5G1XI8Z9Lz2QxTF6+3CgFtV+uZFz0Pi0d2
	 OHUHSOheA77K58j31sstoUVyoEkPUPo9AvTuNqz/YWHb5FVihqRGEyeiWkFwvJd6Km
	 1bMwhUDXRWTCW7sZwct4g6BYpiKWsIn+Ltk+jvJgiyu/Z3rUTYp1ZCuJhcaV0VP83L
	 cs6Y+dzb+uWeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1pMdVf3wCy-015bOG; Thu, 22
 Sep 2022 20:11:31 +0200
Message-ID: <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de>
Date: Thu, 22 Sep 2022 20:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
To: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <20220922115535.44132-1-yuancan@huawei.com>
 <20220922115535.44132-2-yuancan@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
In-Reply-To: <20220922115535.44132-2-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O1HYOjMFSxAHL17sOMztRLxT42ljFPOcYwWiLApcm9+/jDbfRG1
 Y8g7Dl9QkxP60pVSLqGQJyGKYSer2PGPv8x0M5XcvBrEZyIS5AoH/al8KtnV9t2zjFluA4F
 40LuQ++5XuNBQwAgXh2LlY7CtqVjkMnF5LK8FmIKX+9dMhg+1ADwMeQvdV39rtDeIHAB3IL
 Kpx3uHei/DpLsoYW3yCnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5t1M8L3gIk8=:86w5+GSIyOi9PivNN7mXu8
 miQiabD6Wjg3ZTDyR/HVWrbnhm8IR7q/CMtDx52nEqfuqNEbpPsS4mml6fD3TM0EzuzRiLQ99
 3uirZRmpaIIk52mBBMf5CXChfLNMt+H0ZK4Kv4FnjC0NZ2zb46MJ9DdSfqjig4IAPzcjTQ0kt
 sjoxpgK0bSfz2sDAlF7NOC94QZqIBiiXRWGkko9abC1dSPJ2eIczLXYz8EHRf6WEY4Fm9EzXU
 bXx5oHp/pxZhWPHz1ECycpEmq0TQsssYH/aS8EPATe8Gkl9HiYTxckh5Nr7pyka7yNhRnV/Wb
 DwgNyN23rDdXhhnzJZWcRPtU+jK+OzFsanKtwf32ppselMkFh1//Y31l2tMmBl7lkJ6/vNRiu
 F0TIZxbCMLSiGZ957EVQvHUcdFCFMvBp5MBwnemfsoUeHoKwO66It0j6qPZXEi6k1lwIRO/CP
 zaCp4TkxR7L6nojF4kmhkKdyKBVxx9fyi44PJEIrfqngs5JoBhJNeZArek7jLC0Cz/BgXwkEK
 Q0FI74i1G475u6s9xdfeQhDAJAHsIOnL2LrvaCYOk4TUXq5Ibo47qb97WBSnlMiu0Jt4Zh11n
 tMf64cqL+/jhPY32kI6kMmHrnS4tqLz+NCWX84aKk4eQdFVE5OhSN7Uli5R1mJjRO+XvL5dDF
 LVWBp9cSBqZjd2Au6b6H5UpZPK/CXWgvsABqLNk3jsb1yyiGGQwjq58QtlLNfD2xnxPk9E1kn
 azTZWOO41tadZNE7UdvoUWpv0xyEIJ+g+OJP/rTsaHhAUBfBcwWM7GV/nrzxSVXu9SRvGlofT
 VSQLLH/Ppqn6F9PLbpYvl4tlfvL4r8z7D5aykROyUfAJpjT2YH+ooe9EyuY0J3+02tvqz1gOW
 jxiSWBhKbnIdobUkHWwhA6cMuedJCLtQcoQVVYHBLk/honr2gHNjBYmNtgYDEaJDYypif5UTP
 r4HlaUufxsXRypG5GCKbuVq2rw8RwXf2080nlf+QoXBL+NVA0IcN7A1N9+RnJFgdN+7822GBk
 Oh0SVNhgkmRxmsVMxED6VCuufgvvwNF4fTwCp0/p+c0+RHL+yi44cCNLKEuI+n5g7wO9fU1s4
 Q/LGcZJbkbNV/PMx5B+HsdD4GvFPB4v5ODV7xz6JILCDprxz2PzuPrJsqxkq5+I+EDCKK7bkg
 YpxbK8rREUZ2TfrK5mwOvocImz
Subject: Re: [cocci] [PATCH v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 574
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/3351dd3d-f55a-10b0-6b35-d5206570e687%40web.de>

> Find mutex inside struct which is possibly used without init,
> provide the name of the struct and of the mutex, the position
> where the struct is malloced and where the mutex get locked.


I find this commit message variant also improvable.

Will terms like =E2=80=9Cdata structure=E2=80=9D and =E2=80=9Cinitialisati=
on=E2=80=9D become relevant?



=E2=80=A6

> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci

=E2=80=A6

> +// Comments:

Why do you insist on the addition of an empty comment field?


> +@r3@
> +identifier s, fld;
> +position p !=3D {r2.p};
> +@@
> +
> +struct s {
> +  ...
> +  struct mutex fld@p;
> +  ...
> +};


How many mutexes (or spin locks) should be initialised before further data
processing can be safely performed with corresponding structures?


Can it be sufficient to detect only one kind of uninitialised system resou=
rce
for the discussed source code analysis approach?
https://cwe.mitre.org/data/definitions/909.html


> +@r4@
> +identifier r3.fld;
> +identifier r3.s;

=E2=80=A6


I suggest to use the following SmPL code variant.

identifier r3.fld, r3.s;


> +struct s *mm;
> +position p;
> +@@
> +
> +mutex_lock@p(&mm->fld)


Would you like to support extra parentheses also at this place?

+mutex_lock@p(&(mm->fld))


> +@r5 depends on r4@
> +identifier r3.s;
> +struct s *mm;
> +position p;
> +@@
> +mm@p =3D \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)

Will it become relevant to detect any more memory allocation function call=
s?


Regards,
Markus
