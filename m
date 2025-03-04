Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFAFC282D2
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Hd9f8ED3HYtNlKnYfy25W10wkR5BfmeLn5PDLRGCvhI=;
  b=gWm0s2OxflvuAtBI3ZTs2cM5Q7gLmcmqrpSwLTJROnBU4Ma78fTdxV6J
   nvET9QJKBZm7tvkSbBBtE7/r0TxTpP5TNSWuTcm96Old7swKFFh9Wh2Au
   fksHkJBnU2OtUlZf5cLNdQZLAwxMpKrhgG5QgC97u1jxLkD2M8JTVewoQ
   s=;
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
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="211191142"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 18:39:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0294DE0264; Tue,  4 Mar 2025 18:39:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1184DE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 18:39:03 +0100 (CET)
IronPort-SDR: 67c73ab6_b68aDXxVv3HcmutK8aItfdCMcUYMj/w/+3mVXF/H9cN1x6A
 rZmyj7AjJC0LxqoLReRuVAMxi+2+B8uH1JH9eTg==
X-IPAS-Result: =?us-ascii?q?A0E3AACQOcdng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuMQoVcgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFUgnQCixYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDIwQZA?=
 =?us-ascii?q?QERJgEPHwEFAiYCAlYGARICAQGCfoIwAQMxB69wfzOBAYIMAQEG2lwfLCJXg?=
 =?us-ascii?q?WUJgRouAYVrgmMBhWuDfXonD4FVRIE8gRSCLYgegmmCM4Fqgz2BbIpTHC2CJ?=
 =?us-ascii?q?ZkwgU0cA1ksAVUTFwsHBYE5OAMqNDEWHBZ+QzeCRWlJOgINAjWCHiRYgitqB?=
 =?us-ascii?q?AWDW4Q9hECCQVGCQoIRcYEXgjGFUIEthHAdQAIBC209NwYDCxsGPaF0OoNOb?=
 =?us-ascii?q?AYBAVI7AUsmggSTHbJ1NAeCOIFmgWMMn14GEy+XRQ4Gkn0uh2WQaiKpD4FnO?=
 =?us-ascii?q?oFcMxokT4JnTwMZD44hGYQUyChCNTwCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ZaxB56u/rG3VIJbamT0+LzQzC+fnVGFaMUV32f8akzHdYApBsoF/q
 tZmKTuDbvuJZ2TzfIt2b9u+9RhQ6JWEy9YxGwE/rig0QioWgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNt8pvlDs15K6v4GhA4gRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJHs1JK81ov5KOlNf9
 a0GIioOcEyDvdvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaHOOVv5kBjW122ZAm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PNvvTWMl1AruFTrGIHfVfGSHtdlp0KRt
 kTvwkDLIR47HfXKnFJp9Vr32r+XxnOkMG4IL5Wz8fVhgXWI12kLAVsXU0G6qL+3kCaDt8l3L
 ksJ5mwxoKJ0+EHDosTBswOQmn2dnDNEQ+drIfw6uR+H0KnKvwajPz1RJtJeU+AOuMgzTD0s8
 1aGmdL1GDBi2IF5r1rCrt94ShvtY0AowX8+WMMScecSy/XOyLzfYzrKSct/VrG4hJv5FFkcI
 gxmTgBv3d3/buZRj81XGGwrZRry/PAlqSZrvW3qspqNtF8RWWJcT9XABaLnxfhBNp2FaVKKo
 WIJncOThMhXUs3UzHbTH7tURu7wjxpgDNE6qQEwd3XG32v9k0NPgagOvWsuTKuUGp1VIG6yP
 ic/RysKtMIIbRNGkpObk6rqV5Rylvi/fTgUfvHTaN1VKoN8HDJrDwk+DXN8K1vFyRB2+YlmY
 cnzWZ/1UR4yV/89pBLoHLh17FPe7ntnrY8lbcuil0z/uVdfDVbJIYo43KymNLBjsfPY/1iPr
 r6y9aKikn1ibQE3WQGPmaZ7ELzABSFT6Une+pwNJN2QaBFrAn8gAPL3yLYsMd4t1adMm+uCu
 jn3VkZEwRCtzTfKOCebWEBFMbnPZJdYqW5kHCoOOV3z5WMvT7zy54gidrw2X4Idyspd8dBOQ
 cIoQf6wWsZ0dmyf+hA2T4XMk4h5RRH62SOMJ3WEZRY8Tb5BRivI2ITWQSryxgYzDw6cl8g3k
 5u/3Cz1HLsBQAVDCp7NSfSNllmeg1kUqNhQbWDpfOZBSR7Jy5d4DgDMldo1Hp08EgrCzT6ky
 AqmOxcUiu3TqYsT8tOSp6S7g6q2Mul5RGx2InL66OuoCCzk4WaT+49Mf+KWdzT7Vmmv2qGDZ
 /1Q/s7sIs88g1dGnIptIYlFlZtkyYPUmIZb6QB4EFHgTVehUOpgK0bb+/h/jPRGw7sBtDamX
 k6KxMJhBoyIH8HYC38UGhsua7WS9PMTmwSK188PHmfB2HZV8oaEAGJoBDvdrAxGLbBwDpEp/
 vd5hu4S9D6Eq0QLNvSos3lq0lqif106brUfl5AFAYXUpBIh5XNcbLf9VCLnwpG9RO9dE0stI
 zWr1fPOrOkH9HXjbkgcKHnp9shejKQopxpl4gIjJVOIu9ydnd4x/kRb3goWRzRv7Cds8rxMK
 E10EUxqf4Oc0ixNluEae0yNQiZvXAa4/G71wHs3zFzpdVGiDDHxHTdsKNSz81A82EMCWDpip
 ZWz6nvvCBTud+HPhhoCY1Zv8aHffIYg5z/5uZ6VGuqeFMMHehvjuKilYFQIpzbBAc8cgE7mp
 /FgzN1vaJ/UZDIhnKkmN7a0jbggagiIBGhnc8FT+KkkGWL9ejbr/ROsL0u3WN1GJt2U0EueJ
 vFtGPlyVEWF5H7TlgwYOK8CGK8rvfgL4NFZRKjnC1RbuJSirx1okqnqyA7AuEERTe9TzPkNc
 rHqS2raE0i7p2dlpGvWncwVZku6eYYlYSP/7sCU8cIINckxj8BxQ24P05+fnXacAC149T264
 SLBYK73ybR56IJOxoHDLIRKNz+WG/jSCtuawVuWiMtcSP/yKuLMil8lkUbmNAFoIrchYdR7u
 rCTutrR3kmenrIJf03GupuGTY9l2N6TWbdJD8fJM3VqpyuOd8vy6R8l+WrjC5hokstY1/a3V
 TmDd8q8Wt4EaehznEQPRXBlLC8cLKDrYoPLhyC39a2MAydA9z33Foqs8HuxYFxLciMNBYbFN
 Tb1nPST/fFdkpVHAU4VJvNhAqIgGmTZZ4kdS4TTuwWbX06SuXHTiou6wFBkoXvOB2KfGcn33
 YPdS1KsPF6usaXP15dCv5Y0ohQTC21njPItel4GveR7kC2+EHVMONF13U/q0X2IuneaOFDEi
 DDxgK8KDCLgQXJbfB+67NmLssJzwAAREo+RG9Dr1xr8h+SK6EeoH7ZrsCtti5uzUiW21/mpc
 Lny5VWpViVcAfhVqSI7+fGxx+tqrh8fKrTk5mil+/HP790i7XnmGZCv8MehlcAKLi0VqHj2G
 A==
IronPort-HdrOrdr: A9a23:G3xRlqEci5kwK+lxpLqEx8eALOsnbusQ8zAXPiFKKSC9F/b0qy
 nAppUmPGDP+U0ssR0b6La90dC7MBThHMdOkOws1NSZLWrbUQmTQr2KtrGSuwEIcheWnoJgPM
 FbAspD4bXLZmSS5vyKhDVQfexO/DDWysqVrPabx3xwVw0va6wI1XYBNjqm
X-Talos-CUID: 9a23:NskJFGC6qzTIYNj6ExNk7Ww5QtgYSU/MzCbOKVW7FzppcoTAHA==
X-Talos-MUID: 9a23:vC3TKQosOctWLwNjdHcez2poG+pwuLaeMUQEgbMvhu22FiNREh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="110657342"
X-MGA-submission: =?us-ascii?q?MDHDNC9yePtXZ5OcQ/PDQ78sYtUFHBKRsbyWW0?=
 =?us-ascii?q?dAhU6lTWNA6gNFQul9goCKkINfJYoxkJJAnd63xp1oapVWFiAsMO16Sx?=
 =?us-ascii?q?4oxHHDSzZhRbZ1iR2gTtrEbRk7uYOFXuNUgRTUA6h2Z3uznbpU6SEjRk?=
 =?us-ascii?q?8RDAV62VmLdK30Yrnicl7CMQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:39:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741109922; x=1741714722; i=markus.elfring@web.de;
	bh=Hd9f8ED3HYtNlKnYfy25W10wkR5BfmeLn5PDLRGCvhI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XOx6Yb7+IjmoN5q4fcTKsJB+3gujW96dnAJ5aO8w/VuhhfToF6Yyj3OAjexSOV1z
	 /1Y56MEQqGhbvmO6qGspVIHmG/N+bKTKCu6/uSunZGZSosyU18KCKt8nRNM8rjmBd
	 NEr6FAOCB/ZUHA/StjNB8ZJbsHKGWDmvuJkzeSec/Binljzwqg9DBeEOV/UYygfQ7
	 G/hYlJM4ALSxq+FZxR4IMvGYYgWHRTZTDjXisYlL+Mmx29JxLjJ3EWR22GlWe2124
	 ekn5/GeOG8nIyLyzjJTzJfBXFbaZhdkiUA4RF0EKl27yyjd82g6ixf6y2mckMuzMU
	 IYvzksEVziE/kjlPCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3oz4-1t7h213Slc-00tCqt; Tue, 04
 Mar 2025 18:38:41 +0100
Message-ID: <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
Date: Tue, 4 Mar 2025 18:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomas Winkler <tomas.winkler@intel.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J8W2iKNW1YOzbAMnhs59UwrQGwR1Hh6yGO7inTnU14zkOAupzCK
 d9+IIn2FAt4eO1oHC3z0rvCCtO76XilZNUr1lBfotSduoQwvEqx38iZzNgjRdkkhSCCTMxv
 /iCGdqvvWQaq/fp7ERjtHjiJxLxvtaIvmJyGO2Dw3iOMpzV5Vfi+jtTOFfzzhzJYbb1d6gs
 B8iVPlkbih15zmTVSCN3g==
UI-OutboundReport: notjunk:1;M01:P0:9YBNIMP3MJY=;n42+oDqLo6wQnlInoPCWZ53JWo5
 vPe0g1v1iPVJVBX3lQZCBBo4GdaNfkkvbyNuW7p4HKVKEHhtsg5uUwbyt/Q34o1KYLvAOM1H9
 Qs0XMuEYA2IOs92Ki8qAi6MaYVo1RZpyoZ2MGNLZex+fFPatCaCne8GEdEkwFyUkhZa84lozW
 kDCIIZdyunnQcONNQKEbIHQEU/t68T0at36ufZKM2TLG6tvw1hNm7VdLpIt3w870yB+A6fucR
 0Ql4a3Tc9QBOK4C2poBvuJtWV4zdOm6atgfQWV4Srn8tVubzf6hbgJiMWFbJdqUqw2tBmUsSI
 0xq9uM21sbD0ZBsThh2rXqZAd9BJKHzwIO+7T8LTeOyjwu1xyy1BN4iQrLijIg/aHC4t3HhIy
 loT5cQSrxTLpBWGlZ5fXBMZvfzbLHRGpgosv/2OZb6bJGDtFJwYGzTV3tYsG6vDiHS8q43OBz
 e61SWjNma9oWJB5hjLvDJprWHuGUdet2S2I+jYZ/g8iWCE6xOBONbbY9J5AUgRzYawIsvn1Sa
 9NmuoW2bDkCQknfp0wXVtGG4tSnJVTbzJ47sZQulpNs3EeHhfHd8kJpUEx7P2M7UcxlmOSraE
 q0BXphasgMPkrQRtb1wAc/qMDCmLGo8NnUYccIpiopb3WeICO/4Uwqd1nzXtiMYMpkgI4zJrR
 uTgLP9R79sZE1oGNu4S3GsLEQIwIkNeqjz9kWInZnoM+jIP51lMVuZUy3HVDIEWHIBRhDIs2C
 gUJWovKziPfY0zBttTcEErKPN0SIbOYie0VHIZCXU0dNPUM2Usrmf33Dfmb3Ys3qTr5f2sIvK
 Fnu47GsMyn66L2jA8uK49OVNXBE4q+KjHzwApPyGKIG0bK5grn4YZa0SdHqKXC0Rkg+a2/XQo
 dLR29QShm9g6wc4GLFsoNB6glL3+gAHei6RtWjPdFKvwJpsCETPQthDHCKSwurzXeTE9d2gfV
 skCtC0LLA3tBC20bDzN09FXfqSBVkmbZ+Ki/YOuXfW1QqyE8jtK6aZLNw0oIG+YDUsld6/9AN
 kZNr1K8giDfPH/GlcY/+Kabdcf1zn+Xw03gkAPD2vY2NVZJwxTr/WlnHBPKZxssl9oWdzHDrr
 nTXFMV1MygKQ3eB/9OqixtP/5d8YH6NUZKuSqfpIIWq+Eu40HJs1rGKnO7jXY4DmCIlJrJTGu
 RsaLoLPZjLTrnerPNNta0NOhF9KoAJYMHiPho2N114oTn5YAvrTPYt4A8dAjBckWlxHZmjT1e
 JjfSvH4Ni69m+i7AXJncxOF+E52bJi2fsJa00f1ra/wxoFa1dKAtCbb8P5F4YfxZH3F8EF3mK
 NlgGXkoILh07ipFN7p/A4ClS90MbeTm9JEzDryOuAIbO3fdDcacov46zCiD9Vbcpxg5z9PBSh
 vjpxyzEAimIMFbZmHkBmSOj+HR2dbusYfCkLyIyELEzt2eKUWZRcBB+6OxV0QDGGa2Bzq9lJm
 zM8e/nA==
Subject: [cocci] [PATCH v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2533
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/df3ce733-955b-45f3-98bd-04ddb2200eca%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Mar 2025 18:11:05 +0100

The label =E2=80=9Cdiscard=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cmei_cl_irq_read_=
msg=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer.

* Thus use an additional label instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
* The summary phrase was adjusted a bit.

* The Fixes tags were omitted.

* The change suggestion was rebased on source files of
  the software =E2=80=9CLinux next-20250228=E2=80=9D.


 drivers/misc/mei/interrupt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index b09b79fedaba..af5f01eefea4 100644
=2D-- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -136,7 +136,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 				cb->ext_hdr =3D kzalloc(sizeof(*gsc_f2h), GFP_KERNEL);
 				if (!cb->ext_hdr) {
 					cb->status =3D -ENOMEM;
-					goto discard;
+					goto move_tail;
 				}
 				break;
 			case MEI_EXT_HDR_NONE:
@@ -153,7 +153,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		if (!vtag_hdr && !gsc_f2h) {
 			cl_dbg(dev, cl, "no vtag or gsc found in extended header.\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 	}

@@ -163,7 +163,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 			cl_err(dev, cl, "mismatched tag: %d !=3D %d\n",
 			       cb->vtag, vtag_hdr->vtag);
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		cb->vtag =3D vtag_hdr->vtag;
 	}
@@ -174,18 +174,18 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		if (!dev->hbm_f_gsc_supported) {
 			cl_err(dev, cl, "gsc extended header is not supported\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}

 		if (length) {
 			cl_err(dev, cl, "no data allowed in cb with gsc\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		if (ext_hdr_len > sizeof(*gsc_f2h)) {
 			cl_err(dev, cl, "gsc extended header is too big %u\n", ext_hdr_len);
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		memcpy(cb->ext_hdr, gsc_f2h, ext_hdr_len);
 	}
@@ -193,7 +193,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	if (!mei_cl_is_connected(cl)) {
 		cl_dbg(dev, cl, "not connected\n");
 		cb->status =3D -ENODEV;
-		goto discard;
+		goto move_tail;
 	}

 	if (mei_hdr->dma_ring)
@@ -205,14 +205,14 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		cl_err(dev, cl, "message is too big len %d idx %zu\n",
 		       length, cb->buf_idx);
 		cb->status =3D -EMSGSIZE;
-		goto discard;
+		goto move_tail;
 	}

 	if (cb->buf.size < buf_sz) {
 		cl_dbg(dev, cl, "message overflow. size %zu len %d idx %zu\n",
 			cb->buf.size, length, cb->buf_idx);
 		cb->status =3D -EMSGSIZE;
-		goto discard;
+		goto move_tail;
 	}

 	if (mei_hdr->dma_ring) {
@@ -235,9 +235,9 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,

 	return 0;

+move_tail:
+	list_move_tail(&cb->list, cmpl_list);
 discard:
-	if (cb)
-		list_move_tail(&cb->list, cmpl_list);
 	mei_irq_discard_msg(dev, mei_hdr, length);
 	return 0;
 }
=2D-
2.48.1

