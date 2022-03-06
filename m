Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14056C433EF
	for <cocci@archiver.kernel.org>; Sun,  6 Mar 2022 13:43:46 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,159,1643670000"; 
   d="scan'208";a="24626608"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2022 14:43:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02738E00D3; Sun,  6 Mar 2022 14:43:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 13A64E004B
	for <cocci@sympa.inria.fr>; Sun,  6 Mar 2022 14:43:42 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: C6KwRof1PnALCD+cR+qdBFsygqiWc9ewEPikgzT2nkZxUmw3ZazTr3NRMlffEYX58sjlwPihLH
 mHuyx/WuFeXE0og0QIfF0tI3vYNBUbz7dtUorhaBYiH0JB3nIl9BebGXnmYJj12qtC5a7LKrtU
 0DXBrMv6pPr6VMr4Sy1odm0hX1pHsuF9+qJkxJTTLvExgePjaYu32kaSktu7MO/ZBGGm580fym
 CNVVokJZTfBmBr+mqXfWXncioM8gwVO+SlFF12IxLOB3Qcb+gR37OsJZwDU10gHpNRXd0SvbZN
 XRzdtRqIr2gR0WgZ2wELEA1k
X-IPAS-Result: =?us-ascii?q?A0AVAQCPuSRihwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKIFVKwQLRIRUjnOBdzGLI4cWjCILAQMBDT4BAgQBAYQHgQAChBsCHQcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjBBEIAQERJgEECwkCDgwCJgICV?=
 =?us-ascii?q?wYBDAgBAYMAgmUBAw0lkCScDH8ygQGCCAEBBoRIHywiUoFbCYEQLI5IJxCBV?=
 =?us-ascii?q?USBPIJTMD6HX4JlmWlyv200B4ISgTqBQAueCwYULpY4DgaRXpZVIKZZgXiBf?=
 =?us-ascii?q?jMaJE+CaU4BAgECDQECAgMBAgECCQEBAo4dGR6DboosQDQ4AgYBCgEBAwmFR?=
 =?us-ascii?q?wEBjDYBAQ?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23:JMr2ca0+6no15NACePbD5fR3kn2cJEfYwER7XKvMYLTBsI5bpzcPy
 WUeDGvTMveMMWqnLooibdzn9UoEvsTTxt5gTARr3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jV5
 4uryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt/d89
 ulHl8eXcg4gG6Lqu7w/AjVSEwgraMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBoKAtWz4Ir
 KNecWplghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrGfmUv4EGhGhYasZmBPH6b
 OsQShBUfQ3mTTIMAHowVYkRg7L97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl0z9Cw4TMNi32zuA+GilwO7JhyLyHowIfIBU7dZvh0CPgHMeAlsaWDNXvMVVlGaZVuxjI
 W5P3REnpI090m/zbIjRVR2R9SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVsctKnQIN+3CPRbWNwv
 mJlj+8FFhQy6OHOEy71GqO88mPraXJ9wXoqOHdcJTbp9eUPt6kfo3ojpP5GF6iph9f8BCuYL
 9ui8XZi3u17YSIj7aW2/FbDijSg46DHRwonjjg7s0qg6R5lIpGobcqk5DA3DMqszq7JETFtX
 1BdxaByCdzi67nTzURhp81TRtmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 hON5FsMvMcLYCLyBUOSX25XI5t6pUQHPYS9Ps04kvIVMvCdiSfaoHA1OhD4M57FyhN9zP1X1
 WinnTaEVCtGV/0+klJats9En+ZjxyYiyHnVSIyzxhvP7FZtTC79dFvxC3PXNrpRxPrc/m39q
 o8DX+PXlUk3eLCgM0H/rN9LRXhXfCNTLc2n+6R/KLXZSiI4Qz5JNhMk6eh8E2CTt/8JzbigE
 7DUchMw9WcTclWccVTaMi04Mei3NXu9xFpiVRER0Z+T8yBLSe6SAG03LvPbpJErq75uy+BaV
 f4Ad5nSC/hDUGqV5DkXK5Xw9dQweBOujAOIHiykfDlmI88+HVOUoIe8c1u97jQKAwq2qdA6/
 e+q2DTbdpxfFQ5sO8DbNaC0xFSrsHlBw+9/BhOaItRadEj23pJtLij90q0+L80Wd0fcyzHc2
 wvPWUUUouzEookU9tjVhPnY/tnzTLYkRhJXRjCJ46y3OC/W+nuY7bVBCOvYLyrAUG7U+bm5Y
 bsHxf/LMMoBwARAvb16Hus51qk5/dbu++RXwwk4TnXGa1OnVuFpLnWchJAds6pQ2vlGtAHwV
 k/WootWPrCAOcXEFl8NJVN5P7rZiqxOwmHfvaYvPUH3xC5r577ZA09cCBm7jnAPJrVCNo54k
 /wqv9Qb6lDkhxd2YMyKiDtYqzaFInAaCvx1s5YHHMn0hwBtxlwbOc7QDSr/4ZeubdRQMxB2c
 2HO2/eY3+xRlhjYbn4+NXnRxu4D154AjxB9ygNQLVq+nNeY1OQ82wdc8GhsQwlYpvmdPzmf5
 oS224xJyaSyE/NAgc9eQyazFgsHCBDxFokdDbcWvDWxcqVqfjWlwK4B1SKl400TtW5RFtSe1
 K/N037rCF4GY+mothbfmidZRzjLUtF7sAHP8Cxi8wJpALFiCQfYbmSSiabkZvcp7Q7dRKEKm
 AWywNtNVA==
IronPort-HdrOrdr: A9a23:Mj1l66tqOTo1ie3YNO9vZUX/7skDUtV00zEX/kB9WHVpmwKj5q
 eTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniDhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,159,1643670000"; 
   d="scan'208";a="24626607"
X-MGA-submission: =?us-ascii?q?MDEyxti6S3c143BcdX4XBDgteGB7/HWzn7n5ha?=
 =?us-ascii?q?3RzdGNzCadcn6QSwknQd+sUD02RC3AE2IcctGUlxOD8fo52KeoN4ozL9?=
 =?us-ascii?q?mJwoRXGygc1WoAKBw1UyRFwX2T2Zovp/SqO27M4RvPI/+fI9oYxk6XPb?=
 =?us-ascii?q?aZsYXAELsqbDfSCWPub6oWLQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 14:43:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646574220;
	bh=zCCGtBhmjNxP4KdzvJQ5Hx3buW1DKa/7PZO9nIRNt3s=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=MG6OoiaEpFl2I4xklPcNWhOs8h0pUlaDtdzAD0RGtVGdCwzOxMVWf9ktNU71dK0g3
	 bobz1YpOVJfRSH+huT3jM3QUcty6XDIcmRL0PGZSF6gXjVl+aSH8s+wKbMfPia80nw
	 LJdPUiPq56y7e5XWPB3SzzJjY6nUMaRo5debxoy4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.90.163]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1o1YlW2Lx0-00dBY4; Sun, 06
 Mar 2022 14:43:40 +0100
Message-ID: <f6b687d9-a87b-52a4-ed47-76d83c969f99@web.de>
Date: Sun, 6 Mar 2022 14:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Eric Wheeler <cocci@lists.ewheeler.net>,
 Julia Lawall <julia.lawall@inria.fr>
References: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net>
 <alpine.DEB.2.22.394.2203052240451.3180@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203052240451.3180@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qfpxfkN4oyQXkqHrney7nO+NcEoUwBBRMvwJ0nrccjkDruKD1dl
 0HW7a8n6OIOUpBHgsBUX9lgV0aC7oz21pacbTAWOyHpBwg9jH5g2TEv2itnaP6zVSxI0I00
 Kj4hzpznzY8MKrwwU6IMiWZPXJ1hJ7VLhg+tNvH+2DWaLH25qIpoZ7iYVzKX4CH7qtBs0tE
 wZzGj2TY99xEH1qFHp6HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCbkQuhxoOM=:TYrT/N0s2IV5fiASeqH92h
 L4ckRdHEP56UCgstSac57JGSf9Lw0APDLTlJZJXmDMoGvDx2GVqOpJQgU19AfIXxMpjtNV4s9
 fYgIl415JNpFWO6m8jJS/sLDsRviECPSDTm6HRd5y6DQZGUacox/xytv/wdU7OoESMURXyCnS
 yjbQBIMVDGblEWtk5eYjxnNttVXpyD6pDWdLv/nbuqmGMs+JqUBv1sEaj+LAucoKda3TJC5OE
 L99Uq2ES/WCEF+dKg75TQxpvHKNyQ4jaKqvbJVhtK8joScDF1w+H1/iZzlbDYVPVpHc+yjkCI
 eE2XdKZlZQ0ThlgE2XB+Oq2p3NXDrtPBpXzdjlvdPHQg8okjaZ7UyVLZjFS7YqdzS6iVTjUDm
 Koemc1KxrzhNYtrBHARiso1nd+/krjC2bO9Tejz0l2BTYaO/8O64MRr3pCawnaMfuRVbpbkZy
 gjJnDtsAAVwNISN37bz+WbKNsw8ljdzDdwYQouS55T59tr2y0G/K3XVMws+q/8/k+GYy7zWng
 lWh+OkeTEDpbZLj/sf6bAd1rg6oEEUBaw3KmjSbHTzG3c4i2ml65b8tNuF6gG4iP3jVfjwLCz
 Gs4L6DLj2cwBp7ByqAwU4OfV8tuOXHLHUScf8R6voPBvkc8bbftgkboq+2JQ+M5UDKcnk2xab
 L30wLpIQ3ju4jNjaW+WHiEANoTDVWwLfv/+RxjzxfV+OBTRNddjjIu+x6xniV79UzcULF2ISe
 pz3zsddndfIWTWuKwylwKnJ+05lmDOX6sBECgM09OwdHLqGktu0NhMT4vDL7HTs/hZk6iK8CX
 CCmqxFlBDAgfULivKgw4VutcGnIsbVyVQ3m1AzXwj0E156WJXGU0EFIE+gZT/e3EnwtrUIOYT
 LR1Pp+OrEHyc0JCEFyTDD4NQ6xWv4tqZoTNYHUAOEYFXdvxpUfxZdQ4BJoswuO6wGjKv5Qk+2
 QbsVvG/Sq6j3m99r/Mt5NvBEImtZdINrLgckluEHnMyC5UTYUgL+y1uS7KR1sAUVSbbKdLaSG
 JdT5XaBNz+ba8AqaKeEaoicnK/7pUEUQhEzaudDOw56IdZ8G/ig0J7fxVGfL8nbH4oz9ccdDP
 7Tt1mtmWxtgemM=
Subject: Re: [cocci] How do you add a function argument when an identifier
 exists in the function?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 168
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/f6b687d9-a87b-52a4-ed47-76d83c969f99%40web.de>


> You can do the following:
>
>         T F(
>         -PL
>         +nec_t *nec, PL
>          )
>         {
>         ... when exists
>             when any
>         nec->j
>         ... when exists
>             when any
>         }
>
> The when exists requires that only (ie at least) one path have the
> property and the when allows other occurrences of nec->j


How do you think about to work with the following SmPL script variant?


@add_first_function_argument@
type rt;
identifier func, member;
typedef td;
parameter list pl;
@@
 =C2=A0rt func(
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 td* nec,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pl
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
 =C2=A0{
 =C2=A0... when exists
 =C2=A0=C2=A0=C2=A0=C2=A0 when any
 =C2=A0nec->member
 =C2=A0... when exists
 =C2=A0=C2=A0=C2=A0=C2=A0 when any
 =C2=A0}


Would you eventually like to use another SmPL ellipsis instead of the
explicit specification
for the parameter list variable?

Regards,
Markus

