Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF770C6FA82
	for <cocci@archiver.kernel.org>; Fri, 16 Sep 2022 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dXfYlg6XIZl6FqHZ8KpUzgE2mGDmXBYambjgf/3UUu4=;
  b=KRrXKuJYpcodAjSz+Zy/3u1ZzH3qUGDlkogJxqsP7o3OzWW22IZ/Jv4K
   D1N6IO+Lf7W+9pEzAIwExYerUIiQGA4SL4Gw3bxuNYlbviTaXW9uFrKwg
   yv2Qf7R5CjGft4RSpSsBQlgzJqucAEU1hNtoCqKCoQMH0qLvd0ucQ7toQ
   w=;
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
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="53173148"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2022 16:44:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BBC09E019F; Fri, 16 Sep 2022 16:44:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 056B0E0157
	for <cocci@sympa.inria.fr>; Fri, 16 Sep 2022 16:44:04 +0200 (CEST)
IronPort-SDR: 63248bb3_o4lyoce+VyGwnJ7VU7oK/DyVzTRmoiUC+sLyqxmZZBL8Tq3
 YDGfxIsH6uAQqp2QdJyjIKL7YhYdrhOHE3HPUpA==
X-IPAS-Result: =?us-ascii?q?A0ApAwCziiRjhk7ASNlaHQEBAQEJARIBBQUBQIFPgiSBV?=
 =?us-ascii?q?y4EC0WETo5vgXeEV4cXhySEWodRCwEDAQ0/AQIEAQGFBQKEagIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBFwkZBw4QBSKFaA2CN?=
 =?us-ascii?q?SkBg2QDAyMdAQERJgEPCxoCJgICVwYNCAEBgnmCbQEDMAepCIExgQGCCAEBB?=
 =?us-ascii?q?oROHywiUoFcCYERLJAkJxCBVUSBPAyCdz6IGoJmlQeDeiYEDgMaKx1BAgELQ?=
 =?us-ascii?q?jUYAxQDBSQHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk04CAQIBCskD?=
 =?us-ascii?q?wUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTGBsZAQUyJxAJIRwKB?=
 =?us-ascii?q?BoNBQYTAyBvBQo7DygzNTkrHRsKgQ4qKBUDBAQDAgYTAwMiAhAqMRQEKRMSL?=
 =?us-ascii?q?QcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWToBBAMDECI9BgMJAwIkE0h3AjcTF?=
 =?us-ascii?q?QUDDRkmCAUjFh4ECD4CBQbgIDQHghaBQ4FHDJ5LBhMug2STAg4GkgkthwkTj?=
 =?us-ascii?q?0GnZYF4I4FbMxokgzZOAxkPjiAZhAyKLT80OwIGAQoBAQMJhUcBAYU+AQE?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 d0DgKbOyckwYNicTSjB3Q==
IronPort-HdrOrdr: A9a23:CVjiRKprjeXIFc3gMext5tMaV5pFeYIsimQD101hICG9E/b4qy
 nAppkmPHPP5Ar5O0tPpTnjAsa9qBrnnPZICOIqV4tKMjOMhFeV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="53173141"
X-MGA-submission: =?us-ascii?q?MDFHP1tkXqMbxxy46mxCKhaGUnrkTQlHRaZ6Br?=
 =?us-ascii?q?9Qab02viIrU5y38qJtPpIWAgBFT3EmM4m37bOoKHKIQ4r6PUhB+JFrlH?=
 =?us-ascii?q?+Bzx+cfgOBOOasQcutFdDUlqHZt89/cL6bf5HTYduDtiCwrg72C7AGbf?=
 =?us-ascii?q?RvvkwnC2wizgSY9pmEJL3PMg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:44:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663339432; bh=I4AHhvq2iBrxpdTqGBsR50xZVgfDJohABFOC5v5boko=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=gKEkVw1bGY9K2O+iYLCKTD+vTbQ0u5GKelNNJBcoP8WBRJfSHfHxqE8nr/W+r7dPa
	 8h5K4RicE6k2eBMx43dn3+FxexwkBBMRv111Q2Crddw/94uWgvDdpqB1sjcQDt1HiU
	 a5+u4eO1DbiJwEIGckyKVjw6O6b5OwubwxjhdzLAyiUx3kXPG23LA/An5Jxvaltxqk
	 WjPnTJrYeqdi/nZJ7ConSkqmJByDMVv6J+29nYydRI5jphtraGTCVfv/DYP+VdgEZK
	 /ytlEiH2qQmKX3ttWWRG/X7mmTbtoBWHFfTFgVb7NEn6qiUBSd5J98m/ATTU+27D8M
	 QgbTqg0ynnEKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvrs-1oieV33XjG-00RR8T; Fri, 16
 Sep 2022 16:43:51 +0200
Message-ID: <ac3b9185-4b55-9c19-1050-3b659791c59a@web.de>
Date: Fri, 16 Sep 2022 16:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Yuan Can <yuancan@huawei.com>
References: <20220916061923.29759-1-yuancan@huawei.com>
Content-Language: en-GB
Cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220916061923.29759-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:klNt00d4lQJBBPdYP3zZqO9cwGiLit/YqYHoWxwes6H0rSQkGr7
 IAsHXWkh6Mk10Y/ilFsmlLn4kImrXU1DWkRcQfUdYJo/EM464pZiqLn4jaNnGXP+zLriwaQ
 rSNPWlG0ICeZaTbRJ9RavwcXmgKUeIx3SYjcUSw8Gj1LeiwLUvzr56JuGT6idQCqJEOPGdu
 Ecbl8OP3oFXoQ3m0+9pBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2y5/DVEhVWI=:d4ovsYg9rwZVaEcI/WA+Cm
 lv6tnHg09SQ5HGaKFxxWc02+A48rIw56544Tr99NeoGpFE9cHzBfwFMhTDmJH+6KZPJxaU2G9
 5SO4moNaKVjplRo1rtLQv/dideDG81nbuw9sjcBJeRdv+1uaILASH9b9cLpj5jJQtK7Zw2Vm8
 Z+s1MxIRdBXXOUMzAVMWmcIXPXVGDYv1myvjfH9mUPGS3/4zONOO0lnKM9EN/5Klo8wQV3pmW
 G5FBavzj198bwsL83+TNnKdg/nfN/1v7UZzzc4kOGSTSJ4FSCa+L+e17grQ8KPY+dUszp8r9d
 SZ78WfkiqExkiP8EMvBEZeG1D06HD6xwqUt8SxL+kCEJkqgDuJPeljpuwTLKA9NkMfw+zy5XR
 xexMSTogs7hmbpIc66L7CWtaxc6nGgQLtDkFHeSGBJef0R7LAg5ejselSS74TbduWguaLwsx6
 ftyg2emoavurAMIRehayvEsBIr/Vo2NBqzpH4lIP5HdjcWukS6y1fFxb6N8NQ1MMnjgAYe3Fh
 GZXPDMDDFANXwiEX2ljFwBC7fWNkB8OSBbW+hD5M/K90dsiSplYT1PoEoUCxlA/Nw307fi9/8
 z0NwwsH2I+F5R4hfy4WsTtpsphBiqAHwUjmVVW9i1MMQlcXmI6niPO7/3I1FZ5OwEgjG88z2D
 oJp2Xt0jaH596CNxg6CnBnKr4rN+yphvGa5opwcOsGKfY5t4FI8Y6oL5rdM/n5I9XDqmDGMSV
 knxHBPyiFkhDjpjgTocui280+xRPXVlWMD/TW/qDgvM3ccRM3hkSNzHjhRkIo2llgzgR5IOy6
 K9qym+4IF1g2C7l4s+NIc3qHT5y4MlnWTxUQKi1344fLs1ReMoCHu1jWrNa62jy/Y2xFJeIj8
 vsQWvSPVN90OPn+L4G63HZekaiRaeYq8qi30k4l1AWYnRt5wO0g9C9CF2C3pckrTW7oIpzRuZ
 z4Zc4qAtRF1bFwGUV1lBppTjM0LTJKrwekaRkLaWCneLSqT5ZpkV+yCVDgzzw7Nauy7lk0ZyB
 ot/iYuOXFgBuBRmdg8E1d296yVDCarCtkgy4gu2T500KwkFgY8ZxWgX0T7GYINXTn6IYVGUdR
 7ec/eB2kyP8rts+xT6sPAC35BAX3aIvuxpQZycR5iOOL4mDUnha7i7mCR+7eMSgu90BmYARxL
 WSFqhUtM9EkLDoZZn0EypNwcAR
Subject: Re: [cocci] [PATCH 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 552
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/ac3b9185-4b55-9c19-1050-3b659791c59a%40web.de>


=E2=80=A6

> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
=E2=80=A6
> +// Comments:


Can the specification of any key words become more helpful
instead of leaving such a comment field empty?



> +@r3@
> +identifier s, fld;
> +position p !=3D {r2.p};
> +@@
> +
> +struct s {
> +  ...
> +  struct mutex fld@p;
> +  ...
> +};


Why would you like to search for another mutex?

How many mutexes will matter for the proposed source code search pattern?

Regards,
Markus

