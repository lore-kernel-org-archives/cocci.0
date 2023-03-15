Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9023EC6FD1D
	for <cocci@archiver.kernel.org>; Wed, 15 Mar 2023 17:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=NCfTGPBIV9BRNG/LRSwG1B8MaNpAJn7xj+GIN6meW3E=;
  b=oiPvlEtRUvYesB1pyJbZIgE8j8/XzSSx9QX0V63SCO5MNLFNRKB8/4Jt
   s7EeZ2O82ZbMDD/ga7a7myiSWjCzNkd8vt9lm9tJppVf5NTYU28J+YKiR
   6kISZ/hz4CCZWiohL3NYxG3WBxCqASWRRl0raufDfegAQL3EQwi8dPkMF
   8=;
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
X-IronPort-AV: E=Sophos;i="5.98,262,1673910000"; 
   d="scan'208";a="97423207"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Mar 2023 18:36:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63A6FE02AC; Wed, 15 Mar 2023 18:36:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01388E0010
	for <cocci@sympa.inria.fr>; Wed, 15 Mar 2023 18:36:41 +0100 (CET)
IronPort-SDR: 64120229_e70rqPna7a2cQtMgqm98XX7p1RY/029+JvsStmHcqmtj3xO
 jKwZpjIaboLHXLCRQ7JkfmCsFbe/+03AHOeh+bA==
X-IPAS-Result: =?us-ascii?q?A0HYBQA5ARJkhw4P49RagQmBT4IGKIFLLwQLRoRTkQGEX?=
 =?us-ascii?q?4cqhziIaYMWPg8BAwENQQECBAEBAwSCC4goAh0HAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI3IhlkgQgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1NmHQEBESc0AiYCYAwIAQGCeoIoA?=
 =?us-ascii?q?QMxB7EbgTKBAYIIAQEGgmOZJx8sIlOBXgmBFC2HRh5YhEeEVw+BVUSBPIJMB?=
 =?us-ascii?q?zCEbINugmeBDIEeh2ODTIowaoE0doEgDoE9gQYCCQIRa4ESCGuBfkECDWQLD?=
 =?us-ascii?q?naBTgKBWCUEDgMZKx1AAgELdT81CQsgBlhrAi0REwUDCxUqRwQIOQZQEQIID?=
 =?us-ascii?q?xIPLEMOQjc0EwaBBgsOEQNPgUcEgQyBAVOdCYEOlU0fkiCeDDQHgiiBVYFYD?=
 =?us-ascii?q?IhqliIGEy6XCA4GkiOXaSCiN4VCgXgkgVwzGiSDNk8DGQ+OOYENAQKCfI9HQ?=
 =?us-ascii?q?DQ7AgcBCgEBAwmFRgEBgyOCWAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:g8N9eajQ9BAej+V/JJDp/ONob3BQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,262,1673910000"; 
   d="scan'208";a="50296972"
X-MGA-submission: =?us-ascii?q?MDFW3jvXL1z0RrC2P3AnpX9h061HhWkxBeU7AL?=
 =?us-ascii?q?8a4/atuCD6snM9cpVGGP35DFgBzeXJRey5gdjqIfP6mwvkpa1ok+UaLz?=
 =?us-ascii?q?kDX66lDN47JmV7eXqw/ZWIuAMXIQ6Y7rzPfcJkD6tg34XIwnymss47GI?=
 =?us-ascii?q?5Cfb7LoXgfPZSXswrXXPPeMQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 18:36:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1678901800; i=markus.elfring@web.de;
	bh=NCfTGPBIV9BRNG/LRSwG1B8MaNpAJn7xj+GIN6meW3E=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=A02VJ+ESNzlj6HIPsCs+aJNOx4phb6LrMlPxBdyHcrcITkmiY3eO9hIIdgpPWFZlm
	 G05q69Aso44QuDuRj3ILHV8AdUT0tTwsjs7/EEaUSfd7pRgBgGdadxOd3DWj6nJzSH
	 1nos7ugyve+vOWir1uN/nq+PETF17bKu33XYWXC5Mol4Zk8aKfj7yrggCPGr1NAnKk
	 p7sCQHsOa4XIwD9q/fFQe4aRIB7iBQPvbhHSz7KHxbyfPuDvC+LeTzPAIa69IoXZ6M
	 XlAd36rnTISzNIK+rXfWqpIkN7GImKpXL+ccjnmrFhGw1+IDexWOgNUgqT0kEYwMMc
	 P5nlXYg+6EaBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwR4D-1qUsrF2ANR-00s3bS; Wed, 15
 Mar 2023 18:36:40 +0100
Message-ID: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Date: Wed, 15 Mar 2023 18:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmXJJp84GJvAGz7yp9vU2DVYZOl8RMuWtUvXn/oZEvBiHyn2LhY
 K8424MVtwyBEpEWZGEcW1MypB8O4lLgkvmoBfkMUUEndT+QkmU8FK/M+KbdTu9QekMQlgU8
 IQCiFkAUCfWXUZjyvGYUGofwr9gVQ/shukfqHOZrO/GU9uWHsQ4phvYtfAdcxHJ/+o2Qk3D
 XZBDOHZr2LxGZagpIiQpA==
UI-OutboundReport: notjunk:1;M01:P0:aR7dR1oD4p8=;aU0kTZ/2TA9ZV5OVimodxS7hwQx
 GyhHODHaJV0ai+/q7LySHDZp3iJqVlgDCDDPslsQFqBgFGcG67fwcdHJMDBxnDXJxh9QPZHcq
 xQbluy37mYfwYKJT3aKw3pE//RGTFZRUb1Tah2Cahn6kbRYFLwFcBgLeKuQGyP/jHorQ/oBd1
 72/+V1TuK9sSsWH5f7IYPKQxXGSyy3zWUMWC11P2Ae+pqHSJaGjlU6BJ0n2/q4B2YqbsnPGz6
 3hSpil00Bfk91yyGiyDFQo8ovrcX1Yo/35X/6148MSExgWq7FB20mX7+mB01oh0Nzz0zbvu6g
 M67k/9CUDUfqV84ufM7QdEyMFKPBqLra0t7KmPU3oGEI7TBIeL8W2ssJQ/DcXsGG05dMH4BJ1
 Kc00iej2LCaNZc83Gu6fmYPN8Xx5VTeQQnt77fskkJGO46ehXevQXBLU0DEop3CsrY9IBXiS/
 4pzcYSB7HCnEaSvuOjdmDXn0kQu6VzUxl2Ormbdfq84xSTXZxBCU/HYtufuE1rTY5Eu/iSjSa
 zcGcB230NT4m2o674LGF3i1Q5j41X2xgNkhTBvrbesmf5e08T4kiERt4ddJ7U0+7pxxm1Fq6Y
 N3mTNskjtwL9B0xlLCoWhSMCyaloBCnz4gJKZFDcMUwFNIDauFXMIfDLPpX0VP87yAQ8IJRAQ
 f5pAWsAtAwowCab/5xp/9GaYBKAtEy/ufxLJFC2Xj1axKsNc3YYMiLA9+BiBAHULsTOQ1pQ+L
 dYFf08Wx20H4rMQCdrrvzbSUbxIGVpKAQfbWBxdv6p4BHa8llv+ttqPY+W+vZVtrpBPW4Jw3h
 O0C0t0jj9NGYDUhNdFvGiYK/f6iJhOh0JeBDp5B7LC5Zy3NyD5JAmDLLnTUwVxiXK0xvwRDH7
 Bi+WeJ84pEq+W/NJu2SrNYjGapnd1HLSAnXAT39kw9u0jbu1ODoO+qW689hyi6b3HkwmXDjX5
 MJN1XQ==
Subject: [cocci] Reconsidering repeated pointer checks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 890
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55%40web.de>

Hello,

I tried the following SmPL script out also on the source files from
the software =E2=80=9CLinux next-20230315=E2=80=9D.

@display@
expression call, storage;
identifier target;
@@
*storage =3D call(...);
*if (!storage)
=C2=A0=C2=A0=C2=A0 goto target;
=C2=A0...
*target:
*if (storage)
=C2=A0{
=C2=A0...
=C2=A0}


79 source files were found where a check was performed for a failed functi=
on call
and an opposite check is immediately performed for the same variable.
I guess that pointer checks are repeated at these source code places.
I imagine that such code should be reconsidered once more and improved acc=
ordingly.

How do you think about to achieve any adjustments in this design direction=
?

Regards,
Markus

