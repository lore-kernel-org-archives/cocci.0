Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6655DC77B7A
	for <cocci@archiver.kernel.org>; Wed,  7 Jun 2023 09:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Yj97qsTfunhUueXNq0q1rJKCpavuSL6kOegsRx8g25k=;
  b=pw4e4GcwduADwASA1i8FCICX8kGAWXQZPmB9LK5eZl/kDmC3PlPHq6Ow
   4eyDrkP+iamVVhldtbCkdzFGaASvNrBNj0uCRNpHDGaY91LAs8kXwRSO7
   KySLmO9IeIveg7SLGX7xawxbPw2SGKTcU5BWJsjBo23XzLTPvyjQ71Fvb
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,223,1681164000"; 
   d="scan'208";a="111661611"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2023 11:08:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40FCCE0CCE; Wed,  7 Jun 2023 11:08:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B163E00BA
	for <cocci@sympa.inria.fr>; Wed,  7 Jun 2023 11:08:42 +0200 (CEST)
IronPort-SDR: 64804919_XZs4PxB0zPoHqeP9I1QfH6+BwzTyeeSOPNPQjyM71iDdbVj
 JAZCa6HzNmxugs+TYek/JAKWJlQ/LpwjRiPeomw==
X-IPAS-Result: =?us-ascii?q?A0H+AACjR4BkgA4P49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIudQNTMAQLR4RSiB2JNIQzjnSIbIFWgUA+DwEDAQ00DQECBAEBAwQ4gRQ/g?=
 =?us-ascii?q?nQChWoCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEkFwcOBQkphWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICD?=
 =?us-ascii?q?To/AQICASMdAQERJgEECwsaAiYCAlcGAQwGAgEBgnoBgicBAw4jBw2taIEyg?=
 =?us-ascii?q?QGCCAEBBoJmmSgfLCJVgV8DBoEVLQGNLoM3eicPgVVEgTwMgng+giArFwEDG?=
 =?us-ascii?q?IFGg1uCZ44zhR2JS4Epb4EegSJ/AgkCEWeBCghfgXNAAg1UCwtjgR1SPYFGA?=
 =?us-ascii?q?gIRKRMUBU17HQMHBAKBBRAvBwQyCRUJBgkYGBgnBlMHLSQJExVCBINaCoERQ?=
 =?us-ascii?q?BUOEYJEJQQOAxkrHUACAQtwPTUGAwsfBiYBHgIrgVcwWG8KJCSdTgODAwJ6P?=
 =?us-ascii?q?0Y6l0ytezUHgjCBW4FdDIoSlQkGEy+XEw4Gki0ul2Ygi0mBcZpbgWM6gVwzG?=
 =?us-ascii?q?iSDNhM8AxkPjiCEJ4RhiigBPj80AgEBBzACBwEKAQEDCYVGAQGFfgEB?=
IronPort-PHdr: A9a23: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
 kFucjvJFes5Z1pIcGd2lEnDtJEJFfMOFcV5
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:hVIDA6+b1cpqybEhy+xuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:wtaYMWOBYkM85+5DdSxd7hUMFp8ZNSeC7nXaJRT7Mjo2cejA
X-Talos-MUID: 9a23:C772wAhbEEFUdW87ivMXecMpCphi+IKwUEIxgcsBlNHaLyM3ZymPpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,223,1681164000"; 
   d="scan'208";a="58075902"
X-MGA-submission: =?us-ascii?q?MDH3VAsaOJYtrVQvYeCPGOUh8NABSvGRf3yzPy?=
 =?us-ascii?q?cRCiP1z4hUM59iW6NNFJ7CEX5bzpi7LV9LsW2K8rHtVY9nvEkJQNNX/l?=
 =?us-ascii?q?86U1YWiQePiy/6WfV5HSA0OEXeetPQypGIpBfJeowGgqYkaGdsaBIZCZ?=
 =?us-ascii?q?2qj+mjJKZx7zixutXCWlwpUA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 11:08:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686128913; x=1686733713; i=markus.elfring@web.de;
 bh=Yj97qsTfunhUueXNq0q1rJKCpavuSL6kOegsRx8g25k=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=kl2etMEc//aLe8DADiNPUeIzxN8fKbDdT1tK9D1cB4DlnIrWdT9UbWFFzgRrkppEIJADqNy
 6qYI5IVKr8L5KGvzvxQnl5qPneRFTIWCin0UEf+wlrg1FYa5g8P6thEO1TXUllGMFfKAe7X4U
 IIU/2i4+dqkhdBzjz8rk36HlZmYGkbwahS+93nSgwO276S8BckItKiC6jr8PmXlIAGPv/0jVo
 YJrluXl9JmVfJR6I6fumsAK809KzrSdl5dhD5RAo/kdCOjx8aAOrzAJehOYAvIbDsoTYOLhM8
 hRg6twKas6tDfJVUZSrX1FveZGKfIyUUDe8pOtUXazoVKIK3aYiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMXx5-1qQHiQ2XSB-00JQTz; Wed, 07
 Jun 2023 11:08:33 +0200
Message-ID: <5fed7bff-4040-497e-5e1d-f6d7f9f383f6@web.de>
Date: Wed, 7 Jun 2023 11:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zheng Wang <zyytlz.wz@163.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 1395428693sheep@gmail.com, alex000young@gmail.com, hackerzheng666@gmail.com
References: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
 <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
 <e98a620b-7b3b-0d5c-3bc8-4cbbda1dd057@web.de>
In-Reply-To: <e98a620b-7b3b-0d5c-3bc8-4cbbda1dd057@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y0md0Qw1j8+VIA5X1GbBuTsvGcd2kA9zbVGMqyU1XFZuGWS4Rbt
 Wrmx7DEjELt5xOXNxbScc1bh6rcriGx8Y+HvU9lxrQDHxEH00vdMz7Sl3YisNAG8bznnVxZ
 25KXioTDUmJtv3HXdnuYnFEf3kCqQYps2Qa/DnqPeJJr6UYUXSJn9JqKlBJRUlY88egrezg
 Mi/aF9i6dWR0Xe0QSVPhQ==
UI-OutboundReport: notjunk:1;M01:P0:A5rpwg1B70s=;o+AY9AmHbs6mbknW/9N6YDGHsLO
 76QCNBId48OqKh57ALjUVPWB3k3WAG082/oYttS/cdQQ7kGUw1SeCUhrc/twVjfGRcslZxtFP
 AVrigbuFI7mDuZdnpzrZDg8yDcroHoGftrFjwa++Tmbw5wS9astk0LwWH1sy8Xn6RQZMEW+WO
 t4tt6xIjAkn+gGElf2Y7YwlZsFGdUx56y5KeYNoxC0J3EZWUdU/IvlcueGlq6kvz6BUXrgMqw
 XCtHDMtvGzFbpLVVpHX39WHpK6Hmp0UokSMxm9AjL61HFcUU2jEjP1EClan1iIFiDJ+Rc2gjZ
 4Xqlbbs5ZJ6c6QTZYo0nBTfoELKaA+oTzIK1RIBQlw1PikgZD7dFMSkOPznyz8ez97xm2Ku2L
 1fkhw0Yn0B6mXB7KAkSrol7AkaTeklCbhmvgeCcyH+IFgYTJF3GfyJoL7qMzk+SNo624XdU9p
 Y2xqsAhoUdn1EZYzweBN15PD1X1pgR6RWPPThiR7B2Qu317Hi1F3UoOfHLPylZ+NpjKTgcXoZ
 fMPkKxDQvJK1VZEa3KNS1tnpteq8tS5uPJqTnggk6tr9Gp7fy//l+eNiExUxNo5RBSXWQdQqW
 eg+CB84oT8+GNSEfsdrznprRPqOqag+NZcikUgzbSpgUaOfcl6MB1AhSdkrC/Xa2V8w1jrYs5
 ZffWjpthY6a/kFVvK6Ye3P76q1QcSQxvbCcCcGluAWKRCo4xwvEL22NZjF0iksFlMGqWJ+prk
 smptJRUQjKtb8Wbv+wNR21N0OUkxoW3W4ux6lV1JYasgtn0CvCpKmJGk5MqD4ZyaCO+R1mk2a
 SvjCmOmmLiKhSeMDtRsD5+j1ddQJn2zv+eZo06DZLW7yGULXYNE3uQuzlgVG2THX+9qrskwC5
 U3F0TS+PogSmlLG+VXfPeE/yJ4bywhlYicsKdD9e8KdXydgrxAVJyNA2MZ/Dciy4SHbu/YOi4
 st/UlCUf9VnD0QXOoaeQ+Lsw7AY=
Subject: Re: [cocci] [2/4] fbdev: imsttfb: Fix exception handling in
 imsttfb_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1173
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/5fed7bff-4040-497e-5e1d-f6d7f9f383f6%40web.de>

> The exception handling was incomplete.
>
> The label =E2=80=9Cerror=E2=80=9D was used to jump to another pointer ch=
eck despite of
> the detail in the implementation of the function =E2=80=9Cimsttfb_probe=
=E2=80=9D
> that it was determined already that the corresponding variable
> contained a null pointer.
>
> * Thus use more appropriate labels instead.
>
> * Delete two redundant checks.

I noticed that the software evolution was continued with an other change v=
ariant.

fbdev: imsttfb: Fix error path of imsttfb_probe()
https://lore.kernel.org/linux-fbdev/20230527093901.487483-1-deller@gmx.de/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
drivers/video/fbdev/imsttfb.c?h=3Dv6.4-rc5&id=3D518ecb6a209f6ff678aeadf9f2=
bf870c0982ca85

Regards,
Markus
