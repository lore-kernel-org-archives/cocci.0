Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EC1C4829A
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=aVB6P8aqwxOPSAJd6WxZk8H07/EMmD25qioF+f13Y5Y=;
  b=i8w1FEUS47qi0wmSia5dRMr9IxlTKPpvWriGbMVHgE0BWeqG6MpvtbF3
   wEoCqMVAN0uxOfYYTAiApZ28nq7KKd+iT5u9uKtGWBupcsvl+Up1k7NF/
   uuP6gDkBUlSgw9EATxsgCIaJawGNIsdrzYA6x56tZznSpYO1jg0Qmygw/
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151297889"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 09:31:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3916E0CD5; Sat, 10 Feb 2024 09:30:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9FA5CE008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 09:30:58 +0100 (CET)
IronPort-SDR: 65c73442_2qM7b8Xl/W0Rnse0tFDnRZrP9AWb5mbmbbY+nNJBTEcny5O
 dmHr7rOBybM1ksYm0ARyynE+jDihfIYE85yk8Gg==
X-IPAS-Result: =?us-ascii?q?A0GDBAA8M8dlhw4P49RagQmBT4I5fFYyBAtICIFHgwSPR?=
 =?us-ascii?q?IF1hGuBVY0wiHCBVoFAPg8BAwENPQQBAgQBAQMDAQ2BfopNAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJVG?=
 =?us-ascii?q?IEOgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QJHax0BAREnGBwCJgJzAQGCfAGCKgEDMQcNBpgYnDSBMoEBggoBAQaBV0FOr?=
 =?us-ascii?q?HQfLCJWgWEDBoEaLogMGgEFZYlnD4FVRIE8C4JHg1ABA4Irgw6CaIVSgSiIO?=
 =?us-ascii?q?4JEAYw5gVYdA4EFbRsQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FVQNABkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfGBoJPAsED?=
 =?us-ascii?q?BoCGxsNJyMCLD4DERACFgMdFgQ0EQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEA?=
 =?us-ascii?q?yspAyF0EQMECgMUBwsHeINHBBNEAxCBNIo3AxkrHUACAQttPTUJCxsGPQKeH?=
 =?us-ascii?q?wGDJQlZlV+yBjQHgjSBYAWBXAyIeIEjlR0GEy+XLg4Gkl6YV41vlTyFTIFkA?=
 =?us-ascii?q?TiBXDMaJIM2TwMZD445hBSBC448QjUCCTACBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 GokG6uihqKd52VUj6cmc4SkxmVoJ6+IlnTBh9Q=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RMRp8KnRUtpgNeZcQddUeT0d5AfpDfIO3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9J/jJjtWLD2DcMtbnmFE4+ugYzRLrIIqP/AEKK
 Y=
X-Talos-CUID: 9a23:TiRYI2Ec7eZpOm8pqmJC3W0WQpgkSUeellHafgyFV3ZyeYWsHAo=
X-Talos-MUID: 9a23:Q5U7Rwgb1ZZi3WXLHwEWosMpHZhj3on0N0I2iYQUl5XVFzNoHgiDk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151297888"
X-MGA-submission: =?us-ascii?q?MDE38M56s18trCrBNJLWnOZg07vZaJHGrBMdfK?=
 =?us-ascii?q?GqAkokUogc0ZG6nZlNTVRJf/i4RHLAJWHlp7c80KqDtQRHwWOV5R6Qyl?=
 =?us-ascii?q?ovTN7bs/A7WWimzDJ/qBrwecoqe3iOP0beGBgmBSBGq5gnC5QNkoK2UZ?=
 =?us-ascii?q?EMuQq+zKLi04bZ2fAetfGzwg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 09:30:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707553857; x=1708158657; i=markus.elfring@web.de;
	bh=GWQcxXKLIDFkNaX6uwzb1UGE13STuvoBFezVGH84mdM=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=UjQrrHT9HFF+9S6Q2fFSPizDe/3Nb9i9pkXUlx8KIoYd3U4ECa8PvIHDrjRiwQvv
	 3E7JKJLiVi2cvBMRNuYiG72gFeWj6W4dHHY6DY4kRUOl7hLdSOklx5Cw7nCpeQAgE
	 Q59JSD1OjNaaVwQLiXn48StngIADZ72suQnBmBUGbCAxYRq4fOMBELjguwY4TPr6e
	 zuFemAB4srZqkyxrhwkOBLkDsafK23EbHH7VwWREAT1h96/IViwOtrqjrUiCI1/vz
	 T3h/Ug5fJZLJcHshfPKzdje6s0RH241kcBGt+RI6jPqrbV/oufUWZerHtBjEZFnNc
	 tABgACXpeCcIH6TnPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Elg-1qvHKz27rE-014FQY for
 <cocci@inria.fr>; Sat, 10 Feb 2024 09:30:57 +0100
Message-ID: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
Date: Sat, 10 Feb 2024 09:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aPj6+9rimXGJLZGuEAbpisdWLMFUiH80JcHn68HCxaQJes5PPPi
 fuCOObwJ+6Q2P9esTay7orImoXisyUM/LIH3Awgr5NJvtip089C2JPBNJmenfQi/SRopDBx
 cuT+n+iDVJtVNcYBxSI1uiyDKH7lAsYf75GKnyqUAk1BOyPXq6hXy0zTnlBkSgIKCZ1EQfG
 JrxfXgpKzTvmy7u4nYiJw==
UI-OutboundReport: notjunk:1;M01:P0:FCNNhD5fL4w=;ga0RN+hXdH28xilQ2TrAFrQgc+O
 CtOYNea2gzapmzbNnD107XwGuzrlsVnSEPE6JcAw6K7G5cRHozRZKmW06wXQ8CoD/D1QoIpBJ
 pnjN6nXLwaQqnPE4CFSmJ+MTP66gbsyDyYDrMnzkER5T2ng50uqM6lTfVzxtpxEgg+x5xAvlP
 8hsLfqTse4XQx6aDTeVWDDxkQIgnvAu/sxoqAUEghK/3LpM3tZ3o23s33ZSMWLLo1owOKAhXY
 gPA/sCLA6Wfn8b7toFDucxoI45ZwBtYNUeqQw4JR3UAQ03SOOX/LJ3Cwsrbkf9pysLUvm1CRT
 PHvh1dRU0fe1gxDozyT0H3+xNbMdCa3OPpIXx3Ju6NBpkZInjzqmW0kU8ik/csAsQ6gzfAoUP
 AJih74WHU2njhg7AxPTAzUPMJTxLiJrXW/YY6WKdSPvIc8MpcZ7Z85A0qjhN/LQdFRBy03BeY
 +7feb7MzWUCkc5C1pC3+ClazUEIAlKG3VDtxDh3DKt4m78ux/QVRz6I9cW9xIHvqYI0kg5A+K
 eIEdC2///IQOMdsQbcyJIoURMOkCZvQwVCYw6KEIhOmsYMrsFh62dd3bAZIjQj82dtEsmmQTx
 jf3dndb2/LvCKIUC0E0cA23wvUolup5SCc9Zpq3JOYKwHA+Bn51CVLMKysone/TSuHs5hh91k
 baEqJf8kHcfm1+YXJyxsmCSX2bIu9JMIpJW6A4mGPKjefsIPPUe137OqGLOEk1n049z7c1ah2
 Tkignejx9VNUGq15GkWWn63Krcxu+8SJhjBcAm19rXokEa8OaDhP6HbKYkIZVnfl4tZ7Mu3Co
 99Quvip/mHCMqe0oz3vnU3DWgr4mfpj9NnnXwv3hBBqAg=
Subject: [cocci] Extending handling of position information for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1532
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/d4abffb5-6221-4109-9316-acb5c3720c31%40web.de>

Hello,

Source code positions can be determined also by the means of the semantic =
patch language.
I would occasionally like to benefit a bit more from this functionality.

The SmPL manual provides the following information so far:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4965f42eb94d2d67f7375=
c66b268997457cbcefb/docs/manual/cocci_syntax.tex#L411
=E2=80=9C=E2=80=A6
A position metavariable is used by attaching it using @ to any token,
including another metavariable.
=E2=80=A6=E2=80=9D

Such a description is fine for the initial determination.
But I suggest to reconsider data processing consequences after a correspon=
ding
variable assignment was performed.
Addiional data became available. Thus I imagine that it would be more succ=
inct
to use these data at subsequent places in SmPL code by the following featu=
res:

1. Another character could indicate the direct reuse of a position metavar=
iable
   so that the identifier for a companion position metavariable does not n=
eed
   to be repeated any more.

2. Another metavariable type (like =E2=80=9Cpositioned=E2=80=9D?) could in=
dicate that
   known data should be applied once more.


How do you think about to extend the Coccinelle software here?

Regards,
Markus
