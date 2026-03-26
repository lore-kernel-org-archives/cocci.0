Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCB310A62C4
	for <cocci@archiver.kernel.org>; Thu, 26 Mar 2026 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=zRdXEwRuzxgRW3olamaK9cPbkEN4z/OOUScctnB2JuY=;
  b=OH+1pflDJRhMmGyiYnepHICNLo6yr8FNGtpC6f2Sul/OgjQ3knff+b4U
   48f2FFlW4axI3HDoDpSct4C78HYZtlBfwI9hWt0MPhldjC6X3deEJUilk
   DMftAZtK6aorkGSMpwyIEBPsPA2JFEigaTaZTV/NKzkoS3HKC252bSD71
   E=;
X-CSE-ConnectionGUID: RcOlY5xbTgaV7X35+/Rq/Q==
X-CSE-MsgGUID: 0acVhtIoQwmN8evVzL0duw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,142,1770591600"; 
   d="scan'208";a="269634283"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2026 14:05:15 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5577E8304B; Thu, 26 Mar 2026 14:05:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5A08C82FDD
	for <cocci@sympa.inria.fr>; Thu, 26 Mar 2026 14:05:13 +0100 (CET)
X-CSE-ConnectionGUID: K9Q6CgR/Suq3JD9WzmNQ5w==
X-CSE-MsgGUID: D/H3f2fZQhKSuLLAh6X6Nw==
IronPort-SDR: 69c52f08_zgQ1Ha/HpttSKbL2LERcbVh2FsMC4eZlaiIFhv4x2m2E3m2
 MtdmU0ekxMrjujvljv0rqHNs18wuotExZtAYMWQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EvBQCwLcVpgAMP49RahRpoH140BAtJCIRQj1OGX48Ri?=
 =?us-ascii?q?HmDUgIPAQMBDUoEAQIEAQEDAwGSJgIeBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBDQEBBQEBAQIBAQIEBgECEAEBOwcOO4YgLw2CW4EsgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOm0dAQERJzQCGA4Cc?=
 =?us-ascii?q?wEBgn4BgiIBBhABAzYHDQa0SIEygQGCDAEBBoFGBQ1BUNd7HywiWYFnAwaBH?=
 =?us-ascii?q?y6Fb4JKHAFziiMPgVVEgTwLgkcxgx8BA4Irgw6CaYImgQ6KPIcfgUocA1ksA?=
 =?us-ascii?q?VUTFwsHBYFmA4EGbjIdgSM+FzRYGwcFgWAPiG2BYYESAYNdNCgCAQttPTcJC?=
 =?us-ascii?q?xsEPY0/MYItaFcCgg2TVBieHpRjNAeCOIFnBYFfDIkIgSaVPwYTL5dSDpMLm?=
 =?us-ascii?q?QaOCZVghViBfyOBXDMaJE+CZ08DGQ+NeAGEKDOBC8ZXRTICCTICBwIHDQMLh?=
 =?us-ascii?q?UQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23:Sz/2CB/zMf/Zv/9uWTe2ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Y
 AqHvb421gCVAc3y0LFttan/i+jYQ2sO4JKM4jgpUadncFsor/tTtCEbRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiTSybL9oM
 Bm6sQrdu8cIjYZgJas8xQbCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQ
 KJbAjo7LW07/dXnuxbbQwSA/3cRTGoYnAdQDwfK8B/1UJHxsjDntuVmwymVIdf2TbEvVju86
 apgVQLlhz0GNz4992HXl9BwgadGqx+vuxBz34jZa5yTOfFjfK3SYMkaSHJCUMhfWCNODJ2yY
 YsSAeUdMuhVtJX9p0IUoBeiGQWgGuHixzlVjXH2x6061OEhHBnB0gM6BdIOs2nUrM7oP6kdV
 eC1wrPIzTTFb/NZxDzw74/GfQo7ofGPQLJwatDdx0YrFwPLlFWQqIrlPzyO2+UDrWeU9PBsW
 v+xhGM+rQx6vzegyNs2hIbTmoIV1k7L9T9/wIstONC0VUx2bMKlHZdMty+XNIl7T8MiTWxpp
 Co0yqELtJ67ciUJ1pkq2gDSZuCaf4SW7RzvSuecLDlkiH9leLyxiBC/+lWuxO37U8m7yldKr
 ixdn9bQrnANzwbT5daJSvRj5EeuxzCP2BzN5e1ePU80kq/bJ4Ygwr42jJoTsF7MEjX4mEXsi
 qKda0Yq+vCw5uj5f7nquIWQO5Fqhgz8KKgih8yyDf42PwUIQmOV4/6z1Kf58k38WLhKjuM5k
 q3esJ3CIMQbobO5AxNP3oct9RmwFC2q38kGknUfLVJFfgyIj5TxNl3QPfz0E+2zj0qynDpp3
 fzKI73sDo/DI3TblbfuZ7d960pSyAopytBf4opZBLYbL/LpWU/xqcfYAgU2PQywzebnEtR91
 oURWW+UDK6WLrjdvUWV6e0xO+WMfpMauC7hK/g54P7jlWM2mVgBcqa13Jsac2u4H/RjI0WBe
 3XgmNYBEWEQvgo/VuPmklOCUSRLa3a0RK0z/is7B56+DYffWoCth6SM0DqjEp1ZeG9GDVOCH
 23weouKVPkAcDiSLdF/kjIHT7asU4oh1RaztA/m0bZmIPTb9TYCuZ3+ytd5//DclRIz9TxxF
 8mTy26DQG9qkG0UWzI42rhzrlF4yliZy6h3n+RVG8RK6f1RXQk2LYXcz/R0C93qQAzMYsqHR
 ku+TtW9GTExQMo+w98QbEZ5HNWvlgjN0TOyDbEaxPS3A8k/9anX3lDwIdx8wjDIzvoPlV4jF
 +5GL267neZS8wbJBojG2xG8nrypaL9a8SrD7maFwkKRsUseXAMmAvaNZmwWekaD9Yex3UjFV
 bL7UdzPUyNEwM+Gce5Rb8HxyE5BXLHlMcjfZGS4nyGxAwyJz/WCdtmiYH0TiQPaDkVMiAUP5
 TCeLwFrIy67oH/FShFqG0juZUzE7uR07n+2HQcv1w/fV0R6zPKu/wINw/mVSvcdxLUB7QIos
 TZpBxCQ29zMCtyPjxVsduNQbIB1+09JgETesQE1JZm8N+Zii1oZJhxwpF/r3g5rB59olM83s
 DU1wQA0Ja/wPEppUTSe0NiwP7TWLjK35xWzc+vN3UmY1t+K+6AJ4fB+qlP5vQjvGFBwu3Ngm
 8JY1XeR/PCoREIbTI7xX0Ar9hN7u6CSYy8z4JnR3GFtNq/8uyHL2tYgDu8oghi6eNIXPKSBH
 Q70W8oUYqrmYMkjgVu0dVQpOO5I9ag7F9yrfb2K1e/jPeptmi6nkXUS+Jp0gQqH8ytxTPKN3
 o5QmajCmFHdCHGl0RH64aWV0cheaDofH3Sy033hDY9VPehpeJoTTHypO4uxz8l/gJjkXzhZ8
 kSiDhUIwpzMG1LaYlrj0AlXzUlSr2agnH7y6jVukCwy6Ieb0jbPxevKaxcNfGJGDjoH7x+kM
 c2vgtYWUVL9JS0gjhi4/gDXw6ZBpaJwB3beSwFEcmKlSgMqGrv1vb2EbclV7ZouuigCS+Wwb
 2eRTbvlqgcb2Sfud4dH7AgybCri+pDwnhghzXmYMG42t33BP8d52RbY4tXYA/9XxDsPAidi2
 3HbAV21Pt/h+tvx9d+Ll+mkVH+6ELBXfzPqy4yoqyaxo2FnSRGyhPG8nNT7HBNyi3ahkYMwC
 mOR8VCnKoDwn7y3K+dmYlVlCDqeo4JhF4dyn5FxzJAc1H4Gh4mEqH8OkGP9K9Jeiur1aHsAQ
 yJOwsaAulG/nhc5cTTQmsSiBRD/ioN7atK3Y30bwHc45sFOU+KP6aBc2DByuhy+pB7QZv50m
 nEcz+Ev4TgUmbJs2kJlwyODD7QVBUQdMzbrkkHCytmkr7hMIkurf6Kx0kVWgt2rSr2P6FI5O
 j6xatI5ECl8498qenfFyn7u8cfJfNfKbNQcngKZmVHMgqIGTfB53upPji1hN2XnuHQjwONul
 h1i06axu42fInls9qa0UVZIcyf4bMQJ9nTxnL5Ty4yIipu3EMwrSVBpFNP4COilGzUIubH7O
 haSRXci/2yDF+OXFF2a71p66W3CGdanOjmednwe0MknVBeaPlNWmgxSQzgw2JI0c2LijMWzd
 UBk+nUb4UP+oRYK1e9icRXyGm6NoQC1dnI/U5KCKBkQtwhE6x6TOsubi4A7VygK+5q8sEmGM
 WecfRwOVGgPVhXCDFfmdq+n4d2KmwSBLsy5KfaGIbCHqOgFEuyN2YrqyYx+uTCFKsSIOHBmS
 fw9wEtKG35jSYzfnH0URiobmjioDYbTrQqg+iBxssG08ej6EAPp64yVDrJOMNJpsxmoiKaHP
 uSUiW53MzFdnp8LwHbJzvAY0jtww2l2cCKxFL0bqSPXZKfXh7MREBMRLS9+dYNJ4686wghRK
 Jvbh9fyhdsaxrY+D1ZIU0Ckm9n8P5VQZTvnaxWeWQDQZ9HkbXXRzsr6YL2xU+hVheRQ7Firv
 CqDVlTkJnKFniXoUBamNadNijuaNVpQotLYEF4lBG79QdbhchD+PsVwiGh85LQuhW7Rc0MYP
 yJ9dUxlsbCaqy9VyKYaeSQJ/j9+IO+IljzMpfHfMYoTuOB3Dz5ckuVH/DIlxrET4CwOF5kX0
 GPC69VppV+hiOyGzDFqBQFPpjh8j4WOpUx+OK/d+/GovF7b8RhL4WjCU3ziSPN6B9ept60Ck
 7AndYr2Lypetc3Z940QCpqMQP8=
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:VO4kcqH7zEPN0XY5pLqEyseALOsnbusQ8zAXPjNKOH9om6uj5q
 eTdZUgpHvJYVMqM03I9uruBEDtewK/yXcX2+cs1NWZMDUO0VHAROxfBODZsljd8kPFltJ16Y
 clVbRiA9vtClVAgd/9+xTQKadZ/DDKysGVbfy19QYKceiGUdAY0+/zZzzwLnFL
X-Talos-CUID: =?us-ascii?q?9a23=3AAg0t4WiPerMLgqa9oTXlnHTS8zJuUSzkklzfGQi?=
 =?us-ascii?q?DFH8yapHEdk2V3po5jJ87?=
X-Talos-MUID: 9a23:YK2B3AXxBzaaF4fq/BOrpGpsbsla2qSNM10ptbwG5fnaEzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,142,1770591600"; 
   d="scan'208";a="142405663"
X-MGA-submission: =?us-ascii?q?MDGXJ5P/4ZB/dGhCAih7CvejLr27L5FDCafmH6?=
 =?us-ascii?q?c01iMWqdaaDmfeXWxy4SFxw1/OW1fU09Iz8GAdAYj6fBKflHClbzfYAJ?=
 =?us-ascii?q?ylneISNJD6tu8EVWWe4qqIl371XTSmA2R2cHnkEuN8aqZA9LPofBzI/L?=
 =?us-ascii?q?ANOfo6eis5fEI0KxzOaWt4cw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:05:13 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1viUPS3o8L-00a2kl for
 <cocci@inria.fr>; Thu, 26 Mar 2026 14:05:11 +0100
Message-ID: <b7609e78-4219-4b59-a19b-9249f401db44@web.de>
Date: Thu, 26 Mar 2026 14:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2s6xRui9ruKaxIFiiyk7mCWOJOr+BSDr5yuZHxUSefZKrSqonBO
 FgIKSFw4bXgFxC/EpB/wYYUNwwD3wNvcPi5u+wcUyajwy0/WedNzUmUmxwaxzXb2xU+JUuh
 rK3fNPaE+nZyYe+KxmWZ/WEzKp0k1j/DiHvouohrxz8K4SVJkTprHJFyxJBLB0V0WTW5JsG
 zPQK6vpEc74nYAH0b2gGQ==
UI-OutboundReport: notjunk:1;M01:P0:DuHrwa3Fcac=;EulCsP683TSMlEbQg+DqdxRrXpg
 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
Subject: [cocci] Restricting argument lists for function calls (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3457
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/LzMhnahL6847IIJmhduIoQ>

Hello!

Function calls are obviously documented in the way that they can get an ar=
gument list:
comma-separated list of expressions
https://cppreference.com/w/c/language/operator_other.html#Function_call

It seems that the metavariable type =E2=80=9Cexpression list=E2=80=9D can =
handle corresponding data.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/233b5ceb1d5a701fb270e=
bdf0a9bd6be0a6ce53b/docs/manual/cocci_syntax.tex#L242

Such a list should usually contain one argument at least.
It should occasionally be restricted further.
One of the involved expressions (often a pointer) would also be referenced
at a previous source code place.

It seems that an SmPL conjunction would become helpful for such an use cas=
e.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/233b5ceb1d5a701fb270e=
bdf0a9bd6be0a6ce53b/docs/manual/cocci_syntax.tex#L1050-1054

How can it be determined then that a selection of repeated expressions
would be passed here?

Regards,
Markus
