Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1158BC0219C
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2025 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Avfxke0KflvJLmVyOEnqcW+s3dJDGKB81BZTYhBXr+U=;
  b=UcWFqLT7gSDHXaRQ5gr9opk67d20wy+J0kPz9WkAPSZE1U9SUV2g3am8
   /jIlcmdM/KAP3EQbveUWc91u6bLH1R7Bfbwo9hhTsRU3h3oEOjVtOrDyA
   J06BfbET2VC4A78rjEMyaYdzdVmnY9NZjAjDxw8RQK0C1TgDbxXDIegRR
   c=;
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
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207128368"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2025 10:51:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E13FE0D1F; Fri,  7 Feb 2025 10:51:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B74E1E0261
	for <cocci@sympa.inria.fr>; Fri,  7 Feb 2025 10:51:09 +0100 (CET)
IronPort-SDR: 67a5d784_yTXhHsrzpUU13Wb2egd36sGW+TdzITuQ0tIdOI9UzgQCp6J
 l69dSJl3+gbBQ8GRn3Wt9Iq7/wtwUg/oeSBAWZQ==
X-IPAS-Result: =?us-ascii?q?A0EjIgAM16VngAwR49RagQmBVYJCYnUzBAtIhFaPT4F0M?=
 =?us-ascii?q?IQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEggyCdAKLAgIeBwEENQUNAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBF4JngjABA?=
 =?us-ascii?q?w4jB7A3gTKBAYIMAQEG2lwfLCJXgWUJgRovhWuCYwGGJoQ8Jw+BVUSBPIMDP?=
 =?us-ascii?q?oRDg1uCaYIzhEhWEYsEj1yIXVJ7HANZLAFVExcLBwWBKRA4Ayo2MSOBIwU1Q?=
 =?us-ascii?q?TqCDWlJOgINAjWCHiRYgitqBAWBLYI5hEOETYJDgxWCEnRsAwMWEAGCMXB4H?=
 =?us-ascii?q?INaLx1AAgELbT03BgMLGwY9nxKFdG+BV8VvNAeCOIFmgWMMn1wGEy+DcAGTU?=
 =?us-ascii?q?g4GknssmFAiqQyBfyKBXDMaJIM2TwMZD5JOxkxCNTwCBwsBAQMJhUYBAYpfg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpvy72x6EdZELJolBlsZ
IronPort-Data: A9a23:gJxuk6s6VT3wv9PU4Fwfm9LaD+fnVIBaMUV32f8akzHdYApBsoF/q
 tZmKWyOO/+INzT9c4x3a4q+/UtVvJDWxtE3QAs+qnhkHn5BgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsMpvlDs15K6v4GlA4QRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJF8IOdcgq/17Ozlp9
 NUCMDcwfjLahu3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWh235om8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9//JoujKDl1UruFTrGMP1fdu2b+Z2pB6J5
 XCY533yGlIRFtPKnFJp9Vr32r+XxnOkMG4IL5W8/+FjhFm71G0WAgcfE1q9u/iwzECkM/pUL
 Ecf+wI1vK0q/QqqSMP8Vlu2uha5UgU0Xt1ND6sl5QvLxqe8Dxul6nYsUABFMuR3r8MMHRsr/
 0WRmO75J2Vuv+jAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqls1Hojqf48ScaIYs3JJN3m/
 9ydhAQT74j/YOYO0Linu0/KiXSgq/AlrzLZBC2HAQpJDSsgOuZJgrBED3CFtp6sy67HFTG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qG/9qyD9It4Lu2siTKuMDiriUWC5C
 KM0kVwBjKK/wFP2MPYuC25MI597lPm7S7wJqNiONoAeOfCdizNrDAk1OR7IhDCy+KTduaA4P
 5CAOd2hZUv2+ow3pAdas9w1iOdxrghnnT27bcmik3yPj+DCDFbLE+ltGAXVNIgRsvjbyDg5B
 v4FZ6NmPT0FALWmOkE6MOc7cTg3EJTMLcCm8pcLJrHefWKL2ggJUpfs/F/oQKQ994w9qwsC1
 iDVtpZwmQql107UYx6HcG5iY77JVJNy5yBzdy81MFrinzBpbY+z5e1NP9E6bJs2xtxFlPRUd
 vgif9nfI/JtTj+cxS8RQ6Ogp6NfdTOqpzm0AQybXBYFcaRdGjP5ou3fQlO39Q0lLDaGis8lk
 rjxiiLZWcUiQiphPub3adWu7QiDglkAqs1PXm/jANpaSGPz+qdEdg3zif4WJZkXCBPhnzG16
 SefMS06l8Ls/bAnwYLsvr+WiquUCM58IxZqJHba5rOIKiXqxGqv7oteWuKufzqGdmfL1Ii9R
 OdSldfQDeYmmQtUjo9CDLpb96IyyN/xrbt8zA4/PnHqbUyuO4xwMEu9wshDma1c9IB34TLsd
 Bq0xeBbHrGVNOfOMl0bflMlZ9ve88AkoGDZ6PBtLXjq4CNywqG8bnxTGBuxkw1YEqp+NdI04
 OUmufNO0TeFtDgRDo+kgBxXpkO2FV5Rd4U8t5ofPp3ntRpz9HFGfq7nK3HX5LOhVoxyF3cEc
 x6uqojMvbB+/nb5UmESECHN1NVNhJ5VtxFtykQDFmuzmdHEp6EW2hFVwDVqTTZu7w5m1thrM
 TNBLHxFJqSp/hZpivNcXmuqJRpzOR2B9mH1yHoLjGf/TUK4ckDoM0sGJverwEAV10l+bwpr1
 uiU50i9WAm7Yfyr+DU5XHBUjsDKTPtzx1Xko9+mFcHUJKsKS2PprYH2bFVZtia9J906gXDGg
 uxY/OxQT6nfHgxIqo0ZD7iq75gheCqmFkdjH844pLgoGFvCcg6cwTKNckC9Wv1cLszwrHOXN
 ZZcGdJtZT+figC1sTEpNYwdKeRVndkoxuY4VJHFGGoki4ab/x1V6M/+1y6mn2I6YcRcoeBkI
 KPrSj+yOGixh3xVpmzzkPd5KleIOdkqWCCs3cSe0vk4KJYYgeQ9LWAwyuSVuluWAitG/jWVn
 h/JPJGO6+puzbVtwojeKYRYJgCOMdiofv+5wAOylNVvbN30LsbFsT0OmGTnJwh7ObgwWcx9s
 Kak6vrb7Rjgh6kkdkzkgLyDKvV53tqzV+9pLc7HFnlWsi+cUsvK4RFY2WSHBbFWsdFavO+Le
 hCZbZauSNsrRNtt/n1ZRCxAGRI7Ca6sTKPBpzu4nsucGComzg3LA9O2x0DHNVgBWHczBKT/L
 Qvot9KFxNNS9t1MDSBZIcBWOcZzJVu7VJY2c9H0iyKjMVCppVG/oZrnqwsr7GDaK3uDEfui2
 6n/eDrFSE2Qtp3LnfZjiK4jji1PWTw5yaM1c1kG8tF7tyGiASRUZa4BOJEBEddPnja0yJj8Y
 yrXYXA/DTnmGw5Jagj4/M+pSzL36jbi4TslDmdBE4KohyaK6EeoBbx86mF/7n0wdjaLICRL7
 z0B0iWYA/Rz6sgBqSUvCjiTnuptgP/Xrp7N0V6oiNT8Wn7yHp1TvEGM32NxuejvDMzH0knGT
 YTwqaaoX2njIXPM/Q1cl7K51f3XUP4DD9nlUMtX/Ovihg==
IronPort-HdrOrdr: A9a23:nWkmIaOGuoyUrsBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:K7i4pmyUas1fmLTM4R7XBgUKJMR/SizGwE2IBE6RE35uda23EF6frfY=
X-Talos-MUID: 9a23:YnSQkAgURd29daV+2sJYKMMpLedv5JiEK2M3yYRFqZecLCdoeDy/g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207128312"
X-MGA-submission: =?us-ascii?q?MDGYLRNydNByr19cIFtprFfEytc8PoxJ8InJ4o?=
 =?us-ascii?q?Pm3ZYOxv6JhG3soD+lWUInBQtTTJbIJit9HN0QD8wPQZTXLispJaiKqi?=
 =?us-ascii?q?6TMfNP6ml+4EYwv1GuJBnXcT40GB4MBRJuG3HlZ53U1CdouLjMSMwnZQ?=
 =?us-ascii?q?v90hgU2R0p0xTn/PlZLP0s4Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 10:51:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738921859; x=1739526659; i=markus.elfring@web.de;
	bh=Avfxke0KflvJLmVyOEnqcW+s3dJDGKB81BZTYhBXr+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PfVccinwWi+u1s3w94IPekrtMVW80SrsF3bT2Me2UaWL4hBfUSHiU6XqVJBrNs/F
	 CGZP6DTx76Ia2Fbe6fZtiehRJ/HKovHAtLgCxnw5C4GUuRf9e58/PxWYO2WLUtCcn
	 KH7NkARUfAWyyTnfC7qqU40+RS6Ik4y2pVNeuCOJTolDi7BIDCbGa1mEeTT9tWVXI
	 nl583zVQ9yoVZ3eIxqrHaAEv+/h9egbmXbl5Qg/dQYm99MGjYCYrG+EzSspBTARxw
	 cx2XVG2/EuZrPCHOJP1Z+hJx5oX2d7zuWCsPFlxDRu0freWowfiOuBfhtIeuCFS7y
	 UEcAE6NZtLixXeOuOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.29]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3tF-1tb7h61rxX-005zyv; Fri, 07
 Feb 2025 10:50:59 +0100
Message-ID: <434583f7-7fc9-454c-afa7-9a35128aa8b8@web.de>
Date: Fri, 7 Feb 2025 10:50:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9bfe9c42-ef0c-44ae-a71b-26207e9083ad@web.de>
 <be231f53-bc7e-6aae-497d-ec83859957b@inria.fr>
 <f67b5b79-09fe-433b-bd2a-6f50a00e4763@web.de>
 <bf59a6a58a28828d3648d6e14416d4679c585f0b.camel@sipsolutions.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bf59a6a58a28828d3648d6e14416d4679c585f0b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNGYlITC39TYfc595XBxPGVMA5IMtDdpthbNl1mRNhwJw3Ie+rt
 PLVBtND+gdo9zYS6aK9aOP06iEXa3CBEZH2jrEdSqrl6/N7JLlcPlCt3C92F5jqAFTdOZhT
 xdhmiqDBLamWlSMkxEqxRHeRuUlyJjiFG9jgB75aqhuq/raIrIF/queMA03AZ3y9rEtfDr1
 1lYpjNwofqfRjrH4TKCtw==
UI-OutboundReport: notjunk:1;M01:P0:RfngvDWjFDI=;s4vXWp25r6kltepHXnMSoSMU3s0
 FupQoRkiQON4FypWds0M3sVPG8U4d2xzawYGqvp2T5HpY6uvzVxI+hlN0wwAkY2lhuYtRTuy0
 c0aBUPNUJkxcu0F93K9Lyphr5AtSZpK2CDGdAR5UYs8yy9kCVT7Wpk5esamG1+3+ifSyBY7ob
 59MFVKE0XS0iBbGkkwCiYdAj0SvsC2Rb3SOEhqTTNtzbULzNNTHP5OudiUSHeUGUyMhwOnFNN
 cE6t8poDUe0F/0Wbx0ZMyyYB89raR9Wmp+vc/YEUp6n9AMeTBHNbxwVUxJ44t9hjkkYP8XtR/
 zQuvIG7jGB4q51/iwWJiPOa4a0TP+Wj98zCU77GRFQ4tsHexvzumbw4efuspeel2fCdXVp4Dt
 r+ZtukXw3HpJHrqsN4Gd2RbdEYNGiaSOEjNLlhs5D4lHqhYhlUFMQrWD9CgYv1tGC4yibAOcE
 Sv1Jz7yvnH6/tKxhENnpvj6hziTLQ337UX9Av/+kxwje6mbnWk9W78BztX8/5weURFWd13yzn
 NXL3uGL6eXcLxtADNy2OXrT6awKwzLM+WnUjygcaH/rEVjXB6C5AaEav9ij/MS5MK6CoHoKLZ
 O3T+MFrdZuvjgqK5voui4e8I22h7wtYzU6bWykkWHJ2SJlyDeJycH01HbL34nYLcVf+qQ9Rly
 MMrApvorte8i8/fBgDJouV3BHUkrJwXoj6XahRAKI2NViLx1dFOUT6DEN56jBWh0FRzNUs0jm
 caR/3+f7jQTaCFBP7TW68kU1Qx9LAcMulhgy2fJnS4Pu5/QkE7a8QGHe0h9pEDpMNTSfkOmDI
 FS/NaqQVPhTEHNcuq6gjzL+9wghEA8aL/saZFPwMfhZrHjRGoAqWF6zBNdMLgIWRBPYyX9kmg
 6CO4zgP95i6sXBp7h7akWvxnE8bGUVc21kREgQrSGtNOMENy2Cc7fJgkwRu8NOGmmbr66N4dV
 NaxqTPOTtp+49lD6AdAUACLihy/5L+f0BF3NSB3+1hDdREDrHzY5YvesuMUZQ/MW9IeCo1Nl5
 XcnVT8ij6/qWCeCpjfUrz+YIrpiipz8l1FAMv846Pxs/i8vL0LWW7I0owCPrx1Nv2R42nIYMY
 1j5nycrYsxVlroGdWQYQlepnvoCXuj7M3h8+R/8UKwlHBhoDMqbKEO7dlx8U9SSZUxsiLWdOQ
 mNyp237w9JjWRHa6eaDm2h42OrMUaYYSku29/VYyovBlJX6qFXhNdYty0S58Sry4pfxNkUJKF
 GKgQMRlWxKzOdIkrBdrXeul4L4ayj8afJJskjd+UB49pRBXH8E5neeCF1Uiqur1vEah7StO/E
 S06I2IepcJvg2rIfxBQKc5mRCspDJFexToIUvkbN+jYiGe4sJXpX2Wa0ljqswBwUQW5eeHn77
 T5W12O3Xp8hdOVO8/aSv53zDB+EXqKsnAlvFKCA+DpjoX8L8Ih0lZFJVkxCHPbZU0byox0vgZ
 pB3m6sQ==
Subject: Re: [cocci] Checking software run time characteristics
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2370
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/434583f7-7fc9-454c-afa7-9a35128aa8b8%40web.de>

>> Can our discussion trigger any further software improvements?
>
> You're kidding, right?

No.


> Discussions with you specifically only ever waste everyone's time.
I wonder about this view.

Various open issues are waiting for solutions and desirable collateral evo=
lution.

Regards,
Markus
