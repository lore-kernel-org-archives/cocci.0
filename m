Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC62C433EF
	for <cocci@archiver.kernel.org>; Sat,  4 Jun 2022 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fQliQcxCxuFTrz0jta06T5nRK15PcoaueJr2U6due9Y=;
  b=ZSlaI1IbJrZSIWnXTbaui6wIY4d5giBSDZjU0721e200Ghf5PTTK1+4l
   UhJenIv3Y1dLpegdumRQkaFhQWUje8bFsZJWrdNmNbrRfkozfCd8Fv1B+
   e1ObRsTjRL38WtVjm2yilQ+9uiJQeFwRzpi1vLUfvfUmLTbstPX2n68Y7
   4=;
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
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39505580"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2022 16:32:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C55B9E0346; Sat,  4 Jun 2022 16:32:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 07710E007E
	for <cocci@sympa.inria.fr>; Sat,  4 Jun 2022 16:32:20 +0200 (CEST)
IronPort-SDR: sqzVhLkXoAY4vpSi6knMnEoWN/SevMx6ODqJBHxHOzU3CfzFItFBMMm7dgKAhX3LrxWHPPRk9H
 f0pUPL7Mju7IBQ8iji2C/iVl8YrujGNm/hJdtyjXmG47tuhpLBJX2lsyXut1CMO98DPltQJ5fT
 Q2AW09X+uTTz74xpLUK3V3R6NcZWS3xuI9408eBxcADCkSFL+CQJNOelIzMACGj89IemiaiN9E
 W3b86oat+Z8qLQRqARUGvtE4rLGkJ+D+gLO5hj5REm0/C0J4frK/l47HhKwfubbz5WbvVVM7Rm
 6MrFm0ylpAxwE7JTInuwsUCZ
X-IPAS-Result: =?us-ascii?q?A0A7AgAsbJtifQ4P49RaHQEBAQEJARIBBQUBQIFPAoIig?=
 =?us-ascii?q?VYtBAtEhE6OaIZJhwmHGoweCwEDAQ0/AQIEAQGCDoJ0AoVGAh0HAQQ1BQ0BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENDQ4ICgcOFTYGXgZkB?=
 =?us-ascii?q?IFLBIF0CzQNgjUpAYNkAwMjHQEBESYBDwsaAiYCAlcGDQgBAYJ5gmQBAzWrc?=
 =?us-ascii?q?oExgQGCCAEBBoRKHywiUoFcCYERLAGNZ3onEIFVRIE8glMwPoEPgzWDVoJll?=
 =?us-ascii?q?yooBA8DHC00EoEhcQEIBgMDBwoFMgYCDBgUBAITElMdAhIFBwocDhQcJBkMD?=
 =?us-ascii?q?wMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxcJBwoDHQgKHBIQFAIEEx4LCAMZH?=
 =?us-ascii?q?ywJAgQOA0UICwoDEQQDExgLFggQBAYDCS8NKAsDFA8BBgMGAgUFAQMgAxQDB?=
 =?us-ascii?q?ScHAyEHCyYNDQQcBx0DAwUmAwICGwcCAgMCBhcGAgJxCiYNCAQIBBwdJRAFA?=
 =?us-ascii?q?gcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWGR0ZAQU2JwYLCSEcC?=
 =?us-ascii?q?h8LBgUGFgMjcQUKPg8pNTY9BiIBGwKYF2uBFcNkNAeCFIE9gUMMniwGEy2DY?=
 =?us-ascii?q?5JuDgaRdpZopzOBeYF9MxokgzdOAQIBAg0BAgIDAQIBAgkBAQKOHYQlii0/N?=
 =?us-ascii?q?DsCBgEKAQEDCYVHAQGKSwEB?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNJq7N/eu8cRVZC8FQ==
IronPort-Data: A9a23:hDgp1KglAi8s/64N+7GaJrzLX161cRYKZh0ujC45NGQN5FlHY01je
 htvWG6DOquDMTD2e41wPYnloUoOuJ/Vn9ZqTVFkrSozEXhjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8x6TSFK1nV4
 4mq/ZWDYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplrrLuSkRyMbHwhf0tWghiAzFcBahP0eqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1ba24paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcDjWpo250RTJ4yY
 eJBOTwycRD5eiFyEVFOWaMjvv+SoF3GJmgwRFW9/PdrvTGKkmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 1c6pClt9qcuyFGyftDsZQ2ogkaBtzdJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaiSMmedA5/
 gPYx4i5X1SDpJXFEiLDr994uBvvYXB9EIMUWcMTZScoizUJiKI6lBbUVMtjHcZZZfWqR2isk
 lhmQAAUjrkei4s0fHGh4UzKhjihvJehc+LYzgDQQ37j8Q5zIoKoD2BJ1bQ5xaYeRGp6ZgDQ1
 JThpyR4xL5WZX1qvHLXKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9aJGOzM
 BaL41wMvs470J6WgUlfPNLZ5yMCkvmIKDgZfqyNBjazSsUtJVHcpkmCm2bKgzq1ziDAbp3Ty
 b/CLJryVC9EYUiW5GP4Hq8c16Mm3CYz2SvaSvjGI+ePgdKjiIquYe5dajOmN7hnhIvd+Vm92
 4sBa6OilksOOMWjM3G/2dNCdjgicClrbbio8ZA/SwJ2ClA7cI3XI6OKkOJJlk0Mt/g9q9okC
 VnmBh4JlQCl2ySZQehIA1g6AI7SsV9EhSpTFUQR0ZyAghDPuK6js/UScYUZZ74i+LAxxPJ4V
 adXZMiKRPhCE2yV9zMYZJj7jYpjaBXy2VPQZXX4OmBncs4yXRHN9//lYhDrqnsEAB23gs1i8
 beu4QXWHMgYTAN4AceKM/+ilgvjvXUUlO9ocVHPJ91fJBfl/IRwdX7ug/VxL8xVcUfPwT6T1
 gC3BxYEpLCR8tFvr4ST3fiJ9t77HfF/E0xWG3jgwYy3bSSKrHC+xYJgUfqTeW6PXm3D+JKkO
 bdfwcb6PaBVh11NqYd9T+1mwK9itdvio7hWklZtEHnRNg35D7R9Pj+Z0MMJuqAUnu1Vvg6/W
 0Su/NhGOOzVaZ2/TwNLfFIoPraZyPUZujjO9vBrck/00y9A+ubVW0tlORTR2jdWK6F4Md9+z
 Op96tQa7Rez1kgjPtqc13kG8mORMjofXq9hupxDWN3njQ8iy1djZ53AC3aqsc/VNIgWahEnc
 m2Oma7Pp7VA3U6cIXA9Inj627YPj5o5vh0XnkQJIE6Em4aei/I6tPGLHe/bkuiIItR7P+NP1
 qxDMkpoOeOR8j0uiMUrs6VA3e1eLEXxx6Az4wJheK7lo42ASWHHamEwUQpI1F5M6HpSJ1C34
 5nBoFsIkl/WkAXZwSY4H0JowxAmoRqd6SWa8P2a8w+581XWrNYrbmJCpYbFlvc/Pf4MuQ==
IronPort-HdrOrdr: A9a23:GkQAY6m+EFufPlnVbfWlVH4raBnpDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39505579"
X-MGA-submission: =?us-ascii?q?MDEy6zW5KADlaFhjP2O/74hCnLBCHCCoBGWJqH?=
 =?us-ascii?q?KLL0vxbcMmCKb3rOX7Qrpd0opqjlAAaz5GiIKd82pj9NVwcgjozmUmAu?=
 =?us-ascii?q?0YbqUzp555IlPU31zcPG8Zq6du+zEaTLUMATopQgx8D2cBYAVKs5AuLE?=
 =?us-ascii?q?yn8o5jE0VJWZ75kqNoNPnv8A=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 16:32:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654353137;
	bh=R6dUO+jvS/5V2ZbtLEiKjjdqZlxwhmuKEJ9e5woBnRc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i0P1oiMk2UyZtRLKGNDesR4yyJ5DqMPaE6dts19H3eNiOgUW7J9v+HpUqfckVZJUG
	 FTk/xtAy0dMbAi+ou6PHgylHvo4dp+b6OMTrJaICp2xHnXblLXngp2EIYmqaLuLs7r
	 gi8HCr9vLpX+i0gjjA8y9FBVdjUHejKygbQrBJyE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.157.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SPD-1nmnOQ2SMx-013kAy; Sat, 04
 Jun 2022 16:32:17 +0200
Message-ID: <edfe8a02-82b6-aa03-b6e8-25f71e116807@web.de>
Date: Sat, 4 Jun 2022 16:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB7603A9FB9FA6A62438B09A3793DD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <2490b8cf-4d9e-1357-6563-097264bcb01a@web.de>
 <alpine.DEB.2.22.394.2206041609220.2858@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206041609220.2858@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1CLeQHBNo6pWujSGovgLpe1NfrSf1Al6wIoea7Qw6FCNhboOEtZ
 MKnh5Oguwvbzy4opNfDvlo+3IPcL6+K8HWWnYOCRNkL41/oZm7VbFyR+13sFmX5PqCFSgHB
 d5fNKdl6L+occng08BW34+tyZ9lmpRchLC7GsNY/Q2yo3uF/Ljv7/tLPnDs5ERwVUF3sjX1
 VcvYZADMfDdCNeNlfRpgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XT1mh25eSFw=:ob44YrCRJx69IwxjnLHP4/
 k/vLYd+h2Vl3A4tg+RbeSb8uoJpSNtgktYYhtjijCZHSdVG7kdF9koHtEBN+RJ/WI6qnUGDmw
 WLpkKtnNW+lb2YI9mSbW7ash1hxGB9wgk/EFYoaIqvRC9hhxA6QFvIqn/XJGOIu+m0S81rTBM
 RNfEe9I7J4ZKetS3RQDl+B/y5W0lYAj5sxf/VyDHddYWMO5fBA7O7cdA8ZTmcpO9UDunxJdhS
 99JJuZAJgNpcWpgBtIfz26/254QxpU7badTpWA+z8z6ySM6fio3d3kWLHg8lIAWgKpnQlcEyO
 o5luJFBsdtyfZRaHQvBaUJr6PElwk65S3cBvpuZVFwxQO2/cYctgw+s/Wjkhk0B559Z0/ZxWl
 yxNwRZcV484JZ5QtvCuc4OBI+WVu0nowZMU0Chkjiby+bikYO0AcbHsQ7TFZv/45rYeNmBZkK
 YGGlqlIs/VSPlT3z5vwXd6ujeANzyUv/2kxWTo7p+TMgPTpoMzXChJriiNXzBLTlY/2NdOi2P
 DR9Hla4oZsqqkgqF5ANHazqPNE0KnBosqzH4v6vGnOACOjgV/mP0gXGoogxh++wehrL21GiOB
 2jLtJF5Z2l2GRmBZE7XIlGFnT7yzJdKi38yR7IO0cULy7SQlIpR8cADN+AF6NSn4+bv89nTmv
 gmVgvd3SZWP6xbZD1vKXOK/nqFExtZNap+xGXyu8gpkfr2koBBEPxH0bobar6SiCgpU1S/5iG
 2WaPLXuHQK9Yv4V7IgLWZ8SL0DIcpuEhMoBvdBLkxgF1QQKadabrTaj7vE3Ay7Mno2jFb5zrK
 U4MMe3M3K7IjdVlQokdPgP0AkzoHUgbrcsxqeIQ1N+M6UK5uu2U1nK7kX6Qsy/7OYP1rfYNOb
 QPIk3PTFW2JMN6DBvCLHV15fLHVsrIs8U7TDvfohjAyCbsTJLoXO60uOrHvRucpMOLOb8yElD
 22d1KPVK5BzVs3I+bRbcUmYyOhnPgiT/HlcKid5ioncfOoKxlfSlgYBgpWGyL96qiwl1DGFr0
 a/euTeV06OJgyyzbiGOjO0P2HWxvOljvgYawCrPSWPMpYBsM3TQAIg9MKX8pMp+lE7bNs0rrG
 G+mejikBqNqA61z+AcmMmC7TZGVrY9LmFgzHh8hSpj9luz57bfH9r7GWA==
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 416
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/edfe8a02-82b6-aa03-b6e8-25f71e116807%40web.de>

>> *if@p ( \(&x \| &x || ... \| &x && ... \) )
>> =C2=A0S1 else S2
>>
>>
>> How do you think about to use such a SmPL code variant instead?
>
> I don't think that the &x case is needed.  There is an isomorphism for |=
|
> ... that makes it cover the case where the || is not there as well.


Do you refer to an isomorphism which is built into the Coccinelle software
(instead of being explicitly specified in the file =E2=80=9Cstandard.iso=
=E2=80=9D)?

Regards,
Markus

