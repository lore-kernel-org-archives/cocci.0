Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8679FCE8D52
	for <cocci@archiver.kernel.org>; Thu, 19 Sep 2024 07:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cGs2WqBpNcN5WRBfx28twMu1pLAft+cuvXGRLFsvlyA=;
  b=leNS6rNkWBOI8AYuh0yg7L9Wc1sP3qMVkb9pxxKcDbmw2MqOs5aYfGEa
   2kz8xH6Q6FwaMF0W3F9hQN1oLPq2XrASZA5cH1VnKGTno9ogQfjfSZ4oJ
   vh+o7U/aCYistLTjTnqczvyUsu57lOquoSiYV0CCV3X7ntIoer1yiv75Q
   k=;
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
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="183924241"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Sep 2024 09:02:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D08DE0CCF; Thu, 19 Sep 2024 09:02:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B20C9E0131
	for <cocci@sympa.inria.fr>; Thu, 19 Sep 2024 09:02:15 +0200 (CEST)
IronPort-SDR: 66ebcc77_RfjKgQJO9cLILL4qYHnjLTCJGSv5kk5pow7jhiJwgERFWY1
 oI2G4KJxUm1syZE9xmkRe+cZXrnl6MrtbTnoKpA==
X-IPAS-Result: =?us-ascii?q?A0EKAAD/y+tm/wMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYJDB1shVDMEC0iEVogdhy+BdTCEO4c6h1OId?=
 =?us-ascii?q?oFWgUA+DwEDAQ1BAQIEAQEDBIUAAooCAh4HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBCAEBBQEBAQIBAQIEBgECgQoIC4UvRg2CYwEQgRSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARcCR0QBAQECASMdAQERJgEECwsaAiYCAlYGARQBAYJ9gjABAw4jB?=
 =?us-ascii?q?7BAgTKBAYIMAQEG2lofLCJXgWMJgRouAYhKAYVmO4Q6Jw+BVUSBPAuCeD6IH?=
 =?us-ascii?q?oJpkg2LbiWIanCQb1J7HANZIRMBVRMXCwkFiTgKgnYFIQQlgUUmgSGCdQiBK?=
 =?us-ascii?q?xOBBgKCV4FnCWGEO4MsYoENgT6BWQFGgReBXS8bJAuCIYEFOxeBLgU4Cj+CU?=
 =?us-ascii?q?WtOOQINAjeCKSVsglyBLwQFg2gdQAIBC209NQYDCxsGPa4KhQOld6EyNAeCN?=
 =?us-ascii?q?4FjgWMMn1EGEy+DcgGTSw4GknMuh2KQZSKoe4FnPYFZMxokgzZSCw4PjiE4g?=
 =?us-ascii?q?3XFckE1OwIHCwEBAwmFRgEBhjaBSwEB?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23:yNsQdapvDQ9XhaunGaE2UL0xYFJeBmI0ZBIvgKrLsJaIsI4StFCzt
 garIBmPbKqNNmemedBxaIy38koFscSAyYU3Tgpq+CFjRC4TpOPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvrrRC9H5qyo5GtJ5w1mPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2loD5AH4f1lIFhMt
 sA2AS8Ma1O4wNq5lefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5twJsm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PpssjKPllctuFTrGOfoX9+QaNxcokmBt
 n7lz2/APSk8NMPKnFJp9Vrp3IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTif2wlUe6X/pNK
 kke4CNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9pfpD8+iLjBsZlZ8hBYO7qfa6BRzv
 rNVt7sFxACDsYF5jVqY8aqI6yy/M24ZIAfuoMPCoRQtu7HeTEMb13ojjeqP1Iaqg9ezFTyYL
 /Wisn0ln7tK5SIU//zTwL0E6g5AYrDWQwRz6gi/sqdJKO9mTNbNWrFEImQ3IRqNwEh1g7VBU
 LU5dxCi0d0z
IronPort-HdrOrdr: A9a23:WnE2Kqs8O2hhn/iPFjRkcdbx7skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniDhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:Cgomhm0oIOMyJYM2txOkubxfRPI4bWbG3lbpIQyEJ092SbjWchio9/Yx
X-Talos-MUID: 9a23:4NLpUgkSPO5Rx41dPDBldnpfCeJr+Ym3AXwCiIUamPmPDBNIHTeC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="183924234"
X-MGA-submission: =?us-ascii?q?MDG41u4uVGu2DRmQlNohe/9SjaYr2Y+5Hjt0Yb?=
 =?us-ascii?q?7C7Ozc6p9iya8sNuk2i6JX7fKZOIGvAqaWVkyFugoaZkwrjm9UtIuzLm?=
 =?us-ascii?q?+eYPz1gr5avbV47KY4/tRWqTAZ8ihyq7z4cNDRFnRkZWn2iZrKGACxCO?=
 =?us-ascii?q?e3hprwvicZEMawmA+wiivh4g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:02:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726729299; x=1727334099; i=markus.elfring@web.de;
	bh=cGs2WqBpNcN5WRBfx28twMu1pLAft+cuvXGRLFsvlyA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=v8BKVS0or0f+NahBsObj8LPjBNY9jMANjMYI8GDmSoaHngwwpCUqSEbXUYgDffXm
	 sAufhTc1ptam/vCdfxJkcIX8SP+xp9tFpm3h2QTzwWjd6xCfcRBNnSKD1wm+XWiAy
	 JgabdLOdDo+PU7R4Hksfi3Dp3JY9CtYgQJsTYEthj0RniAFo4XMe95OvdgktdiRFi
	 vw9ZeyPl8bZTaXofLieRAhSKVNfSpRyKCYOG4cWhSOXjT2yQqK22PhDLPxuwxCcgh
	 reNIJHelqbqTWt0LEMPDbEZ4XwLjiq2vwYatR5g/vq3KMGUVm3x6lxn7f0xIcUxQ/
	 lHnd3rwqks8j94Y+Jw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1sU3Bf1arU-00JdG1; Thu, 19
 Sep 2024 09:01:39 +0200
Message-ID: <f8bab255-7e50-44cd-9476-882dd95ad9b8@web.de>
Date: Thu, 19 Sep 2024 09:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 linux-hardening@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20240911010927.741343-1-lihongbo22@huawei.com>
 <20240911010927.741343-2-lihongbo22@huawei.com>
 <2aefba9e-f04e-4ee6-60cb-a139c0641ff1@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <2aefba9e-f04e-4ee6-60cb-a139c0641ff1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jEqiU0gukV4uEXAi+gshd8WqxAVEdRjHEbKB0XRk/Y8E/F/GU5y
 NE9EKVwuaO4aJjAS6Xw+55jP1l5XKs5rpcOVJn5xi4roc0fYPsl7jMBVMX5g/Ev2horjeS+
 nNSRs4bk1G9Ee1IYNRKcmggn2Vo32BTyrkhY3GyaynM4y+g3arcGUnLQx8UDRktmt5Lgfop
 UImmm4QRx3ZQk9NHhiFeA==
UI-OutboundReport: notjunk:1;M01:P0:THtbP7Bz6VM=;fw8NMZPdYcVrpGzInfgNNT1eyUN
 CzWPWkzu+fT40U32AjtonJDqkQVRft+a0cb0fy9cZAB70iTmv71zwdyCoZKeOJ8WL47UqiUSh
 8QtmmYu3T8gVjOyNoLzRQCpcfsLyaS9DYYqk4BgxNUjv4tmTth3dZIclRdJEBJNKmLgGq1QUe
 LuVOr8KhrhFI75VbquMkQmb05kwfHKV0EDE8bnoeivEsw8/3FNugkD1yiO32Z/5p0LTW0ev5f
 Pb0JHsTK96lv/NxPZqIop64C+5BXk+hA00X5XlqhM3oY2WP349G8kjIDbcUcvS8Rfic3DcJYc
 xGpPaYTXY2ZsAHOSpto1er69/3ETOnov5jrzLUlc0C4bVh7OcrMn/ZkKc4t5usZfJwa0i9LTY
 R+hx375c1R/0jDaP/esHI4xtutAHhuBMxszoPeCysYlriuZmevjtN4FNgvhwhyLkh94sR5WjD
 fKfWLByPzNLtit5NX12du3wPm20Uv/80GyvovDakQ9MhuNNRv9Cs5/In4xTIi/TTxHP8czVIa
 OolayWov/U08bZYZTe9QYL6Ruvs4O4+5b0DtVEF00AElxHfwgb5baorZrvQE7+RER7m/6hjvP
 jd8Qh07+iZr5i2yNl5u40K6mEUPQ4202YQk2BfT5ziyVeCj2kP8RWfqMpMunoTKV5Nq5hUWXg
 Fb05NX7NfguTtW6MwxKC3jM2nMNAKXInKLbCcnG9IGN00GAHalJISaACDV8Iz7wAYPd0a01jW
 wXYYuqJmAqpjSjChcncrg+/uBjYEShFb+NRIiB907IQ7sqOx4Xd1ztJQBpNbfBe/6I/XkwMfY
 Y4w7Wqmx82kydV526Fv5J1LA==
Subject: Re: [cocci] [v3 01/10] coccinelle: Add rules to find
 str_true_false() replacements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1871
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/f8bab255-7e50-44cd-9476-882dd95ad9b8%40web.de>

> The semantic patch is quite slow.  Actually it tests a large number of
> cases, eg where the parentheses are present and where they are not.

Can such development concerns trigger any adjustments for further
coccicheck configurations and provided SmPL scripts?

Regards,
Markus
