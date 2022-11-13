Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98706C4332F
	for <cocci@archiver.kernel.org>; Sun, 13 Nov 2022 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TwRbD/4GLNAwXFm88spm0QBhYTm3hvwd9DnIvZIFgOw=;
  b=u75HIthNYL4IgUqzCm+wETEKT89r4YBk+czBWr+QMS3MrEoLRZMx94C0
   ADOACQXXniTFWMko0bOpxVswN581GGOclnbZEoTtVIKNgdJDjRpnynAQZ
   yh34FoNTTCVGiQ7ER2eI5CcgLyYQGdxOh6Mu2bMaIdzgAwDS/n6bQEkRi
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208,217";a="77918434"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2022 15:55:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B32A5E0241; Sun, 13 Nov 2022 15:55:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D685E0092
	for <cocci@sympa.inria.fr>; Sun, 13 Nov 2022 15:55:25 +0100 (CET)
IronPort-SDR: 6371055d_Q1kiOAlLE+J96Y5Lgzedv91DK6Nd+0nF9EDxKJvUzEOdy+p
 P+meI9cUXK7mrBFeDKNn6yCXcBI9Vxbg3qCyhkg==
X-IPAS-Result: =?us-ascii?q?A0F2DABpBHFjhwsR49RaHgEBCxIMhDyBBVMuBAtFhE+Qb?=
 =?us-ascii?q?DGEKYcgkBGDVA8BAwENQQECBAEBAwSEfgKEfAIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEZCRcHDhAFIoVoDYI1KQF1gQgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFgJHUz0BAgIBIx0BAREmAQ8LBD4CAlcGAQwIA?=
 =?us-ascii?q?QGCeYJuAQMNIwesM4EygQGCCAEBBpwGHywiU4FeCYFAiH4Bg2GDNnonEIFVR?=
 =?us-ascii?q?IE8gRWBPjA+iBuCZ4w7gjyIZAclBA4DGSsdQAIBCzsyAwpKGzEnDgkfHAoEF?=
 =?us-ascii?q?w0FBhIDIGwFCjcPKC9nKxwbB4EMKigVAwQEAwIGEwMiAg0pMRQEKRINKydvC?=
 =?us-ascii?q?QIDIWUFAwMEKCwDCSEfBxYRJjwHVjoBBAMCECA4BgMJAwIiVnMuERUFAwsVJ?=
 =?us-ascii?q?QgFSgQIOQUGUxICChEDEg8GJkUOSD45FgYnQgExDg4UA16BaQQ1ZpxeeoE6l?=
 =?us-ascii?q?CODGoZipWE0B4IfgUyBTQyeZgYTLpZuDgaSFJc0IKdYgXkjgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIAwNCYQDiixANDsCBwEKAQEDCYVHAQGFIAEB?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23:ctCLfKjGQ4uvKBXZpxavw8uaX161UxQKZh0ujC45NGQN5FlHY01je
 htvWjuGOPyMa2L0fdpxbI3lp0xUsZDSytE2GlE9ri08RC1jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqicUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYpdDNKg06/gEk35q6r4WpD5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGFxwtPYEYo/hLX3BWz
 d82Gh4TXBKpmLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mZBf+QupkBg3Fp36iiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrK+vtuszSIl2Sd1pC2Pt+MKt6KBvlMg2a6m
 D2b3XT4MEAFYYn3JT2tqy/w2LaWw0sXQrk6ELSn//puqE+Sw2YJAVsXU0G6qL+3kCaWUNVUI
 E084TsrtaF09UqxT9C7UQfQnZKflhsbRsYWDOAwrg2AokbJ3+qHLnNZVT5NaIU4iJEnXQQJ+
 G2ngeHrLyM65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L/tBbYvXnEY8LLUKlsjHmMW2gk
 mHW8UDSk51D1pFWh81X6Hia22rEm3TfcuIizin6No5PxiBwfoq+fZGo5DA3Bt4fct/CEzFtU
 FAuksST6qUxEIuRiCGISugXE9mUCxutNTrBnRhwEpNn+znFF5+fkWJ4sWkWyKRBa5dsldrVj
 Kn75FM5CHh7YiPCUEOPS9jtY/nGNIC5fTgfatjab8BVfr96fxKd8SdlaCa4hj6zwBJzzvFlZ
 8nDLK5A6Er274w4k1JaoM9CgdcWKtwWnjK7qW3Tkkj2j+HHDJJrYe1dagvSBgzG0E90iFyIr
 4gGbpXiJ+R3CaOnKijR7YMJK10WZXE0ba0aWOQHHtNv1jFOQTl7Y9eIme1JU9U8w8x9y7mUl
 lngBB4w4ASn2BXvd1/WAlg9M+mHdcgk8hoG0dkEZgvAN44LOtz+tM/ytvIfIdEayQCU5aUrF
 KdYJJrfWKknp/au0211UKQRZbdKLHyD7T9i9QL8CNTmV84/H1766ZX/cxHx9SIDKCOyuIFs6
 /ejzw7XC95LDQhrEM+cOrrlwkKTrEotvrt4f3LJBd1PJ2Tq0oxhcBLqgtENfsojFBTkxxmh7
 TiwPys2n+f3ntIKwIH7vpzc94aNOMliL3VeBFjevOqXNzGF32+Nwr1gceevfBKGZlzV5ZeNW
 ORx5NP/Oc0hg1xlndddEbFq7KRm/PrpheZQ4TpFFUXxTWaAK+1fMFyZ+/JQp4txxrN9kimna
 HKlo9V1F+2AB5L4LQQ3OgEgUNWm6dgVvTvjtdIOP0Tw4X5MzoqtCEl9EUGFt31AEeFTLogg/
 OYGvfwW4SyZjj4BEI6PrgJQxlS2Ak0waYcVnbBEP9azkSsu8E9IXrLEACyv4J2vVcRFAnN3H
 hCq3pj9l5Zu7WucVUprDnXc//tvtbJXsjBw8VIyDVComN3Eu/wJ4CNs4QkHFgR48xEW/N9wa
 05KNlJ0L5qg5z1HptZOdEHyFhBjBC+2wF3QyVwImDfnTm2tbGjsLXI8C8mJ7ks242JRRRkF3
 bC6mULOcyfmQ9H15QQ2AXVakv3EScdj0yH/g+WlIpi1JIY7aj/bnaOeX2oEhB/5C8cXhkech
 +1V0MtvSK/8bwg8nrYaDtSE6LEuVxy0HmxObvV/9qcvH2uHWjWT2yCLGn+haPF2OP3G3k+pO
 fNAfvsVeUyF6x+PiTQHCYonAbx+xqcp7eVfXILbHzcNtr/Howd5tJ7VyDPFu1YqZNdQwOIdM
 YLacgyQHlOA3UV0n3D/l+gaG26aT+RdWijC8rGUytgZL7MCr+BmTm8q2JSWoXi+EVVq7jCUj
 iz5do7UyO1o9tU1k6CxSZd8JhiGBu7ycM+q8wmDlctEQv2SEMXJtiIT8kLGOSYPN5Qvet1Hr
 5a/m/+p41Hgo5A3THL8t6SaMqt0ufWJQ+tcN/zoIElgnSetXNHm5z0B8TuaLaNlvcx85M79Y
 SeFc+q1KMAoXulCyE1vayRxFwgXD4L1ZPzCoQK/t/G9NQgP4zfYLd+I9W7bUk8DT3UmY6bBM
 w7Tv+qiwvt6r44WXR8NOKxAMq9CeVTmXfMrSs31uTymFVKXu1KluIWzpSp4vHuPQjOBHd3h6
 J3IegnmeV7g8OvUxdVeqMppsgdREH95hvIqc1kA/8JtzQq3F3MCMf9XJKBu5ku4ScAu/MqQi
 PDxgGoe5eHVWDNZbVPj7d6lUgr36ini/DvmDmRBwq9WQ37e6EC87H9J6SpqpXt7Etcm5P/yM
 skQoxUcITDoqqyEho8vCjiTnuptgP/Xrp7NFYYRjOSqaysj7X42OLCN0eaDueEr0y0AqakTG
 VUIeA==
IronPort-HdrOrdr: A9a23:DbOvHqEsBbYvAaJbpLqE+ceALOsnbusQ8zAXPo5KKSC9Ffbo8v
 xG/c5rtyMc5wx9ZJhNo7+90cq7MBDhHPxOi7X5VI3KNGLbUQ2TQr2KhrGP/9SPIUzDytI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208,217";a="77918433"
X-MGA-submission: =?us-ascii?q?MDFX5XfMLQ4pQwl4cp/NFsFOOyi05yzqBK8IVM?=
 =?us-ascii?q?ZB9/5PEbPRAcb79uEN6cDj3hTp9f0ukYfJDANRr7HRnBMCwZKh+2lOWz?=
 =?us-ascii?q?3BotCMRdTFPeySz0ei2SzmLC9cwPBbsXCdCMofQE3LpHWQvCbC9GWRzg?=
 =?us-ascii?q?w06nKdX6Nz3TmpgBX8dKUaDg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 15:55:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668351324; bh=XuvT7Yah8x5xpr/GfHII3Zonrn+QKA20qhQARodlN48=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gnfPGbuypZh5Go9kDunwDTCOSbwBVwIQ6SkoBD6/tLItp+wkBKq/evW0G66TDgrnc
	 XGvOlWu1NVwx1LaeCI8c/Idr4BLD4SJygiHslnP32KZfnEPqaA/VzZlEkvaZzWbLXb
	 MV/7DTPNiiI2iHYGX+5G/uemFpfSaVoPiC6mfnIyPqDk3cjasK2GTXrJ8G1FYl0FbS
	 jyXyP4z0lIamt5E5wu6hAwU7U8FiO9B0va6lb7m3sHtaxbYxfMShwQgm3b5zS9WCNt
	 uSC6nl9Xfkw90qvIgUzNhx35+pVG4XfW+Usdgs/8XsUt/wsrtzOf3ww3ULuuLuJoXq
	 +rVQmtOeOVsmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1p0GDs3cYx-015jTg; Sun, 13
 Nov 2022 15:55:23 +0100
Content-Type: multipart/alternative;
 boundary="------------u3oio49Va08wfHV2hZjoEDfG"
Message-ID: <752a875f-6d92-669f-784d-73f96ed2a0c7@web.de>
Date: Sun, 13 Nov 2022 15:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Elia Pinto <gitter.spiros@gmail.com>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
 <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
 <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de>
 <b48551e5-3792-e563-469-57f2b17164@inria.fr>
 <2dd76fcc-0f76-e99b-80a1-2ade40e65380@web.de>
 <6cedba8a-8765-fd51-2980-b64a6f86aa7@inria.fr>
 <4ae6751f-fc14-782e-013d-af6be69c1f7d@web.de>
 <3fdf533a-e03d-25e-ba34-5591ed0d393@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3fdf533a-e03d-25e-ba34-5591ed0d393@inria.fr>
X-Provags-ID: V03:K1:oC+YQtcZ0GSKOCGAjThxXktUO8cpd2ThrwXBxXg8ktT0BtmfDHI
 BZDA667VyKmoNU2G6Ef1Rkvz+lTX+59cuyBqaV/DJpg9w4E5K3IXz8gSlppF9p2gfmkq4EK
 tjzbl83DNXyr6vIH9C4fEdwOyyARdP5Dzb3FCNY/RpHxRRBj5MYMKlaQ17hXVThNhYfBEhG
 pgCRE+cDuyLyXbNkiajhQ==
UI-OutboundReport: notjunk:1;M01:P0:BGmm0qRPeKY=;2UpLLfFqr1smVs+7VhpaREWAhRI
 R58Prwl75vVDIcpcmBi580tGhWbEwI84hrCIBhumr+XRUtYOHJ7lY5SX9SueAuNYnwilmPsfp
 f8Xie4Ot4b9TFR2CnCcJqBZ3lkHZMWBCsgUddTMxbhsfjURu2xfnS0TmDGvwvuA2ARPtS4lJR
 ZbCOrHRmti7LyYgpIzToONwbUreEGzNTwQkwLAClui/H3WIDn29uDnbnaq5I7B/PErkUIVhUo
 GPa2lEHq8Y/mjkNlp/Z7uJd7XrblMO0j/P/HJ4ekQlUDmnEmwxjMC73Pj4XkrvIaAX2GoOAys
 ti1F6UCyzfeF36QUrDR0T21G7xK572ncJM1c4cfguycuStXxDh9V05rFYv8k4GFV/ljz+Drk4
 Qpn/WbthH9Y3Ew7vrdBKDfyrFpp8wN5e4iwPva1ty65SR2oC3eW++6RZa0E9xald3SKARsR/4
 svViCos/Jv4wo8Z5VisMf2sgKf4ZTKQRLwUV1iF1envM8nXkgu0mbqHV2J/NXQKNCvrah5eld
 2kn+rM6GuHcLKXaJl87MpM8C70eNJzhJLgrzzTHsAV13d+IpH/FOFMA76+RZgdE2wgNSU6jq+
 oq1HdtcVWWf+LFWreD48z3gygvV+Oy4pRAhU6A0C1KvBQxImclZ2HvsZTGmWJ/AcqFfc37NMO
 6Qj6AuSJyrOXcwzd4LvdlXLuVYbhErBrGRzuwDBHJaj/d1sC2JEoqXuc74gaMXKLDWzOj5vlf
 hxpr/4FvP5KIiNtyLMe4ULT8c1byT6NzukGwBJbSbIfdngmT+XIBBBdbTZcROYMA/XlERSByO
 6stPKGJ1hXClxrqUMHQY2qmGBtwfmfAxwYlFgZ1vmmU9ZRsPslOdoh3X4hdQzP3aVHNTfoprf
 07hcxG6Pj9rXEyp4hLPkcYu8uFvah67kqktV4FSqaXa+xJYK0X0/YynlzUAngN04bcihKevDD
 kw4vIA==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 745
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/752a875f-6d92-669f-784d-73f96ed2a0c7%40web.de>

This is a multi-part message in MIME format.
--------------u3oio49Va08wfHV2hZjoEDfG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> How will development considerations evolve accordingly?
> If you use the option --debug, you get an explanation:
>
>      (ONCE) compress.c: 2: More than one variable in the declaration, an=
d
> so it cannot be transformed.  Check that there is no transformation on t=
he
> type or the ;.  =E2=80=A6


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --debug s=
uggestion3_for_Elia_Pinto-20221111.cocci expand_ref-test.c
=E2=80=A6
@@ -1,6 +1,6 @@
void my_expand_ref_variant(void)
{
- const char **p, *r;
- for (p =3D ref_rev_parse_rules; *p; ++p)
+ const char **r;
+ for (const char **p =3D ref_rev_parse_rules; *p; ++p)
=C2=A0{ /* loop content */ }
}
=E2=80=A6


The error message was not displayed for such a source code variant.

I got the impression instead that multiple declarators could be handled
to some degree for changeable variable declarations also by the means of
the semantic patch language.

Regards,
Markus

--------------u3oio49Va08wfHV2hZjoEDfG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <blockquote type=3D"cite"
      cite=3D"mid:3fdf533a-e03d-25e-ba34-5591ed0d393@inria.fr">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">How will development consid=
erations evolve accordingly?
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
If you use the option --debug, you get an explanation:

     (ONCE) compress.c: 2: More than one variable in the declaration, and
so it cannot be transformed.  Check that there is no transformation on the
type or the ;.  =E2=80=A6</pre>
    </blockquote>
    <p><br>
    </p>
    <p><span style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;">Markus_Elfring=
@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe&gt;
          spatch --debug suggestion3_for_Elia_Pinto-20221111.cocci
          expand_ref-test.c
        </span><br>
        =E2=80=A6 <br>
        @@ -1,6 +1,6 @@
        <br>
        void my_expand_ref_variant(void)
        <br>
        {
        <br>
        - const char **p, *r;
        <br>
        - for (p =3D ref_rev_parse_rules; *p; ++p)
        <br>
        + const char **r;
        <br>
        + for (const char **p =3D ref_rev_parse_rules; *p; ++p)
        <br>
        =C2=A0{ /* loop content */ }
        <br>
        }
        <br>
        =E2=80=A6<br>
        <br>
        <br>
        The error message was not displayed for such a source code
        variant.<br>
        <br>
        I got the impression instead that multiple declarators could be
        handled<br>
        to some degree for changeable variable declarations also by the
        means of<br>
        the semantic patch language.<br>
        <br>
        Regards,<br>
        Markus<br>
      </span></p>
  </body>
</html>

--------------u3oio49Va08wfHV2hZjoEDfG--
