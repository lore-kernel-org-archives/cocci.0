Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3255BC433FE
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:references:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Bux5i6Hg+lyW73KsqtdilEs1Aoi/CaZwFgRdp+lhnLc=;
  b=A4TQTDBJTVbqrfFXfDSmRN1GhJfmTlTdHNPJtuHH1JSLP34qnZAtZB/d
   E8smHJJhyCYPDW65ytqNhrVoU/efTYR9OLLZuMiX8QiTMwj6w1Aw30stB
   GU2wY4OLGZWo7pSWzr2zSL5qd7uBsPj7A0eSNvOq77WZxzmCQUGMav7Nh
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="5.95,204,1661810400"; 
   d="scan'208";a="67851928"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 10:04:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2F9C7E013D; Sat, 22 Oct 2022 10:04:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 278C9E004E
	for <cocci@sympa.inria.fr>; Thu, 20 Oct 2022 07:18:34 +0200 (CEST)
IronPort-SDR: 6350da29_n83+u+SB7Tj5cJ8PA0yuwOjfAjxkyGRzuCK5qByyVwjmw24
 N9Fa19539z8fBz5PK6TeZSOq3KDHoyyJeEwPmLw==
X-IPAS-Result: =?us-ascii?q?A0DSAQCt2VBjkNlUsotaHQEBAQEJARIBBQUBQIFPgi2BV?=
 =?us-ascii?q?y4EC0WEToh+hXSCKIQomm8PAQMBDUQEAQGFBQKEcQIdBwEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQEBFgkeEA4FIoVoDYI1KQGDZ?=
 =?us-ascii?q?AECAyMdAQE3AQ8LGAICJgICVwYBDQUbgmKDIQMDrFmBMoEBgggBAQaCYIMug?=
 =?us-ascii?q?V0JgREsjCaDNHonHIINgTwcgmc+hEQVg0I4ggwilUU4AxkrHUADCzsyAwpkI?=
 =?us-ascii?q?FgOCSAcDhoNBQYTAyBvBQo4DygvaSscGweBDCooFQMEBAMCBhMDIgINKTEUB?=
 =?us-ascii?q?CkTDy0HI3EJAgMiZQUDAwQoLAMJIR8HJSQ8B1g6AQQDAhAiPAYDCQMCIlZ1L?=
 =?us-ascii?q?xEVBQMNFyUIBTcbBAg8AgUGUxICChEDEg8GJ0gOSj45FgYnRQE0Dw4WA5khe?=
 =?us-ascii?q?AGBcIEyowOfB4NsgUqeeAQugUSVJIsyhnWXGiCnVIF5I4FbMxoIKAhlAYI8T?=
 =?us-ascii?q?gMZD44gGYhthWohNDsCBgsBAQMJik0BAQ?=
IronPort-PHdr: A9a23:wabUQxwT/Q1oSYrXCzKZwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 heZvqQwxw6TFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9q52uyo9ZDeZwVFiDW5bL9sM
 R67sRjfus4KjIV4N60/0AHJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84T
 aFDAzQ9L281/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUjq+8
 ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfFjfK3SYMkaSHJPUMhRSSJMHJ6yY
 IUNAOoPPuhXoJXyqVQVoBuiHAmsAf/jxiNSi3L026AxzuQvERvB3AwlB98AtWrbo8vuNKwPT
 +21y67IzTbeZP5R2jfy9pbHcgs6rPGPQ71wa8zRxlcrFw/fiVWQs4PlMiqT2+8QvGeV8/BuW
 vizi247tQ5xuD6vy98jh4XVh48YxVLJ+yp3zYooJNC1VUp2bcOgHZZRqy2XKYV7T8w+Tm9mp
 Co3yqELtJ6ncSUF1Zkpxx/SZv6IfoWG5B/oSeWfIS9giX54dr+ygwy+/VWix+D/TMW501lHo
 jBbntXRtH0Bzxze5tadRvdj/kqtwyuD2g7X5+1ePEw5mrbXJpg8ybAqjJUTq17MHirulUX2k
 qCWckIk9/C15OTpbLTqvIScN4hpigHkLqshhNazAecmPQgUWWiU5+C82Kfk/U3jT7VGlvw2k
 q/Hv5DGPckXu6C0DgtP3oo+6RuyDC2q3dcXkHUdMl5JZRCKg5DsO17UIfD4Cfm/g06rkDdu3
 /3GPaPuDYvWLnXYk7fuY6x960hCxwo319xf4IhUCr4ZLPL1QUD+rMbYAQMhMwyo3+bnD81w2
 p0GVWKVHqCZKL/SsUOP5u83P+aMY5Matyr8K/U+/P7vjXo5mUcHcqWz3JsXbmq4HvV8LEmDb
 3rsmM8NEX0WsQomUOzqlFqCXCZXZ3moUaMz/DU7CIa9AIbCR4CthaeO3D2hEZFMZ2BGDEqME
 XbyeImeVfcMcnHaHsg0sCEAVLHpb4Y+3BWq/Fv41r5mJ6zQ8zIRsZbL1d5v5uSVmwtksXRXA
 smGm0qKSGI8ymAFSiQ926d8iUd90FCG0LV9xftCGooAyelOV1IZOJPHh8d9DNO6DgHMc8yhS
 1u8RNiiRzYrQYRikJc1f09hFoD63Vj41C2wDupQzuTTbHRV2qfV3nyqYt14126Dz645yV8vX
 spIM2SiwK957QnaQYDTwA2Cj6j/U6Ma0WbW8Xubi3KUtRRbXQNreabIR3YSYg3Rt9uqrljaQ
 eqWAK88ehBE1dbEL6JLbtPzilATR/ruI/zdbni3lmP2AgyHlfuXdIS/XWIb0W3GDVQc1QAe+
 XHTLQ8lGiKouH7TFhRiG02peETx6+Jz7nC2VEk5y0eNdUIJO6Od3BkTiLTcTvoS2ulBoyI9s
 3BvG0772dvKCt2Grg4nfaNGYNp77k0VnWTe/xdwOJCtNcUAzhYXbhh3skXy1h52FpQIkM4kq
 2kvxRZzLqTQ2U1IdjeR15T9crPNLWy68BeqYq/QklbQtbTesqQC5e8QqFj5ugytUE04/DQv0
 tVY1Wed+oSfFBAbAtr6Vkc68QQ/pqmPO3JsodqLhTs8be/u62CRvrBhTPEowRuhYdpFZaaNF
 QupVtYfG9DrM+sy3V6gchMDOulWsq8yJcKvMfWci8vJdK5tmiyriWNf7cVzyEWJomB/R+PT9
 5UI2feV2k2ATTi23x+x99v6n4xJf2RYHWey0gDnCZRXa6k0epwEQzTLQYX/1pB1gJjjXGRd/
 VioCgYd2cOnThGVakT0wQxa0Ul/TWWPoSKj1HQ0ljgoqvHaxynS26H5cwJBPGdXRW5khFOqI
 I6ujtlcUlL6JwQukRKk4w79yc057Ox8ImTIaURFZS77KydlSKT4ureZYsFJ4Y8lqm0OC7X6O
 A/KDO6h5UFDjGvqBCNGySo+di22t5mc/VQyk2+bIHtp7TLYdcx22RbD9YnZTP9V0CABQXowg
 j3WC16getixqIzPxtGa7bD4Bz7nDMQMIkyJhcuauSC25HNnG0i6lvG3wZj8FBQilDT8z59sX
 DnJqxD1Zs/q0b67OKRpZBoNZhe05sxkF4V5ioZ1iosX3C1QhZiY5lIEnH31PNEd3rjxJilFV
 XsQztjZ7RKwkk5uI2mhxI/jUHiZhMx7aJPpBwFekjJ45MdMBqCO6bVCliYguVu0ozXaZv1ll
 yscw/8juzYKxvsEsw03wmCBE6gfSANGaDf0mU3CvLXc5O1HIXyier+q2A9ikMC9Wfuc9xpEV
 i+xc8U6ET9158R7dlHBynv+7sfjYtaYZIAJuxmdglHDgvJTJZZ3keAF4EgvcWuvsXM6jfU8k
 AZl0Ne5sZKBJmEr+7i2ShcKPzjuIdgU5yvmgOBdk9yQ0oTpGY9uf1dDFJK6VvOuVikVqO7sO
 kCNHSc6p3PdHqDQVRmW7EMsx57WO7asMXzfZHwQzNE5AQKYOFQamwcMGjMzgp8+EAmugs3na
 kZwoD4LtBb+rVNXx+RkOgOaMC+XrRq0ajoyVJmULQZHpgBE6UDPNMWC7+V1VyhG95ylpQaJJ
 ySVfQNNRW0OX0WFARjkMNzMrZHY9POEA+OlM/bUSbmAtqpFUOqSzp/p0YZ8+TuIcMKVMTgqD
 vE23FZCQWEsG8ndnGZqKWRfnCbMYsiH4Rakr3Qs/4bmr6StCF6pv9LQWN4weZ119hu7gLmOL
 buVjSd9cnND048UgGTP0P4Z1UITjCdnc3+sF64BvGjDVvG1+OcfAhgFZid0LMYN4bg721wHO
 sPWkfv226R+g/pzDE1KHw+E+InhdYkRLmexOUmSTl6ML6iDLCbXztvfba2jD6ZXkf9fuluzt
 CydHkulOS6M3WqMNVjnIaRHiyeVOwZbsYe2f0N2CGTte9nhbwWyLN59iTBeKVgchX7QM2MYd
 z9mfBEVxlV/xSBVmPNyHypG9HU3dIFseg6V4faeMZELq/BmRCd5jeRX5DI90bQHtEl5
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HmOjSqlNMslq8KATyHpek5luW9zpDfIq3DAbv31ZSRFFG/Fxl6
 iV/cjzsiWE8Qr5OUtQ/+xoXZPsfZqyz/JICOUqUotKGTOW2ldAT7sSircKoQeQfxEWn9Q1vc
 wLT0E9MqyUMbEQt6bHCWeDferIjOP3k5yVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="31919247"
X-MGA-submission: =?us-ascii?q?MDEbCxTH/EzJu5zQGRXq756m8jbYA0665JUCGe?=
 =?us-ascii?q?ec9bmHpQD8P4Orl8tdT11V2OArO9LKTZU0uZM+QcnsItt/V550EYoFMe?=
 =?us-ascii?q?0Bvw1qWEraqbWvWyZxXMsOP4FWDW65E6V5KfxuGRPOFq9wrlC5u786AU?=
 =?us-ascii?q?0H8Uzb5/4+WiAIKQRX+GkdrA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:18:33 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EF23561A02;
	Thu, 20 Oct 2022 05:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42967C433D7;
	Thu, 20 Oct 2022 05:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666243111;
	bh=4pVCCziq7a94r3N8maOeUqp7X0Yk9zsQquoihJA5mgg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GtF/wVU4536AHEaB91zKxsLkNKKhTYFzWarOsMpNt6Uq5SuYVAVemmjoPL8eX5PEz
	 K2ALdjhQ9FHjLZVf0VCM4Zl1DwT7ak37YxKGb7y+X/8KFD1d5yX0Dm9UnUliwO17x2
	 ROd321dUJARKrnaO6wDGt0a5NNYaFyuRZq79gHwCbN1B5r6lUH51wGBQKbpQWNBUxc
	 EMyyJ6LmimR6VJ09OHp0mDO63kitCjs1HbTG5EEN1KqJgCbaWAO1trzt46WYGRH3tH
	 5D7PXk9nbtYhiprl7ga3ZieA2ZUwokOOMXXBgy+IgudjaOQHd5Hsg2zgYWJVNlEB54
	 bUjKInL256wmg==
Date: Wed, 19 Oct 2022 22:18:29 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>
CC: cocci@inria.fr, "Darrick J. Wong" <djwong@kernel.org>
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.22.394.2210200639050.2988@hadrien>
References: <202210191620.171E11C@keescook> <alpine.DEB.2.22.394.2210200639050.2988@hadrien>
Message-ID: <BCF9DF09-DF10-48AC-B689-B97C03900CC5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] coccinelle is skipping include files?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 662
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/BCF9DF09-DF10-48AC-B689-B97C03900CC5%40kernel.org>

On October 19, 2022 9:43:35 PM PDT, Julia Lawall <julia=2Elawall@inria=2Efr=
> wrote:
>> The example I'm looking at is fs/xfs/xfs_bmap_item=2Ec, which starts wi=
th:
>> #include "xfs=2Eh"
>> #include "xfs_fs=2Eh"
>> #include "xfs_format=2Eh"
>> #include "xfs_log_format=2Eh"
>> =2E=2E=2E
>You may want to start with the option --verbose-includes for such
>problems=2E

Ah-ha, thanks!

>The problem is that Coccinelle can't find the file=2E  Your =2Ec file is =
in
>fs/xfs, and despite the lack of a complete path, the header file is in
>a subdirectory: fs/xfs/libxfs=2E  So you could add -I fs/xfs/libxfs to yo=
ur
>command line=2E

Ugh, yes, I see this now=2E It looks like we need to parse the Makefiles? =
:(

>Another solution is the option --relax-include-path=2E  This should cause
>Coccinelle to look over the entire kernel to see if it can find exactly
>one file named xfs_log_format=2Eh=2E  If only one exists, that has to be =
the
>one you want=2E

Interesting solution, and would work here=2E I wonder if there needs to be=
 a "fail I Coccinelle fails to find a header" option? Hmmm



--=20
Kees Cook
