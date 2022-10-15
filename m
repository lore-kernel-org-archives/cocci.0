Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2A5C433FE
	for <cocci@archiver.kernel.org>; Sat, 15 Oct 2022 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Jh2cxhpnEi88leaBX59Ot17bDByW0T8Lm01boyXuy2w=;
  b=GVkKwJ9iokz6CEVWNgsmTfm1/6Nz2TPjTO3V4lzZoN9MN1MUetzLJKPu
   RvCySJdOJQwD9SpWktkaLZqyMWqAYbPQ7H6YzDn0MF4Lq62FUYTQNrXFI
   J0N0yza45TkzvVbEVQPM8r1edazrvJ3om8goNq1VMbKq7d46aWEri1v3V
   M=;
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
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="65299384"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Oct 2022 14:12:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 154C7E0087; Sat, 15 Oct 2022 14:12:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C66CEE0038
	for <cocci@sympa.inria.fr>; Sat, 15 Oct 2022 14:12:46 +0200 (CEST)
IronPort-SDR: 634aa3bd_3jsDphe8teP0d0LlUPI7JNml+QXesnCK9I372zDOSyngI0q
 7pTPxXQQI4Gbj7HLBukXyYV4oyYeYxsKmLVhNfg==
X-IPAS-Result: =?us-ascii?q?A0AsBABgo0pjhwwR49RaHQEBAQEJARIBBQUBQIFPgiWBA?=
 =?us-ascii?q?VYuBAtFhE6QcCmSaIpHgWgLAQMBDTcIAQIEAQGCEoIuOwoChGwCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNg?=
 =?us-ascii?q?jUpg2UBAgIBIx0BAREmAQQLBQYaAhEVAgJXBgEjgmwBgmwBAw0jBwyrA4Eyg?=
 =?us-ascii?q?QGCCAEBBoFAAYMNHywiU4FcAwaBESyHGIRxgzB6JxCBVUSBSIJ3PoJiAoEZg?=
 =?us-ascii?q?QaDGIJmg2aRAYYOOANEHUADRjQDFQMUAwUhBwMZDyMNDQQWBwwDAwUlAwICG?=
 =?us-ascii?q?wcCAgMCBhMFAgJNNAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQC?=
 =?us-ascii?q?AIIJhcHEzMZAQUyJw4JIRwOGg0FBhMDIG8FQg8oL2krHRsHgQwqKBUDBAQDA?=
 =?us-ascii?q?gYTAyICDSkxFAQpEw8tBylxCQIDImUFAwMEKCwDCUAHJSQ8B1g6AQQDAhAiP?=
 =?us-ascii?q?AYDCQMCIoFMMSYFAw0XJQgFNxsECDwCBQZSEgIKEQMSDwYnSA9KPjkXBidIA?=
 =?us-ascii?q?TcQDps9gVdCgTsidsMtNAeCHIFHgUoMiWuVEDMDlmIGkhOHZ48vII0hmjOBe?=
 =?us-ascii?q?SOBWzMaJIM2TgMZD44gGYNZM4otPzQ7AgYLAQEDCYVHAQGFDAEB?=
IronPort-PHdr: A9a23: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
 AYUh6z1J8IfO9+js6SNQkZ3lsLGFhiJNe0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Wy0WTqHVN+7UqCJ4pLqEJMeALOsnbusQ8zAXPo5KKSC9E/bo9f
 xG+c5x6faaskd1ZJhNo7690Yi7MBfhHNtOkO8s1NSZMDUO2lHGEGgK1+KLrgEIWReOj9K0EM
 xbAs9D4bbLfDtHZKjBgTVQaOxQu+Vu68qT9J3jJppWPHxXQpAl0yc8LgqACEV5SE16FYM0fa
 DsnvaunlCbCAgqhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="65299379"
X-MGA-submission: =?us-ascii?q?MDGe73Co7YCfGbmHwKIkYRPhbPN/hHHdAjI5ji?=
 =?us-ascii?q?+Ce4TvnLV2sgIgnj5EZ73DD+ZQypcfOmt0PVUckkez4OTpHOS7Zy7wiz?=
 =?us-ascii?q?C9Vv8PICM4vxqzCP87qqxHZXig/aqnoRd5gYIwfRxTV12YY1GVj+QlQh?=
 =?us-ascii?q?SOmpAggEXIOg0D7Dto50zIuw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 14:12:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665835960; bh=Uzra9eAsUMVyh2Fg9qh5ZJ5sIxtChd200433EImEkqA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZd8ZZaWuaGEjF4Gr7WtvTdWmMIXwIfXieESLDdffYvwKH+G2Eziq/b+tal62/XVj
	 F6PZp2qPaYQ0qf7TAqPLNf7MpL6yv7bUBeT/vFAYWIteq9cUcXXCXwXWpo51yTKRh+
	 pHnlcn01L+u0iI+C2FP0nmgfe8XU56PsNRgI/P2y8XBvPslxDPEN01SiE9yc+h/2Jl
	 dsTEJ6AYMZ5J6nehC1+cuGXXojDoS5GkytQvXkvKQZXWa/wF40NUn/zEKmSSJlTx+8
	 iZasQH9vR1fmfIRgj/56hpmKOpZo9oqtqWhcPfw+0rv93GrqncQ+efjp1Cci99N2Oq
	 w3dRCotF5Ajkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.81.160] ([94.31.81.160]) by web-mail.web.de
 (3c-app-webde-bap48.server.lan [172.19.172.48]) (via HTTP); Sat, 15 Oct
 2022 14:12:40 +0200
MIME-Version: 1.0
Message-ID: <trinity-d7fb79c4-f928-4e4c-a219-b44a6661c39b-1665835960332@3c-app-webde-bap48>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Oct 2022 14:12:40 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr>
References: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com>
 <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ouERVspF857fY9xFnBHXUUI/mdfRQyaU94QHpk9WmqzLR642FsgjJGgOrxRo9p7vWKiLH
 XpXxQuDOO1LvH/eK0VFe+EHTaqZN9J/qlx4ulfznjEHUTI66R54t2uDKB9HcsdetmClk7sPe5/+k
 vhud2m2FNqzZ6Y/QU3EMcDqN9/wxQ/g+rEaAhVicXcmb2aYCiQt+qEVvuueG5Z9ZXyMB4w83kpsw
 KZqabZAFt3UOrJ0t69DfZ27MH+Rt+ezGdKYPIhff7m197n5gqycCRo5b/jaWMp/jO6dSEdSfOE5S
 eY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:zc1tmCmGuKw=:uB2N1JyhICYmHD5oMmpDyy
 jMoH3587EHkMQs0sN9aQLb4WYiMs6xxMlI6sSy767d6p98V+YdnSW1ZSM0394WTXGm0UAXDaA
 MWsA3ptVXb8i6D0ouU7LueAgTbOV9t4qKlOacqK+nguyS23MbFf3kCT8qfcRG+P5m7/xy3VB2
 sIwUHQAWqsV4fFQ8YZJ5ShaF7iNVYFOMd7rIfavXgoxPNltzaZUILOwVt7XISSfIN5fuhnOzF
 H6Coob47WF+cQF5nkz80hv5rcmRNca5vTworq/bw8hTIIvbGi8IbK1/uF2OlfwOjccKC1y5av
 8A6FdP5AaRaSDxzROMrU+dKXtPIT82rbU4uezRJxANAp4JTFn95qAgtrzEK8fO0Zj0+06xlw7
 qFToLEvlC0czo6rSigOcfLUYDhrjwB6VN969fv69hXKrg3zEOm5D4Tm/D5gcv2qNt4kB1Adla
 Y1xG8SupX32dhMW+67hK6ax9jAbq34ttj33KLBcOOiOCCZmm4W8/lgmDPkqCvKEBG/8497zzL
 DEq/4oFesZwmUejjhVazEKMLDBSodRbfft+cAo9mpwtJpiRw6h0wm5lFme4LvqH9kepXw1sPG
 ooTSgdaEovCKuecH7eOjiLkHmPruM5NZO0WbkhPgWbok/l5wUlfXYeMLN4U3t4oLUUuA+i7bC
 qX6UIdh+jTUzz3iLadSh2K3s7BBHzD22EipCe6WLL3nUSBsMVvDCjz6lK20scalF04vHAf1tq
 L7hw0W6X6S63RSaHi86ZSDAkytQh4xC2S1wM9A5Ewt0e9J7sgsuH1qM0F+i0Fzc2XbK3sBoW1
 MIOKh0MkmJtEdiZqEzQ+49f42lJApmoTMf6OupVtVXW0rvNuf1K96YHNMKR4AV89HDp/72s8T
 tVRpxXJo669BDW4/lytP/1Epd4nqu7ltOKrcTuA6ml+x5F2hHqhTfQeKxDwZ8WPQUmdZnugmn
 8L+axQqZVMbtpWKIQY/D8tYZo/wMc9wARf1zzalhfDgYauI3nxvILQgAAxPCgVFHLiTqiWx1Q
 x/mW6fmK7MrKKABP3pqi4ZWIGOcVGw/YNylCANtOJ2x6mBg09QGPeEI8s3/C6VxRqT5AwkqcN
 T/p2PZVIx3blU1r4ztI/r8pgaOBGyuaqUqoanUnoXAhrtySEYusPIFT//thW81WwxV+OKzz/n
 6eOrKkB9+rO89NnvtJdk29I+fP15IGv2+hs3MdTyG/KAYiwB2Xev19UiNNd/wjGPk7RNoSYT3
 z+MfFRTmqwSx1QUpSqmOh+jRe5l+jj6nDF1LShjbbTty4k3mkB0PnP1z+Cx3RMSForMI49BA7
 1NLskhcm
Subject: Re: [cocci] spatch adds zero or two lines after if statement
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 648
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-d7fb79c4-f928-4e4c-a219-b44a6661c39b-1665835960332%403c-app-webde-bap48>

> > Adding 'if' statement to the code does not add empty line after it,
> > as expected, but if I explicitly add empty line spatch adds two lines,
> > and this is unexpected.

I find these use cases also interesting.


> > How can I convince spatch to add exactly one line?

I suggest to take another look at some software development possibilities.

2020-11-06
Checking the handling of line breaks for source code transformations
https://github.com/coccinelle/coccinelle/issues/234


> Coccinelle is actually not intended to add any blank lines...

I proprose to reconsider such information in more detail.

* Some cases should be taken into account where the original source code
  should be preserved as much as possible despite of modification attempts.

  2018-05-23
  Add a metavariable for the handling of source code
  https://github.com/coccinelle/coccinelle/issues/140

* The semantic patch language (Coccinelle software) can eventually help further
  to achieve a consistent coding style, can't it?

  2015-03-10
  Make change influence configurable for coding style rules
  https://github.com/coccinelle/coccinelle/issues/37


Regards,
Markus
