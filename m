Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528BC369D9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qqZ3eksdOuceEzTrNwxJooS08M9fa/A7zgf3pPkJqqg=;
  b=mTVPS2Zvr20XDPXRIUSonRtq3h+lpkMM3PQ3BZfzL60LFwZP8ZUqO11h
   c3un6VOBGbDC1vFtmiay9MfW3y5lIkEIvmGQ4W84aY5r25xPgQyEzYDKT
   uJeSlxkhgeHTeFKAhnu++tkscAaza1R4YCJvnQIZYDYrKp8uNCOyBLcg5
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220212465"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 17:18:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CFA7BE0264; Wed, 30 Apr 2025 17:18:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 59818E007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 17:18:06 +0200 (CEST)
IronPort-SDR: 68123f2d_EGOm1/+I7OyhjYTUgynkvkM5IgHHFMF+smNC8tqNu7BnMPH
 7TdtNaaTnOHbUVgAoyDr07w3f2+o1SW3KdS0USA==
X-IPAS-Result: =?us-ascii?q?A0EYAADuPRJoeAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVozBAtIhFWIHIc0gXQwaYNSjw6IdoFVgX4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDBIIMgmoKAos0Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAFDDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJWBgEUAQGCfgGCLwEDDiMHDQayeoEygQGCDAEBBtpcH?=
 =?us-ascii?q?ywiV4FlAwaBGy4BhWyCYwGGJ4NCeicPgVVEgTyCUjE+gkoXBIElOYNbgmmCM?=
 =?us-ascii?q?YEWgUaLc4Uqiz1SexwDWSwBVRMXCwcFgSZDAyo0MSMPPAUuHYIRhSGCEYFcA?=
 =?us-ascii?q?wMiAYMTdByDRoEjhFAtT4MvggJOGkQjQAIBC209NwkLGwY9lj+EX0aCMaM+o?=
 =?us-ascii?q?nQ0B4I4gWaBZAyKKZU1BhMvg3ATk0MOBpJ9mH4igjaLLpsvgWc6gVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIYQAM7sRQTUCATkCBwEKAQEDCYVGAQGKSDSBSwEB?=
IronPort-PHdr: A9a23:nlfDBxDFP76pKDlFX3IIUyQUikkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua43ygeRFt+FtKodw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiTSjbb9oM
 Bm6sQrdutcXjIZgNqo91wbCr2dVdehR2W5nKlWfkgrm6Mu34JBt7Tlbteg7985HX6X6fqA4Q
 qJdAT87LW0759DluAfaQweX6XQSTmsZkhxTAwjY9x76RYv+sjH7tuVmxiaXO9D9QK0uVjSj6
 6drTwLoiDsCOjUk/mzbltB8gaRGqx+6uRdx35Dbb52UNPpmf6PSY9UaRXZaXs1MUyBNG56wY
 5cTA+YEO+tTsovzqEYUrRamBgeiCuzgxTFViHHow6A63eQvHgPa0wIvBN8OrG3Uoc/pOKsOT
 +y4zq/FxijDYfNM3jf97ZDFfBc7rvGWXrJwbNHRwlQgGQPBgFWQs43lPzWa1u8QtGWV6PBvV
 fisi246sAF9uDehxsMiionTh4IVzF/E+D53wYkrPtK0UlN0bsC9HZZWqiqVOJd4TNk4TGF0p
 CY11KcGuZijcSUIypkr2gLSZuCaf4SV4R/uVOmfLDVliHxqZL+ymgi+/Em8x+HhWMS4zUhHo
 CVYntXSuX4A1R/e5MeIRPdj/Eqs3yuE2Q7U6uFBO080lKzbJoY6zb43kZoTrUDDHi7wmEnsk
 KCWcUAk9+614OrkerXrvoGQO5Jqhg3kLKgihM6yDf4lPgUMRWSX5Pqw2KXn8ED2WrlHgOA6n
 rPbvZzGP8gWpqq0DglI2Ys97xa/Eiym0MgGknkdMVxFeROGgJbxNl3SJv3zEO2xjE62kDhxw
 vDLJr3hDYvJLnjEiLrheLF961NAyAYpw9FQ+YlbBqscL/3tQkPxtdrYAQElMwGs3errFctx2
 pkAVW6RAKKVKr7evF2S6u4yPeWAfIoVtyz8K/gh6f7ul3g5mVoFcKeux5QXcnO4Hul9I0mDb
 nTshtkBEX0Lvgo4Q+znk1ODXiBIaHqoQq0z+Ck3CIS9AojbXICinKSB3DunHp1Rfm1KFEiAE
 W30eIWcR/cMdCWSL9d9nTwDSbeuV44h2Aq1tA76zrpnNvDb9jcZtZLlzth15vfcmQs89TxuF
 8idyX2CT3lonmMUQD87xKR/rlZzy1iZ1ah4h+dVFN1S5/NMSQg6L4TTw/Z7C9D0QALBf82GR
 EyoQtW8UnkNSYcT3tsPag5ZEsqrihSLiyi3B74c0biCG5Uw9ord2WLwLoBz0SCCnKImhFIna
 spJL2yvwKBlpCbJAIuctkyDlLuxPYkY0jTM8mjLmU+HpkJFS0hdVavfXHYQTlTbp5L16xWRH
 PeVFb07P14Zmoa5IaxQZ4is1A0eLB+CENHXYmbq3ny1GQ7N3bSUKozjZ2Qa2izZTkkCiQEau
 3icZkAlHin0hWXYAXR1EE73JVv2+LxboWm4U1Ry4gWEdUxn2JKq9xRTifHPA+gL0Oc8sTw64
 y5xAE772tvXD9SaoA80WaxGYs4mpnpD23jYsQNVIZGqaaxv1RYFawoimUTo2l1sD5lY18gnq
 HR/1A1pNaeRy09MbRud2o3sfKLaIC/+8XhDcobw3VfTmJaT86YLs7Ejrkn7+RquDgwk+mlm1
 N9c1z2d4I/LBUwcS8C5VEF/7BV8q7zAB0t1r4rJyX1hN7W1uT7eypooAuUi0BOpY9ZYNuuNC
 gbzF8QQA8XmJvYtnhClaRcNPeYa86BRXYvuUvKc27Owestkkiini2tv/413lE6BtmJ9RuPOw
 5cZ0qSAxALUHzz4jVqnroX2gdUePGtURDDgj3G7QtcLNcgQNc4RBGyjItO63IB7jp/pADtD8
 UK7QkgBwImvcAaTaFr02UtR014WqDqpg3jdrXQ8njc3o66YxCGLzf7lcU9NH2dRR3R5y3roL
 5K1id8yQ0WiKQQk3kjAhw6y1+1AqaJzInOGC2JBZSvrNCdPVqWqt7yNS9FC4tUkvG8ENYb0K
 UDfQbn7rRwA1irlFGYL3zE3eQahvZDhlgB7gmaQRJpqhELQYto4hRLW5diHAOVUwiJDXy5gz
 z/eGlm7OdCtu9SSjZbK9O6kBSqtUZhacC+jyo3l1mPzwGRwAgCk2d23lMfmFwcSziLxkdVnH
 SnFtxfzZID32r/ya7s9OBMyWxmltIwjQMl3icMoiYsV2GQGi5nwnzJPimr1PdhBmOr/YHcLW
 T8X0ovQ6Qnh1ldkKyHBzIb4W3OBh8p5MoPjOCVMgH17tp8MUf3Hid4M1TF4qVe5sw/LNP10n
 zNGjOAr9GZfmOYR/gwk0iSaBLkWW0heJy3l0RqSvLXc5O1aYniidb+o2Q9wh9ekWfunqxtfR
 W2/V5MsBy524e1gPViK3HC5ueSGMJHAKMkesBGZiUKKquFPK48q0NcOizBmP23VonAvjeI2x
 08Lv9nyrM2MLGNj+7i8CxhTO2juZs8dzTrqiL5Xgsec2438VoUkADgAW4HkCO65CD9H/+qyL
 B6ASXdvzxXTUaqaBwKU711q6m7CA4z+fW/CP2EXlJ1rFhyaOVAZnw0eGjk31pdrEwe32Inxf
 kBj+TkL6hjnpxEKxu8NVVG3WzXaoxq0Lz0zVZ6UIVxJ4wsE60qdOJ6b6f9vWipD9IClr0rUI
 2qXPkJDCmRsOATMDgLmOaSyoNLb+O+CHqznJv3COPOFrukWQf6MwdjHPpJO2TGKO43PO3BjC
 6Z+wU9fRTViHNyfnTwTSisRniaLbsiBpR769Dcl5sa4uO/mXg7i/+7tQ/NbLMlv9haqgKyCK
 //YhSB3Lixd348NwnmAwaYW3VobgSVjPze3FrFIuSnIRaPW0qhZanxTIzt0L9dN5rkg0xNlP
 MnGlpXq27Q+gvN0Q1ZJWFr9m924MMwHJ2buUTGPTE2PNbmAOXjK25StOPn6E+cPyrwL8UTq6
 lP5Wwf5Mz+OlifkTUWqOOBI12SAOQBG/Zq6alBrAHTiS9Tvblu6NsV2hHs42+5R5DuCOGgCP
 Dx7a04IoKeX6HYSp/xlGHFaqFdhI/OFnSmx8OTSbJob+6gOYGw8h6dB7XI2xqEApjlDX+Bwk
 TDOo8RGpla7jq+QxzAhXBcE+VMpzMqb+E5lP6ve7JxJX33JqQkM4WunABMPv9J5C9frtsi4J
 fDQmai1JDoQqro8HOMZANXIbt2KOjwtPEixcNYxJBQIR3inODOH73E=
IronPort-Data: A9a23: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
 FXZjlyojK12pYAd3Cqgl7No9MklgQ7S
IronPort-HdrOrdr: A9a23:9YXpWaAVGZKVLo3lHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AvbS08GiyvoqIqFGsua27ITU6tDJuKmD77m6JKR+?=
 =?us-ascii?q?EKl02VI+NUAGdpK9Dqp87?=
X-Talos-MUID: 9a23:LmQOzQQxSdO0MWlVRXTVmGhdE9tG2p2DLx5VmL4ep+ipait/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="115589072"
X-MGA-submission: =?us-ascii?q?MDE1p7iX8ueB8v9lQwEVO80EtEsL8qMKN5MvXN?=
 =?us-ascii?q?diIPXN8ZZG4cUj/Bji8QMsHN643TAWrho1HFreuwIj7pHcrsdy503fnu?=
 =?us-ascii?q?QCrx30D/C2qOeoOo3lwORMGkHeElPNXui/AZUjqoGFF7MpiXY1nvVtEi?=
 =?us-ascii?q?ANfjhg6zpoDJJdESdFBmfd6A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 17:18:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746026284; x=1746631084; i=markus.elfring@web.de;
	bh=qqZ3eksdOuceEzTrNwxJooS08M9fa/A7zgf3pPkJqqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BgndVCkFucLKPi/G0+ZUOHSZiV8xXMcYf4M58fn6jCjsSzA4bI5kImymF2wgZ42H
	 xTZ87O/FJfAJwkyskf/a+k8+n96absGt7tK69gjgQ/P7cQrT2Osc3gZ+Y3SdnGFIp
	 4VQKEZWnht2Y2uqxEMy0h+KC9hcj6RvtwUHzkDj7dyXItZmIEzKMsUiWZrUPxWJxP
	 TjB7oSP/CK7752R8/eFhvIDlqOY7IgLnBOZo7L5OFZThpSUPIMH5Ooo3OL5Zfgok/
	 7ym6pCDKk8j1JNQap+pm0OeYwS/HlN952FKFfYJP7Gum/YfV1pkROx3zkSA1luk5y
	 ip769Ez3pF2BgEKUXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.59]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1vCNgg3dpB-015CuS; Wed, 30
 Apr 2025 17:18:03 +0200
Message-ID: <e769e004-5c91-452a-a791-5cd04c9af8f9@web.de>
Date: Wed, 30 Apr 2025 17:18:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Dan Carpenter <dan.carpenter@linaro.org>
References: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de>
 <101ac934-7955-4266-4691-d834aec286c@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <101ac934-7955-4266-4691-d834aec286c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:48F4gl+lFORiJbAbXZFqq5IgNeu0yuPlZs49J6rR6mzngPq3W12
 eaTehCH07EVZLN6rH1ZRObphXEp6AvInM6GngVK/mC6pKChwW6niz8KmNHIKq9jqpcKEsja
 TbA0so7eoDxAZRjeTVvTUIh9sna4hh80TP/25CsgkZXMrejqZDL/L0fBiEvsUpPrzhSC2Ml
 5rhDUFAacHPAl+rTt2I4A==
UI-OutboundReport: notjunk:1;M01:P0:SPhc7uADz/4=;1SAjQSYTNqfUy7KZfRyZIOZVTCQ
 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
 XNYaO7BckzlxIq8/wrgNMM=
Subject: Re: [cocci] How to delete selected redundant null pointer checks
 with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2733
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/e769e004-5c91-452a-a791-5cd04c9af8f9%40web.de>

> I think you want to see if such a thing exists, not ensure that it occur=
s
> on all paths.  You can say:

It seems that the Coocinelle software needs still an extension for =E2=80=
=9Citerators=E2=80=9D
according to special source code in the mentioned update candidate =E2=80=
=9Camdgpu_userq_validate_bos=E2=80=9D.
https://elixir.bootlin.com/linux/v6.15-rc4/source/include/drm/drm_exec.h#L=
95-L103

@deletion@
expression e;
identifier member, object, pointer;
iterator name drm_exec_until_all_locked;
@@
 pointer =3D &object.member;
 <+... when !=3D pointer =3D e
 (
-pointer &&
 ...
 )
 ...+>


A patch can be generated as expected then.

Regards,
Markus
