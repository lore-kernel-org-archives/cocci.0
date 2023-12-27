Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1170EC46CD2
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sFYtgUqx5/8rcJnSIVTUvLcv4KtPODMLVzVAeiTwlds=;
  b=juhs40FdO5H0ALa4ewLtYQWDm7GnVUWNtwamZnH3OEYshO7K9m+P7na9
   EQQYMCVXRf+zC2dYIa5UE9EysQd/7NqPi5cHjhW6dNXrYU2Z4+rKXX2k1
   KgUkAsz+2YAzDwrLRCGI0E9uoj6fGIKvmsX+erDBY/0T7CwxkQ4RK2SAF
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="144108377"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 09:20:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25B50E0CCA; Wed, 27 Dec 2023 09:20:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 33CBEE004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 09:19:58 +0100 (CET)
IronPort-SDR: 658bde2e_kjjc9lhEoakg+s7UCmrks0kdvs//rpxfyHXS1oVrA7i5C9u
 RVSbKuYrzya4qaSjMaij+IhJI+nG7XB32xZsFqw==
X-IPAS-Result: =?us-ascii?q?A0HEAACG3Ytl/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4B3hTMgQLSIRTj0GBdTCEO4c1h0yEa4QEgxY+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIILgnQChzYCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBBAEjH?=
 =?us-ascii?q?QEBESYBDwsaAiYCAlYGARQBAYJ8gisBAw4jB68mgTKBAYIKAQEGr1gfLCJWg?=
 =?us-ascii?q?WAJgRouAYgaAYVng0F6Jw+BVUSBPIMDPogegmiLcZUnWyIFQXAbAwcDfw8rB?=
 =?us-ascii?q?wQwGwcGCRQYFSMGUAQoIQkTEkCBXYFSCoEBPw8OEYI+KzY2GUiCWBUMNQQ1E?=
 =?us-ascii?q?XUQKgQUF4EPBGobEh43ERAFEg0DCHQdAhEjPAMFAwQzChINCyEFVgNCBkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAaBgwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2kfMgk8D?=
 =?us-ascii?q?wwaAhseDScjAixCAxEFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDC?=
 =?us-ascii?q?AQDEBspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+AiemHlooJziUf?=
 =?us-ascii?q?7IsNAeCNIFggWEMnysGEy+DbpM4DgaSVC6HUJBPIKhGgXkngVkzGiSDNk8DG?=
 =?us-ascii?q?Q+OIAwWFoNzj0dANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 xUM3NLsWL9bybdtJzgDtQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bo2ZMaO7u5VXCcBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:5AMoVW+moEyThC6yElmVv38xO8UmXGOM8HfzCV6/IktqbOzSW3bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AgZIdAgxMHFYjH5RFBxJh80+fSUSaqLueVksQu4c?=
 =?us-ascii?q?hgZWFGxcgZDG0jzqzQ6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="144108360"
X-MGA-submission: =?us-ascii?q?MDE2WNOT06mBbHdRzA+cF1QiV5RIIo0Y0Q7e4Y?=
 =?us-ascii?q?buydsViV7zN+IYm9rhSKYOtuR6/gZMrARN83ysd2y12IDQE/CgCe5QRi?=
 =?us-ascii?q?iUdbnLAP6Wc++6JYRrIg4YAIDE/ad81RbP+G0CxTDYubk/LA6foHIn7u?=
 =?us-ascii?q?+bx+IdW4Rnl2N3RsWSzr3k/A=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:19:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703665181; x=1704269981; i=markus.elfring@web.de;
	bh=sFYtgUqx5/8rcJnSIVTUvLcv4KtPODMLVzVAeiTwlds=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WNJzKeGxXHHQRvaxrlLeNKs7d9lveaMaReCX6jcIn7YV4oec6G40Drl/LOAWvpeX
	 uOK8eoBBrcFtGqkyebStkwLZpu1I8thiD1YOzTNhAA01+UK+5QCKshVbns3y3Bf9G
	 3TfNDKaBJjOZPx0XFOzIO7CEImEYw8vt0vSpEnVYl8Q4NAUq7sDfXIkUwx/v0adpe
	 Fjho5UQB3xgaMpXL9JuKJ+6dwGi8E8MIS5yoHtRf67RxSEF59D2ZeLzHMN4fyKdNX
	 lLvI0rLB5ojEwLAtzXDKZC0VLfMBe7Yr5y6+gLZ8s7ZiXZNfsnBA1NmgtLZybVsvP
	 VSUUdLoCZdKJ6ow3Mw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bYo-1rIwpv0ata-0024wc; Wed, 27
 Dec 2023 09:19:41 +0100
Message-ID: <b75d66cc-a507-432a-af60-655950671b8a@web.de>
Date: Wed, 27 Dec 2023 09:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 David Vernet <void@manifault.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <3203eb44-6e69-4bda-b585-426408cb75ee@web.de>
 <618f886f-b2ff-4d50-cf74-e8478a7e8547@huaweicloud.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <618f886f-b2ff-4d50-cf74-e8478a7e8547@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NNpJY3Chs/fDzSODGnjQi2SuOxapzbSnV9uYQXas/LJUzP3dHWM
 ZkCkRh1p01y9VGYRQEgXS9iB1Cyu4HDqwqITh9XPhAgwxmdLqjFqiWuVgJe8DJ3Q3hryMyb
 wQL7/8yUdZSBccjulsM6UYrmbViANudJBCtQMfl+FUkIgfxqojyayCUfXKDvfKQdiNKgcil
 6CLJnD6WnszV80CBMPTkw==
UI-OutboundReport: notjunk:1;M01:P0:WkaRGhcrnBU=;d8sDLIBDrl2jkJ2jQNLzsFQzxRt
 yLPFiYbt2Mai7UAArrpAeKw1WwERVGzrztshO0YCvoD3Ar6TwsFcUra18qlFRy65tuHk1M3dF
 TQZfxAcfl5ZYGionVkIXVnZiguLLJXmUqbbdpVeviMJzenNYKdwAnqWjda5GlYZZp4NnJ6Beq
 5LQ1gQt5VGd1wvaCEUWa6YMpRpi6/TC79P6MX3KIf8OV/tvp1ICWVk7e3OB/J6sUXwjI2O12U
 iNKRGWlw8NTt+9mcsCwQ6gIYsnYPq//PytckavXBMurAq1xG+z30z138IYakOjR5JTjJdsssb
 yAMEG1/yGxRgW18irodWsQ3PdDbBG9YQKZE1/PmJCoIi/dIB7sI9sYoMLe3vC9PBDxw61wlz1
 IWtCCAmdhy01JvL36Jv4MIpw3yPCNMiias4RR3rkc9ZnVid/BHmjeXrq4z0Xy72WpUh1Rk5n3
 CosWNhXNw2W3ZAfoUa397W3FyrH4Iriw7M8wm3jbC3QenBdxdWscxmDVDZZObi9Ju9Q8v6q9b
 0rtjq0ewp99ReayD+Y0ROSv38giolAav6NL6FNsmLwPtXes/CuAgumSf9b56X3ZTk2Npz47oZ
 peMSbVt4/OCAO8CFCh95WRbov7Bj+EbF6OHKERKW9M9eVUmjPp5N6vSUHMj8j8aG17LiwJ0OX
 +9fsmef2G3lP2xUSxzHfyWGfFFM3quJz2r1LC1EtKiei+ZZYuXXLos6hKeBCcmBkiEXhzGPYc
 ndFEc5cfmkR5boSYuFQLJLf96erEbAKseT48RC72Xlh2PFzXc+QvXfGMHBHScVw9jA9Y55RG0
 jGd+Pphxo18wirT16aptYWR5HilJCTti+Bf3y/ciIFZDZBD2zwwbj1mjc4RVIVIsWlpb9bAT8
 uq3emOnFmtIamDo3BO7x9Pd2QNJSQHEa0Plp30OnCNd+jDMY5i612R3LKtw3M+7Q7O2OqHm1w
 XnduCuATJOAt7N0tufYTle62Eww=
Subject: Re: [cocci] HID: bpf: One function call less in
 call_hid_bpf_rdesc_fixup() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1408
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/b75d66cc-a507-432a-af60-655950671b8a%40web.de>

>> The kfree() function was called in one case by the
>> call_hid_bpf_rdesc_fixup() function during error handling
>> even if the passed data structure member contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>
> It is totally OK to free a null pointer through kfree() and the ENOMEM
> case is an unlikely case, so I don't think the patch is necessary.

Would you ever like to avoid redundant data processing a bit more?

Regards,
Markus
