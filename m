Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5604C87FD3
	for <cocci@archiver.kernel.org>; Fri,  8 Aug 2025 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TIuw9ii0hidO6s9GSDhR1JP6zUPPLfiuF9+BOV4jEog=;
  b=hVMBIf+xmP5jI52T5Z466SJcm46ZVVJc+Q11RivOjcHfEPB9red3TyV3
   3UptUK0ZlTE2YNGhHGJTQ65SUvgCzY0e1iSZtQhJ54SMsQRCkQybd3xPf
   FZPnBP6tp2dw5Toiw9hNdkoajHuLhZc6IaNmK1CJpDQuNSAKzxNEDztFV
   Q=;
X-CSE-ConnectionGUID: RmyxgMy8SAqLBIgG3Ye8RQ==
X-CSE-MsgGUID: CDnOk9V3Se23Sk6XKI9epQ==
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
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234529309"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2025 11:02:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E9E7E0264; Fri,  8 Aug 2025 11:02:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 79A8DE0171
	for <cocci@sympa.inria.fr>; Fri,  8 Aug 2025 11:02:01 +0200 (CEST)
X-CSE-ConnectionGUID: FUWtQ+hSTKO7W0Gw49HLMQ==
X-CSE-MsgGUID: 3ICrM9nsRbeyflwcYTfmBw==
IronPort-SDR: 6895bd09_q31hRbGZovEp3t94Tjm/A/uEChmSXnq4kMjoRlre5ahY+/Q
 mCv/5mheurP2bRowQGKNwvIm0QaSdN20S0rpPyw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FuBQCtvJVogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQRUMwQLSYRVj1CCJIQ7hzyHU4h3gVWBfg8BAwENTgECBAEBA?=
 =?us-ascii?q?wSCDIJ0AowiAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOCjGFew2CRQEEAQEBAQEBAQMDAQEMAYEhgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEXAkdEAQEBAgEjHQEBESYBDwsaAiYCAlYGARQBAYJ+giIVA?=
 =?us-ascii?q?QMOJAe2W4EygQGCDAEBBtpeHywiV4FlCYEbLgGFbIJjAYYng0J6Jw+BVUSBP?=
 =?us-ascii?q?IMDPoRDg1uCaYImgRaDY5YcUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnf?=
 =?us-ascii?q?YMNgQ6EJytPgiJ1gXlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBh4GIhFAA?=
 =?us-ascii?q?gELbT03CQsbBj2TboI1yxU0B4I4gWaBZAyfZwYTL4NxAZNYDgaTApkDIqN1h?=
 =?us-ascii?q?SCBbw4lgVwzGiSDNk8DGQ+OIYQztkFBNTwCBwEKAQEDCYVGAQGMQQEB?=
IronPort-PHdr: A9a23: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
 xQMCQ==
IronPort-Data: A9a23:Tt0Sn6v8UUpfD6uyeYhBycZ2fefnVIlaMUV32f8akzHdYApBsoF/q
 tZmKWHSaf2LYWvweY8ja9i38U5V75PVm9UySQFqr3s1EHtHgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOhTrOCY2YpGFIMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8UwHUMja4mtC4wRuPa8T5TcyqlFMZH4hDfHpR5fHatIMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRvukqTHKN0hXZ/011lrfgpo
 Dl+ncDYpTMSA0H5sL91vy+0vM1JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwre7K4nG
 fEwcVgwgh6/a+2e7o+EVtAvhv8fD+60A9swpS0x7RX8NKNzKXzDa/2iCd5w2TAtmoZREPyYa
 8dxhThHNk2aJUcVZRFOVdRi9AurriGXnzlwjVuPprcspUXXwhZw1rfFL9ffPNCHLSlQthzD+
 j+crj+hWHn2MvTE6BGf1yOqndXFkDL1XJ0ZJYG289R11Qj7Kms7U0FGDQDr/pFVkHWWUNVUI
 E084TsrtaF09UqxT9C7UQfQiHqNoRcYX/JCEugw8gjLy6zO4g/fCHJsc9JaQNkhqdNwWjEgk
 FOE9z/0OdBxmJOodm6ktbevkRCVZhdNAnBeNA8gaDJQtrEPv7oPph7IS99iFou8gdv0BSz8z
 li2QM4W2Ox7YSkjiP3TwLzXvw9AsKQlWSYZy23qso+N6wRkeMi6aobu5VWzARd8wGSxHgnpU
 Jsswpb2AAUy4XelynblrAIlQujB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RCO5V4AvcILZiX3M8ebhr5d7ex6lcAM8vy6CZjpgiZmP8ErKmdrAQk1NBfBhD6FfLYEyPpna
 MbznTmQ4YYyUvg3lGHmGI/xIJcqwSY53ivISPjGI+ePgdKjiIquYe5dajOmN7hnhIvd+Vm92
 4gFa6OilU8BOMWgOXO/2dBIcjg3wY0TX8CeRzp/LL7belIO9aBII6O5/I7NjKQ/wfsMybuVo
 SDmMqKaoXKm7UD6xcyxQigLQNvSsVxX9BrX5AR9Ywj66Gtpeou18qYUer0+eLRtpqQpzud5Q
 7NBM4+MC+hGAGaPsTkMT4jPnKo7fjSShCWKI3WEZho7dMVeXADnwILvUTbu0ygsNRCJk/UCj
 Yeu7D6GfqpbdT9eVJ7XTNmN02KOuWMsnbMufknQffhWVkbe0KlrDC3T1c0IAtw+BijC4hC41
 A+mJwgSiseQgo0y8fjP3bulqaXwGcRAP0NqJUvpxpfoCjv/4UyY3p5mbOaEWRv/RVHE0vyuS
 ssNxs6tLcBdukhBtrRNNopCzIU81oPJnKBbxAE1J0f7RQ2nJZ04K0bXwPQVkLNGw4JYng6EW
 kiv3N1+EpfRMePHFG8hHiYUXt6h59o1xAaLte8UJX/k7hBZ5LCECEVeHyedgRxncYdaDtkX/
 vcDiuU3tSqElRsYAvSXhHt19kONDEA6fYcJi5U4OLLv2y0XkgxsQJqEESLnwoC9W/MVOGkQH
 zKkrq7jhbNd+0n8T0QOBUX9hepzubleuTRh7kMzGFCSq9+U2t41xEJw9Bo0fCR0zzJG8f55Y
 VYzE0t5IZSPojRav+lYfmWWAwoaLgaoyk/w7FoolWPiUEijUFLWHlA9Ieqg+EM48XpWWypyp
 pW07XnDain7Wv3x0g8Ze19Xm9a6QfNfrgT9yd2aReKbFJwEUB/Zq66JZ1tQjSD4AMk01Xb1l
 cMz8MleMaTEZDMt+YslAIyn1JMVehCOBEpGZdpDpKopP2XtSAue6Ai0CXKaW51yfqTR0EqCF
 cZRCNpFVE2+2AawvzkrP/MwDIEursE5xugpW+3NHnEHgYu9vzAykZP39wrCvkEJbehqs/4AL
 tL2S2rfPE2W3WBZik3cnvliY2CYW+QJVCf4/eKy8dgKKa49jfFRQRky/4aw7lqoM1pB3hOLv
 Qn8Sbfc4M58xK9NwYb9MKVxKD+lCNH0VejSzgGXtu5KTNLQMPXhsxEehUnnMj93Y5oQeYVTv
 pacvOHn2HjquO4NbFnYvJ2aBYxl2N6XXtcLAvnoLXJfozSOaPXs7zQH5Wq8D55Dy/FZ2eWKW
 Cq6b5GWWeMOetIA2kBQVTdSIywdB4vzcK3kgyG39NaIKxoF1D34PMGVzmDoYU5bZx03FcXHU
 CGsgMmX5/dcsIhoLz0HDas/A5ZHfXnSaZF/fNj17TSlHm2kh22ZgYTblD0i1CrqD0eVG8Or8
 LPHQRnDLC6Jgp/q9+0AkYJOvUwwNk1f0NkAJhdXv5Y8jj2hF2cJINgMKZhMWNkejiX204q+f
 z3XKncrDSLmRzlfbBHg+5LZUxyCAvAVcMLMTtDzE5h4tw/tbG9BPFdgysuky3JxZyel0+ytb
 90TkpE10t5d3bkxLdv/JNTi6Quk+h8e7m0F8wbxnqQexj4AVK4S2iUJ8BVlDET6/gKkqKkPD
 Xc4TyZITSlXjKI3/dlIIxZoJf3SgN8jI/jEo8tCLBYzdrh3FNF99cA=
IronPort-HdrOrdr: A9a23:80Braq68i+Q94x/PeAPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:xgFSTm1QplnGd3ZZsf2kkbxfNP0abkSezEzsAGjnNj5GV+HEaXu1wfYx
X-Talos-MUID: 9a23:YkNT+AucTrmSvlgIJ82n3xBJLuI55b+UAk0cn5EZsPi4OylaJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234529302"
X-MGA-submission: =?us-ascii?q?MDGuizrrcgHHJDPym13zaPbTVBvVSMf0EGiCYG?=
 =?us-ascii?q?TVdisXBGHAUZGSKe9TKAE2lqXz/QXOlKBVLz5tW8SNAX346l42ucdzBB?=
 =?us-ascii?q?KoxG/m/AUnGPkyLh4VWkdtm0XJ9T7wAaSC3RaVTWCSwhhhKQLRFdzT0p?=
 =?us-ascii?q?fH+9rOrTq45E4Cly2/EHXG3w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 11:02:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754643720; x=1755248520; i=markus.elfring@web.de;
	bh=TIuw9ii0hidO6s9GSDhR1JP6zUPPLfiuF9+BOV4jEog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bxLuxpIlcuDhczhZbwUoS2K6GmNbp1EDQgpPxs7Pf0ccblO2FoM337NCZ1OQlHs4
	 yeJVS+iqsvKUTPq1UTiKROo40KdvwxprYUdz9b3sH386klCYIZ4k5CISqbFXZeAe9
	 OQBrzHDUXwcIeu10KXP8AUIDzhRfjiyTUu+YWrWDIh5n3ya2jiADQ70LzS7IQwpA7
	 cCahCDhwgzgFKnqGitRYXzCYC6yCippOJFzVyrRs9SAfAx2cE+zLIP0PccVHNQbnw
	 gE1u+XOCNsgw63WWeITT3asgmniJ/ruUL0QVSlYHJhBv1qHGr4ElZ7mKwcjE9d1C7
	 CWFuuJhnhC53CV/Xkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62ua-1uZB680XlI-00uKOd; Fri, 08
 Aug 2025 11:02:00 +0200
Message-ID: <b2a110e2-f56c-4cc4-b45c-9e7c0da8a91d@web.de>
Date: Fri, 8 Aug 2025 11:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Michele Martone <michelemartone@users.sourceforge.net>
References: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de>
 <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr>
 <22cfa841-e385-4d02-be5e-ae7c88188d5d@web.de>
 <24c7cda-a3d9-a41d-aa3f-21b16bc975d0@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <24c7cda-a3d9-a41d-aa3f-21b16bc975d0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p8jTWuwlNqBsWsThcxKjS2gN9NTyHAwFSxlMBVh1zC3yKDdRDf+
 Ur/9Ruc/HmsrxOasoE5mMQn+Tzgex3fQe3SbF5an6gjdJ4qwnFxW5ZnsdMLoAT21kPa9Eg0
 zzIKjI64j49Y410XZ1iHUtTlsgzuUsp04IYmm6T8cYz136UckttNNJFaW4CNjHrt+5mxqcZ
 x1OkOOVOFJYt+f+2TF8Hw==
UI-OutboundReport: notjunk:1;M01:P0:sa0Y8gmcct0=;S8gSssrUw2GBtqMYMAywZMt3an+
 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
Subject: Re: [cocci] Searching for C++ delete expressions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2971
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/b2a110e2-f56c-4cc4-b45c-9e7c0da8a91d%40web.de>

>> Under which circumstances will the mentioned =E2=80=9Cwarning=E2=80=9D =
be reconsidered better?
>=20
> None.

I hope that additional development resources will influence software evolu=
tion
in more desirable directions.

Regards,
Markus
