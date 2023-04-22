Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA88C7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kr+0oY5Y9xz9VqNtMI3DqiZzOjyWDCUCfpVr/O1Irws=;
  b=ocPhbnv12piWn+Gn0pUbPtssQxNB29NQbg9Kwntz3ECwsbt6SkPnt/re
   8OhlKyXPHAckFBMyDF8xiZy69MASquGdmfeYDoeQg9G5eLFbbbfR4i/Oq
   XsvL+4fMjIHXFZCAPKIhO8IZH6Lo4k2U53SqY8sPBLZc9Vp4KqmhcXyTn
   8=;
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104287671"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 13:23:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D8FAE019F; Sat, 22 Apr 2023 13:23:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 70101E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 13:23:41 +0200 (CEST)
IronPort-SDR: 6443c3bc_r5sx2uOPxL9QcjOqHr6acsIYNCHHhcjNwpjpdJp/8FPFyf2
 IHRMT6w4USnFNbEeirWzJ8SxSNiygb7MXFI/MBg==
X-IPAS-Result: =?us-ascii?q?A0GBAwAGwkNkhwMP49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FOPEIInhDCHLoc+iGqBaoEsPg8BAwENQQECBAEBAwSEfwKFPAIdBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoD?=
 =?us-ascii?q?YI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkc+AQICASMdAQERF?=
 =?us-ascii?q?RIECwsaAiYCAlcGAQwIAQGCeoIoAQMOIwerCYEygQGCCAEBBpwMHywiVIFeC?=
 =?us-ascii?q?YEULQGNH4QxJw+BVUSBPAyCRzE+hAY+g1uCZ4lkjDSBM3SBJ4EygQQCCQIRa?=
 =?us-ascii?q?4EQCGiBdEACDWQLDnCBRYMXBAIUNA4MFgVCJQQOAxkrHUACAQt1PTUJCx8GR?=
 =?us-ascii?q?AIfgWwEL1h3CgZKmQ6CS1uSC7EDNAeCK4FWgVkMnw0GEy+XCQ4GkiUel1kgp?=
 =?us-ascii?q?3+BeSSBXDMaJIM2TwMZD44gGR6Dbo9IPzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23:U466FB36PPM1DkGosmDOvA4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaCo6410hSSAM3y0LFttan/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys+5DfeQtFiCa8bL99I
 hi7rRjau9ULj4dlNqs+xRzFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0Q
 rNEAjsoNWA1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVTi+6
 apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSGxcVchTSiNBGJuxY
 YgBAeUOM+lWspfzp1UOoxS8GQaiC/jiyiNRhnLswaE2z+osHAPA0Qc9H9wOqnPUrNDtOakVS
 ++11qrIzSjYb/hL1jn97IbIcgogofGKUrJ7bM3cx041GAPfjVWQtJflMyma2OQJvWib9etgV
 eSgi2M8pQB+vCOgyt0xhYbXn48YzE3P+iplzogvP9K4VFJ7bsC+EJtWryyXOJZ7T8whTmxqp
 So31LIItIC7cSUUxpkr2RDSZv2bf4WL7B/vSfqdLCl3in9lZb6ygxS//FSgxOHhVsS53lhHo
 yxYmdfPrnAAzwLf5tWZRvdn4EutxzSC2xrO5uxEO0w5m7LXJpouz7IqmJcfrF7PEyz5lUnsj
 6KbeEMp8fWy5ev9eLXpvJqcOpd0ig7gNqQundSyAeE/MggTQ2iX4+q926P48kHjXbpFkOU6k
 qjfsJ/EOcQWvrC1DxJL3oo59RqzETWr3M4FkXQHNl5IdgqLj43zNFHPJPD4A+2/g1OpkDpzw
 P7JJKfhApbQLnjYirvvcrJ960BGyAoyy9Bf6IlZC78fL/3oQEP+qcLXAgc/MwOv2+nnEsly1
 psCWWKTBa+UKL3evUeS5u0zO+mMeJMVuDHlJvgh/fHvg2U2mVsZfaSy3JoXaXW4Ee98I0qDe
 3bsg9EBEX0LvgUkVuDqhkeCXSZJZ3muR6I8+i07CIW+AIjfQYCinKCO3CagE51NZmFGD0iMH
 m3ye4WFXfcMciOSLdV7njwKT7jyA7MmgDOzsA7zg55uMePQ/mVMt4/n1dEz4+TMnBU23T1yF
 cWUlW+XGSU8lWQDTD4e3aZloEU7xE3Q/7J/hql9HMZQ+ugBfwM0L5/awKQuLtnoWR/aOPqNR
 kynRNqOHjw7CN48lYxdK31hEsmv20iQlxGhBKUYwvnSXMRcGsP02nHwI5040HPazOw6iEFgR
 MJTNGqgj6o59g7JBoePnV/K372ye/E62yjAvHyG0XLIpFtRBSt5S6bYRjYyYkXMrNL2zlzPR
 fmiBOdvKRNPnPaLMbACcdj1lRNDTfbnNs7ZZjeUkn2zGA3O67eCdovsdE0C0S+bBEVX2xsL8
 yOgMg4zTjykv3qYDDFqEgf3ZFjw9OBltH6hZkoz0h3McEBrkba4kvIMrdqbTf5bnrcNuSN67
 i5xAE74xNXOTdyJuwtmeqxYJ9I7+lZOk2zD5UR7OdS7IqZui0R7EUw/tl7y1xhxFoRLkNQ75
 HIswg1oLKuE0VRHPzqG1JH0M7fTJyH85heqI6LR31jf1p6R9MJtoLwdok/goRrvO04s6XRh3
 PFK3nHa6piLRAseXJTtU1omogBgruKSaS086oXIkHx0ZPPt6HmYgY1vXbZjkUXFHZ8XKq6PG
 Q7sHtdPAsGvLLdvgF21dlcfO/gU8qcoPsSgfv/A2aixPe8mkij16AYPqI17zE+I8DJxD+DS2
 JNQidSRxAiaTHHRiFm7s8b4sZ9Jb3ceEyDsrEqsTJ4UfaB0cYsRXC2LKte02844qprjQX9e+
 3a8CllA1MLjKn/wJxTtmAZX00oQu3munyC1mid1nz8epa2axCXSwu7meXLrI0ZzTXJ5xRfpK
 Imw1JUBWVSwKhMujF2j7Fr7wK5SoOJ+KXPSSAFGZXq+I2ZnW6q2/r2MBqwHoLYhqyZKS6KRZ
 V6AS7jyiwQX2WXvEiNSySs6eDejppji10Yj0iTHdik19SefIol53l/H6cbZROJN0zZjJmEwk
 jTRClWmfpGo8diSi5bfo7W7XmOlWIdUdHqjxoeBuS2noGxyVEfmxbbpwIKhSFV8inyetZEiT
 yjDoRfib5O+0q27NbkiZUx0HBrn7NI8HIhik4w2jZVW2H4Ah5zT82BU9AW7edhdx6/6a2IAA
 DARxNuAqi3swk5+NTSkw4zjV3OS6tRsbZ+2bylFv0B1p9APE6qS4LFeyGFQq0C7sBmXTPxzh
 DYbxtMx5XRcj+xD629Phm2NR7sVG0dfJynlkR+Fusu/oKtgb2GqabGs1UB6kIPpHPSYrwpbQ
 nq8ZoY6EHo68JBkKFyVmi6WiMmsaJzKYNkUrBHRjxrQk70fNscqjvRTzSt/ZTCn5CdjkbRky
 0U0g9fj5tjAcTgInurxAwYEZGesPYVJoG6r1PsYxoHMgsiuBskzQGxRGsGyErTxT3RK8q64f
 weWTG9m8yjdRuCZRF7Frh06/zWVQvXJfzmWPCVLnY8kHUfAYhUC0UZMG29k1p8hSlLwnZOnL
 x0/vGhOoAa/8EQEy/o0ZUOmDSGA/kHxO21yFsTYdkQzjEkK5l+JY5zEqLstQmcCpMzn9VfVY
 m2DO1YYVydQBBHCXQu7eOP0rZzJ9+zSbganB93JZ7jG6elXVvPTgImqzpMj5DGUcMOGInhlC
 fQ/nEtFR3FwXcrDyX0JTGQMmiTBYtT+xl/08zBrrs257PXgWR7+rYqJBbxINNxz+hewya6dP
 u+UjSx9JH5WzJQJjXPPzbEe2hYVhUQMP3G1Fq8csCfWUK/KsqpQEgJddC55csdFruo90gRLJ
 c/Hm4b127p/3ZtXQx9OUV3snN3sZNRfeTjncgmdWwDSafLddlipi4ntbKixSKNdlrBRvhy04
 nOAFlP7ey+Ej3/vXgyuNudFiGeaOgZfscezaEUIayCrQdT4Zxm8KNIygycxxOh+o3rQNnMHd
 xV4fVlMqLK48i5SxPlyUT8kjDItPayfliCV4vONYI4RquduCz9omvhy5XMn1/1K4SsCSPE/y
 06w5pZ+5lqhlOeI0D9uVhFD/y1KiIy8tkJnIazF95NEVB4sEzoS4G/WBxlY/rON7/XwtqoWx
 tWdzMobyR9H9M/Iu9QRDY7YJZDfWEc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LVzR/K0cG3Zq20nEC1o14wqjBGwkLtp133Aq2lEZdPUnSL36qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:TRpmN21k86I6HuTEY+gbiLxfHtoEUEf66krqKUrpCThKFuWYEFnPwfYx
X-Talos-MUID: 9a23:iJP4FwuBJB264OfgQ82n1B0/LZZ0uaqXBwM/yIQAmeygLjdrNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54035310"
X-MGA-submission: =?us-ascii?q?MDEwa7BfSV1guMDIt45BjEs7bsfq45KAtaBb0X?=
 =?us-ascii?q?8gk7dJcI7710mA8T2HwbOJeXoiT6NFdUpInNezWr6yqsX926RxA4nDD2?=
 =?us-ascii?q?6x2Ru7zaopY30fS0p423do/69hzIwrIZ+LfU1X1ZgPvqyMXpzQayG98D?=
 =?us-ascii?q?Jip46c+c94Cq3qjejbuNByqw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 13:23:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682162620; i=markus.elfring@web.de;
	bh=/xMfBGw9N7vj8Q5A1+uk43jidlqCPlJIIQIgi27knv0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=kEPak5KR/0qsrA5wg5YfugSDBNjsh/9JmyFqQ7Bsod0oR55u/IsWMMbsCDNkpvJgL
	 8BkkE3qQH+ZijUAYg/XPLNiFhxyl9alOFzlwlwIrlgfh60JJdNefrCM14k55tA+9hx
	 pVeBNC4euDkm10tqAgFYGHqpI3JwQzDbCbjxn2AmYp1aphfB7tF4k9rGEo+7MRlUUd
	 7gintPh4ARlZRlbR/byx5lP56BVhJWYEwACpxgHtd0YCpGXq3WTBmxDLu88p0RrMkC
	 KY3UwIWkG3s4/Lh1dZWu/YZwGGF8/jWS3YJDolwpMJpL14l+Jhvjxwz15rLde4IGKL
	 vLtI4UmC+xgsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDQZ-1qPW9s3pv5-00awxz; Sat, 22
 Apr 2023 13:23:39 +0200
Message-ID: <549ec2c2-0833-7988-61f6-685f0fa22104@web.de>
Date: Sat, 22 Apr 2023 13:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <1f0089f3-3c8f-60e3-5520-f7813093076a@web.de>
 <alpine.DEB.2.22.394.2304221104340.2766@hadrien>
 <531d1abc-1023-a5ae-2a58-06dd52b26643@web.de>
 <alpine.DEB.2.22.394.2304221200090.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221200090.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:il7RogmWh40u5hdrA0zWHKwk87/VjXKGeTzKoAt1sAgeUbak4kr
 em6Q6jZoOY2awBzdvXED7nqxPBH/GnSEa/ENYcHlEAL/2K456EW5xcdLlj52sLZ7/T5bDo/
 /J4Jz0r6zhdP7KxKFNQ/4uaDthqHEpI39KjgnUXhFfNYZ2+/l+w2rjTQ8cQgmepwwIAT5rL
 E+tohFqMbmcbnwZNoUyng==
UI-OutboundReport: notjunk:1;M01:P0:+yN+cgwebgc=;zJgTSFWOUWBcg/pPbkLxyRicCLU
 9TxWJpXz7sioQkDJGblyGwxJLrXBpVu7xZHvg62C74xFrBKZ5S9h8plTB0JUdm/csOR/b3d/Z
 bfgxUTP7W2Mrr2ua7XfsK1Tb2e3jMJa7WoeipIYgWoL/UsxJ8yqFYFMhCg2C2fQNMebRzcFAS
 mE+MJ3xc5genqksMSNXzch20YVmV9t1LP9Y2I4jHBSSO2lsJprmht/NRstnbPQYxsKHFHXKgv
 XdfZ3ZTlJDEKpRVe8Paz3RDWTBtiEKikvaC1mRFK8olDogzkk1u2oW10gS9BB0DAHAvms0+jG
 L5CC7V/AWuOCasNism18IGFYZjASDsPOB9qSN6zg5yMZQyBVVW3TykgdKL8IlE62h5JOewMOC
 kvDg18ALG7EHUFZCtiNzexR/MFDHvwFpT9/vvNFiVGi6f89CX3Gqg/eO3sCtzyJvFXuBt9Mix
 ytAwamgI54wYtnb2TGMcsXdVV8ShxFIES1n02z9gXhNf25nzxtERJukEoHKC24PpVyHIwS9sx
 UJZEmlbeQiRvvdwhsIB78hqjMr874O5IM6E3Sgro4DX3LjdM02N57aOpt3SwkUUdr4JI1rub3
 +ZvhXiOEWGdRBhjbDePHTgKkgBtdPslLQHJSyCw9PLPu5Sg+IgKCTROkL3g/wkC6j5H/TBvhb
 sIyEuxIEbordVC/4Tcol+vv1mONK6xkQxtlMGsEYKcTONAThpXvH1P6sfUoKgQb7PSq1R7Gfk
 kdb/+T4fvMjkfNqCTx43KTjUzioiL8k65U8HKksgDuW4iRatBNr6jpCk+Vio4n2BenNRaMgUn
 PXDbbza46Nl10wi1unhcaSD/fKb5ALC9+fYJJgGlSaDUW9OErTTJDANzLLkFfjI0cTQqfQ2Oi
 CjyP2qI2Y2Mypx7Gfm+2RnXV8JILczuD2+wubvdUxMJI0kWiJtI1JumkgsL56BnhmzgLPGUpo
 nHQfHtH4ZdMjP2Ad7qL0BrBYDJI=
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1114
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/549ec2c2-0833-7988-61f6-685f0fa22104%40web.de>

>> Under which circumstances would you understand the presented data misma=
tch better?
>>
>> I got the impression that the usage of an SmPL rule like =E2=80=9Cselec=
tion2=E2=80=9D
>> influences the control flow in an unexpected way.
>
> I'm looking for 1-2 lines of python code,

Do you find it easier to interpret the affected code in smaller steps?

=E2=80=A6
@find_update_candidate@
constant char[] input_string;
expression input_context;
position pos;
@@
 seq_printf@pos(input_context, input_string);

@script:python selection2@
=E2=80=A6
param << find_update_candidate.input_string;
pos << find_update_candidate.pos;
=E2=80=A6
@@
sys.stderr.write('param: ' + param + '\n')
match =3D re.match('"([^"]+)"', param)
if match:
   content =3D match.group(1)
   sys.stderr.write('content: ' + content + '\n')
   if (len(content) =3D=3D 1) or (=E2=80=A6):
      x =3D "c"
      =E2=80=A6
   else:
      x =3D "s"
      =E2=80=A6

   coccinelle.call =3D "seq_put" + x
   sys.stderr.write('call: ' + coccinelle.call + '\n')
   =E2=80=A6
else:
   =E2=80=A6
   sys.stderr.write('include_match(False)\n')



> and 1-2 lines in the .c file.

Example:
=E2=80=A6
	seq_printf(seq, "]");
	seq_printf(seq, "<>");
=E2=80=A6


How do you think about to avoid undesirable communication difficulties
by the means of an ordinary telephone call (or even a video conference)?

Regards,
Markus
