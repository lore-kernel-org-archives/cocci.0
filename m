Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D323BCF9C64
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O4Qip/izv/HPJ4NFI+RsCrbZePTPUS9PBcZqHBW6eSE=;
  b=jA3KBq1Ab0zwfI1HNyTg69BB2/jhKjneP5xS4eOwxEyXsNMdAYgm9IKc
   DaoUbhsT9kCWiep9aW8GeiaoR6kMB61sogbJR+5DY5H5uUrOl7Wvp6jgM
   WEzbV3OhV7YiYcHOfZLQYFnrRXpjShDr4VFWCEM37KI3o9mlZJGCXbjEI
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184418708"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 14:30:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C77C3E0133; Sun, 22 Sep 2024 14:30:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A0F9DE00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 14:30:29 +0200 (CEST)
IronPort-SDR: 66f00de4_4LzckK30cTnztzAX68rKKSvk+djf8QfmXAVAEsVBCBQO7I0
 LeJQlA2fvKI83F+SIlSUxUCqZlyMVEXDUPV3U4Q==
X-IPAS-Result: =?us-ascii?q?A0GfAADADPBmh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDfQZUMwQLSAglhCmIHYcwgXUtA4Q7jw6IdoFWgUA+DwEDAQ09B?=
 =?us-ascii?q?AECBAEBAwECAYFJgy0KAneJDAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQE6Bw47hXUNgmMBEHkbdDACAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpEAQEBAgEjHQEBEScPC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn0Bgi8BAw4jBw0GtCmBMoEBggwBAQaBWEHYQR8sIleBY?=
 =?us-ascii?q?wMGgRouAYhKAYYihDsnD4FVRIE8C4JABzE+gmEBAQKBXoNbgmmHb4oeghCJS?=
 =?us-ascii?q?BYliGJwkGZSexwDWSETAVUTFwsJBYk4CoMcgW4mhBUIgSsTg1+BZwlhh2dig?=
 =?us-ascii?q?Q2BPoFZAUaCc0qDUByBXQU4SYJRa048Ag0CN4IqJGqCWoEvBAWDah1AAgELb?=
 =?us-ascii?q?T01CQsbBj2rX4FbSIFZZmgaEyyBXsZQNAeCN4FjgWMMiieVKwYTL5c+DgaSc?=
 =?us-ascii?q?5h2Io1ZmyKBZzqBXDMaJIM2TwMZD44hGYNhM4ELxVdBNQIBCDACBwEKAQEDC?=
 =?us-ascii?q?YVGAQGGPoFLAQE?=
IronPort-PHdr: A9a23:7QeDXxzqY6VkCp/XCzIbwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xSZvKQyxwKSFazgqNt6yMPu8JrcEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/9pPPbwlSmTawZbF/I
 Bq2oAjfq8IbnZZsJqEtxxTGpXdFZ/5YyWR0K1yNgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7U
 LJVEi0oP3g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RTGv5
 LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWGZNQtpdWylHD4ihb
 YUAEvABMP5boYfzqFQBowawCxeiBO3vyDBHmnD40LYm0+Q4CwzKwBAsE8wMvXnSsd77NL0SU
 eewzKTQyjvMdelW2TTg6IjTbxsvrvWMXbxqccrQz0kvGB7Og1KXp4P/JTOV1fkNs3OB4+RvU
 eKvhXQnqwB3ojig3cothJfGiZkPxl/Z6yp02YA4LsC3R0Bne9CrCodQtz2EOItsRMMvW2Vlt
 SQ7x7EbpZO1cyYExZooyhPRZfKKboiF7w7sWuifPTt0mmxodbGhihi89UWuxPHxW9e73lpUs
 ydJjN3Bu38L2hfO5MaHTf598V2g2TaJzw3T6+dEIVo1laXBMZIhzKQwmoIcsUTCAi/2mFj2g
 7SMeko4/eio7vzrba7hpp+bK490jgD+MqI0lsOjBuQ4Nw4DVHWY9+SkzLDv41D1TbdQgvA0j
 KXVqo3WKMAFqqKjAQJY0Z4v5hKwAju83tkUgGMLIVFEdR6di4XkO1fDK+3mAPe7nlSsiytry
 O7cPrP8A5XML2bMna/9cbt79kVS0hA8zcpF6JJRErwBIOz8Wkv2tNHACx85NBG0w/r9BNRzy
 IwRQniDDbKHP6/KsF+I4PwgI/WUaYMLpTrwKeIp6vzwgXMjhFMQebel0YEVZX27BvhmJl+WY
 XvogtcPC2cKuQ8+QfTthlKYSz5TZGuyX7km6j80DIKmA53DRoGrgLyOxyq6EINZaXtcBl+RD
 3jkb4OEVOwUZyKIPsBhiiAEVaSmS4I5yx2irBX6xKZ/LurI5i0Ysoru1Nxv6Ozdjx4y8Th0A
 t+c0mGMSmF7hXkISCUs0KB+p0x90FaD3rJij/xWD9xf/+lJXRsiNZ7A0+x6DMj/VR7GftiVV
 FmmQ86rASoxT9I0298BeVxxG9SkjhDZ3iqlGaUZl7KRBM98zqWJ/WX1Js8173/Z3a0lxw0kX
 89OPCuij7F28wz7BojTkkzfmbz8MewX2yXG9U+Cy3CPtQdWSl1eS6LACFUWfEjLtpzU4k3YT
 rmhQeACOxFC1NXEB69EcNzvgn1ZSf2lNNmIMDH5oHu5GRvdnuDEV4HtYWhImXyFUCDs8igW9
 HeCbk0lAzu55nnZFHpoHE7uZEXl9a9/rmm6Rwk61VLCdFVvgpyy/BNdnvmAU7ULxLtRnS47q
 ChvWnu50cjXDdWouAdrOqlRMpsm+FkS7WvCrERmO4C4aaVrh1oQaQNy6mbnzRZqEcNtlcYwr
 XUl5BV/I+SU3QAJbCuWiLb3PLCfMWzu5FavZqrRj0nZy8qT87wT5e4QrlL+oEe2G0Bk/3gPP
 8B99Xya692KCQMTVcm0SUMr711hoKmcZCAh5oTS3HkqMK+uszaE1ch7TO0igg2tedtSKsbmX
 Ef7DtEaCs6yKecrh0nhbxQKO/pX/bI1OMXufuWP2aqiNuJt1Dy8imEP7Id420OKvy1yL4yAl
 7MM2fKFxU2qUznmjVGumt/6k8ZIaHBaH2ayzzTlGJ8Efrd7Ls4ADWajJdHyx80r3ceyHSECs
 gfyXRVZiJzMG1LadVH20AxO2F5CpHWmnXD91Dloi3QyqbLZ2iXSwuPkfR5BO2hRRWAkg02/R
 Or8x90cQkWsaBAk0RW/4kOvjY1SvqdiNC/+RUlSfi75B35vWO28u/DRBqwHoINtqihRXOmmN
 Bq/Q6T+vgBc/iftBWpYyxgkejvstpizzHkYwCqNaX10qnTeY8R5wxzSscfdSfBm1T0DXCBki
 DPTCzBQJvGR9M6P39fGu+G6DCe6U4FLNDLs1cWGvTe64mtjBVu+meqyk5vpC1py3Sj+3thsH
 SLGyXS0KqzizaenKqRKekdyBVnzw9V3EMdyn8M8iYoR1n4TmpiOtSBeziGsa5MCiPi4MypFT
 CVD29PP5Qn5xEBvSxDBj5n0UHmQ2IopZtW3ZH8XxjNo6slLDKmO67kX1SBxo1e+sUfQea0nx
 2hblqFosS9Axb5Z629Phm2HD7sfHFdVJ3npnhWMtJWlqblPIX2oaf623VZ/mtaoCPeDpBtdU
 TD3YMRHf2c448NhPVbLyHC25JvjfYyaSNsJtQCP1TrEgfJULp0ZifcAwyZqczGY3zVt26sgg
 Bpi0Ivv9q2OMWZw5+SUBhBCNzv6T9we8HfhgOwN+6Tel5DqFZJnFDIRWZLuRv/9CzMeu8PsM
 AOWGSE9oHOWSvLPWBWS40B8ozfTAoimYjuJcWIBw4woF3z/bARPxRoZVzIgktslGxC2kYb/J
 Vxh6GlZ7wz9rQZQjP1lPV/zXy/W9gKvdytxWJaYNgVf9A0E+Erfd8CTi4A7VygK+5q8sEmHL
 XGdbAkOEmwDHECJT1mxO76z+ZzL6OKFAun4dvLIbezIoutbMpXAjZv914x743OHLc6IJGEkV
 vQ91hMFVnd8U9LQnzFFI8AOvwTKacPT5BK1+yks69u67OyuQwX3o42GF7pVN9xrvRGwm6aKc
 eCK1m5/Ln5D25UAyGWtqvBX1UMOiyxoazimEKgR/S/LQqXKn6ZLDhkdIyptPcpM5qg400FDI
 8newt/y07d5iLYyBTInHRT5ndq1YMURP2ynHFbAGVrNK7mMYzHGgon2ba66VbxMnbBUuhm36
 lP5WwfoOjWOkSWsVgj6a7gTyn7BekUP4sfiIkUIayCrVt/tZxylPcUiiDQ3xeZxnXbWLSsHN
 iA6dUpRr7qW5Cceg/NlGmUH4GA2SIvM0yuf8eTcLY4b9PVxBSEh3cdT+ncn0P146C9eRfp6s
 DTfpJhirhv194vHgioiSxdIpjtR0ciTul5+PKzC6pRacXPD4Q5L8miaTRgH7YgAaJWnq+Vbz
 d7Bk7j2ITFJ/ofP/McSMMPTLdqOLHsrNReB8NH8EwYPCzKmZzi3b611lfaP6juKo5J8ppW+w
 PLmr5dEWVZzGv5IUixY
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nfxWbay4rQB0cNdfhGlAKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:ZlWeGG2tq+rotRqtLEsFOrxfRMILc3vA92nrfWyIUGxiVobMEl2v0fYx
X-Talos-MUID: 9a23:F2aW5AsTdE17OanXR82ngDFaaP9T3KiXUGcpuqodvs2BHh0rJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="97033807"
X-MGA-submission: =?us-ascii?q?MDFRxkO+Y2oL7FDekq1q8KF8LnWFLgkzQIJX6j?=
 =?us-ascii?q?RNooTJM5ZXb3zi0Q83XcPgVQYSyMBrtdEy8kxsKTHIbTXefhrIqvPlh0?=
 =?us-ascii?q?3CbDv98frzeDG879ffFOpawUg3n/nc0AvW7o4ufA6P7CuBhh49bRbZch?=
 =?us-ascii?q?5pdlayEvsmTxvNvLJIQdF5hg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 14:30:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727008227; x=1727613027; i=markus.elfring@web.de;
	bh=O4Qip/izv/HPJ4NFI+RsCrbZePTPUS9PBcZqHBW6eSE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M8zNZ1YH9Kzbto91MhPvBYh9D8PgxZ6iAwxN+EK3Uf0buy0PWth/03sG8NiCOHL5
	 5MfS23ziQGAXVPz2Snvps45Kchicw/Tkud7J2+MA9c266si3dGX1oHeNuUo9ys1Cl
	 OckckwH0z9kpcf2F+EWOAAA0sE+IABKqRxb0E70YY6+yFfrlb+qsm6+btckXkH4UV
	 6bHWi2pcPrw6p7j3OF1NwX2gNEqg0w8ki/5DFsTKFlTSaxhbbApo/mznBoSBed4+q
	 4jQgNc+d6viZSGmPEWw0h5nDL3e0gKUY+nrRzs+XZOshRdBqu7OLuPEPb0Caj17l3
	 V1+nbb+YE+o6eMFSYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BM4-1rwpen2ssI-00yFkB; Sun, 22
 Sep 2024 14:30:27 +0200
Message-ID: <42f5079e-472b-42ed-9429-2c636b9a14a3@web.de>
Date: Sun, 22 Sep 2024 14:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
 <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
 <b1872e36-154b-477f-907a-7fc98b301931@web.de>
 <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
 <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
 <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de>
 <alpine.DEB.2.22.394.2409221321131.3517@hadrien>
 <d2d6b276-0f4d-43ea-86d6-6568b79f58ac@web.de>
 <alpine.DEB.2.22.394.2409221400080.3517@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2409221400080.3517@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xv9cpTx/YQtNqhaS4ZKcv9HoF15QGvASf+yQy+QFsuqCYdPYMLA
 mdMxn+J5ypd+bg3yd/c+EVaErXgZwmv2GPxKf2agcKGDto+0okXkGmiawe0E1RD227ts/i8
 +Kac0YxcjK/qMxuQiTWStp6xWYbkdLYJ9lsXMhodaKOcwLjRdDBUTlRieErDRWjLkyOgqoK
 xug2aAi9yRZo7bd1QVNOQ==
UI-OutboundReport: notjunk:1;M01:P0:dChvh+15Zrs=;sem6G6qWG4QwC32ns73XHxVBEXV
 cCB5ZvpZm3DlurAiBUC/Lcup229yNZKJhfNKo8a6whSufhlnIBjXKS4Otp94NfZmiROg6I9uA
 iTmagt8AmFJ1EE4rA6C9sOhRAoq+vqUlgO20GU20dZC30Snspaw/OGhlevA0pqD0F4i4dqjim
 obXTmefhTITRBCSy8KgNfG61evw0RLioooo6uSTq119E2zQbEYaj48Q6CMmbp4cWbQUy3hSqC
 zPHwK1zf+pTBfBE0LH+f/xULmkWGuXZEwOe3fvilGKXNw1Ads4MWQyMfnBq8pyAQdhbXRt7Zl
 82aSokfd4xxQcyJTr7sXmxmZfYRJGJvxCRMMUN/ruk1XOGJNwgfOzsNbkNxBbhf/Kdm3bQUeL
 A0cOAkmv8lEchEfGWwR9l5bfrFxrhbVrzhbvE3GdScAqhhT2FVF5ZOb+sz+t+fb4cPQPOAXad
 XTfM8j6BikVm9Fr0KNdpPkr6w7y79mUt8++Qbl752TUOg8U8EQiJTG6as1AuZOx/JGMgMojzl
 HcVwjhjBo2mR6nGfyc9iapGtUpOdioyXxBqyYoOoDEQXnS+mqCFgKSvGjuINVf5nc1JfYNdNv
 57lY9e8PBMnVHALCgLeTOO+n5xvYINWEwxO42juAbDC3r1D40m+arwudX6xjlYrLt1Wm65kgW
 eOBwTBoXJukLncOaRZdbHK/XJPboGLRUSHtUTA1gjg+Jaok6Ee1H4fL/l9DhejD82nL2iJGxU
 ASqoOod/RryXHrQdyUCaaBx6d9yY5iMFlFdQJPuZrVOEDzdYjZh5PyLcl7pyPHGhcb+Yd9HG2
 MBOdgCeF/S4zLaXsd70hCE0g==
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1882
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/42f5079e-472b-42ed-9429-2c636b9a14a3%40web.de>

>> Would another SmPL code exclusion specification be sufficient (for a wh=
ile)?
>
> I doubt it would cover everything, but it could be useful for some cases=
.

I became interested in another extension of the discussed source code
transformation approach.
I would like to benefit from the SmPL question mark (singleton) together w=
ith
another SmPL code exclusion specification.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/083506fcc2b833796a749=
a9da806d4920b545584/docs/manual/cocci_syntax.tex#L1205
https://github.com/coccinelle/coccinelle/blob/2297fc0f90ce8bef78d2977e9aac=
c188d7e87c6d/docs/manual/cocci_syntax.tex#L1205

SmPL script variant:

// See also:
// ath12k_pull_reg_chan_list_ext_update_ev()
// https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/=
ath12k/wmi.c#L4683
@adjustment7@
constant c;
expression e1, e2;
identifier x;
fresh identifier target =3D "free_" ## x;
@@
-kfree(x);
?ath12k_warn( ... when !=3D \( x =3D e1 \| e2(..., &x, ...) \) );
-return
+my_test =3D
           -c;
+goto target;


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci use_common_kfree_code7.cocci
=E2=80=A6
minus: parse error:
  File "use_common_kfree_code7.cocci", line 11, column 18, charpos =3D 282
  around =3D 'when',
  whole content =3D ?ath12k_warn( ... when !=3D \( x =3D e1 \| e2(..., &x,=
 ...) \) );


I would appreciate your advice for this use case.

Regards,
Markus
