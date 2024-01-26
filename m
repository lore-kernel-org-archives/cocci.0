Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC960C47422
	for <cocci@archiver.kernel.org>; Fri, 26 Jan 2024 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WagTIVQqKSHJ54RkxF58WGY2wOpRYcXrkNhWimT3/sU=;
  b=snuBEwd1vowYntqNLIzS5g/I/KtY1J0W1E6BZvFrVIa3/JBSGsXj7HII
   A1ttlynDS3iy0DDnvjMt+RMQ1rYRHuuJ/IJwueP+Te8ZZ///M9GXXp3HW
   wojtBp0kau/LUkIPwP0lcvtqyJq0cwgAL3G5oFkGJQJHpaIF/dxZh9APH
   A=;
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
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148822318"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jan 2024 14:25:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3C15E0CD7; Fri, 26 Jan 2024 14:25:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2AFD5E0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jan 2024 14:25:09 +0100 (CET)
IronPort-SDR: 65b3b2b3_lmfZLuzrbpYc0eRcLYGZQKZ7sY995UFGUQKtXyIEHJFKLn9
 S/Bdv+8feq5IUT3hYriDZthMdDCvDBaZJSToj0Q==
X-IPAS-Result: =?us-ascii?q?A0F+BADSsbNl/07ASNlagQmBT4I5B4FLMgQLSIRTj0GBd?=
 =?us-ascii?q?TCEO4c2h06IcIMWPg8BAwENQQECBAEBAwSCC4J0AodKAh4HAQQzBg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEXAkdCAQQBIx0BAREnBAsLGgImAgJWBgEUAQGCfIIrA?=
 =?us-ascii?q?QMOIwe2DYEygQGCCgEBBq9aHywiVoFhCYEaLogiAYVnhDsnD4FVRIE8C4JHM?=
 =?us-ascii?q?T6EGimDW4JogRuXSVR/HQOBBQRcDxsQHjcREBMNAwhuHQIxPAMFAwQyChIMC?=
 =?us-ascii?q?yEFVQNABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4AwMGAwoxMFVBD?=
 =?us-ascii?q?FADaB8yCTwLBAwaAhsbDScjAixAAxEQAhYDIhYENBEJCyYDKgY3AhIMBgYGX?=
 =?us-ascii?q?SYHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iCDIE+BBNEAxCBOmADGSsdQAIBC?=
 =?us-ascii?q?209NQkLGwY9Apx8LIEkxTs0B4I0gWCBYQyfMQYTL4NykzsOBpJZHpg2IKhOg?=
 =?us-ascii?q?XkngVkzGiSDNk8DGQ+STY9HQDU7AgcLAQEDCYVGAQGDJjSBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:6k+kSqs9G1IyXOx+JdTj17nQ8OfnVCtbMUV32f8akzHdYApBsoF/q
 tZmKW/UP6vZZGqneN50O9my9kMF78fSm9drS1Fq+X0zRSpHgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRMtspvlDs15K6u4GpC4gRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJFk8Npco08pIOn5f8
 OVGNxYWbTWot/3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaHOOVv5kBjW122ZAm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PZnszKJllwruFTrGMvPIoOpYuFVpHudv
 UuaxGbWLyxLO9PKnFJp9Vrp3IcjhxjTXIsNHbm83uxrhVeJzyoSDgcXXB21u5GRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9pfpD8+iLjBsZlZ8hBYO7afanBR7i
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
IronPort-HdrOrdr: A9a23:7ht566iZ52IdRzXd2UkVUjozyHBQXgQji2hC6mlwRA09TyXqrb
 HMoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AcHacQGojgDvYezYuvi8dytvmUdgveWft5VvvGFC?=
 =?us-ascii?q?pDH83V5uOSnq7yLwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AnlsH5gxywlYauuY+eEiE2J7zUHOaqLW0UB8utrE?=
 =?us-ascii?q?GgfSBLgUsADWyoQnmTYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148822282"
X-MGA-submission: =?us-ascii?q?MDGHBQOsewB1J0DIXFy3CFBARJnSMmo+J0bPnA?=
 =?us-ascii?q?8yciJFrlFBRhWn87k5nqwqgtTFx5nvM1M8Ijjr5v8kb4RvLYjcRL0wwx?=
 =?us-ascii?q?YVjWjEA/NHyJX5c6H4FAAhzwZ32b4nYpcD0LSaV4yzWf8UAHSw3CXVBw?=
 =?us-ascii?q?+tJHjuSWpF5eHmFYwZqhPHrg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:25:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706275499; x=1706880299; i=markus.elfring@web.de;
	bh=WagTIVQqKSHJ54RkxF58WGY2wOpRYcXrkNhWimT3/sU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=pgrzgc60ojg6UG+/7GACrKivlynoQ9ESBF4TPyRiUmu65qx2Lv0+GZZDnYxCeoKq
	 znHrPJV0LUhRaV0X3Wg3qEOAE3Nc5SmT+VgKS0mEu46sxGXsKRZ2TpO1pi3zBQtdQ
	 nShaheVaCD9fYLVGu9rJLbu4wTixa2Paq+m5YPPciaqXVD52cSWE8/o5tBzPjZeMO
	 0G+MirjR8kgLJb79xtfKS+FzArykpYDtom+xl4QU/hMCKmxbn0BXaX7Dqk8hibJdr
	 /wxAvP9NK6+3ng+ttxQal96mAG9E+gTS+1GWlM2zJAJJM1tiLM3eugvmLfbjYeXM8
	 tyfUKGvY7U+nsSqxkA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB4F-1rXV503QTR-00UwqB; Fri, 26
 Jan 2024 14:24:59 +0100
Message-ID: <c9453e9d-b153-4036-ad5a-488159b2273c@web.de>
Date: Fri, 26 Jan 2024 14:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <8a6c0b00-c65b-4c83-afd9-4023132a4183@web.de>
 <51875417-549f-3fc-f661-15d87fa41140@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <51875417-549f-3fc-f661-15d87fa41140@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l62+hR6+ZUJnDQLeQ7Fma997UYeBo6UnDwUtdaIvsOec8dtnvo2
 PjHLCKc060EbPxP3t3kNXLrAmbBOrD4PsdZoibJtu+Cev0FnBFASEn1/V/nsCB+c0ISmoHs
 otD+d1NuNYUaOXA1U7f6ET9sxY+5fYC4hoj7YnHGaAAUQFV2cNgA3A2h7KrvRFxRo/udVRK
 d0bt87TV1+HIUm5ICPAIw==
UI-OutboundReport: notjunk:1;M01:P0:dSEUgY6Bszo=;9AwvTrGMnWlz1um0JBYOuuwcQiR
 4wnUL+jrrp82c6YiXjn2kfQDUM/6jcpOyPa6M3JmgDTbRLbm7A9S4HrLmx0DoWdHepIqfqYWv
 ZDbqcLNhis+DW7hPrWQu7S81tmP3M4ywqUlN3tsBu/vNwjZFAOwWdDrH+utHGFaly5kwUKx6U
 TqWcLRKEXUwfusLnUVp1lbPh2fN8b+bxWk8c2zibbGbu8T6gm8vavI5KhReFYDyU/5kTZtzXc
 Ma0nJ/381/gvQ6PkHMVxRsP3PHzrGwFkLaD0kUl6EoY4Jx5M/UOrFF5s8camXui/wbFfilEvR
 IBYmIhxzVMne9U8nnvqxW+agzKBo9qJQ6e/gLvLpAn5513Yb5ghLjzTNDlYqIXvcagLolJc16
 9VULznbV7RpJQNmIBZUQCcGdDJRved92MxoNedIlaQl1aQ2G9FhgvKHQm7RlbDuDptIJ4gtDT
 pD6fk+lBo49KRjRI2h9UBUTsxOhwWOd3AmDblksFJ2Yb1Af7BdxMf+wQAmd9JAI8SkSM6LjPE
 Qv3wsFVNnyIvAm9Otr80tMIsJgOVnHMDdjXNTMGEKaf5rfoS3j8PQ8ggDS/yjReHFM0rIrMbp
 dYSL9le7TODWd7do/0hjWhtYGWqjR5x8B9awvogIsRF+/mjpNPsx+JVPzYkZFeRl7OBKmf0xK
 7Zh07WBV/w76KjAuy3Ql9UtpH6S3F8CywEqtRjba81x3ks2Ae7VfMZMnWuekGa+5LvJnKrT2c
 d8rD7YMpW/h6qGVYUeL2Z+PHeHQow1/X/p4dmTtUp9rk5mt4laShoxjk5u4P9yW1POvPURqj/
 PrmILHW7XuZmRZIoDK0DZ1V6ssn2bmGo79k5QbcBnwr0cuxAcMlYkpty/ojRv11xsQamQPzOY
 EiFiSM9DtImiEaTsegqaj5pLj7yQFfZzcUjMJvBi+G9GXB8RI3atDl7gY+se3F2p/xMvumCPa
 BmVpYw==
Subject: Re: [cocci] Clarification for input data of scripted SmPL
 constraints
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1491
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/c9453e9d-b153-4036-ad5a-488159b2273c%40web.de>

>> But how does the software situation look like if you would like to use =
contents
>> from multiple metavariables (which were hopefully matched in combinatio=
n)
>> for advanced condition checks?
>
> To a limited extent they can be listed in the ().

* Would you like to point any script examples out?

* How do you think about to improve the corresponding software documentati=
on?


> If there ... in the rule, it is often forbidded to use this feature,

Would you like to extend explanations for such a hint?


> and you have to use a separate script rule.

Will development concerns be clarified further?

Regards,
Markus
