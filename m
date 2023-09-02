Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD241C83F2C
	for <cocci@archiver.kernel.org>; Sat,  2 Sep 2023 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5oDAv2wZBJI51iR8yVyd18ggWZ2i308Dq0nlDWywsIA=;
  b=kMtOPdiC3qnijKU9N/XW6ltQVyTEkZ2awjiD5XqmJxF2yO6lXvj3pNoE
   Br83HkuBwpeZ80HNPOwi0GNSnB3loyyLE39rzEdhOUfmTHQt8bSxqyDcs
   sef9A+p3s3EUWkM0NNs8fNupp/lsxpFCBngHxi/b6e6C8hns0pGuTL4gI
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="124032312"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Sep 2023 20:43:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A57ACE0CCA; Sat,  2 Sep 2023 20:43:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CA0EE004E
	for <cocci@sympa.inria.fr>; Sat,  2 Sep 2023 20:43:04 +0200 (CEST)
IronPort-SDR: 64f38237_l17mXOxTQgUnrMb5beVCewJ7YsmBg1A3W7Z9BlA74RwLLS/
 EKNSzgD2e5bblKw3zIsH/9EXVgYAvP5duqYtybw==
X-IPAS-Result: =?us-ascii?q?A0EICQCHgPNkhwQP49RagQmBT4I3dgNTMAQLR4RSjz2Bd?=
 =?us-ascii?q?oRsjn2IbYMWPg8BAwENOwYBAgQBAQMEgguCdAKGbgIdBwEEMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOBQsnhWgNgjcpARFkg?=
 =?us-ascii?q?QgBAQEBAQEBAQEBAQEBAQEBAQEXAg06PwMDIwQZAQERJgEPCxoCJgICVwYBF?=
 =?us-ascii?q?AEBgnoBgikBAzEHDakxfzOBAYIJAQEGr1QfLCJVgV8DBoEXLogHAYVKgzt6J?=
 =?us-ascii?q?w+BVUSBFScMgkcxPoJLFwQBgV2DW4JnhwaCW4MhgiQDBIFADAmBBoNfiRsqg?=
 =?us-ascii?q?QgIXoFqPQINVAsLZYEVgkcCAhEnExMFRXEbAwcDgQIQKwcEMhsHBgkXGBUlB?=
 =?us-ascii?q?lEELSQJExI+BIFxgVMKgQY/EQ4RgkcrNjYZS4JmCRUMNE52ECsEFBiBFARqH?=
 =?us-ascii?q?xUeNxESGQ0DCHYdAhEjPAMFAwQ2ChUNCyEFVwNIBkwLAwIcBQMDBIE2BQ8fA?=
 =?us-ascii?q?hAaBg4qBA4DGSsdQAIBC209NQkLGwZAAiegO3CDYyzGeDQHgjGBXYFeDIoVl?=
 =?us-ascii?q?QoGEy+XFw4GkjSYLCCNQZpkgXkkgVwzGiSDNk8DGQ+OLA0JFYNAM49IPzU7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
 JdcE9ezsXQqG/lcBkk3RLQ/
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:47mv+KFagAwch/ahpLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:yF7hWGDXXcRTE0b6Ey5grlIrOMcvSFTMwWnxeU2hDWtSZZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AQRgA+w2Yogb2yWhNDyrMutOATDUj4aOVWEAPzcw?=
 =?us-ascii?q?8goqDCBxZGC+ngi2Sa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="64933619"
X-MGA-submission: =?us-ascii?q?MDGVMeZNX53qXfIaLULrQXPXDoiKJQkFxhX9O0?=
 =?us-ascii?q?wTKUrGNYbXpjPJm0yYfihO29E4ceBNaZrAMtwOw7CGLeQXKkxhhOVsdW?=
 =?us-ascii?q?rHr9QqeNmXuJBfBzalj4KdWyAqeyj3FliMI9mcvXEIsL17O89mcglXUz?=
 =?us-ascii?q?Gs8z2Debqa2m4nERBBXlw4Vw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 20:43:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693680170; x=1694284970; i=markus.elfring@web.de;
 bh=lhhxoV+U0PwOrcC9OT4FwRBhZmeV+p2HEHrjmhJ/81o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=unz46uRcME7XlvrNc9tIugH8o163PLvX5hmCFAHqm4EXnqIoV4KQxJqXqVuGB3ANwmoofvd
 R+R3Ru7+d8XQYGxDyI4OATMytQYYIcX7PZ+IcMKSz8mxOYtTQvjGmgHqL1U/7l3ItM0pmvvri
 VCSWrcFIPheA3gtoeZckP82lC+7SH6iKNWUGUXSLicAbkuy3s7qCHpx2tzXwNsnEFv/vc0w9h
 hejYO1R7YHU5zJvjkD+xpsmb8RGSTPK/CBbGmvUVkhN9OTLCI+BJqN64pP8ATqEeBYgSXfz0l
 gmEevQbGmkw6GGKcCHPiZpVuhK2Ai1kkRmLV5XHeNrfQfWcc97xQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1qdc2o2dEK-001T0I; Sat, 02
 Sep 2023 20:42:50 +0200
Message-ID: <1326a929-8a48-4113-981c-df6dc3220474@web.de>
Date: Sat, 2 Sep 2023 20:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thomas Adam <thomas@fvwm.org>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
 <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
 <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
 <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kho3hZHP35peYRtmVxyoOTUPi6quUMud4Afr35c1q8ow9FZifjt
 5STTRM4WqepiLCZBRlNlTFtO29TO1q4F8sipaKV56klvkuOUEjoPdfIBLsR8l/G53KMmAGB
 kzyrZtlDvtbLqytNte2f0KcgKouxRszMsxW1SBlrchOLkrduv7Uqn5z9m/qF90Bzpwqh6iE
 8rcsgBlnKmK4zq06tR48Q==
UI-OutboundReport: notjunk:1;M01:P0:jJW1ahmxu8M=;bjl/9/4ewvILq+vV3wmqt33+wkU
 ZGeRfpFJ/E6hDbVNxE9yFmK2pd/vty3HPIfeiCFXavT7mGBbaQB5tpXXSy5xNYLvSdhBkujfC
 hGuafD0iQ9qpOu9hrzGgX7ZIGLgxOeDXrZHBIKkQXTj9oktqCgiAl1aweTRVqsNckeQzMOnVm
 cpelNNuG03S13tOTvvf0/xHwV+sGYSueL2Ud9UUgZLXKm4LEjibWwgwWL9gAovxju2AbGQD4P
 XR2vq6nmsk40Ck/0Kq9/g3ywLA0pqyfUF/dJxhi/k6bwFOkD5KxEy+UakNDLgN/9XhKo+lSqd
 CmHS6xvzNJS7SJEoeeUBlSSlg0ErhBSdcFLxxnlYqlZyYDLx+JiAlNelx95yJZCb7PruX02vw
 flKmr+7akyUFlwJgqSle1PWY4Gl094nQLuFsiNeRHiIEAsR48rmapDe+kAmxUFhf2Am0Qbj9R
 J6QVidsl2CuhayUujc/KuO4NNGboWOQ+lQO79OBdXyJW8rARWJ9gchfiZX2t56ls7/1Y0FNti
 HbpnPtZSHegq/Y2tRymLU9vchjIz0PlV3aMS90in3nDXhVPaUSZ7ZV5i7SSNRLA7qKNv33wcr
 4gW525aWNIMs1EGmfzqnx49phkSjTVJDChXTK2uDctRAPXpiNk9wIEt5Waf53i8FAZPKKF3lU
 okNeChfZyFxdcBflkG04BeaTBKgknfddVMzQEHzKy1RCwY63CMsbgSuxdf9um/sSl4q5oSJkR
 pbFCQs9KdhXQ0OomJKiIjq8h/gRx/JojaqLg1NLA6508oLsgU2t0VzuOyPx1BYsd5aEgWL8P3
 HphOQ+kuXbFd8CiI3SyTpAMjUe65DbOm7izVnLde/1f7CmenURH9dh1VZQksC7yXp/loUzKxa
 7fo/5ONiCPW710dKv4a9rE1TeNCkj7SqFxHmWxkHHNHP3oK18C2P78LIgv0tQkadXF9OXRKaF
 4xf+fQ==
Subject: Re: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1233
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/1326a929-8a48-4113-981c-df6dc3220474%40web.de>

>>>> Now I wonder why a corresponding patch is not generated by the softwa=
re
>>>> =E2=80=9CCoccinelle 1.1.1-00478-g0afff7fa=E2=80=9D (OCaml 5.0) at the=
 moment.
>>>> I would appreciate further advices.
>>>
>>> Probably because in each branch, the first line is a declaration, not =
a statement.
>>
>> How does this feedback fit to other software documentation according to=
 declaration statements?
>> https://en.cppreference.com/w/cpp/language/statements#Declaration_state=
ments
>
> Whatever.  In Coccinelle, we decided to do it that way I said it is done=
.
> This makes it easy to search for the first statement that is not a
> declaration in a function.

The following SmPL script variant does also not produce an expected patch
for the source file =E2=80=9Cfvwm/colorset.c=E2=80=9D.

@replacement@
declaration d;
statement s1, s2;
@@
-if (tint !=3D NULL)
-{
- d
- s1
- cs->tint =3D GetColor(tint);
- s2
-}
-else if (tint =3D=3D NULL)
-{
- d
- s1
- cs->tint =3D GetColor(black);
- s2
-}
+d
+s1
+cs->tint =3D GetColor(tint ? tint : black);
+s2


Regards,
Markus
