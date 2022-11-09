Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C788C43217
	for <cocci@archiver.kernel.org>; Wed,  9 Nov 2022 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=WalGVWp9jVxasTS6+YNjJ3jh4E2DBMUSc79KiKEBNPo=;
  b=tW0RecKGw23reYQxamOkGesmwWQnbP4+VbbhvZVO1hpUfCQBQFN7+5Zn
   Cf8vAaFUsww7Xl+fuc3F2VE1fkkkwGKvQxm2icDngQ5pIS6oIUz0xQpWp
   vVUaSt251uldB6U3BVnoUS1SRwUuvpu5yiCmlfjqYI+VLfcHaXTo3OWVy
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.96,150,1665439200"; 
   d="scan'208";a="77446452"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2022 12:48:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC67DE039C; Wed,  9 Nov 2022 12:48:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 22193E0092
	for <cocci@sympa.inria.fr>; Wed,  9 Nov 2022 12:42:30 +0100 (CET)
IronPort-SDR: 636b9225_NkXoAEVjfmAO8ExZz3wJKaKq91qT1dMrSaWxnBafn4F9Rj6
 rZO6KdLieKT3+q0NQUWJNYVs1vdvCGssRUIzinA==
X-IPAS-Result: =?us-ascii?q?A0FfCgARkWtjf7DQVdFaHQEBKwsGAQUFAQIBCQEVgVGBQ?=
 =?us-ascii?q?wJmgQJVLwQLRYRPjnVaAQEBBo0JgQqGKIhggxY+DwEDAQ0UAQEjCwQBAQMEN?=
 =?us-ascii?q?wGERoR9Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECE?=
 =?us-ascii?q?AEBGAkZBw4OBSSFaA2CNSIZY00DAzUBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBBAINUh9gER0BGx4DEhAPAiYCJAERAQUBIxoaglyCb?=
 =?us-ascii?q?QEDMAMQnnaBBEKLMoEVBQIWgQGCCQacBwoZKA1rgUEaAgEGEoECKgIBAYcog?=
 =?us-ascii?q?VKDYIM2gSGBGYEQgRU2gkSDUAKBdYNCgmcElxoBAwcDBAYFDwMDAiEBAgFDH?=
 =?us-ascii?q?QIJAyMPAwsJCBM/BgECAQECCgdABBsfAwEBDyQBAQICAgMEBwIBAwYDDAICA?=
 =?us-ascii?q?QEBBQYNAwIDCBMDAgEDBQICBAECBAoIAQICAQIEBQcCAQgGBQ0FCQsBAQIDB?=
 =?us-ascii?q?wQDEQIFAwUFAwMCAQoFAgMBAgEBAwYEBAEBAgMCAgEGAgIBAQMDBAMBAgYCA?=
 =?us-ascii?q?gcCAwIBBAIDAwEBAQICAgICAgMDCQIIBwUBBgECAQQDAgIBAgcBBAEIAwMFB?=
 =?us-ascii?q?QkPAwUDAQMDAhQKBQEDCAYIAgQFAgUDAgQCAwICCAMCBAMLAwUEAgcEDwcCA?=
 =?us-ascii?q?wICBQICAgICBQQDAQICAgICAgUCAwIBBQECAgECAgIEAQICBwQCAwEDBA4EA?=
 =?us-ascii?q?wICAgUBAgIBBgIHAwECAQQDAQEEAgQBAgUCBAEDBgIEAwoCAgMCAgIGBQMDC?=
 =?us-ascii?q?ggCAwUCBAEBAgcEAgILAQYCBwICAxABAwEEBQUDAwMJAgIDAgQCAgoBAQEBA?=
 =?us-ascii?q?gEHAgQHDQICAgQCAgIBAwIBAgIKEgEBAgMGBAYFAwIIGAUCAQECAgMDAgYCA?=
 =?us-ascii?q?QIIAgQBBAUCAQICAgIEAQMGAgMBAQIBAgIDAwIBBAIEAwMBAgECAgIDAgICA?=
 =?us-ascii?q?wICAQ8CBgYBAgICAgICAgICBgECAQIEAgcCBAMCAQICBQICAgMBAQYCBAsBA?=
 =?us-ascii?q?wIHBgEDAgcFAgMBBAMEAwMLBQwIAQUBAwEgAwICCAIHAgEGBQEPAwICAwICA?=
 =?us-ascii?q?QQKAgMFAgQCAQQIBwIEAQIJAwIGAgcFGAECAgcEDAoCAgIFBgIEAQECAwECA?=
 =?us-ascii?q?QECAwQCAwIEBQEFAgECBQQCAgEBAgUCDAEBBwYCBwICAgIDAQQCAQIBAwMCA?=
 =?us-ascii?q?wEBAQMGBgUEBAIDAwYCAgIGAgIDAhEDBgIGAwIEAQ0OBQQFCAECAQEHAgQCB?=
 =?us-ascii?q?wkOAgEGAQUCAgMCAgEFAgEGAwECAgICBQgFAwQFAwYPAwEBBAMCAQIBBAMCA?=
 =?us-ascii?q?wcDAgQEAwECAwQGBgEJAwICBgMCAgINAwQCAgECAQEDBAQGAgICAQICAgIDB?=
 =?us-ascii?q?AICAQEDAwMCAgIDBAIDAwsGCggDAwIBBQsEAgMCAQMGCQIEAgIGAQIEAgICA?=
 =?us-ascii?q?gICAgMBAQMKBAIBAgMCAgYDBgIBAgECAQkFAgEJAwECAQMEAQMJAQICBAkCA?=
 =?us-ascii?q?wcFBAYEAgICAggCAg4DAwIBAQQCAgQFAgILAgECBwIFAQEDBQcCAgECAgEEA?=
 =?us-ascii?q?wEJBAECAgMCAQEDAxEDAwMBBAICBQMDDQkGAgIBAwIDAQ0DAwECAQIDAQUFF?=
 =?us-ascii?q?wMCAQgHAxMDAgEBAwIBAgIDBg0CAgMDAwIBAgUCBAMDBQIBAQMBBAMCDgMCA?=
 =?us-ascii?q?wMDBgECAQECAwMBDAQFAQEBARcBAgMEAgIBAQIFAQQDAQECAQIDAgIOBgEEB?=
 =?us-ascii?q?QwDAQIfAgIDAwEIAgICCAICAgEDAwEDAwUBAgMEAgIBBQQKAgICAgICAgEMA?=
 =?us-ascii?q?goDAgMBAwUBAwIJBQEFAQIHAgUCAwEBAQICCAIIAgMLAQMFAQYCAQIBAgEFA?=
 =?us-ascii?q?gEBAgECBgUFAgICAgICBA0CCAICApkXgyosxSkHg2oFi0iVBzKpFZcyII0jl?=
 =?us-ascii?q?H6FJxAjEoFEI4FcMxojgQGCNk8DGQ+OLBaDUIpfQzE7AgcBCgEBAwmKZQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qPhF2qD6ZbUfp2/lHemv55DYdb4zR+YMi2TDsHoBLyC9E/bo8P
 xG+c5w6faaskdzZJhNo7C90cq7IE80l6QFg7X5VI3KNGLbUQCTXeRfBOXZslnd8u7FmtK1F5
 0MT0GzMrLN5JFB4/rH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,150,1665439200"; 
   d="scan'208";a="77445499"
X-MGA-submission: =?us-ascii?q?MDGN4+cyZH/lNc5IZW516ixn6pN9xMFBqjjpUt?=
 =?us-ascii?q?ExTA94OjjrH2p2vJ1UOxVReWv364+Z+93M222JhFLQLVzQlq9wirFxU4?=
 =?us-ascii?q?XrDt9a4KuNQuqtIF4A0abqzq5JF/3e8PjgLJfEC320PyvhI4YsRpBHYJ?=
 =?us-ascii?q?TKPke4iVgpf/MviRfC+B0xSQ=3D=3D?=
Received: from mail-lj1-f176.google.com ([209.85.208.176])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 12:42:29 +0100
Received: by mail-lj1-f176.google.com with SMTP id t10so25427574ljj.0
        for <cocci@inria.fr>; Wed, 09 Nov 2022 03:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WalGVWp9jVxasTS6+YNjJ3jh4E2DBMUSc79KiKEBNPo=;
        b=OmxdiNzJzEWN83zdDihodeNbowTn/RtD3hYpo9Ib9LBPFe51QhrpjPALcNcETpgvO3
         N10AVqhZdVFWbAoNTE+3HDbzDdq7T6LySl+MUy13hV68k2a1ZtiQ0WHsz0ln5Myt6goE
         QcD6BAu6g4VUai1i8JH2V3boWJqabMfJCPRwhJOaS9vPlVoLbq5Hq4dtzpwZjh1xWpZQ
         5vBkzoMUySgu+AcdPKIxrsaGVT94do6lIXUX2kQoy0FnjDDFuQv548xYURYRp5M6Qye4
         xZljz1AP9m70OcqoAUa6/nxxuazd0c/10Dixfrh4PzJiHIgRcAEIYt0IFJ8DetgMAr3k
         sa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WalGVWp9jVxasTS6+YNjJ3jh4E2DBMUSc79KiKEBNPo=;
        b=Qv/b3U1Hrf+q+3Xt/UXHMtVGxfy+2TxSqP+12ewOEGyYKoFLizgtRkRmWn5j4vwi7A
         rRm3MRUVV2MGD+sLgaseh/k1qJMBe5tzygDHwmdF11FQH10HAWSw4nEJlomtuvzDc/CN
         ILY058h+xAOhbvrEujVpA14LlXhHqmpukAd+vwwU9p3kUNQf5rmhBTcuWM1hXzlLJ2iB
         hRm+B45jzAp/lhgUSzZ31exczgbRHDOjgkKTNBlLO6zbdvRO0K5WO50Q31bXWTcb1b00
         vYjIkRl262In4/Nfb5rhX4spX7jGdWxUrqGN7tH4I2FUp61xXHoFj756gUULXOfkNRUH
         Pb2A==
X-Gm-Message-State: ACrzQf3qqdXSCCMWPoM7tiDAy6Gd5IzV43jBcEY/85Z6UfJRP2Wgy9mR
	P1bbE4vFWkHxiXUkTfeQ437iMDmlkJjRT9fNzoeCo4gAq1k=
X-Google-Smtp-Source: AMsMyM7QjgvFDqjgBz7qJMAj4Nki5L4KmwAZo4iD+19jcND+N9kpyrmECxrGYu0GpURXqTyEe4dk0BGkispVxvluxAI=
X-Received: by 2002:a05:651c:95:b0:277:35ea:97b1 with SMTP id
 21-20020a05651c009500b0027735ea97b1mr20687178ljq.408.1667994148139; Wed, 09
 Nov 2022 03:42:28 -0800 (PST)
MIME-Version: 1.0
From: Elia Pinto <gitter.spiros@gmail.com>
Date: Wed, 9 Nov 2022 12:42:18 +0100
Message-ID: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
To: cocci@inria.fr, cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Possible bug in a semantic patch
Reply-To: Elia Pinto <gitter.spiros@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 728
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/CA%2BEOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg%40mail.gmail.com>

Greetings to all

I am trying to apply this semantic patch

****sp.cocci file ***********************************

/ * SPDX-License-Identifier: LGPL-2.1-or-later * /

@@

type T;

identifier I;

statement S;

expression E1, E2, E3;

@@



- T I;

  ... when !=3D I

- for (I =3D E1; E2; E3)

+ for (T I =3D E1; E2; E3)

    S

  ... when !=3D I



****************************************

to this repository

https://github.com/git/git.git

The semantic patch works on almost any code. However, it produces an
incorrect transformation on the refs.c file
https://github.com/git/git/blob/master/refs.c

Doing

spatch --sp-file sp.cocci refs.c -o refs.after.c

An incorrect transformation is created:

diff -Nu refs.c refs.after.c

.....

@@ -733.12 +730.12 @@

 int expand_ref (struct repository * repo, const char * str, int len,

               struct object_id * oid, char ** ref)

 {

- const char ** p, * r;

+ const char ** r;       =C3=A7=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NOTE



......

which erroneously changes the type of the variable r.

Is it a bug or should the semantic patch be done better?

Thanks in advance



Elia
