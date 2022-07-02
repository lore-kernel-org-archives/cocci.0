Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37987C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Jul 2022 11:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=soDOim2DnleT5oI19M4Ct90YuavWgD8YSBe9HgvC6lk=;
  b=MxSpSIJ87ujhFMylfxht20wS2RPMp6w4isb4v3EE6SThaMlQkZlFxQaC
   itmu3V9n49UMeLpkj8rcueiGmD4O0rlPClqLrT1H/pP1QY5ZKnWHZhNHZ
   7zjY5tuyQlcEsbOl5m/fG6KQdI5ykcg7lQ54ebg2kEj0rvEIhy0AIBwGS
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,239,1650924000"; 
   d="scan'208";a="43933130"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jul 2022 13:01:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54B31E034D; Sat,  2 Jul 2022 13:01:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D074E0092
	for <cocci@sympa.inria.fr>; Sat,  2 Jul 2022 13:01:07 +0200 (CEST)
IronPort-SDR: bR3sP1sBlOAjHnl8nyTFDCD52zg5rtlPZkE94t28uW0e2MeFjT4MTCkAFIOGR6utDTbpjS4nHM
 oijzb//gWNng+RIHrz2kwHjVMNyDMcOjqt0W9wLFBI+ykqH4BVj7Xio5ZnZ+GMcjIBOrC4l0vR
 BYFa0zEad+tSo6cNSbpoNwZNUm2zYQGIi/ucXjkZUnyajiHnMCqfFXLOlQLSjmRk8+KIHp7qk0
 D6Zn6WO2at+m2zWMZ//+YCvKxzhepRaJ6VhsSJ6bYUl5/h6Ky89NQApYL3zpZu8jv+aCp/g7IA
 aJRz6NRnkaq8e/lj2dxsBz97
X-IPAS-Result: =?us-ascii?q?A0ATAADuJMBihk7ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYF7KIEBVi4EC0SEToghhkeBdy4DhCSOKoongXwLAQMBDTcIAQIEA?=
 =?us-ascii?q?QGEPzsKAoVLAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AETAQEBDAsJBwgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJ?=
 =?us-ascii?q?gEECwsaAiYCAlcGAQwIAQGCeQGCZAEDDSMHC6x0gTGBAYIIAQEGhEsfLCJSg?=
 =?us-ascii?q?VwDBoERLAGOAXonEIFVRIE8DIJHMD6BD4FTAoFgg1aCZZoyJgQPAxotLxKBH?=
 =?us-ascii?q?24BCAQDAwcKBTAGAgwYFAQCExJTHAISBQcKGw4UHCQXDA8DEgMRAQcCCRIIF?=
 =?us-ascii?q?SsIAwIDCAMCAyALAgMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKA?=
 =?us-ascii?q?xEEAxMYCRYIEAQGAwgvDScLAwUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EG?=
 =?us-ascii?q?wcdAwMFJQMCAhsHAgIDAgYVBgICbi4NCAQIBDckDwUCBy8FBC8CHgQFBhEIA?=
 =?us-ascii?q?hYCBgQFAgQEFgIQCAIIJxcHExgbGQEFMicQCSEcCh8KBgUGFQMhbQUKOw8oN?=
 =?us-ascii?q?DY8LB8bCoEaLCsWAwQEAwIGGgMDIgIQKQYyAxUGLRUVEQYiARsCm00BcT59I?=
 =?us-ascii?q?nZ7VQ/AWzQHghSBPYFEDIlSlGAGEAMtg3WMQ4YeDgaRepZ1II0SlFuFOIFhg?=
 =?us-ascii?q?hUzGiSDN04BAgECDQECAgMBAgECCQEBAo4dGR5vAQeCRDOBC4kiPzQ7AgYBC?=
 =?us-ascii?q?gEBAwmFRwEBiTwBAQ?=
IronPort-PHdr: A9a23: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
 V0EzOGgRbk=
IronPort-Data: A9a23:8hQ796KG+ONrOufJFE+RuZMlxSXFcZb7ZxGr2PjKsXjdYENS0mMGy
 GEfWjuFOvreMWWgKtAibY+1/E4A7Z7Tz9BjHAcd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M58wIFqtQw24LhXFvX4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhtPlS8
 5Js6bmKbAoAJqr3s/Y6SzxgHHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RHvLktRzgfr
 7pHeFjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLifGPSRvoYBg1/cgOhAEvXGZ
 8UjawFPV1eeWDATA2wSFIshybLAan7XKmAE9gvM+8Lb+VP7yAVu2bzpGMjUf9aQTINUmFyZr
 yTI5QzRCRYRP9230iuA6nvqh+nVnCq9Vph6KVGj3vttnUHV2WEZThEbPbemnRWnomWXeOkYC
 hAxwA8jhLA1z2e5acHYZxLt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4c9JRVDA1nJJvH217j
 Tdli/u4WW026NV5XFrHru/8kN+kBcQCBUMvDRLooCMA5MT/5p4+hFTDQ76P8ZJZbPWlRlkcI
 BjQ9EDSYon/a+ZVj81XGniZ2lqRSmDhFFJd2+kudjvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 iVaxJDGtrtVU8zW/MBofAnrNO72jxpiGGKM6WOD47F9rlxBBlb+IdEOu2sWyLlBaJ9dJ2OBj
 LDvVfN5vcIPYiLzM8ebkqroRZ1izK78GM7jW+ycZ9UmX3SCXF/vwc2aXmbJhzqFuBF0z8kXY
 M7HGe7xUypyIfk4lFKeGrZFuZd2l3tW7T6CFfjTkU/8uZLAPyH9dFvwGADSBgzPxPjZ+Fm9H
 hc2H5fi9iizp8WkMnmNqNFIcQpaRZX5bLivw/Fqmie4ClIOMAkc5zX5ndvNoqRpwPZYkPnm5
 Ha4VhMKwVbznyOVNgiALHxuMeu9UZF6pHM9HCotIVfxhyl9O9nytv9HestlZ6Qj+cxi0eVwE
 asPdfKANfITGD7JzDIQMMvmp4t4eRX33g+DZnL3YDU2c5N6aRbO/9voIlnm+CUUUHiouMF4r
 7D5jlHXRp8KRgJDCsfKaavzng3r4iVHwLp/BhKaLMNSdUPg9JlRBxbw1vJncdsRLRjjxyeB0
 1jECxkvpd7L/90//u7PiP3WtIyuCeZ/QhFXEmSHv7a7MS7WojiqzYNaCb/aeDfASCXr9a/ka
 egMl6PwN/gOnVBrtYtgEu83nPxkuIa1/+dXnlZ+AXHGT1W3Ebc+cHOI6sl4sPEfzLFuvwbrC
 FmE/cNXOOnSNc65QkQdIhEpMraK2f0Ow2CA6PMoPAPl6SUx8LfeCRdeOByFiSp8KrppMdp5k
 Ll755NMs1Sy2kgwL9KLriFI7GDSfHYOZKUQsM1ICoHcjAd2mEpJZobRC3Ot7ZyCAzmW3pLG/
 tNJaGv+a7VgKo7qdn0uCT7S0OAbiZlmVNWmCrMdDwzhpzYHrqZfMN5tHfAfUQlfiBlKuw62E
 nY+LFV7fM1i4B8x7PWunAmQ98VpGxCTvED8o7fMeKs1UGHwPlHwwKYB1SphMazXH6+wvtSWw
 V1A9FvYbA==
IronPort-HdrOrdr: A9a23:6X4ejqNQvrNV28BcTuWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,239,1650924000"; 
   d="scan'208";a="43933117"
X-MGA-submission: =?us-ascii?q?MDGXFzOazWD5q6B4IidxAPmkeflOVqHI2RCM20?=
 =?us-ascii?q?4fuGpzYgi2j6C5Z7YLumPb9IXeLXlqttt7FgPs6d4NZugvy9DMipVQV2?=
 =?us-ascii?q?3rXqlKB9ZOKm7rEw6mF5UKDBnooHZk1k2JJBXkNVTRpqGntJ2ronbbUo?=
 =?us-ascii?q?naZZA3l43eLRqyGdUHuX5yjA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 13:01:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656759658;
	bh=soDOim2DnleT5oI19M4Ct90YuavWgD8YSBe9HgvC6lk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YRNF64D1Y3MuA8hYIW+mFwlC/7/Ff58L29qfY4oKti1U+AxjV7v3nUCUSMwvB/YTG
	 n839AFOGJHOZucvlk9Ea5UW6AMi/sjyZRIzfpHK0jTKxgIGT6kCZQnXpCrcPR9WgAJ
	 WOcPXdnAjBzRCl+IBbx09I11bdYbdWtggurznPGo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.49.151.168]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9vU-1o60Po2iFu-00XuKK; Sat, 02
 Jul 2022 13:00:58 +0200
Message-ID: <45245872-0ed4-0b8c-30bb-bfc4bcd94c0b@web.de>
Date: Sat, 2 Jul 2022 13:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de>
 <alpine.DEB.2.22.394.2207011647580.4779@hadrien>
 <51130aa6-1a1b-51fb-c4b7-c0dcda1d78d1@web.de>
 <alpine.DEB.2.22.394.2207021218550.2882@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2207021218550.2882@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PFr8IHjEeCVCYcJtM2CtEKOZPzn1pXzanOsnYmqh6Ca8QsUBce0
 IN+BHLa1qkHty7eGSyKUilbi/A58L8KuBqc229K4IXfl6OoxHYzVhWTpqIGkUyF1GDwxOGr
 hPTkbxjKMDPdovUdT9rnDF2PANZKmSswShhNT9ETgIvKMeKKAOz7Yq/Jex7pHTLGOCN6znc
 woz0gX0hHJNTS8zdS+ZnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PlxQ8ufx7HM=:k9udybMyuzIi6iz0et+ivg
 /h3UTjJg06ZRX8lPRwHJX4XpQEAsi6xLP9vnRptdBW6aNKWaSMGlyoKcQXHKTgtnpfNYHjaGE
 VfT4XRJdS4POId57d70aOwJyab4J0aOhYo+lycoYcgKB4QZwHeyPzOd1Ve688iDvojJQbKbgY
 mJRfDj+/7wQcTiKM58sB3esaaVc8gxgBanjLzYhZy9FTEbAVL++oZEgbMVC/aj+NnfX3sPNP9
 9YalSpXxBDYj8AmDzyUI60xLUyz8CuM/3/tKQMNDfSikx9RwoEfY/khiIZw/vEj3KscEHyHXR
 spKkl11H9oIPbk5wr7MTyvrmWuq2yNxpsNHj+etMR35RwfRdweXbREa8qXPK+AXZNEvYqqvK6
 q9eZQT8Gsmhxvesc2XPP8VLIhB8yWDuKrysFmH5lBuVWOoDcJrLZW4jPWu2izVaj0vk2Nltr1
 kQTWEqWaN7KufoPZRLU8mDKCNjDdRaFAEmgZD+054x8xjkrY4jSE89QA/LsncWDgEW33nbQlx
 c90qkFEHTppoceAzrO64sVq5vgWy/rVmrqR+ea2HB1cI/pAKX2fbYFDP/HZf5lFG4JBL2y22r
 epqaU04oHX00dMi90Qbd57lpKd9ogsGeo8VCjq//cume+37B8bVgoy/yk3M1v9ifVqJE7bC2H
 bNIZrkTL5R9NptJaWt6AeHp6OG2iXgItDbBalEue1W5mS/SrQPKhOc2949qoa1HofTsJqr8yY
 KFDTR3CUwM8TDYvhM13WXb6841S+wSnNyE2AXL6Pm2/4BWi/xkDlZR49RBMKINes7eOEdUxsR
 JAzf5tx8XPZyWFXVAM0MFrsccMo+HCd0Z1+eiYxgEaPQWrs/c5UENho7/Lur2GssWfjp6Mwah
 xQnHhAbW2wKr9FL8g/ynTKYZX1cQJdETA9juszXwX1ANh+rA3ACgIPQo2A2yvg++iuBqXlRun
 EgQDdsFtJDr2zudYQArXQCu3CXJT4vt+GmMImQ0jZe2xcfziJzQ6InuXXxoo62Xp3Ma+tS9+T
 6PDA0X+Y+UX/84g3WklJETGpTdyeg9we+2mml+FxjkhotoG99rh1UPD9fG5DJ7LH/D+RYuc7d
 xB43nRpK4OxiQF7nDOkPd4L0XPEl/Ryy/DzJrADMTSJUz4cPxAbKEuAdg==
Subject: Re: [cocci] [v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 478
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/45245872-0ed4-0b8c-30bb-bfc4bcd94c0b%40web.de>


> It seems that your resoning is "I wish Coccinelle would work this way,
> so I will suggest an "improvement" to a proposed semantic patch

I pointed further change possibilities out several times.


Examples:
* https://github.com/coccinelle/coccinelle/issues
* https://gitlab.inria.fr/coccinelle/coccinelle/-/issues



> that actually currently has inferior behavior as compared to the origina=
l one
> (but not mention that at all in the message),


I find this view interesting.
I hope that we would like to make the discussed SmPL script considerably b=
etter.



> and hope that the Coccinelle developers will think that adding the funct=
ionality
> that you hope for is a very important priority".


The importance will vary as usual.


> If you want a feature to be added, ask for the feature.


Would you get into the mood to extend isomorphisms (and corresponding docu=
mentation)?


> But please stop confusing the discussion about semantic patches
> that are proposed by other people.

Are any additional SmPL disjunctions and metavariable types like =E2=80=9C=
binary operator=E2=80=9D
relevant for the current SmPL code review?

Regards,
Markus
