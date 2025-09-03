Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24506CA0EE8
	for <cocci@archiver.kernel.org>; Wed, 17 Sep 2025 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=othbIAfHD8jxzhcpkufOBN+0y6FnMpOO2Go3Oj8brGM=;
  b=XJvccKONAauMjQkv7+X3IxHWKpTvwNUypBpTao4BwW3N5LwwQgbV20Ou
   l595ZEZN3igDSJznyJJslJ8LUcgpaN0haC0GkFHzfbBULZP1I3D2ztsZC
   ghK6vnXCjOSy6EkHDZ4zu8YKadwx4ZfovwoKhC2gEecPIZ2tH3BM/MH0E
   M=;
X-CSE-ConnectionGUID: q2YVTys/Rh6O2rPXJ1j94A==
X-CSE-MsgGUID: b2M5N1DpRwiBZP9Wu8vZ3w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=permerror (signature expired) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="c'?scan'208,217";a="239634437"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2025 14:46:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CB2CE0CD6; Wed, 17 Sep 2025 14:46:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7899BE0171
	for <cocci@sympa.inria.fr>; Wed,  3 Sep 2025 16:05:10 +0200 (CEST)
X-CSE-ConnectionGUID: +0jYLVszSlObOOYtxFuyHw==
X-CSE-MsgGUID: de9KJaE0TFSOshYdhYJQFg==
IronPort-SDR: 68b84b07_ChyX57rP/GMucqyy62Y3i9+tBYvTsg+7LLE1b7iThMXj/SZ
 D5k3HYmqt3KEjwih6shyx9vcYW2HTR8EdsMECpg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FZAwCNSrhogbTbVdFagQmEE4EBWTQEC0mEVYEjgiyMA?=
 =?us-ascii?q?aI7AggHAQMBCAUxIAQBAQMBA5EpAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQEiGQcOO4ZPDYJbO4IWLA+BFBEEGQEBOBgGB?=
 =?us-ascii?q?zcCBB8SAQUBLimCYAGCGwcBBkkDliiPQYEFQos8An8zgQGCDAEBBoEI2xyBX?=
 =?us-ascii?q?QcJFIE1gVhMg0iCWQsBgVwCAg6HWCN6Jw+BVUSBSohDgw6CaYImgRaKLyACi?=
 =?us-ascii?q?FmHeiYmAwcHDitGDyEDWSwBVRMXCwcFgWMBAgGBDm4yHYEnhQ2EHitPhQKBF?=
 =?us-ascii?q?4NTERNrDwaBFYNdhDM2CgMLYgs9NxQbTJJwDAYhRoFng2w+E3kugSSlGgsBo?=
 =?us-ascii?q?TU0B4QfgV4GDIRtgzOCDpVTM4VbpRCIA5EDqTARJIFbI4FcTSOBAQaCMAlGA?=
 =?us-ascii?q?xkPkiGGHRKyJSwyPAIHAQoBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 UEiPzDBFeo5Z15IeGtvmRfHuIZKX/VbSP8cCCI=
IronPort-Data: A9a23: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
 akfDTtX0fr6HL01VvVtvw==
IronPort-HdrOrdr: A9a23:Il1ZTa258kEqRe3xz6KdKgqjBJ8kLtp133Aq2lEZdPU1SL3gqy
 nKpp4mPHDP+VQssR0b6LO90cq7IU80l6QFhbX5VI3KNGLbUQCTXeZfBOXZslvdMhy72OoY+q
 tpbrRkBMeYNykese/KpCe9V/gvqePpzElqv4vjJrVWID2Cp5sP0+6xMGemLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3AgfE4WGnjPnO7wutrFTFnmX4QXZrXOT6Fzkb0HVS?=
 =?us-ascii?q?qMmJOQpqyeEOA1r51s9U7zg=3D=3D?=
X-Talos-MUID: 9a23:aBTB6wmVzp3CQL0jawridnpuOZZLwa2DUHwjqrIdu/iINR1SAhmS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,236,1751234400"; 
   d="c'?scan'208,217";a="124542714"
X-MGA-submission: =?us-ascii?q?MDG3Z+A9MIridpStPMPM9QKYRHR5mPRzdoheQw?=
 =?us-ascii?q?O9J14cXX7aQfAhJX+WU9wm0UrfpjbZ48ksB/qZhekPAyCwObUqHz8W79?=
 =?us-ascii?q?yUI6j/a/pvkDee/NFsKWzD04hv4JxgCQMszbv8lKatMFVjz5tVCS7Ba6?=
 =?us-ascii?q?ahmK/BYgFrf3pD2QHL9Oypjg=3D=3D?=
Received: from mail-yb1-f180.google.com ([209.85.219.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 16:04:55 +0200
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96ff16fea1so6515452276.0
        for <cocci@inria.fr>; Wed, 03 Sep 2025 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google; t=1756908294; x=1757513094; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=othbIAfHD8jxzhcpkufOBN+0y6FnMpOO2Go3Oj8brGM=;
        b=b69pb37URvV9TVhn6WrDhW98qrI0O2ZCuOn8wsM5kvPGjjvFU/qwVBSmTT7JMHE1Bu
         S3ERMEg41T0g1MIbNRmCiX28oBjloBeK9VKWzhe5TETxVXTb/4UfK6yHK65z1cdkTDHG
         6oEMUJlPWn3KutdwaIdnXyic62xkKS+oY+tHby5kttQRwzA5uUVk3P/lPF/1lCjhPFN1
         K8t54iy006f6olgqOvPue2HVuSi61c5VpadmdSrt3t6OFauUmxE/ML9KfsG2WDrA7dT9
         AjZOukZuGzEApCi+ivWBCT9eIq7ycrfpPeLiGswYYwQIETfgkjWhstuYX2uRfHyMZycj
         tpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908294; x=1757513094;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=othbIAfHD8jxzhcpkufOBN+0y6FnMpOO2Go3Oj8brGM=;
        b=TZhePaVkZ8EnPEIFGjjVJ3FO24v25vgHPXQG5MiAu381iPbXba8LqNbX7q0gH96h9+
         yvp7VO5NWUgl95vn2Ryo1Lha3GhZuXVRrwMdX+Rg+KnCvNnFG5MNWbq/Tf8/dM6pgPrX
         eRg0NHXwOoPlo9u5byiXaeOfmfzNauZeQyzIODfwYYP2WwJUxT1xUady8jMHxZpY4y9A
         zAkuphrL2OPrSn3EgBqTurCSpUyob2uNr+FBp+8gOVOER5apgUz8Qiq2goUUq3sZLSbg
         T8Own6cEABgF79Zh0H4+YLU8+nztWbSKTRAOwuC31me/kLTaKOLESEbnEgGiEJ76daeG
         2ulA==
X-Gm-Message-State: AOJu0YxCHCgF6J26WAevt7Gw8xdI90JfVwfQ+e33/bFs+gk51Z2Kwl//
	cC+bawMAZBxppEbEzDrV/q6yKX/xkPoz8LdoJtp923X/8rb+Uoy2ATlHbIO1n7tQnJ+am/PlGM/
	fy76STXru0nf5uQuyyyAre+7Rz2KqbvtEO3zTznf1d6QnmeexQUEjQbA=
X-Gm-Gg: ASbGncvf1mLplZh65KdcEZ0KRrK31OPaYVHFL7pkSEJoSl2SqyxlX/7vgfJadLoStnk
	Ga2xQWNVl9JkBYWNfMaDYckNG1cwJzCjQqgCmz811Eic2BMfYTI60A0FxKTsJsg7frPNynbAOhF
	5qfF2a7v+H4/ChxlkNEKa7uUR8T7ToEEt6sA9R1fyELHXBH5rg5eKuzuzAxHy87pWEYwMzb+owz
	caSvVk=
X-Google-Smtp-Source: AGHT+IFWD6zicApHYew6I7Njvgj95onv4axlsZOq8US/gAXDFUTgZ4XpTxIqqKfdycza0WmHCVvvSh1kPWukKQubtbI=
X-Received: by 2002:a05:6902:1b84:b0:e98:9a5d:6de with SMTP id
 3f1490d57ef6-e98a585f869mr15229876276.50.1756908293478; Wed, 03 Sep 2025
 07:04:53 -0700 (PDT)
MIME-Version: 1.0
From: Gaston Fernandez <gaston.fernandez@eclypsium.com>
Date: Wed, 3 Sep 2025 11:04:40 -0300
X-Gm-Features: Ac12FXynEW3dt2XjbAX8pM1OaiuzXqY8ijkzlIewlJS3_bktCS5QheOIaloj1xo
Message-ID: <CAE0_PArbd-jaTHr8NR-mdP7pkDPsfHVSAAw_Xe16vvexx+eVrA@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/mixed; boundary="000000000000bcea8b063de61634"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Help - Pattern with nested 'if' statements.
Reply-To: Gaston Fernandez <gaston.fernandez@eclypsium.com>
X-Loop: cocci@inria.fr
X-Sequence: 3022
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/CAE0_PArbd-jaTHr8NR-mdP7pkDPsfHVSAAw_Xe16vvexx%2BeVrA%40mail.gmail.com>

--000000000000bcea8b063de61634
Content-Type: multipart/alternative; boundary="000000000000bcea8a063de61632"

--000000000000bcea8a063de61632
Content-Type: text/plain; charset="UTF-8"

Hi! I'm having some trouble with running a cocci pattern, and I would
like to know if it's a mistake related to my pattern, or a
coccinelle's limitation.

*### What the patch should do ###*
- The patch *[if_else_swap.cocci]* should take every instance of if/else
statements from the file *[test-nested.c]*, negate the condition and then
swap its bodies. (A double negative)

*### What I have tried ###*
- Declaring the if/else's bodies as `statements lists` variables, since I
need to store the whole content.

*### What I'd expect ###*
- Negate the if condition
- Swap the "if" body for the "else" body.

*### Result ###*
- Error: It tries to rewrite the variables multiple times. (Instead of
trying to solve from the highest/deepest?)
```
According to environment 2:
   rule.Sb -> x--;

   rule.Sa -> x++;

current modification:
MINUS
According to environment 2:

   rule.Sb -> if (x == 1) {x++;}else {x--;}

   rule.Sa -> if (x == 1) {x--;}else

   {x++;}
```

Thank you, very much!

--000000000000bcea8a063de61632
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div><div>Hi! I&#39;m having some tr=
ouble with running a cocci pattern,=C2=A0and I would like=C2=A0to know if i=
t&#39;s a mistake related to my=C2=A0pattern,=C2=A0or a coccinelle&#39;s=C2=
=A0limitation.<br><br></div><u>### What the patch should do ###</u></div>- =
The patch <b>[if_else_swap.cocci]</b> should take every instance of if/else=
 statements from the file <b>[test-nested.c]</b>, negate the condition and =
then swap its bodies. (A double negative)<br><br></div><div><u>### What I h=
ave tried ###</u></div><div>- Declaring the if/else&#39;s bodies as `statem=
ents lists` variables, since I need to store the whole content.</div><div><=
/div><div><br></div><div><u>### What I&#39;d expect ###</u><br></div><div>-=
 Negate the if condition<br>- Swap the &quot;if&quot; body for the &quot;el=
se&quot; body.<br><br></div><div><u>### Result ###</u><br></div><div>- Erro=
r: It tries to rewrite the variables multiple times. (Instead of trying to =
solve from the highest/deepest?)<br>```<br><span style=3D"font-family:monos=
pace">According to environment 2:<br>=C2=A0 =C2=A0rule.Sb -&gt; x--;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =
=C2=A0rule.Sa -&gt; x++;<br><br>current modification: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>MI=
NUS<br>According to environment 2:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br=
>=C2=A0 =C2=A0rule.Sb -&gt; if (x =3D=3D 1) {x++;}else {x--;}=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>=C2=A0 =C2=A0rule.Sa -&gt; =
if (x =3D=3D 1) {x--;}else=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0{x++;}</span>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>```<br><br></div><div>Thank you, very much!</div></=
div></div>

--000000000000bcea8a063de61632--
--000000000000bcea8b063de61634
Content-Type: application/octet-stream; name="if_else_swap.cocci"
Content-Disposition: attachment; filename="if_else_swap.cocci"
Content-Transfer-Encoding: base64
Content-ID: <f_mf41ibxw0>
X-Attachment-Id: f_mf41ibxw0

Ly8gVGhpcyBydWxlIHdvbid0IG1hdGNoIG5lc3RlZCBpZi9lbHNlIGNvbmRpdGlvbnMuCkBydWxl
QApleHByZXNzaW9uIGNvbmRpdGlvbjsKc3RhdGVtZW50IGxpc3QgU2EsIFNiOwpAQAoKLSBpZiAo
Y29uZGl0aW9uKSAKKyBpZiAoIShjb25kaXRpb24pKQp7Ci0gICBTYQorICAgU2IKfQplbHNlCnsK
LSAgICBTYgorICAgIFNhCn0K
--000000000000bcea8b063de61634
Content-Type: text/x-csrc; charset="US-ASCII"; name="test-nested.c"
Content-Disposition: attachment; filename="test-nested.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mf41k3t81>
X-Attachment-Id: f_mf41k3t81

I2luY2x1ZGUgPHN0ZGJvb2wuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIu
aD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKICAgIGludCB4ID0gMDsKICAg
IGludCB5ID0gLTE7CgoKICAgIGlmKHkgPT0gMSkKICAgIHsKICAgICAgICBpZiggeCA9PSAxKQog
ICAgICAgIHsKICAgICAgICAgICAgeC0tOwogICAgICAgIH0KICAgICAgICBlbHNlCiAgICAgICAg
ewogICAgICAgICAgICB4Kys7CiAgICAgICAgfQogICAgfQogICAgZWxzZQogICAgewogICAgICAg
IGlmKCB4ID09IDEpCiAgICAgICAgewogICAgICAgICAgICB4Kys7CiAgICAgICAgfQogICAgICAg
IGVsc2UKICAgICAgICB7CiAgICAgICAgICAgIHgtLTsKICAgICAgICB9CiAgICB9CiAgICByZXR1
cm4gRVhJVF9TVUNDRVNTOwp9Cg==
--000000000000bcea8b063de61634--
