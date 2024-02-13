Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56228C4829A
	for <cocci@archiver.kernel.org>; Tue, 13 Feb 2024 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=XLfJsXCxnY5R6sigtQZYj9mhkjblLvoxMRrFBXHbYrk=;
  b=g5kplNWqvtjd1vbHzawyf+UaCjD6hpRdFHHcRMweuGMSduHy3IQWBgDo
   X64oe4K7/sUgdtfxW16VecSpNusYvW5mnmpeZ5Sj+7b1Qg0BAYg1/9WKY
   OLwTYJk27W6kLKcrEqH1zRmbZ/ZCy7c02RtXOubQnWe1TLRKnL9bJnOyl
   c=;
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
X-IronPort-AV: E=Sophos;i="6.06,157,1705359600"; 
   d="scan'208";a="151689966"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Feb 2024 14:08:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E668DE0CD5; Tue, 13 Feb 2024 14:08:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 18C32E008A
	for <cocci@sympa.inria.fr>; Tue, 13 Feb 2024 14:08:52 +0100 (CET)
IronPort-SDR: 65cb69e3_lWtEt5W2HkZCXsFjmN+4yk6bro9eUqrjf/6KHMlHjEpq+hl
 Cn1JndqUe06/yu3oeGEXgFN1nUYzsXvoLYBEUug==
X-IPAS-Result: =?us-ascii?q?A0HsBAAfaMtlhwsR49RagQmBT4I5f1MyBAtIgU0CgwSWJ?=
 =?us-ascii?q?IFVhWKHTohwgVaBQD4PAQMBDUEBAgQBAQMEDYF+ik0CHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxMEBw4QJ4VGJg2CVRiBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREnNAImAnMBAYJ8gisBAzEHs?=
 =?us-ascii?q?EeBMoEBggoBAQaCZqx0HywiVoFhCYEaLogMGgEFZYlnD4FVRIE8C4JHgXQBh?=
 =?us-ascii?q?AqDDoJoghiDO4EmiDiCQgGMSoFTHQOBBWsbEB43ERATDQMIbh0CMToDBQMEM?=
 =?us-ascii?q?goSDAsfBVQDQwZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwV?=
 =?us-ascii?q?UEMUANkHxgaCTwLBAwaAhsbDSQjAixAAxEQAhYDHRYEMhEJCyYDKgY2AhIMB?=
 =?us-ascii?q?gYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDEwcLB3iDRgQTRAMQgTSKMxQDGSsdQ?=
 =?us-ascii?q?AIBC209NQkLGwYiHgKhdhOWC7IGNAeCNIFgBYFcDIh4lkAGEy+XLg4Gkl6YV?=
 =?us-ascii?q?6MrhUyBYzqBXDMaJIM2TwMZD414AT4ChBSPR0I1OwIHAQoBAQMJhUYBAYMmL?=
 =?us-ascii?q?AiBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eJJzKaoW/waiRcleDBUukTMaV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3Au6Xoumo9xBOgsMLO1gEIPAPmUfk4K1Tdl2/MGka?=
 =?us-ascii?q?TLkFOV5SsQkCupJoxxg=3D=3D?=
X-Talos-MUID: 9a23:uqFiJgTHzP+PVNIvRXS3pwMyDN9Uwp3yK0FRlYRX4ZGHFQhJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,157,1705359600"; 
   d="scan'208";a="151689945"
X-MGA-submission: =?us-ascii?q?MDG3PF6UXdqj/RsGFJS0n90sWPY66QfGPd4m+c?=
 =?us-ascii?q?l9a7peeqgfABCqCuiJtb6bbWu5Sq0JFbA+SdLdwI5BpUloyUq/BVpmdk?=
 =?us-ascii?q?XozYTHyCvqm2rh+6eeohdc2dQ6PxfYB6prpNyXysMrWpnrEetTvgAgr8?=
 =?us-ascii?q?QzsKmY+51bP8ewq8zHNPTAdw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 14:08:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707829730; x=1708434530; i=markus.elfring@web.de;
	bh=ghapLHIOkZvTx3T5LU6Ox7cfVQ8EvJX/DMjkKZJrXsg=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=KFCD/2kKha6kp+LM3Jfevs3QSdolZ/X9pMVSr5GnTRUz/xbzVlx9XkiZeJcCCtfz
	 2yLzVsrfQlMPCCecGOTb1KRqN9L2Bj6NNESRJQO29Fhy6L410hos74ViW2vRvxLs/
	 /2QuS5l9l/P9nAWNf9g0Ycoq0zajfDZUVnOij3GA8z0QcpSGIjUtd/Prfeh4P+oJ2
	 mhzgBPZgTWZ7QFbBb/cNvAfWvE3IDpE/UBT3lZJcg07sM8G59V4SHcjuH1eIJbHdm
	 ZMmfQmB2YGaP0xn43uFHZXCSRCsewxDVf4yl2R8w1lwj9Pxz6hGLiDCvZX0QSDKmD
	 M9bgnCW9F3MCBFtDEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtwh-1rg9ut3KvZ-00BLzC for
 <cocci@inria.fr>; Tue, 13 Feb 2024 14:08:50 +0100
Message-ID: <6346056f-abf8-47b9-9024-ceb60a3f36a8@web.de>
Date: Tue, 13 Feb 2024 14:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6IaYa+2b+JdNOKkxG8YIjXjV48ZCJ4hMxJHDjAkl5rzRpCfGjD5
 HzllIwFF3QL5+4FiZLpiKPzLrPS80TndOaDdgm9xovwfSd+4DK7b4D/Kp2AgpSI4p1mJ2bQ
 cBzHuDI5qdHHnKVuGlUgOlBHsLstEo0b2eycJOUH4i/WgSZJfHKeBKsT+QDubphth9lriI1
 BbAYZhjo+4w/iag1O2IIg==
UI-OutboundReport: notjunk:1;M01:P0:63QtKdB/zGk=;EZ71iDV459dQ0DyoPeUNON7FCMF
 HzC9oxN24I5eebvi200AZaEyv4e28x+6xgwFvTaj3rusdmDrQl6uUbYdVIpMkgGpTuCvbkFn7
 eG7Zk1kPmLqB9K7KkNeDBjGqoujyqhZsR6zOz6CVoiH7o1GVt72r/YcyFyxvm6kiFYrGvcmFb
 cCg+TghSyzdpZAERX6mnsCQ09AEogescDyuF8/Gpt9uVG/veUbayoyplbWeAvX5q7d+5f5BNK
 NdQ3BX+rJomo9tkTjn794rOk/0ct4nBz0X3ttowvY/JobkmuBJV/c9/iSTJ2cNy0cHTWohGlo
 j7h+CbAPoCODiEc6gpXwlOPyAekR1s9erCr5IA/MlMARKVH7xQaftCdOYO0DumwGJ7p462v20
 i9sg8ptfCErVAQZjbTjFJveXai9LZS4FCjYPXjQUZ7tX3kTES/XMgtmyFpmKU2kmRNfgCn3A/
 5shjcUbMkyAlcHi7S7zuiAh77eM/RL77rJYPqR89v7uzv0C7SO03sibi90VLBDkSALDazz/e8
 /It7Ky2ASlKhprrW9CMEv7yCvsfImZP5mTf+iezl9C/T82pNlpafGya38YDWvjS1b/o53oSjf
 0AYMWidYqPfdocfUWh1EZsFssnGQj0iJqit3RtsBh5cSFe0XwHozqS7jx11QEURlRAihGLzuM
 kb57tFRSGD3Ab+sqPB7lbl4JxtBPgjbd98RtwXwC0yrQqy3V4JBKyTAY3ymlXypaewmWH2GQu
 T6fx1Z/7z0ZOGRb2UNqaesXh4ICEqthKX7bT8J9tKUOvru+Mnr2s2DefaIuwhtrthvDHNYAd9
 qKhMdqatJVLe0okAhpJiGL4oqjT2MJqBR7+mZU9XWRJe0=
Subject: [cocci] Fixing a parse error for a SmPL position variable
 constraint
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1550
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/6346056f-abf8-47b9-9024-ceb60a3f36a8%40web.de>

Hello,

I hope that you would like to take another look at a script variant
(like the following) for the semantic patch language also together with
the software combination =E2=80=9CCoccinelle 1.1.1-00676-g99513ec1=E2=80=
=9D.


@find@
position p1, p2;
statement s1, s2;
@@
 if@p1 (...)
 {
    ... when any
    s1
    s2
 }
 ... when any
 if@p2 (...)
 {
    ... when any
    s1
    s2
 }

@duplicated_code@
position find.p1, find.p2;
position pos !=3D find.p2;
statement s1, s2;
@@
*if@p1@pos (...)
*{
    ... when any
*   s1
*   s2
*}
 ... when any
*if@p2 (...)
*{
    ... when any
*   s1
*   s2
*}


Temporary test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci show_same_statements7z.cocci
=E2=80=A6
meta: parse error:
  File "show_same_statements7z.cocci", line 21, column 21, charpos =3D 226
  around =3D 'p2',
  whole content =3D position pos !=3D find.p2;


Will more desirable analyses become possible by similar source code search=
 approaches?

Regards,
Markus
