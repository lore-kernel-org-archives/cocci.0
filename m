Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5FCC48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=mDCZvyUJfJfdaiylLxXPSj993FbqAwrtUsdLidOe6Xs=;
  b=QMj7kAHaMIqFAm/mcr+x36n4yFm92gTxjHvOmZE0K2Hp5J7tx4DEKawu
   kd768mCk4BncfIa2/8mILfTGs/zgHBdKhuS+4kklSeffo84R0ABEOX1cF
   jGIDmXPaUcMz+l6lHL44n26L7hzSXOHMakViuhRAiuzGK/J2KAzw6fkgC
   0=;
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
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150894038"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 09:49:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 591D0E0CD5; Thu,  8 Feb 2024 09:49:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F024E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 09:49:07 +0100 (CET)
IronPort-SDR: 65c49583_T2Mhag5g7nFKok6Z35qugUTNUYAajY0YKhxwVNCu0gr6HNd
 Yl4JnZwn7Ps+KR4FgUTBzxpMiRZkjo3QWCDY67g==
X-IPAS-Result: =?us-ascii?q?A0GwBQAdlcRlhw4P49RagQmBT4I5f1MyBAtIgU+DBI9Fg?=
 =?us-ascii?q?iKEPoFVhWKQPoFWgUA+DwEDAQ1BAQIEAQEDBA2BfopNAh4HAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VGJg2CVRiBD?=
 =?us-ascii?q?IEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREnNAImAnMBAYJ8gisBAzEHu?=
 =?us-ascii?q?RuBMoEBggoBAQaCZqx0HywiVoFhCYEaLogMGgEFZYlmD4FVRIE8glKFf4MOg?=
 =?us-ascii?q?miCGIM8gSiIO4JEAYsQgVMdA4EFaxsQHjcREBMNAwhuHQIxOgMFAwQyChIMC?=
 =?us-ascii?q?x8FVQNDBkkLAwIaBQMDBIEwBQ0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA?=
 =?us-ascii?q?2QfMgk8CwQMGgIbGw0nIwIsQAMREAIWAx0WBDIRCQsmAyoGNgISDAYGBl0jB?=
 =?us-ascii?q?w8JBCUDCAQDKykDIXQRAwQKAxQHCwd4g0cEE0QDEIE0iE8DGSsdQAIBC209N?=
 =?us-ascii?q?QkLGwY9Ap9PYCITgkseOpJnsgY0B4I0gWAFgVwMiHeWQAYTL5cuDgaSXphXo?=
 =?us-ascii?q?yuFTIFjOoFcMxokgzZPAxkPjXgBQIQUj0dCNTsCBwEKAQEDCYVGAQGDWoFGA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pI08Cq3sbdoweCFsGzDX0AqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A5te4vms6eoaodeHonVLyCpyT6It/I3v3wS7+I3S?=
 =?us-ascii?q?HKmZ3FaS3SWHB/6h7xp8=3D?=
X-Talos-MUID: 9a23:izx3mwWrJx6j/Ujq/A3mnWpbE8Bq3/mFC15Tja88tsCdaDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150894021"
X-MGA-submission: =?us-ascii?q?MDHFXSd2vmjVFXwPTRMUMg//cAKZ2afaa/gjv0?=
 =?us-ascii?q?QhiJjGW0ZY+U+7EhVMyEGRU7MSOMTg6D7ZaPR3ompdRBw7hSRStu4nzu?=
 =?us-ascii?q?7xPgsOWeSLSbezFhMt9GKD2OZ3yosq7YQK8ux7ELaDi121naYpQhtObP?=
 =?us-ascii?q?KFVOqDq/Mk1+Ure6TTkhI0cA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:49:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707382146; x=1707986946; i=markus.elfring@web.de;
	bh=8mbcgQBOHfNnAxh9wBtTpEDjQxb189jZBdv3Wk1QL4U=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=ULsEK45OO3yot/WOFXUfvnARb+7YelhAwV2ytRgNweh0iXOu//AVtbLczFjTOGLr
	 YoX2R57RUpsqVoDIfPGaXYrBKR+4B0pbrV31WKlKGyUNRTogIh3+MEuIiq13Iba+T
	 KHVafcFKn0g6z3bMQdcUZIawDM0ix0v50Z6u0hnWG1Tj02ZiLJu7eUzUCktRhtIot
	 CofMbAtJDMfyinwc4am+VAXZacBDI4hrqXoFdYa2qLALRYCqd9H4PZRQ8+GAf79HL
	 /WBSNsBeLvg1tbdne6xkKPACD2tz7BxB13a5AZzlp3MUADmFqLClJu/OOUwGJBI5G
	 jF/5ASDUrfwXprbZpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2gkl-1rZvll0NqR-0049AR for
 <cocci@inria.fr>; Thu, 08 Feb 2024 09:49:06 +0100
Message-ID: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
Date: Thu, 8 Feb 2024 09:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/eSGhaLQRTcakjsmUJFK1O6q8YMMzVcPOiyxlRbkLvNWyfcJFL9
 x+Sk/F8N6b9CIPnVzMsZ9kuxBs6rYYpfTdvihM2bEU2hT2sBLlB0IYUgtxwYyKykSYazL25
 QYEcLtBRfr9GGeIH5t9VFqyztIgzCSu+jh4t6fqgkn84gz9dpV8PZbEq+gSaTR1AsNoyGEr
 U9ZznehEChqhhoXqeu8CA==
UI-OutboundReport: notjunk:1;M01:P0:RjBmaOU7U54=;ncV5OqxH1wEQkZkDCk+aS6ufjF4
 5qdtYw2ixrplkwAJat0HfXpg5bjGOJipPlB4hQuo9NDsEPaH1Jw923Ci6jH696TkHIsrhESyP
 w0I8KvnUzPiDkBK5iVyWmbnY/UnA1S6fhDsVUnI9+y4nXoW1t5UQ2Jdhn/Na6dCek15R9ITNm
 3BfrXpfvr5dael9Zykyj/G2bDrXAg3yw5fPOf2bVUfbv4RJwx5oXUXyHPmSZR1I+ZnVTyLriG
 SdocMFg1BJo42dmDFMXVa0/zXTisqDsgIr1KKsYciqVCGPa9/hl1+6Cxmrz0cgTUn10cE7U8h
 69jTtdWBpSMjI4PNZt8W83PUKIMocdqb/Th64tpCNXwe3y2oqH8tav9QS40EPln8GNgiaUfIC
 c/D/dlJ51yZHruDKDeFDr/FluTrJTK1tWG6iZPMOuNchzMEDmHe1CeT9VmyVEpaQs0bXg9geN
 zVc8CrHYDRHHTpdYWh93B/NaWDNrvNzcvxWWHjPgf8kNJMxsDVlYZgVlcqWEUbkS7ZcwlVCUm
 y8NcbGyyWAFrJtgSmvX7TcOkpyYBeWsit+MI1/mZXPNskR29KWIVTqTSb+FmwwroXOQ2SDPfc
 xZqzVkmKmUVMJyeB6EZFCLkXsPfPiImLDaleF+enuuIljUCEoS8sRYp18TiGkF/uivpIai47K
 UaPTVPVAmOBH+gAi+JUWq9wiSkiUkoEcCOFjWhq5QlMPzkG5jwbiiIxKvod/mDfUWb6wpSJd+
 imorgpWtJpBPDDp0Y3jaEj7REzlss9fY0Z97sDBnnoe14LmGroup+qUtSBC2kZg7EiGopM3Xg
 GL+8RWLnQQ/Bf4cVsj9sTxGTe1/c7ZThliwzOiMbSrtc4=
Subject: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1511
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/dcb996ea-f041-406e-b641-0e6b515b9a0a%40web.de>

Hello,

I suggest to take another look at questionable data processing according t=
o
a script variant (like the following) for the semantic patch language
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0067=
6-g99513ec1=E2=80=9D.


@find disable decl_init@
identifier var;
position call_pos, declaration_pos;
type t;
@@
 t * var@declaration_pos;
 ... when !=3D var
 my_test@call_pos(&var)

@test_switch disable decl_init@
identifier find.var;
position find.call_pos, find.declaration_pos;
type find.t;
@@
 t * var@declaration_pos;
 ... when !=3D var
 my_test@call_pos(&var)
 <+... var ...+>

@adjustment1 depends on test_switch@
position find.call_pos;
@@
-my_test@call_pos
+test_case1

@adjustment2 depends on !test_switch disable decl_init@
identifier find.var;
position find.call_pos, find.declaration_pos;
type find.t;
@@
-t * var@declaration_pos;
 ... when !=3D var
-my_test@call_pos
+test_case2
 (
-&var
 )


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi test2-switch_opposite_dependencies-20240208.cocci
=E2=80=A6
meta: semantic error: position cannot be inherited over modifications: cal=
l_pos
  File "test2-switch_opposite_dependencies-20240208.cocci", line 28, colum=
n 44, charpos =3D 572
  around =3D ';',
  whole content =3D position find.call_pos, find.declaration_pos;


Will source code transformations become better supported according to
opposite SmPL dependencies?


By the way:
I observed also that another test case can work as expected (in principle)
if the specification =E2=80=9Cvirtual test_switch=E2=80=9D is used instead=
 of the shown
second SmPL rule.

Regards,
Markus
