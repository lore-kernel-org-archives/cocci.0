Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6AAC433EF
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 13:40:16 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D802E61378
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 13:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D802E61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2378598"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2021 14:40:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B8CFE02AF; Sun,  7 Nov 2021 14:40:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3ECEAE004C
	for <cocci@sympa.inria.fr>; Sun,  7 Nov 2021 14:40:13 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AFxdrKRxvohoKNBHXCzKszVBlVkEcU1XcAAcZ59I?=
 =?us-ascii?q?dhq5Udez7ptK+ZhWZvaQm1QeQFcWDsrQY0bKQ6/ihEUU7or+5+EgYd5JNUxJXw?=
 =?us-ascii?q?e43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgR?=
 =?us-ascii?q?pOOv1BpTSj8Oq3Oyu5pHfeQpFiCSgbb9oMBm7qQrdutQKjYd/N609zgfFrmZSd?=
 =?us-ascii?q?+lZ229kOUifkwrg6su14ZVu7zlet/U9+sBaTK70Zb44TbtWDDQnN2A6+sjmvgT?=
 =?us-ascii?q?dQAWM+3URTHwYngJHDAbZ4h76WIzxsjbhuepmxCaaJ8z2QqsqVjmk8qxmVQXni?=
 =?us-ascii?q?CYDNz4+7WHXlsl9h79VrR69uxByxZPfbZqLP/RiYKzSYdIaRXJAXslPUSxBHpi?=
 =?us-ascii?q?8ZJYLA+YYIOpUs5Xxq14IoBCjBwejGfnvxydLiHH40qI13fkvHx/I3AIgHd0Br?=
 =?us-ascii?q?Hvaoc7pNKcLS+250LXEwDvBYv5QxDzz6JLIchckofyUWrx/a9DRyUoyFwPek16?=
 =?us-ascii?q?epojlPz2P1uQMtWib4PdrWOWohWE9sQFxoSWvxtw2hofGgoIVxErE9SR/wIY6P?=
 =?us-ascii?q?tC5RlB0bsW+HJRNqS6XLo17Sd4tTG90oig10KEGuYKlcygQzpQq3xHSZuGIfoW?=
 =?us-ascii?q?L4B/vSficLzhmiX9lZr+yiQi+/Eahx+HgVcS53ktGojZbn9fDtn0Byhje58qbR?=
 =?us-ascii?q?/V940us2TiC2g7V5+pZIk40jbLWJ4A8zrIujJYfr1rPEy3slEnrjKKabEsp9vC?=
 =?us-ascii?q?s5unpeLnqu5GROo9uhgz/PKkigNGzDOs3PwUIQmOV4/6z1Kf58k38WLhKjuM5k?=
 =?us-ascii?q?q3esJ3CIMQbobO5AxNP3oct9RmwFC2q38kGknUfLVJFfgyIj5TxNl3QPfz0E+2?=
 =?us-ascii?q?zj0qynDpp3fzKI73sDo/DI3TblbfuZ7d960pSyAopytBf4opZBLYbL/LpWU/xq?=
 =?us-ascii?q?cfYAgU2PQywzebnEtR91oURWW+UDK6WLrjdvUWV6e0xO+WMfpMauC7hK/g54P7?=
 =?us-ascii?q?jlXs5lkUTfKaz2ZsXbGu1H/VnI0WcenXsmM0OHX0Lvgo4VuzqiUeNXSRdZ3aoR?=
 =?us-ascii?q?6g8/C00CJq6DYffQYCgmKCO3CCnEZJKZ2BLEUuMEHftd4WcQfgAciOSIsl7kjw?=
 =?us-ascii?q?FT7etUYEh1Qv9/DP9nph6KuvdsgkRqpvn0JAh5fDXlBh08TVrBsCZ+2CLVWB92?=
 =?us-ascii?q?G0SEXt+4qR2ulB8z1aHmYJxif9RXYhN7fpDUQ4SLoPHwqpxGYahdBjGe4KsQUy?=
 =?us-ascii?q?lX87uLDU/VNM3zJdaRk9nGMi5yD3H0TCrBbA9iLGBQpA5pPGPl0PtLtpwni6Vn?=
 =?us-ascii?q?JIqiEMrF44WbTXObktX6AXZQYLEwR3xf0mCaqkWmiLApj7rJYumuUZFTEhvXK+?=
 =?us-ascii?q?DUX1NPiPr?=
IronPort-Data: =?us-ascii?q?A9a23=3A+cRD6Kr00AqJnB/Xor1CHHFmT15eBmJIZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmMaXz+DPqzbM2WgedF1OYu/o0gO6JTWzdVmGlc/+380Zn8b8?=
 =?us-ascii?q?sCt6faxfh6hZXvKRiHgZBs6tJtGMoGowPjZ/xYwnz/1WlTahSQ6hf7gqobUUra?=
 =?us-ascii?q?eY3koHVA8EU/NtDo68wIHqt4w6TSGK1jV0T/Ci5W31G6Ng1aYAEpMg06wgE8HU?=
 =?us-ascii?q?MDJhd8tlgdWicanE7PpvyJ94Jo3fcldJpZjK2VeNrbSq+3rlNlV8o5FlirBBO9?=
 =?us-ascii?q?Jkp6jGqELarvVIBTIlXdcHaSv6vRAjnZriOBhbqVaMBoR0F1lnPgpoDlJnbm5U?=
 =?us-ascii?q?wQ0JevhnOoHUh9XOz5zN+tK9dcrJFDl6pPDkhybG5fr66wzUB9vZNNwFvxMKWV?=
 =?us-ascii?q?H6vUcLBgfbxWJnevwwbShS+AqiN5LBMLsN4gekmpxyCnQS/cgW5HKBavQjeK0d?=
 =?us-ascii?q?h8k3pUVW6vKPp9BL2J7NkGYJUcSZAkDU8dm2rq82SzWbRlzrXS5pY4W6k7oyQB?=
 =?us-ascii?q?Nyp7TMf/BI4TfHYEMii50vUrD+HnlRA4XPpqTxFK4HruXrrentUvGtEg6TdVUN?=
 =?us-ascii?q?8KGgWF/AkQWDwAKE0S2q7+1hyZSnvo3x1M8okITQWoarSRHjeURmzWnrXTCshN?=
 =?us-ascii?q?0tx94Dbgh8A/UokbLy1/xO4XHJwKtrPQ5ucVwSTFCOpqh9z/2LWQHjYB5gk5xO?=
 =?us-ascii?q?ltZQf1e9MTVwaI/ifc4cDY4?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGae7YqCHmFMPsTrlHemB55DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXoBLSC9E/bo6vxG+c5w6faaskdzZJhNo6HjBEDEewK7yXcX2/hqAV7BZniAhI?=
 =?us-ascii?q?LAFugLhuvfKn/balTDH4ZmtJuIGJIOcOEYY2IK6PoSIzPVLz/j+rS6GWyT6ts2?=
 =?us-ascii?q?t00dNj2CopsP0ztE?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DrAACV1odhhwMP49RaGwEBAQEBAQEBB?=
 =?us-ascii?q?QEBARIBAQEDAwEBAUCBWQKDdjoxhEeOb4F3i0OHCIwSCwEDAQ0+AQIEAQGCDYJ?=
 =?us-ascii?q?1AoJTAh0HAQQ1BQ0BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDggnEySFaA2CNSkBg?=
 =?us-ascii?q?2QDAyMVCAEBESYBDwsaAiYCAlcGAQwIAQGCbYJVAQMzqxaBMYEBgggBAQaERx8?=
 =?us-ascii?q?sIlGBWgmBECoBiiKDDHonEIFVRIE8gwM+h12CZdFkMweCC4EwgTkLnSUGFC2DW?=
 =?us-ascii?q?gERkXgOBpEwlhAfgiGjbIF5gXwzGiSDOFEZD44gGYQMiixAMzgCBgsBAQMJhUc?=
 =?us-ascii?q?BAYssAQE?=
X-IPAS-Result: =?us-ascii?q?A0DrAACV1odhhwMP49RaGwEBAQEBAQEBBQEBARIBAQEDAwE?=
 =?us-ascii?q?BAUCBWQKDdjoxhEeOb4F3i0OHCIwSCwEDAQ0+AQIEAQGCDYJ1AoJTAh0HAQQ1B?=
 =?us-ascii?q?Q0BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDggnEySFaA2CNSkBg2QDAyMVCAEBESY?=
 =?us-ascii?q?BDwsaAiYCAlcGAQwIAQGCbYJVAQMzqxaBMYEBgggBAQaERx8sIlGBWgmBECoBi?=
 =?us-ascii?q?iKDDHonEIFVRIE8gwM+h12CZdFkMweCC4EwgTkLnSUGFC2DWgERkXgOBpEwlhA?=
 =?us-ascii?q?fgiGjbIF5gXwzGiSDOFEZD44gGYQMiixAMzgCBgsBAQMJhUcBAYssAQE?=
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2378595"
X-MGA-submission: =?us-ascii?q?MDHo2KZe+bpBzgLxhcSiXrFRlAJuHeYSCHBLX0?=
 =?us-ascii?q?omcZDuZERIfLLCYqFslbWxkYDtcNTXeClN5r/shG2+/Q5ZsgU4zH4hq5?=
 =?us-ascii?q?3MOXqp5lDXUyrycEcmxqC5GMqp8hOP5kt85APraUyxYYY8nmfR4LgraS?=
 =?us-ascii?q?flxAI2nmrfVS2b3s3eYtD4gw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 14:40:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1636292411;
	bh=rpUWs9FEnBbqyA39E3pYmXb3CQm9+WwnlhhoJePR3pU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qunfNML38+o5QPR7IhJ4QCYt/pJUUsupf+qUe0fhff5eATdIyrIJNrnfRMa/W10b+
	 e+Yu9ZFDPu90Pnr0Pd422xngsiCnFmTenTmPdisFAz74Q/WK56pir5QgS0Q3DEmzf+
	 EVIiMkQBSvGSdNcNujy8QqvF2yQgE1kjgRlMQFfY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.63.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jaS-1mbqgZ29mu-013ILA; Sun, 07
 Nov 2021 14:40:11 +0100
Message-ID: <02e2b7cf-4a37-ca2f-8ade-0cd731b7e660@web.de>
Date: Sun, 7 Nov 2021 14:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Vlastimil Babka <vbabka@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
 <alpine.DEB.2.22.394.2111071321530.2988@hadrien>
 <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
 <alpine.DEB.2.22.394.2111071417560.2988@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2111071417560.2988@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e2ETEEnXbI1zRtlozriu3jeROSqYZ9vHaGDPnTDOvmnNr01rhMA
 H/ImbQHwKaVfu2YtAS+349b2DJTRUOmR0Yekd1p6DhSAoqQV/1mTiyZP3TXDam9x83zCviH
 M26PijOgL4LZInZxD/0wxE+bhY29ATVvZj1YulI+WqtGSnV5TFvXSg1fLo9EeX1nfHyX9si
 sbJ4mScysON4WsuGrBaLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ra0fcQn8++I=:JK6zOh0xuVOTtGK7aaZ3bq
 EYTx6bSXc5UAxf4s25YHLusXrlfGb9v8hmhtm/gEfk2v9eFrCDUGJUT0hUr2gy6nok/SIMIVL
 /wA0i8fRJl7uq9Q4sUzTbx0o3jv6i1QAo3NDZTFxvY0385qS0Wi5MLk4sTqPEzhJA9lYzomp5
 v+N8XqedeaABrNoPutOyo9szHKEKJXwsfjrm6RZwn2KHTV1HM+/PVCIZMuJW3ZVNP3H3Z7fdD
 /EdzXmHXv1r0SZyyIApF/SJkcCqnjUdRXuSWx+cOb6vTjwXBrDADnX6fyyZ2QbIO17HY9sBCw
 0WPUb47tQR6Ud+lKnbFzkPFLZLR3vL6umDp3MMfnE5cLUHbHn8CBi1KToRMEcjBd4P4c+hibf
 bomNBIvQhl+hbNTcn4dR/43TybIlOdsvAeyVjzpLCFxrWqU7cnIGx7eF7GaytdazoN+zyp7oW
 q+OeOq8bS03ogFLsMGo9vA0D/LKq+It7g26KgVR1xrwHKOEMSwIDoOxuAbLq1RUA0nrWbB2l5
 kTomk2h/nPDll7dGCZiAoiI15luYUcPbSbt3DF/XNtMdZNd5/kxQAfMNbINZDSJxmaXmo2xmY
 Id6ky1Fm/gxgyM9FTEsI72vXWzdkdPcv2373ZGmVHTHzujCsTt3Qhb7Tb84kjI33R/NJN88qT
 KL3aqWo5l8Xf+ktWMzhIX/4ag/V7oHYmbIMk1zndeCb2W/sZ3sRWdFNUR277lAd6qkLpEgXOP
 Q0wSxn3kPOoSCnbldvTFc70918g7N7Q5Qt+uR8DRN77pyIoqlM0yjklpk1IcRil6oCQLa+M/W
 0di4vYKmxlDEFOcm8/lOfmnse51yDt+cFKbVI9FSxi7AGZvaJHIrx/OzAWIw+ijlS9AN4STpd
 y6+6GdYcAukhQbGBB6TCo1jh2H05Rwk36bcsuXG0krlGAwu1F8VMhNEuKpwsGBKLJFQFDxQRb
 0OCZUbA+7jQcZiaIOcqXonbCAlXGeUzejqzBTgqYBfWE4pUoLNlOKdkigsi72B4nvcfl6052H
 mhxgeHuFPkl+Onmid0anTRalbGWuNfYFRxVIPqVEXP8C2rFBkOyxNNba/8M04dNoom9+jUzFQ
 l/hWMbTaEPKtOc=
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 91
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/02e2b7cf-4a37-ca2f-8ade-0cd731b7e660%40web.de>

>> @@
>> @@
>> -struct page
>> +struct slab
>
> It looks fine to me.

Such a transformation pattern can be applied to some degree.
I imagine that there are more source code adjustments to consider
so that the desired software update will become reasonably safe.

Regards,
Markus
