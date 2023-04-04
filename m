Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970BFC7618D
	for <cocci@archiver.kernel.org>; Tue,  4 Apr 2023 07:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WrZajbQhgpXHcK4m2HUWEOVYDrRGbdGf7fRi3wCVobU=;
  b=lwz9//BG7t/FAehXE6+WDG9HVmEy8BgeBu0r8LZqgLDXx4ImKnmW+Ijd
   evQW7QWZjGNrIbQ5gecYUJTqbr7vtoEzosoU57DzvM4PUZOjLQulaFNep
   F9fiTCk16NaLHpYiRBvR2SHzWeHo/DpeBoQlJHhbcaYyFpbBZFJOGdz5x
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="100570445"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Apr 2023 09:01:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 49748E019E; Tue,  4 Apr 2023 09:01:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F3B72E00CE
	for <cocci@sympa.inria.fr>; Tue,  4 Apr 2023 09:01:39 +0200 (CEST)
IronPort-SDR: 642bcb52_1wCXu22ALt1ayJyZXQNyOX4Nevp+oXrwdxfN6omdDnlu91O
 AmfTBvdBjefmc0vZrgNkLB5PHNJ92EdFFl4BUHA==
X-IPAS-Result: =?us-ascii?q?A0FDAADHyStkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItdVYvBAtGCIRLkQExhC+ObIpAgUA+DwEDAQ09BAECBAEBAwMBO?=
 =?us-ascii?q?IRHAoU8Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQJHUz0BAgIBIx0BAREmAQ8LGgImAgJXBg0IA?=
 =?us-ascii?q?QGCegGCJwEDDiMHDAasIoEygQGCCAEBBoFAARVBmXMfLCJUgV4DBoEULQGQP?=
 =?us-ascii?q?XonD4FVRIE8glMwPoJiAQOBXoNbgmeOOIJ6iDUKgTR1gSAOgT2BBAIJAhFrg?=
 =?us-ascii?q?RAIZoF7QAINZAsOb4FKgn0lBA4DGSsdQAIBCzs6PzUJCyAGWGsCLBETBQMLF?=
 =?us-ascii?q?SpHBAg4Bhw0EQIIDxIPBiZEDkI3NBMGXAEpCw4RA02BRwQvXHwKBgEmJJ5eW?=
 =?us-ascii?q?YI9OsMDNAeCKoFVgVkMig2VAAYTLoNqAZMeDgaSJZdwjVOaSYFqBS6BXDMaJ?=
 =?us-ascii?q?IM2TwMZD44gGYQMgQuOPT80AgkxAgcBCgEBAwmFRgEBhXwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DqEE7q/3Bs0GTzgzFnBuk+BMI+orL9Y04lQ7vn2ZKSY/TiX4rb
 HWoB1173DJYVoqNk3I3OrwW5VoIkmxyXcW2/h0AV5zZniBhILAFugLh+bfKn/bak/DH4VmtZ
 uIHZIeNDS9Nykese/KpDKjCt4lzZ2u+r2pg+C29QYXcShaL5p79g98B0KjCUEzfwVdGZ8lfa
 Dsm/Zvln6aY20easn+PmUIQ+SGh9CjruObXTc2QyU88QGLgHeT5KXkHwPw5GZlb9seqY1Sll
 TtokjC/62mvrWBxgXB0nK71eUvpOfc
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="100570424"
X-MGA-submission: =?us-ascii?q?MDELb9zm/4HHhUThuqSk3X+52VCx/GoQEDJ2T5?=
 =?us-ascii?q?Ok2T4RC7k+pMkB0Ng8M1aca0p/AHSTmihmwoESQqE2z57eS8ce9dqpq5?=
 =?us-ascii?q?80Zpv+vPNcsbXClwB0N1pKipVYY94PpLC990yWrnvwJ6fgZGhdjbGsdX?=
 =?us-ascii?q?Jombg22zlFErYUO6aKQsWXKw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 09:01:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680591699; i=markus.elfring@web.de;
	bh=WrZajbQhgpXHcK4m2HUWEOVYDrRGbdGf7fRi3wCVobU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vTrxLGx/cM2zNpP95FiY0nXl8belcQ5w6ewqdAKBYRpA6DPEPsmCFJr2SSeHlbGll
	 RTiazFBnYP4sSrxVr/H+frtbcftLX1edPL9hmqf8uq+qz1BxqZ8jq+ThbHCzO37rPf
	 LdaJbvL5DgLv5vdRGE/djvCJRvk458cCWu1OuslRNS+MCnZSUVLqyhbJo2UKhgVnD+
	 nyVPIrGbKrPml9NcqUI04Uc5lJJ4S+98puX4V9JQedrcqP7Jesk4a0ZUOlGUjpdZDw
	 lwm6mmXU2GZ3eXJEMBSi8JTVHQpqugN/pKXMoIwfDecjZxsQQBaKSHeKKJ22DYQxxC
	 6naFVVMYIwtcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrft-1ptBRf3Xvh-00Rn5m; Tue, 04
 Apr 2023 09:01:38 +0200
Message-ID: <5a615033-fa79-67fb-c892-bdd8e6f47d80@web.de>
Date: Tue, 4 Apr 2023 09:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <4bd84094-5838-c630-d1ec-d2d6bd0380ea@web.de>
 <b59a8472-95df-b592-78d6-9543aef463ac@inria.fr>
 <58d22807-63f2-da0d-e1a6-84210cb81e66@web.de>
 <30f398f2-1394-b67a-4ca4-ab6118c549e4@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <30f398f2-1394-b67a-4ca4-ab6118c549e4@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hRU+2HiaDOOAg8kHTTwJYt13AokTIMtE11AitgE6oTRq/KU6h5d
 1PNTBuR3ShCeAygiXK5XeZWpjceYtCTbz7VNyl6Xk0SmW7Xo5Rvnj85qd2g5yGNr86Xgdi6
 xc/Z7XeWol9Y3pSESkGWscVxClsmxqwEUWa0M9c8aRnMVhRXGaGyGeGnXkasn6H2t5GId+j
 wwhKEtCOcCQNSMeDJGLmQ==
UI-OutboundReport: notjunk:1;M01:P0:HOlY/586VIY=;84W6gVHDwHtKRyh963Ta608Ikj0
 Rw+tjNtdXPhn5OvHkaOb1PPOt3UqkpLiXQLA/3WenlEBsElbAJ5nCX1oSUhXmupfSGOms3mbU
 WEBSnGY2AlfH8nj3F8IkWhjZXgRGIAd29J+B4EKWTH8sv+tn4KN8ewhCVdAmlR3m0JyvWV4pL
 GIudNQvnnTY/YfuwvG04tdmBnl3qQe1yrRK6dxla4EGa2GD113jfuqRcfoFvL5HdkiUOz5aHu
 +NDSqlCJ6p8zjC7Wq2hcUP22597SD4p0FLeqAqXc51nPp7zyIJyEoIymdGKhSuVVlYzVuOh4B
 RjArn1NwHXMDGvrpef1jol6Q9xDZfFHPZnUaLGAr0k7d1ujf8vNRfVWhXedETKCP27ebQWWW/
 i9c06OxGO4wko47WVWkXFj53RNG0euwc3LKARsPxcG4pNfYbY8RfbkAq3IgtAL4agOLEdIlGH
 IvGSzclPqIqaKdzXB9Qpkzv89GXkBbee2W+2ayeSmWJ9S58u16cdLUxq8+SXyNRsHO9QGHEfv
 xwM8gy0dVEgXwxjuQUlvI699YJVyoejtUp2IDZK5kO8OPZleGnJZIcHer0Tz0QxRmmFmmDmLy
 LHCidO6bsok1xd8UNWIA/C+cd3TSPpppBYx6dvvEG1Llqcs+06eSUGS5fz5Qt/3Sx+ZSFgtT7
 egIWPP8Ra9ssYqgWBhfA5pBzn60jNDZA3OA4etv5/bXb0s+Y4hLgqD5tPT+UhFNzkIk87Z/fP
 H+U9oTc24txm945qBNklofJeX189TixbXB4SdfQ1kt16jqNft3jti3inAreDZiKu1uHmeE/ff
 ha4TvXpFEfipM4B6Sx9583Y8Ydpy3/vx73JuqoyrvFmbu74ypjN4ywaXQ4gT8n5iU6ol3yZGA
 IPAjdgORE1XOf5o/5fNYHx6B4exUxdX5mFe8gd2phKGIIH0SvJcKaTq9X
Subject: Re: [cocci] Completing support for fork-join work flows
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1001
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/5a615033-fa79-67fb-c892-bdd8e6f47d80%40web.de>

>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e910982fe0830c9dcc=
c9a8d3a4639484947a7559/docs/manual/cocci_syntax.tex#L658
>>
>> Would you ever like to distinguish the scope for such actions?
>
> Why are you referring to the section about metavariables?

The description starts for the elements =E2=80=9Cinitialize=E2=80=9C and =
=E2=80=9Cfinalize=E2=80=9C of the
semantic patch language here, doesn't it?

Regards,
Markus
