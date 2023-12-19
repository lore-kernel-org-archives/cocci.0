Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF08C41535
	for <cocci@archiver.kernel.org>; Tue, 19 Dec 2023 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O6jyalgviahG+aKvI9Lxsu1A9ueHYDvOIsACLJkPhtc=;
  b=JUgNM3mZNrhfP1Pbk3s4RSzbYU73FviPF1e9EQCa9UD43LJrqW7QNhqE
   Evh3z+p6Q9t5knC+a9aZgpQtXlnUziZrfIq/aNOksALWh+Xhusp0X3QuQ
   zI2a2H3fk8GZAcfSdScnGTcsrRsdKNlnSVrzkqtVSnSeRIDHtT2Y4vMpv
   A=;
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
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143156133"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2023 16:33:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E471E0CD2; Tue, 19 Dec 2023 16:33:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 41BCCE004E
	for <cocci@sympa.inria.fr>; Tue, 19 Dec 2023 16:32:58 +0100 (CET)
IronPort-SDR: 6581b7ab_b9nYhH8udeT8zeH3Ib5FsqvIZwHwDsuNNWQtSWNuJbOlrWQ
 OvVIKsEHreVSi7IJ8w9jyTN3fbG0mgrfKac1YQQ==
X-IPAS-Result: =?us-ascii?q?A0HvAwDqtoFl/wsR49RagQmBT4I5B4FLMAQLSIRTj0GBd?=
 =?us-ascii?q?TCEO4c1h0yEa4QEgVaBQD4PAQMBDUEBAgQBAQMEOIRHAoc0Ah4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglwBEIEMgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdCBiMdAQERJgEPHwEFAiYCAlcGARICAQGCf?=
 =?us-ascii?q?IIrAQMxB64ogTKBAYIJAQEGgmasch8sIlaBYAmBGi6IGwGFZoNAeicPgVVEg?=
 =?us-ascii?q?TwLgzaECoQUgmiDZoU3BzKCHINQkgd9BUFwGwMHA38PKwcEMCIGCRQtIwZQB?=
 =?us-ascii?q?CghCRMSQIFggVIKfj8PDhGCPiICPTYZSIJaFQw0BEZ1ECoEFBeBDm4bEh43E?=
 =?us-ascii?q?RAXDQMIdB0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMAUNHAIQLCcDA?=
 =?us-ascii?q?xJJAhAUAzsDAwYDCjEDMFVEDE8DaR8yCTwPDBsCGx4NJyMCLEIDEQUQAhYDJ?=
 =?us-ascii?q?BYENBEJCygDLAY4AhMMBgYJXiYHDwkEJwMIBAMrKQMjdhEDBAoDFAcLB0gfB?=
 =?us-ascii?q?gMDAwIhAwsJCAMZKx1AAgELbT01BgMLGwY+AqYSfIEOcoIEknCTF55xNAeCN?=
 =?us-ascii?q?IFggWEMnyoGEy+XJA4GklEuh1CQTSCoPYFjPYFZMxokgzZPAxkPkkuPR0A1O?=
 =?us-ascii?q?wIHAQoBAQMJhUYBAYMmNIFBAQE?=
IronPort-PHdr: A9a23:+XwRCBdWczNvrLWjRvqdRUVrlGM+CdTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWZG9+Cs7kb16L/iOPJZy8p2dW7jDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajYr5+N
 gu6oRjNusUZg4ZvJbs6xwfUrHdPZ+lZymRkKE6JkRr7+sm+4oNo/T5Ku/Im+c5AUKH6cLo9Q
 LdFEjkoMH076dPyuxXbQgSB+nUTUmMNkhpVGAfF9w31Xo3wsiThqOVw3jSRMNDsQrA1XTSi6
 LprSAPthSwaOTM17H3bh8pth69AvhmvuwJwzJLVYIGNNfpxYKXdfc8BRWFcWspdTjFNDp+gY
 4cKCecKIORWoJTnp1YWrhWwCwajC+3yxDFImHH7w6M63OY9Hg/JxwEgA8sOvW7IoNnpKqsfU
 +a4x7TIwzXZaPNW3C/w5o/SfRA7ovGMQKlwetfex0krGQPFlFSQqYrqPziI0ekDtHKU7/BjV
 eKykG4rsQ5/ojyhxsc2i4nJgI0Vx0vK9Cpn24k5P8C3R1BibNOiDZBfuD2UOZFsTcM+X2Fnp
 jw6yrsetJO1fyUHzIgqyhrRZfKHd4WF4BDuWfqeLzplh39pZLyxigiz/EauyODxSMe53VhXo
 idBnNfBuHEA2gLQ58WZVPZw+Fqq1zWX1w3L9O1IPF44mbDFJ5I/wLM8jIcfvEbZEiPrhUn6l
 Kube0o+9uWm9ujreLbrq5+GO4JwigzzNLkll9K7AeQlKQgOQ3aU+f6h2r3i/Ez2Xq1HguEwn
 6LEqp7VP94bqbS8AwJN0oYs9RK/DzC+3dQdmnkHMU5FdAiJjof3IF7COu33Aumnj1Stljdk2
 ezGM6X/DpnQMHTPiqntcah/5kJG1QY+z8pT649JBr0ZJfL8QE7xtNjWDh8jNAy0xv7qBtJn2
 YMEWmKPH7SZPLndv1+M6OIvOeiMZIkauDvmJfkq+eXhgWUkllADZaWp24AYZ2iiHvt6O0WZf
 WbsgtAZHGsXpgY+VvDliEWeUT5PYHa/R74z5jYnB426DIfOXZutgbyE3CejBJJafGFGClaWE
 XfpbYqIQfkMaDjBavNmxz8JT76sT8oj3BevqAjg0JJ5IefOvC4Vr5Tu0J5y/eKX3Tg0+SZ5E
 Iy41HuRSGc8ymoLXzoe2KF5vFw4xFCe16Rxn/1fE5pU/fwfFk8VL5PTh89gDNnyHyLIZMuMQ
 VDuFtq8DD4yTvo1wtkTc0h6BtOuhwzC2CzsBKUawfjDTqY9/KvR2zDTYY5C2m3B36ogxRFyW
 MJBPGCirq1y7Q7eA8jOiUrPxIiwcqFJ+SfX93qYhUeKsltZVgE4BYDMR3MCfQ37qdrj50XNZ
 6CjA/IrP10Smoa5NqJWZ4ix3h19T/D5NYGbOjrp84/RLROBx7fWKZHvZ31YxiLWTk4NjwEU+
 3+Ccwk4HCao5WzEX3R1DVy6RUTq/KFlrW+jCFcuxlSvZldiyqHz1xobn/2aRNsM07hCtCpy4
 y5sEgOF1snNQ8GFuxIneaxdZd0n51IS8GvDtBFmeLGkIbpjgFE2bAl9+U/jhF1sEosVt88so
 TsxyRZqb6KV1FQUbzSDwZX5IaHaMEH3+w2zLbHb0BfS3b56448p7/I14xXmtQCtTA859ml/l
 sNS2D2a74nLCwwbVdTwVFw2/l50veOSZC51/I7S2XB2VMv8+jbfx9IkAvckwRe8bp9eNq2DD
 gr7D8wdAYCnNuUrn1Gjah9MMvpV8eY4OMavdv3O36DOXq4ouTu8jnlcpq153FiN8SVUVePCm
 ZoIgrmZ0gaBSzbgnQK5qMmk0YtAZDwUAi++0X2+XdQXPPctO99UTz73cKjVjp1kipXgWmBV7
 gumDlICgoqyfAaKKkb61ktW3FgWpnqunW25ySZ1mncntPn6vmSGzuL8eR4AImMOSnNliAKmB
 IGujM0BGmWsYRIokhSN+kvwgaRW7vcaTSGbUQJTci76Ins3GI65rLmfeIhi7J0ysCNYePuxa
 xaWR/SuxnlSmzOmFGxYyjchcjissZishB12hlWWK3NrpWbYc8V9rfvGzOTVXuUZnj8PRS0iz
 CLSGkD5Jd6iu9Odi5bEtOm6EWOnTJxaNyfxn8uMsy6y5GsiBhPa/bj7v9T9EhUhlwL/2cNrU
 yrgsxv2JIXmn6i3KuNoeEB0CUS0sZMgXNskzc1p29dJgDATnd2N8GACkHvvPNk+u+q2d3cLS
 TMRgpbU7AXjxEx/PyeMzoP9WG+ax5gpbN27b2UKnyMlupoTUuHOtuMCxHQz+wPryGCZKeJwl
 Toc1/Y0vXsTguVT/REo0j3YGLcZW09RIS3rkR2MqdG4tqReImi1It3SnAJzm86sCLaar0RSQ
 nH8L90HFDVz8945HVbCynz15an7ddOWYd9Z5Xj221/QyvNYLp48jK9AoCN9On/m+1AhxfQ6i
 xNGwpyw+oSKYTYInurxEltTMTv7YNkW8zfmgPNFn8qY6IuoG41oBjQBWJa7BeLtCj8Zsu7rc
 hqfCDBp4GnOAqLRREXMjSUu52KKCZ2gMGubYWUU3ck3DgfIP1RR2UgVRGloxMdjUFrwm4q4K
 hk/v2pBoQSlz3kEguNwa0ulCz2Z/l33LG5pDsDYdkce7xketR2Ma4rEtL01Rn4eptr780SMM
 jDJPV0XSz5THBXVXRa5Yunpv4ilkaDQB/LifauUJ+zQ9KoHCqbOndX1jMNn52rebJzQeCY4S
 adjhQwbGiomU8XBx2dVEnNRyHiLNp/B4kngvXcpy6L3uPXzBFC/v83WVeYUa48+vUnt2e+CL
 7LC1Hw/cGgFkMlXnTmSkvAJ1VoWwUmCbhGLFrIN/W7IRaPUwOpMCgIDLjl0P41O5r492Q9EP
 YjajMn03/h2lKx9DVANTlHnlsyzAK5Ca2igKFPKAlqKP7WaNHXKxc/we6a1VbxXiq1dqRSxv
 T+RF0KrMC6EknHlUBWmMOcEiy/+XlQWoIambhNkEnTuVvrjbQCndsB6h3s6zPx8h3/HM3IdL
 Skpc05Jqe71j2sQifF+Fmpdq3t9eLPdwWDDtbaec8lQ6KI4Z0Y83/hX63k71bZPuSRNRfgv3
 TDXssYruVat1O+G1jtgVhNK7DdNnoOC+0t4asC7vtFNX2jJ+BUV4CCeERMP8pFAA8fsprsW5
 9zBjqP1Jx9d/tiS8cZWVK22YIqXdWEsNxbkAmueFAweUTuiLn3SnWRYl+yOsGKYpN42p9K//
 fhGAq8eX1szGPQAD01jF9FXO5Z7UAQvlruDhdIJ736zxPE0bNpXtNbLW6DKaR0OADOekKUCe
 BYCh7/1f9x73mLTxEFoLFV3zt2iJg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:V73UPqFiYWRBeZ2OpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:EmTIwW8p2WQp6X8BYqiVv2A4BJk4QDqD933RMmu5CWA0aa2zEGbFrQ==
X-Talos-MUID: 9a23:ZxfRQwmDoZm2SB5Z90c3dnpMMPU36qGMMHoJstYe4I6qOHVcPDOC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143156114"
X-MGA-submission: =?us-ascii?q?MDFlfOk/foAxmKGHkpwhzDfeUIjhdROFr2SvLP?=
 =?us-ascii?q?q2mvJpnVwt2L5GXh98ts5gMupkUCl3SdCxBwUiLOGACaHy0zlnkMWgZ+?=
 =?us-ascii?q?O6HWkI7FJOPUfJTVb5U1o99aM/32bSlKyKlnQG04bQvsg1cXXpTJqRfd?=
 =?us-ascii?q?d+sdZDC4lEy7Xdz42AlWo1rQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:32:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702999969; x=1703604769; i=markus.elfring@web.de;
	bh=tn6Ij30L4nzJk1aQGY/PqCDgEqVZBUaPZ1LpxACXJwM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=rReFhxAzgTkMWDA0DJzIQ8OD+hMHBfwo7o9LSN3BWD16842g6PnD6VDyASqxtAOX
	 kzxI+w0WfT+kRlp6JgVmzizSUH2rPDEt/xg8/5f+6Sv0yUI2WJa+gHjnhafE5T4f9
	 jkWttkRDCxS4qw6nuYjonHnrYuyfAn7TUPaSvWJgDWRd/UvjZutQv0hV4DEp6O1Am
	 wkAD8NrJx9w4b3NUp7AvH6/Bder6I7rcHPHhgu64zurZgACNf9Gu2SCSJh8mCghEi
	 l56fXmmGw5X6AVz8gJzX1QpQHxdOjPx8mCTwyBnG9xFE3SI15i0GbzUC6XtHj4vk8
	 HZo20+PBIlJ4Vmr2Yg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1rarCZ3qhj-00LtdG; Tue, 19
 Dec 2023 16:32:48 +0100
Message-ID: <6d7d0b33-6c9e-4941-af5f-678137d2a00e@web.de>
Date: Tue, 19 Dec 2023 16:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
In-Reply-To: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RZRPQpP5gRDbecmiyr/GE+SRHU+DXgMz5lHrrQB7DWJnkoOjyg2
 K30sKLY3bstzCh5sNb9u0n4vzpJnhUf3kom/Wvx0HiUSDBLP/DO7VaZYeafo671XrPyWciw
 vnfG7mDdhrRdfw+WkhapcjKAdsrG1QCGE4hUp94NKfmfRkMTqGhQPG18A2MvI8yCeMzRjRI
 u6JZvVNqlOSj0q7C62FXQ==
UI-OutboundReport: notjunk:1;M01:P0:hcQw/9bQR1o=;HL5Pf2hLEmDWinV+zatF7bP3R1l
 +kQw8rd9Ep4QCKYhup2nx2GEs6mb4obohDmH05Ff7ymBibhqU75K/r1lDdPKwVTaap+GgE7fa
 ahM3XHFEN19jDllEy0YPbts01U571bzGRy+KUVH0/j07X8YPmKXATQdx0xkNsFgFu/oSajBZ9
 bUBBxJzIlwt28c+qKdhBZFyiuggTu136gxqiFxutDLJu0OXwJ4vp0p+CBgVMQ+cTXHY2QfD1K
 hOsxTGIV7vP6C+hzdjzCEZWcVV1dM2jUcxjFWnY/hChFlQkAFOYH4aQo42zt9IQU7ODWHAzo3
 C9wrGnoskFEHPlPNM/n6Z0jtPxze2pyFEdFHajNvKCZqaaYUL7I7wKaSzpBsrbaNBapRVXv4D
 0XMBurnDW1b/QHYH3rxtnIDnBaozZIoCcjGTeiEn9Eh22DL4h0M6sVJGVeL+oDIAAGKxv8bz/
 KAzNT0Ff0LTZkFyt1JM82B7JotEeNNxZMLVVn5PwVWAbv9qwRecwYDRbDYMdsWERe3OOYlYTF
 2Hy8CKPTtG2U4bbxPM2d0Fa5pl7FjmjjYg62ss7mIriXM6t+Y+ABM0Qjaxm/4VQowKJnTvXSF
 anDFUWazBxqP28/kFUWDl0de3tr9FJ5//nd3f0jcEu6S5Qd0XjHXgCZLb2j0U6JjNl0oNtbZa
 ZCrrlWFpJ/VwPQrdk9qYKP/RBD/+hWF9UDOYo7xVbNsi3ksjyyyegMUr0oJJlH8msgy9gCkC6
 fbkJl+z7MQh6aVk+Cp+7KTIPH44BlvoZVWHkzVgbyyIBY1ioaZfly2BsuZwIuwu377GOT7fvN
 YSxxZRsj/hCoCfUT1jYoPFhPOWtYcXWTmnxSR1yPdorA3rWvWROnMyhJTWp8hbYSJOfVWGrff
 zMsIlecFJw0T1ATQMzmvVwcMBUmWSuxicVTLpK1Faj3W9jWpAnUrqL98Pu5d78Jj4eSBklaGU
 N3qjuQ==
Subject: [cocci] [PATCH 1/3] kobject: Add a jump label in
 kobject_uevent_env()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1349
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/6d7d0b33-6c9e-4941-af5f-678137d2a00e%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 14:16:35 +0100

Use another label so that a call of the function =E2=80=9Ckfree=E2=80=9D c=
an be avoided
after a failed call of the function =E2=80=9Ckobject_get_path=E2=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/kobject_uevent.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index fb9a2f06dd1e..811e579ed89d 100644
=2D-- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -529,7 +529,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,
 	devpath =3D kobject_get_path(kobj, GFP_KERNEL);
 	if (!devpath) {
 		retval =3D -ENOENT;
-		goto exit;
+		goto free_env;
 	}

 	/* default keys */
@@ -623,6 +623,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,

 exit:
 	kfree(devpath);
+free_env:
 	kfree(env);
 	return retval;
 }
=2D-
2.43.0

