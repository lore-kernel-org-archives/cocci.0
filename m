Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD458C5478C
	for <cocci@archiver.kernel.org>; Fri, 23 Feb 2024 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q8axwdP1EpsiDss5Gd5ukYvhNkl+VbXDjd4g+nl2IQ4=;
  b=MnKkZ4pegjuU0MvPIp7GYh0x4kXYEpdLV2Y02lw0ZAi8uV5g8gYNYmnE
   V48+Ypk6VmX32KC0Tj6LiddcCn4vRNMWd3js/Hy+clxet0ChdZHHvdkWs
   sU2gdrieGrf+bUQdT6uxQE6WXzVabAwc3e3ejQPh+5MMxbvLPEJi2Jmqh
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153409812"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2024 08:53:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22374E0CD6; Fri, 23 Feb 2024 08:53:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 16EA0E008A
	for <cocci@sympa.inria.fr>; Fri, 23 Feb 2024 08:53:01 +0100 (CET)
IronPort-SDR: 65d84edc_o/3/NPFcDzpClMSXMQePAjQ2Y3KpZNAm5JqfEV6Gsyy2dby
 VDwj1so1bS+99F8nYrFxzdbH4ZMIN50LQW+M9wA==
X-IPAS-Result: =?us-ascii?q?A0H3AwDITdhlhw4P49RaHgEBCxIMQIFEC4I5Yh1TMgQLS?=
 =?us-ascii?q?IRTj0SBdTCEO4c3h06IcIFWgUA+DwEDAQ1BAQIEAQEDBIR/AoduAh4HAQQxC?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsD?=
 =?us-ascii?q?YJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQQECAgEjHQEBEScPCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgnyCKwEDDiMHsU6BMoEBggoBAQavXB8sIlaBYQmBGi6IJgGFb?=
 =?us-ascii?q?4Q8Jw+BVUSBPAuCRzE+hEODW4JohVGTYIcLVH8cA4EFBFoNGxAeNxEQEw0DC?=
 =?us-ascii?q?G4dAjE6AwUDBDIKEgwLHwVUA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJA?=
 =?us-ascii?q?hAUAzgDAwYDCjEwVUEMUANnHxgaCTwLBAwaAhsbDSQjAixAAwkKEAIWAx0WB?=
 =?us-ascii?q?DARCQsmAyoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxMHCwd4ggmBP?=
 =?us-ascii?q?QQTRAMQgTSKJgyCSAMZKx1AAgELbT01CQsbBiIBHQKhSIFuE4JLHsUtNAeCN?=
 =?us-ascii?q?IFggWEMnzgGEy+XMQ4GkmAemDsgqFiBZQE4gVwzGiSDNk8DGQ+OIBmEFI9HQ?=
 =?us-ascii?q?jU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 /DKk7/vbihP+ZTY8JlEbyAxAN2KOjwtPEixcAM=
IronPort-Data: A9a23:WU+qhqwUK9daKRXm7JZ6t+cPwirEfRIJ4+MujC+fZmUNrF6WrkUAn
 DNJCmCEPf/eZmb8e9t3PIu29UMEvZPcn9VjGgFrqFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjg2Ac3l48sfrZ9Es15q6q5Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPR4dZRUkoWErE4695TUDFH7
 /sDASE0O0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4YEtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QF8w7N9PVmuAA/yiRs0rH0O9PoaubaG9VtmR2Xv
 kXX3mTmV0Ry2Nu3kmbVqin82YcjhxjTXIsNHbm83uxrhVeJzyoSDgcXXB21u5GRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9kbKyzu7JVdaRR5uVPw3jOtnFTUw0
 USgjuq8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4oe0tvYmLTGYb0EynczpzLJNZmOEZDhnc7
 li3QMUWgrIOkYgU2q/98V2vb9OQSnrhHlFdCub/BzzNAuZFiGiNOtzABb/zsKkoEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AE3T8d7qWrypifzJui8BQ2Swm82bK7onhe2P
 SfuVf95vscNbBNGkIcsONzqW5hCIVbIRIm6DJg4keaikrAqKF/fp3ExDaJh92Hqlk832boyU
 ap3gu78ZUv2/Z9PlWLsL89EieFD7nlnmQv7G8qnpzz5iuD2TCDOFt843K6mNb1RAFWs+1mOr
 L6y9qKil31ibQEJSnKPr9ROdA5SdSZT6FKfg5U/S9Nv6zFOQAkJY8I9C5t7E2C8t/ULyLX77
 TumV1VGyVHyo3TCJE/YIjpgcb7jF9I3534yISVmbx7i1mkBcLSfyv4VV6I2Wr07q81l7/p/F
 Mced+u6X/9gdzXg+hYmV6fbkrBMThqQqDyrAzuEexk6Jp5peBzI8ITrfyzp7yg/MRC0vsof/
 Zyljx3XcaMeS15cDeLTUvaOzkywj1cZiuldT0vFGfgNWUTOoaxBCT39se8zGO4IcS78/zq90
 x2EJDspvszfitYR3PiQoo7ctKavMe91PnQCLlnh9bzsaBXrpDuy87FPQMOjXG77Vlqt3I6Ae
 O8M7fX3EMNfrWZwq4AmTopal/Mv1eDO+Y1f4B9vRkjQTlKRDbhlHHmK8O9PuoBJxZ5boQGGY
 V2OyPYLJYS2PN7ZL3BJKDoHduij0dQmqgvW59kxI2T443ZT15iDWkNwIRKNqXJ8KJ1YDYAb+
 toi6fUms1GHthkXM9i9nn918UaIJSc+SKkJjMwRL7LqrQsJ8Wt8R6LgJBX42qzSVOUUAHIWe
 meVoIHgm4VjwlHzditvNHrVgstYq5c8mDFL614gfGa2u8f3qcI2+DZz8j0HaBtf4Tsa8uB0O
 0ltb1ZUI4fX9RhWpcFzZUKeMCAfOw+85WrK1EovqG3Va2KKR179BjQxFsjV9X9I7l8GWCZQ+
 Y+p7VrMUBHoTZnX5TQzU0s0kM7TZ4V92SOakf/2AvnfOYcxZAfkpaqcZWAojR/DKuFpjW3lo
 dhaxspBWZfZBwUx/ZJiU5K70I4OQi+qPGZBGPFt3J0YFFHmJQ2d52K8FFCTSOhsedrx7k6KO
 +5/LJluVjO/9hq0gBI1OKouG4JwzdkVvIcsW7WzPmMXkaqtnhwwurLqyyXOrmsKQdJvrMUDF
 r3sZw+ySmy9uH8FtFLO/e9lO3W5a+YqfAfT/v6428RXGoMhsNNDS1AT0Ly1sy+rMS9ixRa1v
 RzCVYDS3edN2YRhpKqyM6RhViGfC8L/a/SMyy+36+9xVNLoNdzcki8osXzlAlhmBqQQUNFJi
 ri9it7780fbtrIQUWqCuZ2+O4RWxMe1Bsx7D9nWKSREoC68R8Pc2RsP1GSmI5hvktkGxM2GR
 RO9WfSgZ+wuRNZR631EWRdwSy9HJfzMUZ7hgieho9CnKBsXi1XHJez6007ZVzhQcytQNqDuD
 gPxhe2V2elZi4ZxHz4BOeBtBs5pAV3kWJZ+TebLixujMjCKjG+B65zYrjhx2QGTXzPAWIz/7
 IneTxfzSAWqteuahJtFuoh1pVsMAGw7neA0eVkH9sVrjyyhSlQLNvkZLY5MH6Q8fvYeD30kT
 GqlgKoe5STBsfBsdBLh/JL8Uw3ZCuFm1hIV4NA21xv8Vst0LNro7HhdGuNI/Hp8PDfupA1iA
 c9L4WX+Z3Bd3bkwLdv+JZWHbSNP2f7QgH4Fkaw4fwoeHD5GaYg3OLdd8MahmMAJ/wwhVKkGG
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:7qmIxq5AS64d0lEHFgPXwBbXdLJyesId70hD6qkDc203TiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:5Ps8xGzFtD5f3UrMFlosBgUpOOMaLHb940vwMnecWDZgUrqOYE6prfY=
X-Talos-MUID: 9a23:8le86QRqHzWLg8a4RXTxhjh7P85V857+VlA1ls4Jo+6VFCxvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153409793"
X-MGA-submission: =?us-ascii?q?MDHNIHonnywScTF7icDyWvmDia7XtTvysI9hr8?=
 =?us-ascii?q?VMo1XOVmEgoyb72OpLS3Xjz8Pg4nEGoziGDYKUfwxNaidrmxNdga9B+o?=
 =?us-ascii?q?VqCLnRR4Dk4eduPdY3+h6Zbz+45Onub+Il2NLzOMYFx0iAVKlr1DcgLO?=
 =?us-ascii?q?fiZ1dIs5RbLkps8ONOC8wZ5w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:53:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708674780; x=1709279580; i=markus.elfring@web.de;
	bh=8FRN8KygxLs9T7/Ewv9WzvLh2i4pTtaTIiN6eW0F3Ts=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=vc84IQBmOLFhUJexHyfrrXxOJerl8mqnigne4hRWMFWxz7cHrXsh4aQfDYf5jpij
	 sb13hu8kTVeegDAyiWgczv+pWlrdthbc2MTXr7boPSZ57KR/e/zWfhkS4bHRZGkkM
	 55SF/RSl3+/YJ8SNm0IKUM5gR89tPwRvxm8MZJse9gIusdPN9X73I5qCGCftt8SIz
	 pgo+VCiWlanUoIMWh1YsfG5XGYAPveihIJJqtO5s9dPLESdQX4SuYqCmBjtzevjf8
	 s3Wg8qtvJqXmP9zbcwLx/5OW6DkvMB0XU+NA6iOW3F1jsOAGTeu1V3k7nEM3b34WQ
	 /io0H2dBwzDOd4JHNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGSU-1rmo253ph4-009YUd; Fri, 23
 Feb 2024 08:52:59 +0100
Message-ID: <e3d5d5ca-ab22-49a4-8483-75e35a88446b@web.de>
Date: Fri, 23 Feb 2024 08:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <784320f8-7731-47df-be6f-9ddc71c20d61@web.de>
 <71f51659-e163-abfd-7f96-fb6f40e0117@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <71f51659-e163-abfd-7f96-fb6f40e0117@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sL5df31bhiu/Z98UOusplZG216aNMeUzXJoX0XpNk3McIroC848
 FFi4LO+j2CVwOo3fTu1c1YkhoMOHDUvDRYGIZJpMpfMImoCfQuglLsFF00q+KE2E6kqI8Kt
 o7Z1SbSeC/zoN2onSq9byzPl2d7sEp7X7WHQHeK0Usf2ksnjyWjSaeEXKiCzWxtNRLUHz02
 OQjQWTrMQcaYGLZCwOZ6g==
UI-OutboundReport: notjunk:1;M01:P0:MtEWRiEji4Q=;sQRhlPMP0w4WYfIApioFWLkVxcM
 yzu1dD/4SP4xmBXVbfSfQ/nL5q9Fk5l17jyIlIOHZ6kqupFX6fnviYTWDdUTqBg2Wm2yz7lHf
 Gt1amVudUC+ZssX8rIctH4RG6mBsdLnrbet2NL0Ah5Wtv9huB4OH1aKTvP1TvAqa5STp79YTB
 LOHLaAmM4zdkHaKGz8E0R6r2YMgB7dx29XGe8BJIm4yKJyq5W/KuqNq20p6FD7JPpeEeg50FQ
 Egk29cNTVRTPlYXkMkrEGtHku/nRLTmo38WQYSg/LVQ7pr/m5eZO5NG+yh6nIyz4C6Rn9CE5A
 MiXbzec+3jPEpRahXTwgILefzBK/Oe5mYlAeZNSZUpPChAMywYMDWmgd9FsdPZjYrX6R04cBq
 QIXNuQVzMYOmUDEySL2ZY5wx081GJAerYVF17Rqcb17a8yiY8XKxt+oshpDoEqsvwzJ+m63VX
 4F1NpHBPn/Xn5Urm0Jsd/PdQx/pwTS1vTAN19whQXaCpGt6xbe1MRqnQUlq19Frm30dqh/eEu
 +tgc77iZ79rDpuQ474b2cM9KoSz0Cz7Ze1xtuv3KwDbw/RUOzF2JB8Rqxv15SD09UyyCyxjMy
 Kot777XY9EhCAJGH857MBWupIFoKMmx18zICIqN+s/V2bGP9/j+e1pAVCdyqyVpqU0xO6CXWY
 eYUIiC0sV0nCtCXoibqodzKJPNrZOydiqCHaIbpcUgWx4B5V/r6KI5qO/k8Jtv+0JCHHIYo/A
 sPnLRF6CYHZwljStCLUSC/4X2Uujk+abGsRXXb2pOJiMus+gmYHyb1AP+ZLGgCX7ptSvVjBvY
 d2+yrVKKDAGG3fif96X/6eAJYSJK4Ost6BQcVl6H0I3UM=
Subject: Re: [cocci] Using inherited input data for SmPL script rules?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1600
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/e3d5d5ca-ab22-49a4-8483-75e35a88446b%40web.de>

>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --pars=
e-cocci test-inherited_input_for_script_rule.cocci
>> =E2=80=A6
>> scriptmeta: semantic error: bad rule second_search or bad variable id
>>   File "test-inherited_input_for_script_rule.cocci", line 12, column 21=
, charpos =3D 161
>>   around =3D ';',
>>   whole content =3D x << second_search.id;
>
> You should have inherited it from where it was defined, ie first_search.
=E2=80=A6
>> Can the application of input data become supported for SmPL script rule=
s
>> even if such data would be inherited by longer SmPL rule chains?

I am looking for extended data processing support.

The second rule could also specify additional SmPL constraints,
couldn't it?

May SmPL script rules depend then on search results from a previous rule
which references also inherited metavariables?

Regards,
Markus
