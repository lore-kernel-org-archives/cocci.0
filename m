Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D95C32771
	for <cocci@archiver.kernel.org>; Mon, 26 Sep 2022 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RAWkcH5d219W4TE5PRGTaarDraX166/bkUli+GdW07w=;
  b=XsVgxvrOr2Ug8xWN3zVUERBX/ZeOx42CXsDNr7fAlaJH7YliMSsRYqhq
   1slS3gbY1szDK3GnWGIELsG7Hlo3xIuJoAxOB2QRrsCgoOGBwYpKSt388
   4z/u8UAYn/NUgWJ1xVQ9qzxwhYKq5lq7KaFK4zldJ3QOnUWKTqyygu6TV
   8=;
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
X-IronPort-AV: E=Sophos;i="5.93,346,1654552800"; 
   d="scan'208";a="54605958"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Sep 2022 20:42:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD1ACE0090; Mon, 26 Sep 2022 20:42:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A89F6E0090
	for <cocci@sympa.inria.fr>; Mon, 26 Sep 2022 20:42:41 +0200 (CEST)
IronPort-SDR: 6331f2a1_QuN2Sy2ZKgMvMSVfaRpqf3Rg09J/9JRTwax2hGPbYdRsRH9
 66s3gnoB86gsvrfiYLB9NRgFglQA3/KT6u/TVJw==
X-IPAS-Result: =?us-ascii?q?A0A9BwAv8TFjgAwR49RaHQEBPAEFBQECAQkBFYEqJ4E6A?=
 =?us-ascii?q?maBAVYuBAtFhE6Ob4F3CIRPjj2MKwsBAwENEgEBJQYBAgQBAYR7CgKEbAIdB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEaCRcHDg4HI?=
 =?us-ascii?q?oVoDYI1KQGDZAMDIx0BAREmAQ8LGgImAgJXBg0IAQGCeQGCbAEDMAcMqmqBM?=
 =?us-ascii?q?oEBgggBAQaETh8sIlKBXAMGgREqAgEBjy16JxCBVUSBPAyCRzA+gmIEhTSCZ?=
 =?us-ascii?q?pR/hComBA4DGSsdQQIBC0I1GAMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCA?=
 =?us-ascii?q?gMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJ?=
 =?us-ascii?q?hcHExgbGQEFMicQCSEcCgQaDQUGEwMgbwUKOg8oMWsrHRsKgQwqKBUDBAQDA?=
 =?us-ascii?q?gYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMCE?=
 =?us-ascii?q?CI9BgMJAwIkW3YCNxMVBQMNGSYIBSMXHgQIPAIFBlcTAgoSAxMPmGWCE4E5p?=
 =?us-ascii?q?QifDjQHghiBRIFJDIlmlGcGEy6DZAGTAg4GkgmXC408mi2BeCOBWzMaJIM2T?=
 =?us-ascii?q?gMZD5ISM4otPzQCATgCBgsBAQMJhUcBAYUNAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TqbFEa4+hugBfmr2BAPXwOzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,346,1654552800"; 
   d="scan'208";a="24730260"
X-MGA-submission: =?us-ascii?q?MDHZCtV7xq4O9rEUSIbG/5pbM2zGh0+3gjsx70?=
 =?us-ascii?q?320ukOJTvBVGVZgNI6agCnWe33RdHuse8sQ/6mqKEWkq1zMvOGrLeLyl?=
 =?us-ascii?q?7yfJeuWqFLBnEWUre9Gd0jsEGX78zPbpE5pMwxf/oGX1dyje464NTRIc?=
 =?us-ascii?q?kgn/HHKu8AcXtvEKRN8TCcUA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 20:42:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664217751; bh=RAWkcH5d219W4TE5PRGTaarDraX166/bkUli+GdW07w=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DxBQeEPdL0RrfJc8vcvxaob6hi2zvNX65zl0XsDOtR1spMn/bfYhxz/SFNTVjfKNX
	 4fMLzHoSKNOA9ddx2xg+rx3xaQ/kyLSRInFkuOoapYnyZPvCLTHRdA706Fqd8VE1fh
	 2eMVMaE1F31TDqjCcRr8/OX/sAojmj4SkWaXge3nugWIkXh2D3yzG48qdw2UhoWzB7
	 H7HTpoUW/Y9B8FQVuxd+vM5POgKujANhe+W11XCLvyIGkqlBb6GcvHFjHWmD1Wc6DQ
	 xLP5Su9vQ8GlI9se/wAigKNADLhpSHmlW+uIYeTki9a4zx6p/fm3lySU1DOaZ47m40
	 UEMaPa5Qb0ndQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1p0dAN3qGX-00on1i; Mon, 26
 Sep 2022 20:42:30 +0200
Message-ID: <9197b8e4-6d29-7970-2fc2-306817aea642@web.de>
Date: Mon, 26 Sep 2022 20:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:65JoEVDwbFyVCW+bAtfcL9oEo5z0WTFvi0tjq8tM6cjBWN3eTtN
 vX5m32ISp66gLTCQUcGcxv6COO2is7SB+PL2ffvYFYDUMg69rWgqcsEtJmm+qClvwAyZIMe
 CYp8v0Dq73fFCQuwWL1SEckon0kQu3DdS8YMSEi9Q6RuDze0zamPInfujPM50AD5Y26DSkh
 xO3zO0en1YHN+phWOq97g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+JqcaTXlVh4=:/tn3z9PgmYp+ZUgQEAvANM
 Z51TxMmcDTMiGnVteRfF9QxIoYsiWcOiYJEgVATHeCi6fzF5U4V3JyA1BlVdxxVbu9wMrK5SR
 Vub+0vrAWztNf8GWTmYFBHBNDXwZWG4W8s41A8YcMRnNVWwnDD4cj26kauTBOvf7p339LnVxd
 JFi/qSV4wE4VbMVhhn6E4YyxYFTIa1Ub4rxUyIYqaNWMBNFHWpJ6v2bR4br7EgOdCmShKJkyv
 XrRthGjWZkPHqZZV4Yrv7+Loj4okLFKd4slS/92Nz9NfEKZECVRxXkGyehlcp5+fjKas42udc
 GcXdhwPqYblxhD0GcEih/mIPGjnst0ERggGEYFNfpJmqs22PaTn3uUkfHxi0wdrVE3RE05kr9
 ExQxwlW2TCP8S71Jf3ifR8lc7dhgkY2jnfSUZMZmMEwrCGmesMU5sWAXHkzHh0gCTlAPdIk0R
 Xz8KMfWe+clUIMj2IocKME8Be3f68cE+bo5Rw945iMeBn6GViOJp/6LCFM5Xs46sGYYxi4nPL
 AF14FIYAVJBmXmykb+AP4Z2bIheYtcANyibbXoJKwVSAzFGGfgwreXPQ31gM3NvIium965IzG
 j1URE6o1uiPDfPpufz/Z2udhLi6UO/p4L+h2i2ihf6Nu5i8MnVLY9V81wUKOzYEQgnty69EwN
 a39BrmunQwCZ+WPRf0wu00HMqUY+yf2O3lKuXwQM32caykOZQoBgFTCu5JCbwcWosTzq+alXe
 7j/FX93BtRv6up1IYgLKXfksguhPFOl89TsUI02GsDeGhdM7Fl+9lUUvR4UXS4eALKY2DFbx8
 Gy+kO2nClDU41H35kH1pgcRmD71bUlWtr2aNchUFvI49VOlN/juLTycpinAPqNWFOh7UX3uC9
 2O7BaEfHYOQwew3Nfhl03uAaw47kjLpeakNXSV1cg8ZKWOLZKkhzJUiV+kyfma5reRusizd0s
 tLC6z2/Y9q4hRh6ejX8EDAMHRwf4sEFFvvwji8nwpH+is+p0nDglwhAKdxHseYuwZOI0yafHx
 D775eVqpSW8vKFbvuTodiifU/A7AtASe4s/o3N5b8vvp23wnxrMUpRjf+tgsPbVnBb7mKgUOK
 Rc2gQH3fIpeJqlqIq7V2PVoSY9ey2WeKqkCgu2+z2u2q45tkv7WU45IFHPNmMBtjmWdyOrHMU
 tb0rIsJApK+WmKvQflFQ+ZG5me
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 589
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/9197b8e4-6d29-7970-2fc2-306817aea642%40web.de>

> (* check for standard initializations and locks *)
>
> @init@
> type t;
> t o;
> identifier f;
> position p;
> @@
>
> \(spin_lock_init\|mutex_init\|__mutex_init\|__mutex_rt_init\)(\(&o.f@p\|&o.f@p[...]\))


Can it matter to detect the usage of the following macros?
https://elixir.bootlin.com/linux/v6.0-rc7/source/include/linux/mutex.h#L108

* __MUTEX_INITIALIZER
* DEFINE_MUTEX


Regards,
Markus

