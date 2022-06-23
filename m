Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E20C433EF
	for <cocci@archiver.kernel.org>; Thu, 23 Jun 2022 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fhnuMnrWZbXmbnWPjYjZMIhTElJAANJ2wAvhJ1Tri3U=;
  b=Z3np5l4tJyXxdtagKc3dFkj9MjfuH4ZrzlB/ubh2l6ErUGIPkTp+8n3M
   QUgAGaGpnTSwHxRFzk3xaz7hQQojz1Wd3OEOfuHquh0BQilVAcQST+nqw
   DIq8c7MxR3GY8xmytefI68/HXb1+qrcMfIv2GLHV2AHrCS3S4vmd3254q
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,217,1650924000"; 
   d="scan'208";a="42637917"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2022 21:50:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22C4AE7E65; Thu, 23 Jun 2022 21:50:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D8D4E7E63
	for <cocci@sympa.inria.fr>; Thu, 23 Jun 2022 21:50:57 +0200 (CEST)
IronPort-SDR: kAtvFUS1CGtZaA9G+k5eSsjxXsxX4y+t+v1cmFv2z4nxjbR0VOKZS+gNQ0/J5WOCSkdrBjiOpU
 gQ5wQChWDtixweiCBscs9Qlej2tHMIqyfiGh493ydMtLFviVXRvExgVsbNstZhAgeQ6Z2qaC1L
 bg45MOg2ib/PzXnsfWgVoxdzCSdStOINorEUGFMnsjwFIzCkvJj4NjXpWN+CuYTSabsA64MhxR
 ZDtHLeWjSturH6fIENWx4rg5V/rAV/foHH9ZGBvsMSpMDuZtafACmXOkCy2XHTflT/OtnTrwGP
 WRleV4DECal4eCKdNMdCwiNs
X-IPAS-Result: =?us-ascii?q?A0AIAAAPw7Rihk7ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYIjgVcuBAtEhBE9jmeBdzGEIYcKhxyMIwsBA?=
 =?us-ascii?q?wENPwECBAEBgg+CdAKFSgIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBEwEBAQwLCQcICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECA?=
 =?us-ascii?q?gEMFwQZAQERJgEECwkCGgImAgJXBgEMBgIBAReCYoJlAQMNIweQI5wUfzKBA?=
 =?us-ascii?q?YIIAQEGhEofLCJSgVwJgREsAYpXgyN6JxCBVUSBPAyCRzA+gQ+DNYNWgmWZF?=
 =?us-ascii?q?SYEDwMaLS8SgSBuAQgGAwMHCgUwBgIMGBQEAhMSTQYcAhIFBwoGFQ4UHBISF?=
 =?us-ascii?q?wwPAxIDEQEHAgkSCBUrCAMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIA?=
 =?us-ascii?q?xkeLAkCBA4DQAgLCgMRBAMTGAkWCBAEBgMILw0nCwMFDw0BBgMGAgUFAQMgA?=
 =?us-ascii?q?xQDBSQHAyEPJg0NBBsHHQMDBSUDAgIbBwICAwIGFQYCAhhWLg0IBAgEGB8kD?=
 =?us-ascii?q?wUCBy8FBC8CHgQFBhEIAhYCBgQFAgQEFgIQCAIIJxcHExgbGQEFMicQCSEWB?=
 =?us-ascii?q?gofCgYFBhYDI0gmBQo7Dyg0NjwsHxsKgRssCSIYAwQEAwIGHgMDJQILBiIBG?=
 =?us-ascii?q?wKaKHGBD6NVoCE0B4IUgT2BRAyeLwYTLYNjknMOBpF6lnAgpxuBd4F/Mxokg?=
 =?us-ascii?q?zdOAQIBAg0BAgIDAQIBAgkBAQKOHRkeg26KLT80OwIGAQoBAQMJhUcBAYk4A?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 JdcE9ezsXQqG/lcBkk3RLQ/
IronPort-Data: A9a23:urrj/q1+VKYbJhLimvbD5b13kn2cJEfYwER7XKvMYLTBsI5bpzVWn
 TNKDGqOOquCZGD3Ktp/Pdu28UJQ6JTRyNFgHFc/3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywYbVvqYy2YLjW13X4
 ouoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt8Jt+
 u1WlcSPcz0KHfLxsr0/UB5JHD4raMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBpaAoWycXp
 KZed2BlghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrGvqUvoIEgm1YasZmPMaHa
 pMwa2dTPRXgMh5danYQCswXk7L97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl0z9Cw4TMNi32zuA+GilwO7JhyLyHowIfIBU7dZvh0CPgHMeAlsaWDNXvMVVlGasR+BnM
 GxMxRAUjottyWbybNr6ThKn9SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVscgOteODKp+drHGZ7h
 wThc8fBVGA+6eX9pWe1rO/MxQ5eLxT5OkcuSEc5oeYt5t7+vMcsgxiJQtsL/E+JYj/dSW6YL
 9Oi9nBWa1AvYSgjifzTEbfv3WvEm3QxZlRpjjg7p0r8hu+DWKarZpaz9X/Q5utaIYCSQzGp5
 SZZxZDGvbhUUs3RykRhpdnh+pn2t55p1xWD0TZS82UJq2zFF4OLINwBvmokTKuXGpxeIGO1C
 KMshe+hzMYOYCXzNPEfj3OZUopzhanmCdn/UP3IJtNBCqWdhyfXlByCkXW4hji3+GB1yf9XE
 c7CLa6EUChGYYw6k2Leb7pMidcDm3FlrUuOFMCT50r8itK2OiXKIYrpxXPVMojVGovf/V2Jm
 zueXuPWoyhivBrWM3aGoNZOcwhiwLpSLcmelvG7v9WremJOcFzNwdeIqV/4U4A6zalTiMnS+
 XSxBh1RxFbl2y/YJA/MZn06MOHjWpN2rHQaOy0wPA/0iiZ5Ptv1tP8SJ8ktYL0q1O1/1voqH
 fMLTMW3BKgdQDrw/TlAP4L2q5ZvdUjwiA/XZ3ilbTEzcoROXQvM/tO4LALj+DNQXDW6v40yr
 uT4hA/cRJMCQSVkDdrXMa7+kQnu4CJFwO8rBhnGONhefkno4bNGES2pg69lOdwIJDXC2iCei
 VScDyAYku+R8YU7x9/E2PKfpICzHuoiRUdXEjWJ7buyMiWGrGOvzZUZCbSNei3BEnz58uOua
 LwNnf37NfQGmndMspZ9Suo6k/hhuoG3/7IKnB55GHjrbkiwDu0yKHex3f5J6v9HyIhftFbkQ
 UmI4NRbZe6ENZ+3ClIXPwZ5PO2P2etNw2vX6ukpZlr37ml78ePfA0lVOhCNjg1bLad0ad90n
 71+5ZROswHv2AA3NtumjzxP8zreJHI3U5Ih6sMQDrjth1d50VpFe5HdVnT77Zznhw+g6aX2z
 uJ4RZYuhoiwAmLHdGcvU2fA16xRiPziffyMIEAqfzy0dhjt35fbHyG9NRwoQw4TwhgvPydbJ
 D1wL0MsTUmR124AuSWANlxA3yleCRff9kGZJ57lUoHGZxHAa1Eh51HR9QpAEI71Po6ckvVmE
 Gmk9VvY
IronPort-HdrOrdr: A9a23:sxMMUasvgXNCu2jYL46ZedDe7skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,217,1650924000"; 
   d="scan'208";a="17635462"
X-MGA-submission: =?us-ascii?q?MDHfBhYRCA+zz23Y8RjQeg+Wd0es4ZxhtEa+JW?=
 =?us-ascii?q?FF65XYm/J76xyEalXXK/RNHwp+e3MIZaVlwfYVbJz3JScbtt8muH+r+A?=
 =?us-ascii?q?vK4qjHh6AUdYyCr2M1ueqzp0oJSjJwuSJFx4QtcxxiJcm9NyOTE7v4k+?=
 =?us-ascii?q?X2rwZm4Wh0VpjAaxYMEhCXzw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:50:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656013854;
	bh=hftVUZU7ESbZ6ijI4zOMKXY4EbmWLhofinZB9vGs9dU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pfjmv6f5bqO0Cq220V84ni9G4Qe3j/TuzW2GU39B9o32rRn71OSzTcZfVOBw/PwHu
	 MMqAQSM7Q1gFkftOqenADtUgC4svA6FLzJotfFutaRds2DVZKsthy//6hzLQd2Wv7m
	 BXN96ere/ichE99L1u1RpsXwJyOOx7d19u1/lVNU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.49.47.129]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1nMdn52Swr-00iCa0; Thu, 23
 Jun 2022 21:50:54 +0200
Message-ID: <6525216c-4e17-0ec9-5372-2704d351b2e8@web.de>
Date: Thu, 23 Jun 2022 21:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s7dnLORt3YO/ogJDVFnRktLbWYpfcMK9Nlqyj6Y2Hkg7u6m4Gvr
 VgCz9rb6+JLgDION+dztgwUIe+h9gYXeqLSGN0b1iRvWpvvwBBVcV8b3fknanAjkaV3zBzU
 K9AJeZ+SCjCZbIo/4QZWMwu9o4kdk83CVEVmEN2Bv2lYf/R2x310d9gYcTEJWDOU0Zz4Uzn
 tdSrxXzN2WNlaBXK28CmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gjA09RYx2gQ=:oiq8yA3PrgaUXf18UbHguZ
 l9A3fVgiPdXDComKFRnlKeQMHVTVAf7sHrKwi6OuaGiVnnTlwLyL36l2HYpDe4nwNGphKEgz3
 3Lj86Dzo+N7cWgqtdzXq2uCR8V/521lpt83H95w2AwrEWTqMGxEOYQeCQwsisqFDbiuI/FIBT
 YjKkKG7yIBuYT5KYgjst+sWYz/0qwysrpQW8keAgIPX1uY4spvkqpxVpryQ3m3SWEYrOgW8Sh
 LEyRtJzTiBT6G85A9PxtIcVuKJr2WC0pizNL7+j7lPqSmZH+TQMnUExQnVccSzorbFd0G5qoz
 A+6icsDsbMrhpVx+WHa9rQJjJDWCXXN8hXKzXhJYlhZtHAhUBHxHcTisfszKjnUkUFDvmx1uY
 O7WXcuAp6ySIb7X+90j9kwBUp+s8bZ3uJivojyWJY+JE8UVUqBvF69lki76TpHNiEpSfM1dlv
 UTfBBDqxpoaLA6gsY7WUGvdDhk3eLOkfAYqCfxb67ufCz8vm7kE5Y/yDfzOMsilMxq52Ek5ol
 8LOchS0f2q3qIP2GUg32JC7/B1ARbG8LP6UpSlDi+0pNu4oRsVrqXTAFeb6jQdmcTlNsdRsVc
 COD0Ch6A5loj/GBjjnyIEyuY7Ix4EA0hYLVjnduHvPQqQC7Ia6bP6zqmHFmtDhZeXX2Z7/5CR
 DBchg43sA7oxtt1l3YcA8lEdnNwU6/4UF6lYWRNBTlkciJ/edCFS0BCfaBJRT3jmCA61MUxVH
 FzO+h5fo39Y6JdzCSSm94QLRT7I7RPowEOpkmLVFEG9zMT7FZVY1IVdhiZJabEv5WHRLaCoke
 35Z7DMgNboTHGzQ0GkzKKPJTKMsGkdDoAXJ9LUv9TlRmacP5LSASQbsTasMCr+XWBSvMAVBja
 3MpKdwUc7VslCEoET/2YdoV44T79mZkKk8Io+ZNoDsdzHhTUbkQjAuy7ngclrtMJ5E7A5LSfs
 YvSApz77A6ympcGsgqYIcEiDXXq3c0EE7a7LUAYHIQeaO1YUZ/NnjhRoJswxfNiw50YrVjCvL
 me0TfP4rrLj8pCerwFm496KBROR8P0i+j47ckioS4kx6zyyoZZpIUVlYQ+2LL69ZI69k/30ID
 ajiXGz7rzdUvCw0etpuwcXQWEkl3/YlU+XrOIAp1D83Sdp2A5O9xBrjlg==
Subject: Re: [cocci] [PATCH v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 452
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/6525216c-4e17-0ec9-5372-2704d351b2e8%40web.de>

> This change aims at detecting an address test in more complex conditions
> for every test expression.
>
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v3 -> v4: Improve patch subject
> v2 -> v3: Apply Julia's suggestion to have a more generic solution + ada=
pt
> commit message and file name to this new solution.
> v1 -> v2: Moved disjunction on the condition itself instead of being on =
the
> if statements.
>
>  scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} | 4 +---


The affected software components can be improved further, can't they?


Regards,
Markus
