Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD76C433EF
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 13:37:11 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D556E61051
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 13:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D556E61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1816504"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 14:37:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B2D35E0295; Wed,  3 Nov 2021 14:37:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1F0B0E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 14:37:05 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AgppVfBaSSBm/Ug//wfkgjZH/LTHT0IqcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gaPBdyQsqgew6qO6ua8AzRGuc7A+Fk5M7V0Hycfj?=
 =?us-ascii?q?ssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd?=
 =?us-ascii?q?6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAuroQnLqsUanIRuJrsvxhfXv3BEf?=
 =?us-ascii?q?/hayX5yKV+cgRrw+t288IJ//yhVpvks69NOXaLmcqoiULdWFi4mM2c75M3qsRn?=
 =?us-ascii?q?MUw6C7WYCX2sVjxRFHRHL4An1UZntvCT6sPF92DSBMs3tUb80QzWi4Lx1RxLul?=
 =?us-ascii?q?SwKKiQ28GDTisx3kaJbvBesrAFxzoLIfI2YMud1c6XAdt0YWGVBRN5cWS9PDIy?=
 =?us-ascii?q?zYYQBEeoPM/tEoIfyvFYOsRmzCBOwCO/zxDJFhHn71rA63eQ7FgHG2RQtEdUUv?=
 =?us-ascii?q?3TOr9X1KbwSWv26wqnMwzXDdfJW2THy6IPVdR0vpuuDXahzccrM0kkjDQzLjlG?=
 =?us-ascii?q?eqYz/PjOV0OsNvnOV7uV+Tu2jkXMopB9orzWp28wjhZXHiJgPxVDY6SV23pw1J?=
 =?us-ascii?q?dugRUN7YdOqHoZcuiCUOYV5Tc0sTWVltSI0x7AatpC2YjUHxZU6yhPCdvGJfIm?=
 =?us-ascii?q?F7xDtWeuVPDp0mXBodr2wiRi87EStzPD3WMez0FZPtCVFk9/Mu2gC1xzS9siHS?=
 =?us-ascii?q?uZ98Vy71TmT0ADT7+dJKl03m6rDM5Mt3KM8moQJvUjdACP7ml/6gLKUe0k+5+S?=
 =?us-ascii?q?k9vzrb7Hoq5OGKoN5hA/zPr4zlsCjH+g0KBYCUmid9O+hzrPs51f5T69PjvAuk?=
 =?us-ascii?q?qnWrpTaJcMDq668BA9Vz5oj5wyxDji4y9sUh2QII0xddBKGiYjmJU3OLejmAfu?=
 =?us-ascii?q?inVigiilny+7EM7H7H5nALGLPnKr8cbpl7k5T0gszzdRR55JODbEBJer+VEjru?=
 =?us-ascii?q?9zCDR85Lhe0z/zoBtV52IMeQ2OPAqmWMK7Jv16H+PkgL/ORa4ALoDr9MeQq5+b?=
 =?us-ascii?q?yjX8lnl8QZbWm3ZwLZ3+kH/RrOF6ZYHrpgtcZC2gGpAs+TOrwiF2DSzFffXiyX?=
 =?us-ascii?q?7hvrg08XYmhBozCboGrmr2ImimhTbNMYWUTL1mWEmrzP6iAVe0Nbi3adupoiD8?=
 =?us-ascii?q?ZTv6MT4E71BehnBD3wfxrI7yHqWUjqZv/2Y0ttKXonhYo+GksZyx8+2SKUn0yg?=
 =?us-ascii?q?W4CATM7jvgXSalV1VqJl6R10aQw/TN7+P5DFAs3Z8e08g=3D=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3AVuLt6azZp5NJ8lkidld6t+eMxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDJ3gTNVyTQcCDuHbPmPNGGgfdByb9vg8xxXuZWGnIRlOVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OlULW?=
 =?us-ascii?q?cYEideCc9IMsfoUI78wIGqtUw6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kurP8b1FMXbPYewSD4pZUc/L72F4Y/HN0i/l9baN0hUR/011lm/hUwc9OqIf2Z?=
 =?us-ascii?q?AMnJKzKl8wCXhMeHywW0ahuoe+efyTu6KR/yGWfLieymqwwZK0sBqUT/e18AEl?=
 =?us-ascii?q?V5PkAIXYMaAqCjqS42tqGpkNEkpx2d4+2KNpK4jc42WuMVbB8HMuaV/6fvZkFy?=
 =?us-ascii?q?Ghlr95qNvP4S8o9SDNJVA/AXwdpBFYyHMtmyb/s3m2XnyZwrVWIuewo7mKVwAE?=
 =?us-ascii?q?Z7VQkC/KNEvTieCmfth/wSqP6E2XF7tUyMduC1Xya/3jqiuKncebTMG4NPOXQy?=
 =?us-ascii?q?xKoqAT7Kq8v5Nk+Slax5/W04qJ7c8wKMFQao0LCsoBrnHFGjbDBs9mQv3OO+BI?=
 =?us-ascii?q?RMzaVO4XW9ynVopfpD82l6qTog9KPhBHKdCP7eNDy6mK0og=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AopHinq+f4WI7nPiKz4Zuk+ABI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlD/Bw8vrEoB11737JYUkqKRcdcLy7VJVoAkmsjKKdmLNhRotKBTOWwl?=
 =?us-ascii?q?dAT7sSkbcKoQeBJ8SWzIc0v5uIFZIQNDSaNzVHZKjBjjVRbr4bsaG6GXST9IXj?=
 =?us-ascii?q?JwsEd3AMV0gZ1XYbNu9tKDwTeODuP+tdKKah?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B9CwAtj4JhhwsR49RaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgVkCAYMeVzoxhEeObIF3kkCKFoF7CwEDAQ0SAQEhCQECBAEBOwG?=
 =?us-ascii?q?BUYIwgxoCHQcBBDYEDQECBBUBAQUBAQECAQMDBAETAQEBDA0OCDokhWgNQAEQA?=
 =?us-ascii?q?YFjIoQVFQgBAREnNAImAmwIAQGCbQGCVAEDMwutYIExgQGCCAEBBoE+AYEbgW0?=
 =?us-ascii?q?fLCJRgVoDBoEQKgGFfBNBh20QgVVEgTwMgkeDUQKCLYJLgmWPczgiPoEuI5Iuj?=
 =?us-ascii?q?jedaDMHgguBLAWBNAuHcoEVlBkGFC2VZA4GkTCWDox0lASBFIQegXsMgW4zGiR?=
 =?us-ascii?q?PgmlRGQ+OIBmDWTOKLEAzOAIGCwEBAwmFRwEBgXGJcQEB?=
X-IPAS-Result: =?us-ascii?q?A0B9CwAtj4JhhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAgVk?=
 =?us-ascii?q?CAYMeVzoxhEeObIF3kkCKFoF7CwEDAQ0SAQEhCQECBAEBOwGBUYIwgxoCHQcBB?=
 =?us-ascii?q?DYEDQECBBUBAQUBAQECAQMDBAETAQEBDA0OCDokhWgNQAEQAYFjIoQVFQgBARE?=
 =?us-ascii?q?nNAImAmwIAQGCbQGCVAEDMwutYIExgQGCCAEBBoE+AYEbgW0fLCJRgVoDBoEQK?=
 =?us-ascii?q?gGFfBNBh20QgVVEgTwMgkeDUQKCLYJLgmWPczgiPoEuI5IujjedaDMHgguBLAW?=
 =?us-ascii?q?BNAuHcoEVlBkGFC2VZA4GkTCWDox0lASBFIQegXsMgW4zGiRPgmlRGQ+OIBmDW?=
 =?us-ascii?q?TOKLEAzOAIGCwEBAwmFRwEBgXGJcQEB?=
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1816491"
X-MGA-submission: =?us-ascii?q?MDFa3bBuO9Q4wAZmuaD5nnClzGMezoagD742yo?=
 =?us-ascii?q?CwKYg+flgS2YXaZyQA0Zno2KONWNKtGKDOCIMJvernJY1ugTQhc3jhoX?=
 =?us-ascii?q?BHSXIa/tdLa1DMX27HnIFoi+PuZDSKrp7Lked2rTHxJg1FnnZvB4PCb4?=
 =?us-ascii?q?ps0eEkGc/6xkDcFZUtQcv3Jg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 14:37:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1635946624;
	bh=q4lwHdz/EzU/59l/71ZYTjNutHEKd6ZDaq3SSNixetE=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=p7VhRiFp3sZZi4nPCz8NuICPiZyGgIA1TQAtBtzuS7VIvTLfJ99C/o6LeoDiEgiqM
	 vBgJ9RbG3ixIhv3JG3nZhRmtn813//EXzZKw0OViUNRVRjB04rYE/LFjwQ3AkdSkNP
	 Km3MstqdQASY/dCs3kNXix40V2yrRIYmtz5pXh6U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.102.25]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3p7-1mwJSa3rtf-00F3Od for
 <cocci@inria.fr>; Wed, 03 Nov 2021 14:37:04 +0100
Message-ID: <70e08eec-0d29-0256-f21f-26f3589a9419@web.de>
Date: Wed, 3 Nov 2021 14:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5QXDRZfuGmrUT/x3l9R1Ou47/K8SrJut2Rcks27AeI+S8ld5lE8
 rM1NRXHZlKcYNigtjYKbgrMY+Di6Xi+mRMb85tCA2+HBihYvq+0oLi5Kge6JdniVfhSHtkc
 zWJ5bWMZF4SoS3vrFaMis9L48NgmrLwqb2wC5UeUXWgU/oW+3PahqLLIysK1VzJg1fXmBxM
 NJlMxO4Y9W9PNXovHprgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ver1sAxolzs=:BZ9nE1aKG1gA7E8VXOx3O7
 9VSlqwA+mSq5U1nk9PmhgWcmOa7HZC/Snw/o2UBIZxdCppUFDXEvq7zSZf7az5j1C9mnTxeYy
 NSe4mFHJBbcifNkcer+iG6DKL6JAXOK4fsEsc0GWwWQwnKJYDm3GciUwznApjgGkpCemLc2aJ
 xMf4GecZ4l6iqp5doN9P5OubKFpZZJ7DHXCfgOwnCwvksifArje1S1zA7G3RG4LkOCH71dEpp
 rF13HxWGef7KkjSxEtB/yRsh3+zbb6CcEsFtrlx+nlunfxlrbaxJPgX9Ixn7ac2hn0IbF3wId
 VOadoZvi94dncg2ATkIzf4syBAqS8VNEo1CRnkEkRxxkc2o1PPunXilkqKdLrjTIDgl50IH6o
 4yWqMKKWUzEtFqVz6Z+g4HuGOVmh/+8qrIzfFaP8EKYidameCBCD+fbm1stlRj6HMpkF5XJe+
 1PdtRMrLqMky0vrr55Shc9B7+8kg6b16+9Gz6L4Me3EFR0mJnxlTU2w+uDWFRgkTgnSPq+kUj
 FURY85hkCULeY/p1cjtC38DyDje8Bpgc6uTzZaX709uwcufflZcfb1xwk3L4sMd0ulQXdIhAW
 kRkNszIskZcV06tMV/s4i3fovH9f3/YCLIh4xQxbHgLuruUkYX9hbPvYMNqGW/DU0OpLO1z5U
 0VBBOT+CEoPuYvCTQ3+RfkfmbXYxJWxXRd2L6Iw03wQ0T3/JWORkzSMhbycYstJp07/xfzAf8
 L5FdRQ80og6nHn6PeAd91ZwPKfuQqyie3l+eJM0W+7tPYSSlsFJaaDCXKKaDZjZX2eDYwM1Ot
 15Ul0LNjgVVqRIPo13ej29FHEdq6mgLDHj/ejytPqfpVayMLSE6rcH+HW6xBMcNdtkjeUl2zU
 +59Zh0ai6IbkiNSbXchNEMWe/O2fo2Jn4d85rTarSbN7fHDVyE+vps/ibFQPT8VbuDqElqTIu
 EJ1fiHWsx7Z7nfbGgFC3WynL7q7V2NSClRTFhfkwyHpJ7WG7nVDUpnenMy8Q6YMHZ7MbUt5Mv
 D0L9GX3A+l/1egoyjiZ/n2sEAV1f109pT7hzjbYzstqFiNe8+9p1LhTP9A/Z5hNFYKktoI8np
 5Pe/BkxG96kChU=
Subject: [cocci] Detailed categorisation for binary operators of SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 62
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/70e08eec-0d29-0256-f21f-26f3589a9419%40web.de>

Hello,

I dare to repeat one of my development ideas in the hope that it could influence
another bit of software evolution.

2016-01-16 11:05
Fine-tuning around evaluation of binary operators with SmPL

I would like to clarify another aspect around the usage of binary operators
in the semantic patch language.
A corresponding metavariable can manage also a constraint there.
Each operator can be selected by a list. I imagine that it would be nice
to express a special restriction on a specific property like "Distributivity"
(non-commutative) for them directly.


See also:
Extend mapping of metavariable types for operators
https://github.com/coccinelle/coccinelle/issues/224

Regards,
Markus
