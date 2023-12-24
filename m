Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA3C46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kqWqv28EuXFj17tS91/nmYJ0CoUR08K/ybLR6DQi93I=;
  b=r1T06FniWqmsWNKDPuoEp6vkSJSqn5hCf4f8DNbIvNvqzPKPAs6w8EU2
   Fc3w4xHu9nPb/ZVbFx0Tb/aVLuwGAiy3LmJQgJsoxwkGyY/wZTbueGsyq
   OtYuFfwGHiX73u1oP+rGG0mk+EcfxUNxheAbdviTvT12BRAVuVh8wDZ0i
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143934922"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:45:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57347E0CCE; Sun, 24 Dec 2023 17:45:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2C155E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:45:39 +0100 (CET)
IronPort-SDR: 65886032_MXOWhHWrYw1aYRY6sUttwluiQPyPbYdwWPWOzUxHXlpnGaH
 AEtMTq2v+gKoqFKNbAXjYOmO9170AMzUHyzk4FQ==
X-IPAS-Result: =?us-ascii?q?A0EzAACQX4hlew4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYkZLQOEO4c1h0yEa4QEgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIFTgnQChzYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEkGAYOBQsnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAkdCAwMjHQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQevMIEygQGCC?=
 =?us-ascii?q?gEBBoJmrHIfLCJWgWAJgRouAYgaAYVng0F6Jw+BVUSBPIEUgi2ECoQUgmiJH?=
 =?us-ascii?q?QcyghyDUJFafQVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCn4/D?=
 =?us-ascii?q?w4Rgj4iAgc2NhlIglgVDDQERnUQKgQUF4EObhsSHjcREAUSDQMIdB0CMjwDB?=
 =?us-ascii?q?QMEMwodCyEFVgNFBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKM?=
 =?us-ascii?q?QMwVUQMTwNpHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCE?=
 =?us-ascii?q?gwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLG?=
 =?us-ascii?q?wY+AqZDB1MoE0yCKpJykx2ecjQHgjSBYIFhDJ8rBhMvlyYOBpJULodQkE8gq?=
 =?us-ascii?q?EaBYzqBXDMaJIM2TwMZD44gDBYWg3OPCQE9QDU7AgcBCgEBAwmFRgEBgyY0g?=
 =?us-ascii?q?UYBAQ?=
IronPort-PHdr: A9a23:hjthOB3wS6/ZH/5usmDOVQ0yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaPo6831RSZDM3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNYAhEniSxba1vI
 Bm5rgjcstQdjJd/JKo21hbGrXxEdvhMy29vOVydgQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WSin4
 qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXHdNUtpNWyBEBI63c
 okBAPcbPetArIfzqVQBohWjCwesGu3i1DFIiX3q0qM1yOkhDRjG0RY8E94SrnjZrtP4P7oSX
 +Cvy6nIyC3OYfRM1jfn64jIbwshquyDU7J0f8rR00gvFwXKjl6NroHrOCma1v4Os2iG9OpsT
 +2hi2opqwFrozivwMgsh5LHh40L0V/I7zh2z5gsKNC+VUV0bsKqHoFKuCGGK4t5XNkiQ2dwt
 Ss0ybALvYK2cSwExponwxPSaf6KfpSH7B/+V+udPTl2iWxkdbyxhRu/70atx+PhWsSw3lhHo
 CtIn8fPu30TyRHe7NWMRPhl/kq5xzqDyh7f5vtaLUwql6fXMYMtz74qmpYOvknPBiv7lUrsg
 KKYa0ko4Oul5uT9brjippKRMZJ/hx/6MqQzgcy/Hfo3MhITUWia+OWzyqXu8VH/Tb5XlPM5i
 LPZv4rfJckDpq62HQtV0oE75ha6CDemzcgYkWMJLV1bYx2LlZXmNE/WLPD5C/ewnUisnS91y
 /zbILHtGIvBImbBnbv7YLpw61RQxBc8wNxH4pJbELABIPb9Wk/rs9zYCwc0PQuuzOb9C9V9y
 5geVXiADK+dPqPSq16I5uQgI+SXao4api3yJ+I46PHwlXM5n0QScrGz3ZQLcHC4AuhmI0KBb
 HbxmtsBC3sFvhIiTOz2j12PSSJcZ3GuUK0g5zE2E5mmDIfGRoC1mrONxia7HptMZmBHEF+AC
 3nod5/XE8sLPSaTJNJx1zsBXKCJVYAsz1etuRX8xr4hKfDbvmUctJT+xJ1+4+77ix4/73p3A
 t6b3mXLSHt72isLSiUw0aQ6o0V7y0uEy7NQnfNVD5pQ6ulPXwN8MoTTi6RTDdzjEjnBc8mCS
 FugQdLuVTg3Qsgw0pkVY0tjENWviBPE9y6rBaIF0b2NGJEwtKnb2i61b+15wmvK1bRppVQ0R
 MZGfTmtgqdi+wnOQYTEgUOUno62aLQb2mjB+XnViSKrvUpYWQN0GZnYR2kCa1fKoJyt41/fV
 aazBKg7PyNLwN+GK6FQZ5viilAQAL/ZP96WQ2+rgWa2Cl7c3LSGbKLpdn8b0SGbD1ILxURbx
 mqLLQgzAG+LpHPSRGh1H1X+b2vv/PN4pXf9SVU7mUXCU0B70PKW4B8OmfvUH/AJ36kYvw8ip
 i9yEVL72MjZXZ7Imw1nbe14YNUx701K0yqNqwt7L7SpM6dnh1ITNQ9wuhW9+Q9wD9BlmNIps
 Whi4Q58M6Oe3xsVUjqC3o3rfJDTJHPz+h+HdKPcnF3ThoXFspwT4eg1/g2w9DqiEVAvpjA+i
 4E9Oxq045zLCFFXSpftSgMs8AA8objGYy477oeS1Ht2MKDyvCWRk8kxCr4DzRCtN8xaLLvCD
 BX7RugTHcuzM6oHn1azbxQLFP9f/ug4MpDubOOIjZaiJ/0ohze6lSJC6YF53FiL8n9ZQ/TLw
 o1D7vWWxAqBWB/jgV3nvs2k0Ztca2Q0GWyygTPhGJYXZqB2etMTDnyyJsSs2thkr5vqRmIe6
 1OpQV8LsCOwUTyVaVG1nQhZ1EBM5GeihTP91Dts1TcgsquY2iXKheXkbhsOfGBRFiFkih/3L
 I64gsp/PgDgZhU1lBaj+UfxxrRK7KV5IW7JRE5Ufi/wZ2h8W6q0v7CGboZB8pQt+SlQVe29Z
 xidRNuf61M/2jngAnAY6TQ1bTCstb3mkhY8hG/cZHd/oXzFeN1hkA/F7Y+UTvpQ0zwaAShg3
 GOOXB7mZYbvpIjSzsuQ14L2H3isXZBSbyTxmIaJtS/goHZvHQX6hPer3NvuDQk91yb/kdhsT
 yTB6hjmMeyJn+y3N/xqek5wCRry8c1/T8tbm5EzmYpW9HwUnJST8lIYnG21PdgRisecJDIdA
 CUGxdLY+l2v/UR5LW+Sga/9WG+cxMRJeNSwJG8bkHFYjYgCGOKf67pKmjFwq1yzoFfKYPRzq
 TwazOMn9H8Qh+xhVBMF9iyGGfhSGEBZOXepjBGU95Wlq70RYm+zcL+23U44nNa7DbjErBsOE
 Hr+f54jG2d34KAdeBrp2Wfw95qiVd3ed9MVuTWLnh2Gg+UdJJ8ql/UMjDZqIiqn5CdjkbRky
 0Uzm8jm9IGcY31g5qe4HgJVOliXL4sI9zfhgLwf1sea0oazH4lwTzACXZ/mV/WtQ3oZsfXqM
 RrLESVp8C7BX+CFQknGtQE/8yGqcdjjLXycKXgHwM83QRCcIBcamwUIRHAhmYZ/EAm2xcvne
 UM/5zYL51e+pAEfr4AgfxT5TGrbox+lLzkuT53KZj9f9AJf/AH4NcKE7+R8Nz5V9NutoUbeT
 w7TLxQNFmwPVkGeUhrGN6Ot+MKG3uyWHOu4INPRbL/IpeEUBJLqjdq/l4Bh+TiLLMCGOHJvW
 uY61kR0Vnd8A83Fmj8LRn9fh2fXYsWcvhv55jxvo5X17qHwQAy2r9jqafMaIZB19huxm6vGK
 +OAmHMzN2NDzp1VjX7QlOpFhQRU0XsxMWD3T/JZ736KFv+1+OcfDgZHOXkqbo0Stf16h1QLY
 YmB15v0zuIq1KdvTQ0fChq4xYfxIpZVa2ClaAGdXRnNa+7AfGyRhZurMeTmGNgyxK1Vr0Hi6
 WzdShG+eG3exn+xEErxeeBU0HPBZUMY59v7KE4yTzCkFo2uawXnYoUu0ntpm/tt1ymMazJba
 2YZEQsFr6XMv3MCxKwhRiobtCsjdLLc0yeBs7uIcNBP76YtWH8s0bgAqGIzz78fhM1dbNpyn
 iaa7ttnolX91/KK1iIiSx1W7DBCmIOMu0xmf6Tf7JhJH3jerloL6i2LBhIGqsEAaJWnsr1My
 tXJiKP4KStTu9PS88wGAsHIKcWBeHM/OBvtETTQAUMLVzmufW3YgkVclrmV+Bj35tAirYPwn
 ZMVVrJBfFkyC+9cFUlvWtAPYd92Uj4ijb+HnZsI6H65/3yzDI1RupHKUO7XAO26cm/Dy+MeO
 F1RnPWhcdd2VMWzwUFpZ1hkkZ6fHkPRWYsIuSh9dkovp10L9nFiT2o10kajawW34XZVG+Tn+
 3x+wgZ4f+kp8y/hplktIV+f7g45ikosgpPIhT6LcTj+BLi9V8daBmCn0ip5eoO+WAtzYQCoy
 AZ8MyzYQrtKk7Z6XWVslROappZFX/JRB/4hAldY1bScYPMm1k5ZoyOsyBpc5OfLPpBlkRMjb
 Z+mq38oM+NLadkoOerPKaAPwlUC3spmWwe32+p3zAJMfy7lH0uNdSROtEFab9Eb
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YG3m3akXU/sq6q2BJtcSlJTnFuDpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:QHQL92FqYIGsI+P2qmI5zBNTG914XUHx83rgBRGHKjY0E4O8HAo=
X-Talos-MUID: 9a23:1hBeOQg4w4yWnzhSvMRgP8MpCMhKvYuoDk42yLoohOOGZT1TOmm9g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75293311"
X-MGA-submission: =?us-ascii?q?MDF5Jbu7mfzak1/gpxmlvNIE1e31brcBR2M0Ap?=
 =?us-ascii?q?GGE2gZ2G60dkTKyEWXa0tmFXypi6Ikb0Y+L910eX3z7fQfbfBWj1W3f4?=
 =?us-ascii?q?by1te2VPJQ2K9TtVgyAEXORQqL6IRaV0HiBCZm892xq+CkonglD5udKL?=
 =?us-ascii?q?l3k6y8iuhmcTgN5Fk2xGwhFg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:45:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436334; x=1704041134; i=markus.elfring@web.de;
	bh=rIlcz4hsgLr5IuoUvlYO4snd4l8Oh6JPILbZ0XdVhaI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=ocnEnBLv1ZdoxCh/A5KpMu1pjzoNNj7GkXqDoj73ViELx8GpIH00JTPPdOxHRa27
	 +95eSoF2bYAnIPbk1evHf9ZD+W8ZTBZdhQN8n6xp0ro4G9HAuTFz/7V6ie3d2mxyo
	 ZJFg43yYkDsBqwnb0YYmQT8bQ45JGW3OATujhKfIC2u0kzrEKsl9qoTH5K7KlDIZa
	 tmxjl6wOivtCyO2Btm0n3HX+TcfluDAj8+9bn5Km77MGVV23wBCKsiMA3oNLfx9+p
	 zSul9G2JGsKOFCqBPDtUAVRiYd5g2YRQQ0LITeu6/sKFrw+6JIeDMyWpAsOYk81AI
	 ToMaBdUk8CGlag0EUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrdM-1qxivW1sCG-00tHXK; Sun, 24
 Dec 2023 17:45:34 +0100
Message-ID: <769d269c-126f-477e-a046-d00dcf918829@web.de>
Date: Sun, 24 Dec 2023 17:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
In-Reply-To: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/6OmN1PZ8R/kwCXXkcrmaU8tPWjwWsHBwdPLlxjovbJAPktU2Lg
 YK8ClV7XYr/8oPrjOf8juijZcJWlPKrpZLrLgVGIUG8JmdMIv8OcWa1i0lUDrbHrgYHN2ye
 fmdARTQORywVsXaBLECgLCwL7rVaydK4b77WPoAxmQCvO90Rh6HBvaOmwtudqpsmgIr4ZnP
 tyG94hmLjq8B6otEpK0jg==
UI-OutboundReport: notjunk:1;M01:P0:7AZ2as5BfFY=;q63bFAXQH93kRNCwv0AIiisgcPQ
 WeMEgia6QumAjtMsd0rQoCRh/NNdFC7hgcjQHzO2VO/yH3kHCLhcflgvIbK90OjTD77H30uvj
 v8J8JIdDk2qT3lmGdTBh3rdMBurtS2TiC3VCoFjzbqjE5KQRWIS94/SeLMzkQUFFulrjMWmuc
 3zeZ/b7OyQTmaoQtpTF9zEAG1O24zJtLTxqA7zWw3vOYR9Gr6E68V7kAR/sefQywaqH34IwUP
 c9h9+TXgxKVepF3rSNX6OfYN71T/25YfMZPs4ApZ+8rqbRedzataiDRhDkI1rM3JKH4WfQTB/
 yPYQ9b+DgggVVZ51mhC7cUmuq7sXFiOJa9ASoKu6HhhP5GyA3tz4nqUkqKOk95GsZZOm2bcG4
 R76F9wxXeI/6VdUc687fhFhPH+MkSVJhZOmUcetSNfmKJSX1ByNCKMeoyux1lsC4AD1JcsjrY
 hA6gyYUQoUX63+vPqqgHIYbzZiEku0PDWdhH7wtOuzgohuHzOSUdqHtIlVdmiZ0uY2DxxmuuJ
 v2CXnvEDXwb++vrwchB1AJ+GIPbW3oV6UN0dleVviQq/kPm95LEtLB/6jkSDctrNJWwDVrmEZ
 d3c0Varl0cuSEzXG+sJESY/7rptoL+kFRavnHteBKqugc6qKHrVFCqQ8KtPeFPUmhgv5ehkzd
 jn+qvC89l0dVr61wXSR8POyIPzFt0v+PILMyLlOWtuItOn4a9CvKEmbO5e632y06CApGrY+gg
 pDKQTc2pfGoiLq1FqYAHXyeuO7jpOZs/uh+aZqV5U3pNxkGU1iYvZERV3WLf1PPwZCovmpO8c
 GhKT3qtTv20qEcLVBbhuXi19IVoHfHbDkhD0oSdhL1Eii6Sn6ofexmrASJ5kWemqQFj8NFusy
 r5cpMLaKOONESWby/VGzkVrw7G/DFVPXRYGgL3sSH+YBdH3g+6rCEb3m7v6elra7Tzcf5DoAa
 8//mPA==
Subject: [cocci] [PATCH 06/10] clk: ti: Return directly after a failed
 kzalloc() in of_mux_clk_setup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1374
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/769d269c-126f-477e-a046-d00dcf918829%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 14:20:18 +0100

The kfree() function was called in one case by
the of_mux_clk_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 1ebafa386be6..ab1205fa40d6 100644
=2D-- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -182,7 +182,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	}
 	parent_names =3D kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
 	if (!parent_names)
-		goto cleanup;
+		return;

 	of_clk_parent_fill(node, parent_names, num_parents);

=2D-
2.43.0

