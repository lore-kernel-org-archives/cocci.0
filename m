Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC65EC6FD18
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 05:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K+rjz3fLncTPeOTYvVDEOHJNpiFP3FTcm7yx8BDiq2M=;
  b=HxGykxOX6NP9/CbkEc1IAaFEqUqIRUO3fWrk4RH5lAV24onQVnMd9iUQ
   CEoQ3OwHpRvRKSSaMm9RorPxGgoPJdlkNpjpo7wgb9rJ8RmQwObPw0+qT
   iC1vR5gHfJWTWwk6QUrYfjmlxygqXfcAJDZ8XkSUSv4/LoXOITdlRRspx
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,299,1673910000"; 
   d="scan'208";a="99613309"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 07:21:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63D7CE0B4F; Wed, 29 Mar 2023 07:21:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5AD47E0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 07:21:10 +0200 (CEST)
IronPort-SDR: 6423cac5_ymKFF69IWtRRmtu9VlFiYW4XW59wr0qiqWONMK2U8cLfw91
 IHWrFo4/7I2q665wWwU0cA2CbW1hPnVBdU7//kQ==
X-IPAS-Result: =?us-ascii?q?A0FEAwAeySNkhwQP49RaHQEBAQEJARIBBQUBQIFPgi6BS?=
 =?us-ascii?q?y8EC0aEU5EBMYQvhyyHOoRnhAKBaoEsPg8BAwENQQECBAEBAwSEfgKFOQIdB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHD?=
 =?us-ascii?q?hAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQECA?=
 =?us-ascii?q?gEjHQEBESYBDwsaAhEVAgJXBgEMCAEBgnqCKAEDDiMHrjKBMoEBgggBAQacC?=
 =?us-ascii?q?h8sIlOBXgmBFC2NBYM2eicPgVVEgTyDAz6DfUc/gxmCZ44fiyUKgTRzgSAOg?=
 =?us-ascii?q?T2BBAIJAhFrgRIIa4FtD0ACDWQLDnGBSgJkTIEhJQQOAxkrHUACAQs7Oj81B?=
 =?us-ascii?q?gMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPBiZEDkI3NBMGXAEpCw4RA?=
 =?us-ascii?q?1CBRwQvXnwKBgEmJJx7ZoQ4wnk0B4IogVWBWQyfDAYTLoNqAZMdDgaSIy6HL?=
 =?us-ascii?q?ZAPIKd6gXojgVwzGiSDNk8DGQ+OIBmEDI8JAT4/NDsCBwsBAQMJhUYBAYV7A?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 9igoiAYs+qMRME4L+rcKfgQpmU=
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:h8UfQ67jMuggFlxgqQPXwPfXdLJyesId70hD6qm+c20tTiX4rb
 HXoB1/73XJYVkqKRQdcLy7Scu9qDbnhP1ICOoqXItKPjOW3FdARbsKheDfKn/bexEWndQtsp
 uIHZIObuEYzmIXsS852mSF+hobr+VvOZrHudvj
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,299,1673910000"; 
   d="scan'208";a="51540782"
X-MGA-submission: =?us-ascii?q?MDEIlm8MGg2dBbJsCX+HkXnyVQxd2od8qCRRUS?=
 =?us-ascii?q?+eSbxllf1zhfIzc1VbTxAAX4ssyrlV+AXJJY8kQEMT0wYx2FhdXhpgoZ?=
 =?us-ascii?q?Ur/gvzFZdYnY2qPFUvJTEYd9YhCTYXoRJdsHNMR73nQrrL+8pf6nli//?=
 =?us-ascii?q?HNe5q/wDBo0aFVo36bF0okbA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:21:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680067236; i=markus.elfring@web.de;
	bh=K+rjz3fLncTPeOTYvVDEOHJNpiFP3FTcm7yx8BDiq2M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tB7gtb7p2vr24vA1rTW90LZNXZkdbZz0WbK0M8ccVP7tLOz9FPnuuX0S6aQgGd6Qz
	 b278d5otiD60knDdmaM3tihksVISD34fsj4GYl+INtPqeoD36QiIMZnnoWy/cE8G9P
	 gUjgK3GXrTVeXKiBjD28GoA+Tl8gM9HCbFc6yQkZSrD4m3VyKnNH59dL6gTkerMR1p
	 vaSear6B6yJt2vy3iCkjjFWKiba4Wvv1no2M+YTq/aGYkOEwOqMSFfQCGnkjmhqGxg
	 zOVHebmxRimfM/LJ38SmwcVcsjZx5sfl/zrnkN/nZiNc8h2bz3wtLHz7MeEGoWDx9Z
	 7OnDVmyLEjJDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1q8mxT3UcG-00jHFA; Wed, 29
 Mar 2023 07:20:35 +0200
Message-ID: <382bc6d8-7f75-822a-6c36-088b1d2f427a@web.de>
Date: Wed, 29 Mar 2023 07:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Paul Moore <paul@paul-moore.com>, kernel-janitors@vger.kernel.org,
 selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=c3=b6ttsche?=
 <cgzones@googlemail.com>, Eric Paris <eparis@parisplace.org>,
 Michal Orzel <michalorzel.eng@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Ruiqi Gong <gongruiqi1@huawei.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Ruiqi Gong <ruiqi.gong@qq.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <57a97109-7a67-245b-8072-54aec3b5021d@web.de>
 <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
 <CAHC9VhREfdgiCji=uEeCrc4w1kPGfnWGKnJuUYKXwTApdneSjQ@mail.gmail.com>
 <9e8bb69f-99e8-f204-6435-cc6e52816ebf@web.de>
 <CAHC9VhQfiNd_4uWBmKCC81UnOJb7Y=UFCDMXuqz3=UPr8QtqNw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAHC9VhQfiNd_4uWBmKCC81UnOJb7Y=UFCDMXuqz3=UPr8QtqNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SZVhGXo/2DOISQVev51I+MvM+CHsDzV/e1cJNONAvvQWMn2i2ZK
 4M81+X3vn0D8dUNXj5ibYJ24eVxIFsTTunPwdqnaZlnRB+IgIJixzoV7/MMBFtsTaS3Q0fU
 6d98VbOMKxNajnZF6TmRawD11wd6jW6QdJiavRNHA56FiCEO0bF0yq0yEOq0h2zGblHHsA2
 EcG5fZ82d51/YF33zzzFQ==
UI-OutboundReport: notjunk:1;M01:P0:dwnaWMJOSgo=;w4iWhrWWyjdiE8GZ5mhSxB39peB
 Ii8Jn5Vh19gQWrM4YoU0osgpuQTnI0pRHaCWDXyvVpwPp9M9FM5/7XSzhkeg+oTToC0l/dDAH
 TZic5a/jn9zIqcopLyew6BLDKRNO7mTY3Mn5NBtd1q03r19At11QeWkhAfSKDW0zcbh5WwWmi
 1UyAatQiP0GVT6xkgIjiGnqBhTcccpz2DMW3ODZfO9m1qfUATITS+qlSzbBIPyvJDMynVQlwu
 HV+/bDwC1dUlrLPN6O/nzQkUmy5N316xUZn9/p9Er5MN2D8b3qKT85kulrBfc+AE6kAb3ADk5
 rAEz4Oje/KAHJ4lpuW1roVhJxMR46Tn23LDgtT5nV/mDfXVo1/D1xhKXm4K3zQgE9m1yOubRM
 XqYdwtVnOr7m20S6D8JFU+3BOeMZz4QSs0+MiJQVzUNItfRX6wMEbovbPSjk+JbW/yoUNIR23
 PPgVIj7Q15dcOwyDVS33+K7byx838xp/p4IqsK2QO+CFk3Oi1vxy9MExwOfo5mlAWV0vX4d0C
 WEL2YVYPuAwNCxPMz+aEaB3I5rhEtiPopMB4jaK6mlTDdRVskiGOi2DpyvkcRJnu1X1zS2Ksk
 +43zmh9Y/4nWgJdGqFgWc3pInh8VZzgwzq6y3XFIbP+HpKHMDQCyNaz29I7/kbS2yxTgmsOqJ
 sKsOuCA7246EEr8MGOCYm/LGgxOlV91npYxLF0czbn2B7gtqUSuDeBaZ598T8o5EIAclMNCaW
 uvwKPnKxUsMh9HuPX+aQxHTuwEwJbUsvEl4FBWNClGkc+ndV+XvEzaK4aDfWy1G8rVToyVCnw
 w1OiUFf2lxP/KIw7no4FaaPCNGHARdwfc/WpbEoEvNqDKRtTonLSaCzT3/sJtyn7jZnY1BHaL
 TlNlS12hxY46lTqIjwohOqTnYN+h+/jvbPIfgDZJt0AL7mMUwMNdRb34h
Subject: Re: [cocci] selinux: Adjust implementation of security_get_bools()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 978
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/382bc6d8-7f75-822a-6c36-088b1d2f427a%40web.de>

>> Would you like to take advice from another information source
>> better into account?
>
> In this case, I prefer what I suggested.

What does hinder you to work with more jump labels for improved exception =
handling?

Regards,
Markus
