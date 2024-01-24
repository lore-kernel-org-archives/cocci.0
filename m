Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2317C46CD2
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Lqi8ztWYiNmWkcbbxlivvSQyGZnoKpcmbnH7A8lMUlw=;
  b=V08z3LH64TAqYCGBlAxvW/Xb8Z024kzpybYjSgRzoldR/gKrONP/TQ8R
   R2aHcTDw1ib96gzkGY5m4QC+9OACqH/tMnc91l1nf/ghoacxqNp+cSguX
   qJy+nUOf4A/kMmTFZNF8bV8li9eAnRzEFbUEJ1AigMAcG2GmLbrn/nukr
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
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148431597"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 16:40:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65C69E0CD8; Wed, 24 Jan 2024 16:40:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D24FAE0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 16:40:30 +0100 (CET)
IronPort-SDR: 65b12f6e_1G6HcIj7lydtwBYsQPk6aHals0kkC+vdNJLqBDfsbUjRHvB
 D/zt265nG6+JYnNIzDWVetQjMhZTusW60mSAsxQ==
X-IPAS-Result: =?us-ascii?q?A0G/BwBaLrFlgE7ASNlaHgE8DAILFYFPgjl8A1MyBAtIC?=
 =?us-ascii?q?IFFAoMEkTYthD6BVY0viG+BVoFAPg8BAwENPQQBAgQBAQMDAQ2Bfoo+Ah4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBJBcHDgUJK?=
 =?us-ascii?q?YVsDYJVGIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQJHax0BAREnNAImAnMBAYJ8AYIqAQMxBw0GtUWBMoEBggoBAQaBV?=
 =?us-ascii?q?0FOrHMfLCJWgWEDBoEaLogCGgEFY4lhD4FVRIE8C4JHg1ABA4Irgw6CaIEZf?=
 =?us-ascii?q?4NDgSiIR02BegGFaYFTHQOBBW8bEB43ERATDQMIbh0CMTwDBQMEMgoSDAshB?=
 =?us-ascii?q?VUDQAZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDCjEHKVVBDFADZ?=
 =?us-ascii?q?R8yCTwLBAwaAhsbDScjAixAAxESAhYDJBYENhEJCyYDKgY3AhIMBgYJXQkdB?=
 =?us-ascii?q?w8JBCUDCAQDKykDIzNBEQMECgMUBwsHeINOBBNHAxBdAxkrHUACAQttPTUJC?=
 =?us-ascii?q?xsGPQKXTAGCRFMIGhMsgh+TPY80okk0B4I0gWAFgVwMiHaBI5UWBhMvly0OB?=
 =?us-ascii?q?pJZmFSNbZU3hUmBYzqBXDMaJIM2TwMZD5JNgQuOPEA1AgkwAgcBCgEBAwmFR?=
 =?us-ascii?q?gEBg1qBRgEB?=
IronPort-PHdr: A9a23:DnsoDx8hPYu5w/9uWaS3ngc9DxPPW53KNwIYoqAql6hJOvz6uci4b
 AqFtKwm0wKBdL6YwswHotKViZyoYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5Z7ebx9WiDe5fL9+I
 xe7oAXMvcQKnIVuLbo8xRTOrnZUYepawn9mK0yOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ
 7FGFToqK2866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXDmp8
 qlmRAP0hCoBKjU09nzchM5tg6JBuB+vpBJxzIHab4+LNPRwY7/Sc9wBSGpdR8ZcTTBNDp+iY
 4YNCecKIOZWr5P6p1sLtRawAhOjBPnsyj9VnX/9wKI00+AvEQHc3QwgGd0Ou2nTodvyLqgSS
 +O1zLTTzTnZYP1W3Tn96JLJchAnrvGBRrxxftTKxkU1CgzKkEydpIr4NDyayuoDqXKU7/Z8V
 e2xkW4nrRl8rzuhy8ovhITEhIYYxk7F+Ch6z4g4JdK1RU51b9OgEJVdqjyWOYVoT84sR2xlu
 Cg3x70JtJKnciYG1ogryRDeZvGBboOG7BXjVOOLLjd5gnJoYLO/hxCo8Uih0OLwTMe00ExMo
 yFYkdfMrmgA2wLO5sWFUPdw/Fmt1SyS2w3X9O1IO0I5mKnDJ5MlzbM8jJQevVnZEiL1hUn6l
 qube0Ui9+O19ennZqjmpoSAN4BqkAHwL6Uum82hDukgLgQDWXWQ9/6m273550L5Ra1Hjv0on
 andt5DXPcEbpqmkAw9JyIoi5QiwACy83NsFg3YLNFNFeBSZgIj1I1zCPu30APWlj1mujjtn3
 e3KM7n/DpnXLHXOk6/tfbNn5E5dzAozw8pf55VRCrwZJ/z8QFXxtN/FDh8iKQC6zOLnCNtn1
 oMfX2KPDbSUMa3MvlCT/O4gPveDaJcTuDnmM/cl/eLhjWclmV8BeqmkxYYbZGiiHvt6O0WZf
 WbsgtAZHGgWuQoxUPDliFyZXD5IZ3eyWro86SshBIKnC4fDXIGtj6ab0Ce1BJ0FLlxBX1uLG
 nzpX4SCQfYFLiyIceF7lTlRcLG7SJI6nTyquhX7zbUves/d4C4FrtTO0NZv5uvcvQ4//3p4A
 pLOgCm2U2hokzZQFHcN16dlrBklor/i+a1xgvgDUMdW++sMSQAic5jV0+19Ddn2HAPHZNaAD
 li8EZ29GT9kaNU3zpcVZlplXc24h0Xm1jCpHqRTuriFHp0y/YrD0nK3K8sug23e2vwZhkI9C
 tBKKXXgg6d+8wbJAIuctkyDlLuxM4kY0jTM8mir0meE+k1VA0ZrSauQe3cZawPNqMjhoEPPS
 7j7EbM8Lg5I0tKPMINPbcD1y0pLTrHvNbwyekqXnGG9TVaNz7KIN8/xfnkFmT7aEA4CmhwS+
 nCPMU4/AD2gqiTQFm4mE1WneE7q/eRkzRHzBkYp0wGHaVFg3Lup61YUg/KbUfYawrMDvm8ot
 Tx1GF+329+eBcCHokJte6BVYNV151kityqRkgVnPYG7aY1miEQfdQtfoE7kkRl6S81BncUss
 HI23V9qM6vLmFhFdj6ewdXxIuiNcza0o0rpMv+MnA6Og7P0su8V5f81qkvuplSsH0smqDB81
 sVNlmCb/tPMBRYTVpT4VgA28QJ7rvfUeHpYhcuc2HtyPK2zqjKH1cguAb5v7x+6fMpEdo6AG
 hXzFcIyGMWkbuAn0QvMDFpMLKVJ+ag4MtnzPd6Pwq22J6BNmDy8jGJIyJ9w2ASA+mAvL4yAl
 4ZAyPae0AydUj76h1r0qcH7l7dPYjQKF3a+wyzpbGJITpV7Zp1DSWKnIsnsg857m4aoQHlAs
 liqG1IB3satPxuUdV30mwNKhwwbpnmumC3wyDIR8Xlhi6OF3zHVhcnmegAGPGFjW2Roy1vha
 YS5lNEVWkG0YhNhzkL6oxmggfEK/uIgfyHaWg9QcjLzLn1+X6fV1PLKeMNJ5J4y8G1WXOm6f
 VGGW+v4qhoe3TnkGjgWzzQ6eje2/5ThykYj1yTCdjAq/SCfJpEjoHWXrMbRTvNQwDccESxxi
 D2MQ0O5I8Hs5tKM0ZHKruG5UWulEJxVayjii42a507ZrSVnBwOym/erl5jpCw8/hGXe3sNpS
 D6OgRLyeIjt2IylPOghckQiVzqeo4JqX5pzlIc9nsRa/HEAhYiOu1cDn33yN9pzxq/0KnYAD
 21uoZad8E3u30ttKWiMzoTyWyCGw8dvUNK9Z3sfxiM3680ZQLfR9rFPmjF550aptQ+EK+Yoh
 S8TkLF9jRxSy/FMogcmyT+RR6wfDVUNdzK5jAyGtpi3/qBQeXrpbrW6kkZz1dnzCbafvkRMV
 nHjZZ44EWlv4885PF+psjW749Phf8TMKNgUqxufnlHfguITJJ95n6gPgjd7fGnmt2AhyKhih
 BpihNexu43iSS0l9fC8BQNEczbubMQJ4ne0hKBSx4Cd2IXnCJxlHn9jsILAa/WuHXpSsP3mM
 13LCzggsjKAHqKZGwaD6UBgpnaJEpaxNnjRKmNLhdNlDAKQIkBSmmV2FH0zg4I5Gwa2xcfgb
 FYx5zYf4UT9owdNzeQgPgf2U2PWrgOlIjkuT53XIB1T5wBEr0DbVK7Wpvp0BD1d94a9oRalL
 2uGe0JXAGtPVkHFT1HvM7+y5MXRpuiVAu3tSpmGKb6KqOFYS7KJ3cf1i9QgoGzKb5TVeCYyX
 JhZkgJZUHt0GtrUgWAKQi0TzGfWatKD4Qy74mtxp9y+9/LiXETu45GOAv1cK4YKmVj+jKGdO
 uqXnCs8Jyxf08ZG4HbSy6UEmnMWhTtvcTaFDrkK8yLABvG1+OcfH1sAZiV/OdEdpbo7xRVIM
 NXHh8nd07llkrgqBl0DWVGryaTLLYQaZmq6Ml3AHkOCMr+LcCbKz8/AaqS5UbRMje9QunVYW
 B6eFFL/eCuOnX/lWkL3WQmppD6WNlpStdPlGv6CIXfuRpTqZ0/iWOI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wqw/zKB0eYJHrj7lHelO55DYdb4zR+YMi2TDt3obdfWaSKOlfq
 eV7ZAmPH7P+VMssR4b8+xoVJPsfZqYz/9ICOoqTNWftWvd1ldARbsKhbcKgQeBJ8SUzJ8/6U
 4USdkGNDSGNykdsS+V2mWF+q4bsb662ZHtvv3Gx3NhCSlhdqFn6G5Ce3umO3wzfxNeDZ41UK
 KB6tZK4xqsEE5nFfiTNz0/RfHKo9COrp78fhIcbiRXkjWmvHeT8bb/Hlyi0g0DVi4n+8ZbzV
 T4
X-Talos-CUID: =?us-ascii?q?9a23=3AGA4CFWne6JtMewjDJwxblsktcSDXOV+e52zeIV6?=
 =?us-ascii?q?kM3hKQZiQEG25oJI1odU7zg=3D=3D?=
X-Talos-MUID: 9a23:DR44WgtSiCf4luogGM2nlGtMK+5h3aKXAX80i7BZsuqoPiosAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="77717697"
X-MGA-submission: =?us-ascii?q?MDH91o8XV3fLxvhcEsHW5d6e6BGYtR+rN9iISt?=
 =?us-ascii?q?LmA7mxEoJhDs8+/Fdvvx5I/8bnRzkMBDQyh8o3P+YVKQWfBiOMOmHIq9?=
 =?us-ascii?q?T9MXZCrhY9H5MYPW+axUkd5oeQzZ69KgD/2a0NBtJAawZvX0QU2Em72B?=
 =?us-ascii?q?gOZIipNNx41h8wz+lSDQqe/w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 16:40:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706110829; x=1706715629; i=markus.elfring@web.de;
	bh=W2XH+8hm15kSYLluO+WQMOXrXymDcPsCFD4LMy+xKJU=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=gyekQitzWFGQBDB7jHfy9A6n1DyNN63i0ebSMJBbcH1PWroKnhDGazIh9RQs40il
	 R1CPpnKC7ZMQfjjvnRPoZoUgh1PGRL+uR1Mwmcu4WwpF3t6X1OanzEj6kl6hy5KUp
	 q2pshElX2v7mtfnMZ+pJCYmLkOjrUBQpwwOC/Wrv72Ro8VvoPScmKRRRIY8o+v8VX
	 F52teJcYujm9MSgc4RTbLMUl2A3JJ809QwV+6ZFikLmNf/5m/QrBz5hVQ5m2BSXe1
	 USkLDMVzGzHsXbOtQVJdNcSXL7NBLD4tAMqOaYDwEMQpz79HmQ+c5PFnpZyVLK1hn
	 GS93LFFxqOmzsw2UEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXN7-1rafxK0XSp-00Z933 for
 <cocci@inria.fr>; Wed, 24 Jan 2024 16:40:29 +0100
Message-ID: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de>
Date: Wed, 24 Jan 2024 16:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TGVEtyHC1RwhLDRI2sqxhf1BjHYSr/JVehThzfT4iHkEX0QXVDQ
 YMHST1aDfQBu2XqO08M6B5rNY5hBSPOrbsG8SUSxTXV0XlqrtqvFvaB91tW6dUk1Axqyyvq
 oFkq2XnD4VDt3YixzRqSX/2YZI0RjM6yCAKCGCj/aiWrqK80Oi0EnVnVlixPwR45IPEZ5R/
 72QSalFU8HmMIMXB3P4FA==
UI-OutboundReport: notjunk:1;M01:P0:XbNHO7gbWCI=;9C39wdEtPpbZAWE33So/za0UbEG
 jI9e9pIuWNtB7JNIw7tLfYzFJxbWEM93XI6ySuLgkfAvpf9mcycY48bOQHjKdG4hcsxGvicsj
 aqNsiQItBJnZQx9zyJQ12X3uZ4koKjKgbhK6p4Wbe2lL+AiRlXNOHhTt0ZuN4yma7MJp/2gaM
 jGVD/QBakOQzUsfBo+cgA5/ih9AJG1z9IYUlSO9E+ZV2bgM3vR7S+v314atxvqTxRP+hfQp2D
 gR6KckH8dODSvhKwlVPdeHWXxR1OVcKFhW/91fD70CT1Z/T4zDe5T0OnlAcMtPOl/r3ImSDjm
 1BsSt+CVw7MQIKiSwMV1q7h75WgE+OOS5Z5DjBaZzvMndjkodzmzENYToQYXTfInWC/eSP2bz
 rpqH98J8l07REGyPw9+EVt31BzRC2EK2cP3XeQ9l6F3ICWZWBzQHEFMCKZv0drlgZByypWMtG
 iN2CJc0Sz67SczEg5HUuaydHgJ98QajsDM+q8Gfbx+nehGZKQ9pCNz5+mPJJ3sOxfX2dbGifJ
 iVc4TJW7OsaFKS25JU4F5ycWj8qFIFXeuPrdJ40nmeGYIcnuHze6olzLSomqz7RMhoMAhJSod
 Lb5I6Z99xKtWFiJJwTHXL5stzGHEG9hwKv7FRXyEA8YIirlubyxHBWGKkS2P3rc8/jxu+QdWM
 nrw7yQGsb1One+DFNwpSBAwEEO88pbxdbTFfCbyRe7RiZKPPRME5081eE3KXbJvODmGrpwYw5
 PYhnxf784EfhgxpP+4LWy4meurncBSnVty14tPuDStViwPvkTvIbK+HAlBDzRGxKiwWcydfJm
 bBjwLqowGH5GIyJAcf3dvh/vyD9d2sXYSUX+qpkHlLUGF53QNZgUm3Hkx39TxnbE043qDCwF9
 2LcAnn9JRZ+S13xrn5mBIM5LUGhiHjuf24ff0m5AmfGkXWVa7CcO1z5OQL913UaUyACkRYnV3
 +p1XDw==
Subject: [cocci] Checking a parse error for detailed SmPL rule properties
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1476
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/4604ee8e-a876-4545-b0cb-e4fba2e187a2%40web.de>

Hello,

I am trying the following tiny script variant for the semantic patch langu=
age out
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0063=
0-gdeb429df=E2=80=9D.


virtual report, org

@or depends on org || report disable sizeof_type_expr@
position p;
@@
 my_action@p(...)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi or-test2-20240124.cocci
=E2=80=A6
rule name: parse error:
  File "or-test2-20240124.cocci", line 3, column 1, charpos =3D 22
  around =3D 'or',
  whole content =3D @or depends on org || report disable sizeof_type_expr@


Now I wonder how this software behaviour would fit to the documentation.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5fdb1a247d3374ac30a3e=
565b2cc5167aeefc4e5/docs/manual/cocci_syntax.tex#L87

May SmPL rule identifiers be chosen freely?

Regards,
Markus
