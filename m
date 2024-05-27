Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB186C25B74
	for <cocci@archiver.kernel.org>; Mon, 27 May 2024 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4WqulsVYitokYPFU6nTMWplVI2Z0sKTb41EjmG9PPl8=;
  b=EnuqyOfApWo5X1yy/Q5lj+yKnzHBS9DHV4EvoQoOXaE1eEhqjXmTZSL2
   6agebHaZOIuuuvLNmPgaRnRGt/AqIQmd79G/LJoWbn4I5SLWcRgHAgZBG
   LY9de6UvshxPkhYqnxWvVlz2C/ddhMHCxyFBYTQprWArzrSuqegvALHrj
   g=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,192,1712613600"; 
   d="scan'208";a="167549350"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 May 2024 10:22:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB275E00B7; Mon, 27 May 2024 10:22:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77A9AE00B7
	for <cocci@sympa.inria.fr>; Mon, 27 May 2024 10:22:32 +0200 (CEST)
IronPort-SDR: 665442c7_vToGyBio08d4Y1/x8OOlkM+k440NCZrxQhiYm2fKeGi3+8C
 GIVK8ZK43eD6qVZI60Uew64fbDnreRTYuRoCC4w==
X-IPAS-Result: =?us-ascii?q?A0FCAAAHQlRmhwQP49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YJDgVYzBAtIhFaPSIIlhDuHOYdQiHGBVoFAPg8BAwENQQECBAEBAwSCC4J0A?=
 =?us-ascii?q?ohMAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?SMXBw4QJ4V0DYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVgYBFAEBgnyCMAEDDiMHr0aBMoEBggwBAQbaWR8sI?=
 =?us-ascii?q?leBYwmBGi4BiC0BhXyDRnonD4FVRIE8gwM+hEODW4JpjkWIDoMWgiaDUI1DV?=
 =?us-ascii?q?H0cA1khEwFVExcLPh0CFgMbFAQwDwkLJioGNgISDAYGBlk0CQQjAwgEA0IDI?=
 =?us-ascii?q?HERAwQaBAsHdYFxgTQEE0QDgTcGiW0MgwcCBSEEJYFMKYEigngIQ2wVgQkCg?=
 =?us-ascii?q?meBaw5hhFWDRGOBEIFEgWkBdx1AAgELbT01BgMLGwY9qS+DTirFQzQHgjaBY?=
 =?us-ascii?q?IFiDJ9IBhMvg3KTRw4GkmiYYyCoaoFnAzWBXDMaJIM2TwMZD44hGYQUy1JBN?=
 =?us-ascii?q?TsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 fIz
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:qktYOKN52h6OxsBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:lQWBi25AG0dz4QGDHtss235IB/weQF3mlVTfMUDjLkZHebyWYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AgwBTng7laocSyUHQkbfTysTqxox0zI+wUlJQiq8?=
 =?us-ascii?q?MhPCaPDB/Bi7CvRGOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,192,1712613600"; 
   d="scan'208";a="88033890"
X-MGA-submission: =?us-ascii?q?MDEKTTjV3jnOvO10hBe3VXIgu+oBoDou45LvZq?=
 =?us-ascii?q?i3zm2m/Q18ynr7txapcmjSszE2JwQFRyobV9j8KPK78NVKlVTJHOUjfz?=
 =?us-ascii?q?wImGz+iK8RPUvchEG7cLRdzoX4OyanFmeQZrt95Fk1xFk01uzpuivYBf?=
 =?us-ascii?q?Obv/RmXUQMwyMd63MJP5XAUA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 10:22:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716798150; x=1717402950; i=markus.elfring@web.de;
	bh=4WqulsVYitokYPFU6nTMWplVI2Z0sKTb41EjmG9PPl8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ba55Mkh9GwocQ7REJXK6DQ8tDl4fT5dOKKsN80LM75h9TEQ1QSWFLRyAzK2WIj0Q
	 rTiKRsBSlTpJHn98OTzCeLw+AGbFpjPfR9MuOE6eTqnMbtQ40WLZNtMSHvAgqBgXe
	 LO1q0NsYrfNGBl9xTZNSbXD1TjJG7wOwmVbqexr2pCBZUwza3pOobvAFh94x4Z+Qv
	 nS+Nh3ZSLcC7Ufqxs8ztyaxSNhEPe9GvdLHG3LF75U7mWWwwIrgIfZxGYP0zsk9zH
	 BaxeAsi8Ug3K432z9f0lWL8c1qwhK9LZvXO82MseqKAesr08C4Hnr1379jmsj15Eh
	 b2vcZFa99FKeZqIniA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Madzi-1snbGW0e7u-00lSKk; Mon, 27
 May 2024 10:22:30 +0200
Message-ID: <5f48bbf9-f110-470d-8e3a-8b2316821bad@web.de>
Date: Mon, 27 May 2024 10:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
 <75137a20-aef6-4a40-85ce-879983decb83@moroto.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <75137a20-aef6-4a40-85ce-879983decb83@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lFwdxTKGmorAJlakl1Yseuk1sySIy903TjSnml1Op/cUiYb8Zme
 zp6h/bzHhtlaS6Lr3wsfh8VkkioVTa2K3WBR6VXhRDDzsYw+62Cva/6IpxyQwukwt9+MGkV
 loLJPDdXnKyM4aUsBTdaFsfGP47VV6II85y1G6rrFF/dKywvW3XmGNN7aRhLDraJ36wpdB4
 +yR5TSAnDj43zAFKMb14w==
UI-OutboundReport: notjunk:1;M01:P0:eiGxDlRacKM=;VnoAlMN4eKC71A0YmtPlxt8xDD7
 GYexmCXBLZs9UOyRfwl+lEuaqYQwg9FN5NrvR8DS7aPh8TBjazmYvpnz87dnzoIhYrl9fgKFa
 tzYRibmXRZFzl+ikbcD1tuyCsJZwNWdtb7vc8o9W1Ag/ANewcL4ZI9u5nPNZ1/5RHJPjkuUW3
 3CinC7BcHOVcDRIraKRTjXGBjHN86k0ib+3KRFPY8/JBWsCVWUAt3UHzHU7TcHsCrYPlh4dPd
 7+HQvLtprhZc0UUQwBD5OJcv7Gr//xeWnuYEaRLQ0jI/0nShQ4v2HjTviqPyqnheeIwuZYv7N
 9EZBmSEzH2s87muS8aJd3S7OSihDNf34udW2hre1qy8x8MpCuWu9rSeNh3ODLJQfjbilPHHmF
 9C9xBmEyTwt70yA+Qx/9oWJTJr3b84fRTTzmgqiuErz+jKSVcb0bu9ucauHloMNEie8FBFNOr
 PQUzOIboiLX0q6SiniENAS2W3TD3sUT3R6j/nlocQhRuPtY1P4gMmczS3mio2HBPqx14s/eUg
 GdtYLixM80VBFuHzNKiFWJ5Jo+yhQKzJgUzhCEi9eS/30nTwQ23pFCWRawI8ckRKpLs8S2wTe
 P4b5VonMCgr/Tg0q40n1lkW32WuIoCj844syhCHAX4fFXMmfj8h5eJ8gmXAPAiFLJwUxrNowo
 duo5m6wKD4ngky47aFSv9B4oNanWG4c/2pE8cUwBhxVAmcpFCdo5EnxiBazqOJoJVJnGytRyl
 bDWQ/fiuY7ODruQneLXpOzpYNWaiYEL+lp2Jwh+szHN3aIJYE09gDLjx4TNBfYxM8p0jmvdeS
 FiLZJTPvQyBkVbt1W4FaZUI4Xf+qHyID1LfauG+cfDQqk=
Subject: Re: [cocci] Increasing usage of mutex guards (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1761
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/5f48bbf9-f110-470d-8e3a-8b2316821bad%40web.de>

> Different subsystems are taking different approaches to the cleanup.h co=
de.
=E2=80=A6
> It really does change how you review code, so mass conversion patches
> probably aren't welcome.

* Can any contributors (with a better reputation) achieve corresponding
  tree-wide source code transformations?

* Would any software design =E2=80=9Cadvertisements=E2=80=9D help for adju=
stment chances?

* Will the support grow for the usage of SmPL script variants especially
  in combination with the tool =E2=80=9Ccoccicheck=E2=80=9D?


Regards,
Markus
