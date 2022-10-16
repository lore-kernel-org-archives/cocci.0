Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69431C4332F
	for <cocci@archiver.kernel.org>; Sun, 16 Oct 2022 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=P9muo8csAMSgOTI+adEeitRHKsqu7XrZs5xFp8L5m88=;
  b=ddZaGcELNAwfvnOV5W3N4kD+mR4VJvfum53p8hyt0tbh8aMMil5GxQ+X
   LSQlH01uayo0JGVpps1tzbPt8i6S8GC6heEXCguyy9O9T1i2NKxyVCLNi
   1YTC4al/dPvkGC7RvedQHfKiYoOHUVkT7tPBCbuukMkq53xMpVaV5gifl
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,189,1661810400"; 
   d="scan'208";a="65352295"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Oct 2022 10:50:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EEBB6E0087; Sun, 16 Oct 2022 10:50:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 062F4E0038
	for <cocci@sympa.inria.fr>; Sun, 16 Oct 2022 10:50:42 +0200 (CEST)
IronPort-SDR: 634bc5e2_OpDNkRcBFT0HUP19+5exIbksxIjWBQLKwWS2f0+4fkOCCP2
 qzd8xIzSHruwVtaG7O0h0HihgXPFT8x7Q0bPYCQ==
X-IPAS-Result: =?us-ascii?q?A0CPBgDExEtjhwsR49RagQmDdIFXLgQLRYROkHABi2mHJ?=
 =?us-ascii?q?4wvCwEDAQ0/AQIEAQGEewoChGwCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpg2UDAyMdAQERJgEPBQYaA?=
 =?us-ascii?q?iYCAlcGJIJsgm0BAzAHqhaBMoEBgggBAQaETh8sIlOBXAmBESyHGIgheicQg?=
 =?us-ascii?q?VVEgUgBgkYwPoREg1eCZpRkhgo4A0QdQANGNBgDFAMFIQcDGQ8jDQ0EFgcMA?=
 =?us-ascii?q?wMFJQMCAhsHAgIDAgYTBQICTTQIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGB?=
 =?us-ascii?q?AQEBBUCEAgCCCYXBxMzGQEFMicOCSEcDhoNBQYTAyBvBUIPKC9pKxwbB4EMK?=
 =?us-ascii?q?igVAwQEAwIGEwMgAg0pMRQEKRMPLQcpcQkCAyJlBQMDBCgsAwlAByUkPAdYO?=
 =?us-ascii?q?gEEAwIQIjwGAwkDAiSBSzEmBQMNFyUIBTcbBAg8AgUGUhICChEDEg8GJ0cPS?=
 =?us-ascii?q?j45FgYnSAE2Dw7jTzQHghyBR4FKDJ57MwODUJMSBpITlxandIF5I4FbMxokg?=
 =?us-ascii?q?zZOAxkPjjkeg26KLT80OwIGAQoBAQMJhUcBAYUSAQE?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDDTd+dsFB04jENFQef9K
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:UxtxlaCF6UHi3I3lHelu55DYdb4zR+YMi2TDGXoQdfUzSL3hqy
 nOpoV46faQsl0ssR4b6LW90cW7L0801KQFhbX5eI3SOjUO21HFEGgB1+TfKlTbckWSygce79
 YYT0C6Y+eAamSS5vyKgzVQfexA/DD9ytHTuQ/EpU0dMD2ChpsQkztRO0KmMglTSBNdDZQ0UK
 eN/8YvnUvaRZwvBP7LeUXs1IX4zeH2qA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,189,1661810400"; 
   d="scan'208";a="65352279"
X-MGA-submission: =?us-ascii?q?MDEi297bVPqT7pX5CGMtEztbpkKg8mDL8WepHy?=
 =?us-ascii?q?rWdoskB74IpDDiPZwO8GSdwoHrzcnepuNLyEII9Ngqm24vfRcvw+ZRGq?=
 =?us-ascii?q?/yQpbiaU/Icl4EWQTP2/6evn+CF9p+Py8Hq+VxT+WKIQ56dbi057sON3?=
 =?us-ascii?q?Eozd13iRDbbBtz6toX1E4HyA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 10:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665910237; bh=P9muo8csAMSgOTI+adEeitRHKsqu7XrZs5xFp8L5m88=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TUC/VnnVoJkg6vazpK+GrPe2xN6F9WN+3JM+U35g6yXpd88gs0lqY2w4T2Mcmqv6Y
	 XPz3Ethqx6JjuY4usMopvp868wkU/vp74kawAz0BDcQxozr8yDhtfP6CDZ3dNhkITO
	 XlQ24yE9owGWA6+b7r8p1VFDSA9mrG4OcX0+QWeh0vZMJMq1gf/Z16Ww5gXAedPW0b
	 M7P9LDFdspN3S+HwKlB87ywj70JvI6tbODibm0CNBM4oPjoMxCq6lUsqCed1Eq5dQJ
	 bfpakRvZTT3osqYfLraskZvsQaDVgLz/aaAwrRhOuKE0xVDfrzNP9f2tsRQbscdY6U
	 43tHxoH8sBTZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.85.160] ([94.31.85.160]) by web-mail.web.de
 (3c-app-webde-bap53.server.lan [172.19.172.148]) (via HTTP); Sun, 16 Oct
 2022 10:50:37 +0200
MIME-Version: 1.0
Message-ID: <trinity-9962637d-23d9-4904-bac0-10debfd7156c-1665910237184@3c-app-webde-bap53>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Oct 2022 10:50:37 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <alpine.DEB.2.22.394.2210151733130.2759@hadrien>
References: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com>
 <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr>
 <trinity-1ddd0e69-3785-475f-ac01-ba838dac2762-1665846759728@3c-app-webde-bap48>
 <alpine.DEB.2.22.394.2210151733130.2759@hadrien>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:+1lsbOYjq3ByISRbf4CkTlthsAk9cdO9de3IeYB9foIQCA2jKBU9AUHqsohtB4c7/IKfO
 Y+irqR0CZpwIO6Xlz+z1ISV1y1897v7bXpv7UcWBpS+jvzs8hqESUN0tpOef7ElxBwn1nLRQNP1v
 5q66KVACbyolmQAxSrqWLcRx8PBw68kIAQvMMzTmlbKFIJqI7lThe19dWh6yG2b8fHhlLpPQ3oEY
 vT+0IjhGcHkpq9XV3p+SNzszH49m/9qH4nPoZbLtqSKmsdihGcPBryAn4tnvchdRxO8H80fDZycl
 MI=
X-UI-Out-Filterresults: notjunk:1;V03:K0:cMlWjGcQ9XQ=:CVwRsWN6i2hAZCCrcsU8MQ
 CA4fvp2nNw0wtEb1cq8yPcinWhFn5+RskZkqpFNdxrQ8Yb/OZ0R2D+5zqo941tEzreui0x7wp
 D8ABgqiRUDa5Qf5TDDDvBNB4ReG51GDfkOpdi5Rd1fFcTzkrqx97FuMJDxYLuaJcphBN8jHNo
 /vLieNn3nLANEhh/uKFwKqQVFq3oprQ2vA0hIKPeenT/gonimzcudTLSkh2WjKHOphmIV0R4r
 5FRM6DL6DdKXvJ7yp9qaMNbBo7ueywQB3bhyXFvhgq9BQkiBv+R2b0LKKUmRiUEA3/Ar8uEMX
 NkzRquSoi8Oa5kVbfqMyY0sUf9IL5oinQ3kGWRR/G6IOMleL0Kk5y+efKDixd9K6ZWPNVY1+K
 B8kp8mOpra+1ftgtUtHM0ULlgThKNQiN1PstPeO6f/MDUUUrAcjCLwOwloMMenQcVEQYkc6ve
 BJwTsnsPlwJVK3n4lWdx5Z4XK2xwumdaozM9yiK0puJ0DAQ1m3B3B16+LPlXUXUWuuLrQWOwN
 q7AI5t8L9zqA74pTKQqGLjbJ0gNhoMO+SDkPu1RJAj7mr2w/BWo7ZxS8jMtyRM7tZ3fPk9+vL
 QInVRp2pXp5b2Meeu4xdLEl3GqGFXboTsUAgwqiuH72ZeoRORYBdtiBHu3JRaK3Vcn4EIQnpl
 aA0/rHm0J6girPEnA0V+VUTClklH3FkUL0uiOVArDed2U7VnOapUOJY+nAtyzmS3sLCIuA+sD
 B4Rd8Y6Vd97+BOBrqHip1lNj+h5KKreKmvOyyy3XC6wpRZpHYVOqDgbrfbrUBK5rmL+7ymXGc
 uJ3O2Jr7xR8khUyvU2H9S7m+iHCzgc+/vEb34DXXx0rHmCeUA3f4olF1CWIMhcyoOBXZ5/xwJ
 9W1LC9ah5FhtFdZ2iuv4dOGjkO81glj2JtS1HZiW9UQXkWoam1JGgyCebLJyavpyVAWnkn9lC
 VOgPpAvoma8hb4d6PTC7E3Zolkp5DKFAky/AIupUfL3uuWDjBRGrsDg7A6E/++fSDCZtx1nIe
 GNJ4xm2ZmxQrCmTB5MdRIfDLpE18JnrDqUaXrLJagQnHKZgUJFH+9xghIPq+gHFvZVNFlT4dS
 qVqC8bb4dOyeLYyepH+5y6HChkvWk6eckKMItFx7m7CjJOMdVLUn+2331TJaZwQ3G4tC5zTVS
 n6qT17T2HjIlgHMfWV1MKfDzU46bVJNu3pTiV++Ifh01D3oJB4E9b9AQMhREaOtsPoew3mkuR
 dVuUaq0CLbnNkJ8OdQi05eRjNW8IOvMf/uxMMuI41aU+FNElNHIhT4KNSdVUcxlQlRlDbblSz
 uprNOD6m
Subject: Re: [cocci] How to fix diff generation for adding if statements
 before return statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 652
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-9962637d-23d9-4904-bac0-10debfd7156c-1665910237184%403c-app-webde-bap53>

=E2=80=A6
> > > > int b()
> > > > {
> > > > + if (1)
> > > > + printf("b\n");
> > > > +
> > > > +
> > > > return 0;
> > > > }
=E2=80=A6
> If the return is not indented,
> Coccinelle assumes that indentation is not wanted=2E

I would like to point another diff format detail out for further considera=
tions
according to such information=2E
I see a space character between a plus character (in the first text column=
)
and C source code=2E

* Would this usually be interpreted as =E2=80=9Cindentation=E2=80=9D?

* How do you think about variations for possible code beautifications?

Regards,
Markus
