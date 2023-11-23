Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7762BC61DF7
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xeTIRVciOtcGoCxQl72lfueEaHCUCSHxgcRYOF+Du2o=;
  b=iGU339zj+WXDAJB4iOnd6yOjWMOU+nphltonFQnKgVSkEFIPxsVcIfRt
   Ji1sA+VDt+SPFsI17tzkWdPnTCVdN7kiscIW2gabXpgnvgoJV0Uw2lBGp
   2o+kYfz8Y1F8JN1iECHvsWKH2ZWISuUqodKXdsMsqP4J3eICjsLTQf6J0
   c=;
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
X-IronPort-AV: E=Sophos;i="6.04,221,1695679200"; 
   d="scan'208";a="138134962"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 15:06:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4424CE0CCE; Thu, 23 Nov 2023 15:06:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D5E7E004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 15:06:01 +0100 (CET)
IronPort-SDR: 655f5c48_cSAzJ9Mw3MBQ1U99cPi5ckEFHpkBb8z6w+FLoJ3Rgzc5OkZ
 uOGSa2769lsKR+sFzNl+ruANp9D0kQobXKauXDw==
X-IPAS-Result: =?us-ascii?q?A0FPBQA5W19l/07ASNlaHgEBCxIMQIFEC4I5B3NWMAQLS?=
 =?us-ascii?q?AiES5EyMIQ7jn6Ib4FWgUA+DwEDAQ09BAECBAEBAwMBhH8ChykCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CXAEQgQyBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdCA?=
 =?us-ascii?q?QQBIx0BAREnDwsaAiYCAlcGARQBAYJ8AYIpAQMOIwcNBrBMgTKBAYIJAQEGg?=
 =?us-ascii?q?VdBTqxvHywiVoFfAwaBGi6IDQGFWYQ1Jw+BVUSBPIJSMT6CYQEDgV6DW4Joi?=
 =?us-ascii?q?ScHhiWOfV0iBUJwGwMHA38PKwcELRsHBgkUGBUjBlEEKCEJExI+BIFggVEKf?=
 =?us-ascii?q?z8PDhGCPys2NhlIglsVDDRKdhAqBBQXgRIEahsSHjcREhcNAwh0HQIRIzwDB?=
 =?us-ascii?q?QMEMwoSDQshBVYDQgZJCwMCGgUDAwSBNgUNHgIQGgYMJwMDEk0CEBQDOwMDB?=
 =?us-ascii?q?gMLMQMwVUQMTwNuHzYJPA8MHwIbHg0nJQIyQgMRBRICFgMkFgQ4EQkLKwMvB?=
 =?us-ascii?q?jgCEw4GBgkdBA4DGSsdQAIBC209NQkLGwY+AiefXYQXMFmBWsVMNAeCMYFfg?=
 =?us-ascii?q?WAMihaVDQYTL5ciDgaST5hAII1Hmm2BYz2BWTMaJIM2TwMZD44ghCuBC448Q?=
 =?us-ascii?q?DUCCTACBwEKAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:y8cPJ6uhdsJB74bk5C9yhgAzzOfnVCtbMUV32f8akzHdYApBsoF/q
 tZmKWmCbPeNMGOkLtpwPdy19E0Eu5DXzYUwTlBv+3tgRiwRgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRMt8pvlDs15K6p4WpC5QRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJHkKMZEWwtdGPXkN5
 NtbEzoDU0ifmsvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaHOOVv5kBjW122ZAm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PFnujOPnVAtuFTrGNX+cMSjeORfp3y/v
 Uj6/kjyI01dZfXKnFJp9Vrp3IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTif2wlUe6X/pNK
 kke4CNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9pfpD8+iLjBsZlZ8hBYO7afanBR7i
 AHbrMCjHjF1rryeRFSU87re/3v4OjEYISVGLWUIRBcMqYur6owirAP9fvA6Go6Mj/rxBW7Rx
 RKOp3MAnLk9t5MA+Ji62lHluAiSgKb1YDQ73DiKYVL93DhFPNakQ6eK9Wnk6e1xKdfFb1uZ4
 1kBtcuszMEPKpCvzx6yYfg/M4yow92nMzTsp0FlMLd81jaq+l+lJZtx5hMnLmhXE880Qx3bS
 26NhhF0+7loI2qMUa97R6mTGvYa5/HsOvq9X8+Fc+cURIZ6cTG22R1HZGmS7jjLq1ctm6RuA
 qWrW5+gIlhCAJs20QfsYfkW1IIq4SUMxWnzY5Tf5Db/2Jq8YE+lc5s0AGGsXMsYspzd+B709
 uxBPfSk0x9cCe3yQhfG+L4pcGwlEyIJOoDUmed2KMi4PQtUKEMwAaTwwJQgWbBfsYZ7q+Pqx
 ky5C2hkkAfRpHufMgibSGFRWJW2V7ZFkH8LFygNP1Gp5nsdXbiS/JovL5saQL1229FgnNhVT
 uYEcfquGv5gaCrK0BVDYIjfrL5NTgWKhwWPM3CbYRw6RZpBRhPIyPDgbADA5CkDNQvplMoc8
 pmL9BLXfooHfCtmVP3pUfOIy0ijmFQgg8dwYhf4GcZSc0DS74RaESz9ofspKcUqKx+Y5D+l+
 yuJIBUf/8/hnpQU9YTXuKW6sIuZKetyMU5EFW3977ztFy37/HKm8LBQQtSzYjHRe2PlypqMP
 dwP4anHD8QGu1JWv65XMbVhl/s+7uSygY5q9F1vGXGTYmm7Dr9lHGK94vBOka9w3Z5chxq9X
 xOe29tdOIjRAvjfLnwqGFMHYNiAhNYuoRuDydQuIU7/2j17w6rfb2VWICu3qXJ8KJlbDdob5
 NkP6e8s1hyHqxs1M9y5oDhe2EaSI1chDag2lJEoL7X6qwgsy1t9MMXQIXKt0q6ududjD0gOC
 R2XjZrkmL5z6BfjcX0yNH6Vxstbp80Ely5rxW84BWaiu4T6lNoo+hxO4xEbcx9wzCgb49lsO
 2NuCVJ5FZ+O8xhsmsJHeWKmQCNFOzG05W3zzAEvuFDCbkz1SFHIEnIxCdyN8G8d7WhYWDpRp
 5Oc6WT9VAfVbNPD5TQzVWFlus7cY4RIrCOao/+eHuOBA5UeShjmiPX3ZWM39j3WMfloj0jD/
 eRX7OJ8bJPgDhEpooo5NpK70IoBQxXVNU1ARvBcpJkyJ1/+Qw3r+zayKBGWQPhvdsz6qRryT
 4QkI89UTB2x2Rqftj1RV+ZGP7Zwm+Vv/9YYPK/iIWkdqbaEsz51q9Tq+zPjgHMwCcBb+Srnx
 lg9qxrZeoBRuZdVp4MJhMxDJ3b+ftQOIgHxtAxwHCPlCLpb2NyAs2lruld3g5lRGBRq9VSYs
 WsvoofImvd6x90Ec5TES81+6sbdFT83fPuF+ka/vryiqD8J3djm72sol7UsA+ia0Xb9lTi6e
 XRhfeMbBH/4gYs=
IronPort-HdrOrdr: A9a23:uKdxkKE1RHkJ6aGKpLqENseALOsnbusQ8zAXPjNKOHhom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtexPhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0QEJSWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:lkLF9WGhKFe28tX6qmJfyEIIFPgUQ0HFj2b3YHSyB1sxVKC8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Afv+fQw6C31S1tzM4P6rdWEpxxoxnyK62IX0sm6w?=
 =?us-ascii?q?8nNKuCS1cMBbBy2WeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,221,1695679200"; 
   d="scan'208";a="138134944"
X-MGA-submission: =?us-ascii?q?MDERcq3F7HCCnvmFl5WrKHU8BDK+BjlGWgb2lY?=
 =?us-ascii?q?W4GpMJvEENrYGlKg3j1ZN1h3ynfNa42oqg+Mn9Cis9Qm7gQA2WIg51Y4?=
 =?us-ascii?q?AErtH003fznNDcQUeIZ0qqyN13ixDhZC9u7UC0HVwXLVEGLPm8+lZC7r?=
 =?us-ascii?q?VsMrtCWa5fL7iTKONS4cqzwA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 15:06:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700748351; x=1701353151; i=markus.elfring@web.de;
	bh=xeTIRVciOtcGoCxQl72lfueEaHCUCSHxgcRYOF+Du2o=;
	h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
	b=u34rzU4i6YzKUSy8/XYtkmUPoJGTRsYe2neppEJXEWCQkH9e79XEbY6tZjIgu7Fy
	 KbFWHainbxL4Bum92zNg4wsmnfncP5psZkiO2Uct/uOYmXDR+zKzq/qw+2xuzofC2
	 QbajmSkF8xp2KRmde0xKL2KrpE6yWVJJnUoBQ0JZA9bJ6wGQxqD3Nh8hM+/+ag4BD
	 w5YU6tziqvSlaHZuDcV2SL5wf7fq37LbF6JJN5OoWXcOQqZl3ZPAFZXZ1+PveWYAn
	 g2QK4/xG2iOJJk8mceaaZrX+lc6q2FkhsVZUR6oEdtfW2Y3LKgFr86Mqk3XkehPVm
	 f0CJeDu9oRC5uTvW2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9IOj-1qzp4j3aEx-006LEL; Thu, 23
 Nov 2023 15:05:50 +0100
Message-ID: <fabb554b-d109-4a77-96c1-a96f31d107d1@web.de>
Date: Thu, 23 Nov 2023 15:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
Content-Language: en-GB
In-Reply-To: <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:puQPogbl6gQpqQm2PrwB1aJO1BK1XbN3YN3YI8tzLh0ftRs+SCF
 TYcFiZiymyoFCCev8t9Jb+IgHx32NumOdG47tviUJrahBlsrwI4nFbDwhE2ymxMwY7Hn/ID
 moZ/ZiAoBslnb0hzc6qmsKXVFUrHemuE/83GoWdd+UjevOjbudd/G8DiRShLNgqmQhW6U7h
 vvZzhnbubEv0pLa3OceLQ==
UI-OutboundReport: notjunk:1;M01:P0:qR2aih7uy40=;czF1LC3J1hvzxwdg/Uj5RFvXp7W
 Na98bwAEIt6hatK2rutPs8KHE64twIVnj3DU53zrMXwPQZcEgIdnD9TMKBGY4AY4y8PRfUGH3
 JUNpJkp8cbbqp1bajKn+/UGJUIM1EwP0NPzXll2D1CySilc7juKt0UgBs16oFIq1ZUv3e/sDQ
 hga0+djMAQjxENrB2KgYNMeNHryLvUi7NkW9awd553YQoS8OvRoGy2Vepo4z4oS1ahBaPfBT2
 dqZ0JiumRiL+cBVf8DQygizF61mhN0N1/G+mifKQVHhQkkC2WSgaQOjDtI3Jc5DjL0Z+VoGRa
 ch1Vmstr7/iutL2Sxaa2HrHAlRtWKvf43l9o+C8zQCTMKzSzhWkYm3dn1pKanJEqovT0vaTr2
 jT9W4kiO19tm0xszKj1Hp02UzmWGhxr/TRlvh3UDbrTJAPmz1oJyVst79Yflu2DVR13cKedw2
 7myXW65Wtm48f3TzLQYu7cdPLAEEm11dElO6lyNb4L04NxLWmDPDgRVQDQS9sDoTCwhqVkbwV
 np8UWTEtgZ01/uOdbw/YrJZRlxvEEouxzgbj3aKFGa9056uS/v43uEieu4ThEHd9m6yQiDgob
 ZZzX9zyabZnEYXkm9BwCFJNG+xs5idSG64RpU13WWqn+qvPcL80QOXq6MTmEBRfP8y0qMsqkX
 UGUebxLsuDkb+rL1ZWNXAP30Xw7rZu5DkEfONdEf/LvRWWYA7rCuJFWOVBu3odjXv+hOYM44A
 6Va2ebBe399Z2HWMKgA3FzZneT2UCzdlSJQHB2GuskKlXE3nZCc0dcJUkFF6z/G0dVBihz7SB
 1yWmUp9h0N8uZcxks+WvBnutNd/WXdXC6SbHbQGujXzLiZMaR8pMaL32N7L6uf+1r6DiS6tHB
 lK2ZgCZdg8mY5wBx6ozYuGgvmJwY/B8AxKKITE2n16xdDsIo8IKZpBwn7B/xGJp6HhuX19VA9
 +Rg7Tg==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1315
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/fabb554b-d109-4a77-96c1-a96f31d107d1%40web.de>

>> How do you think about to count involved if statements?
>
> You can put a position variable on a matched if (if@p) and then use pyth=
on
> code to add the length of p to some variable.

There are programming interfaces supported to some degree.
Scripting code can be used to construct customised metavariables
which can be applied in subsequent SmPL rules.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c2=
1b60d41938d32321b1a/docs/manual/cocci_syntax.tex#L655

A position variable needs probably be applied to mark a source code place
as unique for desirable adjustments.
A function like =E2=80=9Cmake_position=E2=80=9D is available for such a pu=
rpose.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c2=
1b60d41938d32321b1a/docs/Coccilib.3cocci#L226

How do you think about to provide a function variant which can copy releva=
nt data
from a previous position object directly?

Regards,
Markus
