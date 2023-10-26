Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807A9C25B6B
	for <cocci@archiver.kernel.org>; Thu, 26 Oct 2023 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uPjYhLBsnApcPlFMvHabM3yS4xS1nBDLSyTPT4cr+Is=;
  b=rfQVx7Mrh2nF2bUsfO1kPeeumafIoykVFGDKp1RzbfZV06G7OB2ccGnR
   hbjZccykfRHpVzEYq7raBn8oATZ2M97msky2j6mkfMqax9GklMKTzerhv
   BzIzy7H+ZKVECJLhVT0ZiRSv+pfYP+uMsM2CFnIpiGGgnxS01XF/viLNT
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,253,1694728800"; 
   d="scan'208";a="133284552"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2023 11:15:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D177E0CD6; Thu, 26 Oct 2023 11:15:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8BCDAE00B7
	for <cocci@sympa.inria.fr>; Thu, 26 Oct 2023 11:15:23 +0200 (CEST)
IronPort-SDR: 653a2e2a_So6xflOTngvMML8ltHDZTTlAhmF8K2kh39YLiABdABlP/dG
 zf1Fjv76jeC5XmVvJ6PVe4A4EdEAQjNZ06ZLtQw==
X-IPAS-Result: =?us-ascii?q?A0GGAgCsLDplhwsR49RaHgEBCxIMQIFEC4I5elYwBAtIh?=
 =?us-ascii?q?FORYYQ7jn2Ib4FWgUA+DwEDAQ07BgECBAEBAwSCC4J0AocZAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4QJ4VoDYI3K?=
 =?us-ascii?q?wERgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCDTpCAQICASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVwYBFAEBgnoBgikBAw4jBw0GsA16gTKBAYIJAQEGr1QfLCJVgV8DBoEaL?=
 =?us-ascii?q?ogKAYVRhDUnD4FVRIE8C4J4PmmBeAEBAhiBRoNbgmiDdYU6BQKCVINXjBxeI?=
 =?us-ascii?q?gVCcBsDBwOBAxArBwQwGwcGCRYYFSUGUQQtJAkTEj4EgWeBUQqBAz8PDhGCQ?=
 =?us-ascii?q?x8CBzY2GUuCWwkVDDRNdhAqBBQXgRIEah8VHjcREgUSDQMIdh0CESM8AwUDB?=
 =?us-ascii?q?DQKFQ0LIQVXA0QGSgsDAhoFAwMEgTYFDR4CEBoGDScDAxlNAhAUAzsDAwYDC?=
 =?us-ascii?q?zEDMFdHDFkDbx8YHgk8DwwfAhseDSssBA4DGSsdQAIBC209NQkLGwY+AiedS?=
 =?us-ascii?q?WyDaj9QgTjFGDQHgjGBXoFfDIoWlQ0GEy+DbpMvDgaSSZg8II1FmmyBYzqBX?=
 =?us-ascii?q?DMaJIM2TwMZD44gGYNfM49IPzUCCTACBwsBAQMJhUYBAYNagUpfAQE?=
IronPort-PHdr: A9a23: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
 H8mVbJRElA4RKtyNw==
IronPort-Data: A9a23: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
 Z86eodV312r5w==
IronPort-HdrOrdr: A9a23:0v3iIaOJDCnBa8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3A+EM8KmqU44GZrG3xSQh1BcfmUdorb17k7V7VHxK?=
 =?us-ascii?q?HAEcyQ5G6blCv46wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A3+pPxQ57XQyuMrG7PpjRhuERxoxW5OOBBmtWo6w?=
 =?us-ascii?q?Uotu9PnFyYQy+oTeOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,253,1694728800"; 
   d="scan'208";a="69815588"
X-MGA-submission: =?us-ascii?q?MDFAyKOu1F1ki8zc80XFjD5gakYfg8SwyPi0sV?=
 =?us-ascii?q?UcT190RCnm+i699vidFlFF/TNgn3SgJrUBhXyYQGKXpg+AFkvrTESGN0?=
 =?us-ascii?q?g9XK4/MRt74CaHlIIPTzz8YUJGhDAFHdvsZfL9wxCi/vrSeJ6msrYKLu?=
 =?us-ascii?q?7Yp0CoSM1srGMxq7JtB4iA8g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:15:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698311720; x=1698916520; i=markus.elfring@web.de;
	bh=uPjYhLBsnApcPlFMvHabM3yS4xS1nBDLSyTPT4cr+Is=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=FFI0qs6WyomJ7qswYclYyPFibuPbHMSvaFsDrPZifJtacH/miOlAoss/4DoB2LTM
	 H6G7xB+ZG4uYbvuMQAmf7BpInVkOLpuniy8WZtcNF7jRBo5NEv22KvgsKRVqv7+9q
	 R8cGCEBgXLkt1M+sMc0AtUpehXYfNiKVgnAbBNBI7tyBrk6mpoMJYixHsRPwSrH4y
	 lxBvU3B7TKVPkzliF1x5XeIBmfBH1HglQYuKRac+hFVUzYTqxsVJXzjXAw8IlCNDx
	 iVXh7o5FCOU+yIaecYVobNGNFdwi2/oT2+HB1kWnWBowB9G764ox7NF6d367MYdNF
	 olOsz1po7th+hXGBPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1qsvnB2UuT-005aLZ; Thu, 26
 Oct 2023 11:15:20 +0200
Message-ID: <6e6f06cc-c300-4e80-9973-6c0ba0a43317@web.de>
Date: Thu, 26 Oct 2023 11:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20231026075755.GA19414@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231026075755.GA19414@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYvOEDCH+bC4CmvrPFjhyAbyEqLJiwI/bPxVxTdLHhgcs0oYNcP
 W7xOQ1kiQkuawmXKvp9LNDb7znRCOL4LdI6cSkiY9lhZOgnozW72CFDJdSs8cszSVtZOE4o
 thzho5G0ah7/+diLm2ZfhOeB7vBa5ush4AyRIotyOQ5lqW3xhyrKhNzShfkaiadeP01XI+S
 vZpU+ZPaSXwFO44QYPg3Q==
UI-OutboundReport: notjunk:1;M01:P0:ageIINofp/w=;63cQRGU/Pn3rAQo5gYVOoHvrJPN
 DGHMvBKYBNbkn7/MfxLS68POscI1TaK4LCjBc4KKMst0ByhlPSwnd7Gh2bmhZkbClgkemgE1x
 cQrYneWoROXIPWEY/8VR1TtdihUk3LDhkGhtH72m2Ls2dIE626JfHxSfG/aD19LZbGV82udAa
 CPPvkrsT3/y1qpGWHng6g7EFSy0hICArykOoVhmrR/iXZ1FcscP2FBS1DVa3PB6ycGmRQX7kU
 cmmb4GUjnLZHQ4oetGDva2WUT6OpmKJtd29TaZ0kvoBf//R7npz3kmw6IYF87t72DGXTTamrk
 Czhonto9lCrt7ohZ9cemG9wF/o9vOR3z/XcuwXcQTVGRUkiGfQCkH6+HsmhT//StohF3QPW0E
 6yXwukdQgBI1rsHXX0ytZlJ8ro/N4q3zpoETqxQyNknR6fIzvGkEJE35wiJXYN9NM08C0+jCB
 mm9CrL+kR7FP5OOCZ7OYp/VslIbJ8LdX9HjGVROr70ogl+4bYix3d5dy+CveDEw0xa6+gnS6R
 qOTLbMBcaQbchq4VRaB3/wQREJpt8WoxYJvHxebTwjGcZ/T/ATENKVPhYXUNJyRuiWWE1bqH0
 vGM+Pa3OKEsFurMFnHgwIXNsSJr7X9h9o5Iq1E7Qul3J/WYArFuk6o8A2YgUxQxT2ylm+Mz8u
 Sj69oVp92hvwqG0mkdt2ld6b/xaxRFT9CcMwRmHZEdj5N37lsIWt9ZzTMNUxFswL2+MCuTcGn
 hOogT7VqMwY9cCaueIj5JmNAkhByX+TrTioH1OVhj3aCUP9OMd88DoGTIRCrxJjwoI35UAz3G
 BK
Subject: Re: [cocci] Report that Coccinelle doesn't compile with Python
 3.13.0a1
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1279
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/6e6f06cc-c300-4e80-9973-6c0ba0a43317%40web.de>

> https://bugzilla.redhat.com/show_bug.cgi?id=3D2246276
>
> Longer error message is in the link above, but the guts of it seems to b=
e:
>
> Py.find_library: unable to find the Python library [/lib64/libpython3.13=
.so.1.0 returned Cannot resolve _PyObject_NextNotImplemented.
>
> I don't see anything about this in the release notes:

Will interests grow for the involved software dependencies?
https://github.com/python/cpython/blame/78e6d72e38ef4b490f0098b644454031f2=
0ae361/Objects/object.c#L1279

Regards,
Markus
