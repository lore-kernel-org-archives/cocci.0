Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A02C4828F
	for <cocci@archiver.kernel.org>; Fri,  9 Feb 2024 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W5ufYCqcC7avZ4RNfUDCaDrQiTFheodbKlTSq8r2mLs=;
  b=XUjixAq+MpRRzY9X1pEJhqa0AKljSPicm2ALyOAREVzBC5wAf0GQnuBY
   TVSyRMmjODsfJCsEfMr+35glT0CE3ExZKnojZ4AfBOY6j0Ky/fUfkWF3Q
   WRxmnquA09Uv6IUDVUSbtuToF4a982n3ZRpYVI8GIPIStYZ1yYPooKVbO
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="151116354"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Feb 2024 09:37:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0DDDE0CD9; Fri,  9 Feb 2024 09:37:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D1741E008A
	for <cocci@sympa.inria.fr>; Fri,  9 Feb 2024 09:37:03 +0100 (CET)
IronPort-SDR: 65c5e42f_YNp4yOD4mfBgiseEWiDnA8auuRN2OPXiwpOmZD7059ErnW7
 GHa6axP8H0bjs7/AQ9stEVU9fcXenzTPoxFMbSQ==
X-IPAS-Result: =?us-ascii?q?A0EqBACL4sVlh07ASNlaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FOROjCEO4c3h06IcIFWgUA+DwEDAQ1BAQIEAQEDBIR/AodXAh4HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJcA?=
 =?us-ascii?q?RCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBEScPCQIaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ8gisBAw4jB5oZnDSBMoEBggoBAQavWh8sIlaBYQmBGi6IJgGFb?=
 =?us-ascii?q?gmEMicPgVVEgTwLgkcxPoRDg1uCaIVUiQKPBFR/HQOBBQRaDRsQHjcREBMNA?=
 =?us-ascii?q?whuHQIxOgMFAwQyChIMCx8FVQNDBkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSS?=
 =?us-ascii?q?QIQFAM4AwMGAwoxMFVBDFADZB8yCTwLBAwaAhsbDScjAixAAxEQAhYDHRYEM?=
 =?us-ascii?q?hEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iCCYE+B?=
 =?us-ascii?q?BNEAxCBNIU+hA4DGSsdQAIBC209NQkLGwY9AqEBgwAexSc0B4I0gWCBYQyfO?=
 =?us-ascii?q?AYTL5cuDgaSXphXIKhXgWoDMIFcMxokgzZPAxkPjiAZH4N1j0dCNTsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 j3ni6/5bjtPoYq8FSo0As/JNISYPXBnPRe7QFbp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:smMu8KOnQKbXtcBcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:DFTr22P3r0S8Ye5DexFky2ESQMkefSPP3HTLM0CVKkdAR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ArXcwcwxJG2x/cmoI/ciq+eH2pwyaqL+LNUkiiI0?=
 =?us-ascii?q?/h9KVHCVeBQjCpg6HH7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="79182438"
X-MGA-submission: =?us-ascii?q?MDGJA6KQElfZhEkZCRpEFB/MS/BxtjMMTIWatb?=
 =?us-ascii?q?+TixsPIEbWNh3knPrlZplseya/RIIdN7Jbrd+g2hNXMyq6NO5FAySWNG?=
 =?us-ascii?q?rxshS6jvFJNSQ6RM3jpLk1xGi4eQ/G8ZahlKnLaJN09GZ8m0fH9h10RS?=
 =?us-ascii?q?7DKwvCIkK1zcIcHIG0gnKxdw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:37:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707467822; x=1708072622; i=markus.elfring@web.de;
	bh=QosKA3VvGNFuZvQml7Xw/Sh603BhBnnlhaIa4NVZjBY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=JCHfAgihDTl3Z0eL70NU3lxvxFlrgwYvSU6Asyt0OfN+4e61UhbWTGi3j1bx8vng
	 qRnkcopEitT57ChzYpXHwPOY/nGuUxIWvW936GfwgI/S/SKVSL6apRlbQeUIDs6ic
	 duaDWkCv1zpxNEAcrDJpguYPFSAb1zAM5BfEXwVI8fXTAkaceivpdWOK+rTsJhkP6
	 YDTovM2YbhEVy0GVrCLrJuI1m9kW0mXPKtzwe8Z63obiiXodY26ccRRuIBLib0pX4
	 OEbXvUkzM+rVToEBgcs5Ylwmm2fjLtk9wB9S7ZHs6AN23xNSCs8k/VcBdrvydnBU7
	 tpNPIusnDJyELWcx2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXRF-1rVFzN1xEt-00Yx70; Fri, 09
 Feb 2024 09:37:02 +0100
Message-ID: <256efa8b-64cc-4806-a780-facfa42fba11@web.de>
Date: Fri, 9 Feb 2024 09:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
 <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr>
 <1f8cb65b-715f-404c-84f7-8eee6de02352@web.de>
 <e2189114-2fa3-1045-1ae1-fb308b8c5c1f@inria.fr>
 <cffc1d24-5bb3-4a90-9593-31d3905449e4@web.de>
 <510575-bbc0-442-85a3-3c2fa510aba7@inria.fr>
 <55ea3e4-8ef8-b457-ea92-9d612ba9d943@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <55ea3e4-8ef8-b457-ea92-9d612ba9d943@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7sJpc1muwItiv3rVeMuZ9GDCANE4pgArseQUvHi6SWZIsFgJcQ/
 6vi+qphoHyhLrx/wG+zA8zN5as62lN+rQ1EWrKz5/lELoaxE0mVAaRlS4OMbLYy47mz4rO1
 ZQ6vnNHLOD6ywFmjfQ5VONtBOxMUBHT3Lyawg+0L8FTN+WRLiXc1XBb2jCi+bHVUbzA/Mtt
 /IbDrfHWobugBCX0bx1uQ==
UI-OutboundReport: notjunk:1;M01:P0:C+YHoXRfEYY=;jb9YxdBQ+RnPK/GRTnFv/8W9Uuz
 wMhVptyjs87hu+MrlDDehIqJX+3+FB/yhXl7o+UShmlWskL4n9vmJArc16q/Tn1OjDziKX1e2
 /aFmDenNZksq2ufA3/QV51xRw2aEaUQtgoXPpeNfUy6SUDBDxluhxeB+pZKQwppuebw/btD4m
 fPlMyXHccP1J32QdziJ7h0Y3qfykGWiZDnbo7agoKVQJgQKlG42uc0lHRPquPGLinpbsDdayH
 +Zbapbrqx2IQbhFqGY4+LWO1jV8F18+v1wZ+DxGhjjaUyVH1p3bmzfx3fLzh9itY6K/uc7j9t
 jgnpPT00XbZ7Xs4QuzH2odhoyIQ/nUuvx8S/6nBEa31f6HZYQ6ZLXgY4tPM1qVrPYdCZjfI5I
 0q/ECKejOKVSroxz2N2rbqDiec36ocA+7JrqXfWIIxyMMNjUSX8iiNwpRS4QwOa5f05bVQLsG
 kfpIstQlog4CSKbmhIHRkzlT4NmTBC0YWXFFlkf3KT+GtD8iPnUD04ArPU67SOxCeXyrHaE1g
 O9moYoq1A2jvyAHhQhPAcjmzZxkB7/RYwmYwWtcrgJ6Q/GycA0IuI9mVwAcE0oKfYOlRS0wxX
 om1yVsGgxol4DKAXfNbnBPCXICvikxXMNxbWb8/Xofkx5HW2nH5XxoDQ1yCVBStJy4xTHuMuL
 ymXhuHS5rvB6XmI+NxQppIXyyOgiVVti1FCwGPtRnQ9P3N9D+Sc68TdvHB1kZgbc+1RLNZqS/
 MuMAVvJzlwnYyG/f98uzBpq5BXVuJjC/8g0Hrp5VeZO6QXrs6yOC6qqsgfDcOafrQ543eTE5j
 z0RXWXDjOmxLiBZoQopgdJcM8TH5dD/9c8FAwlSj4WiQA=
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1527
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/256efa8b-64cc-4806-a780-facfa42fba11%40web.de>

>>> How will the handling of  =E2=80=9Cif =E2=80=A6 else =E2=80=A6=E2=80=
=9D constructs evolve further for SmPL code?
>
> You need to figure out how to put the two cases in the different branche=
s
> of a single disjunction.

Further development ideas can hopefully be clarified better also with the =
help
of the following SmPL script example.


@selection disable decl_init@
identifier var;
type t;
@@
(t * var;
 ... when !=3D var
-my_test
+test_case1
 (&var)
 ... when exists
 var
|
-t * var;
 ... when !=3D var
-my_test
+test_case2
 (
-&var
 )
)



May I expect that the same data processing result will be produced
if =E2=80=9Ca virtual item=E2=80=9D is replaced by another SmPL rule in th=
e following SmPL script variant?


virtual test_switch

@find@
position pos;
@@
 my_test@pos(...)

@adjustment1 depends on test_switch@
position find.pos;
@@
-my_test@pos
+test_case1

@adjustment2 depends on !test_switch@
position find.pos;
@@
-my_test@pos
+test_case2


Regards,
Markus
