Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2FEC282DE
	for <cocci@archiver.kernel.org>; Mon, 10 Mar 2025 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=I3lgknlUNHEVj5zQIxnyrNmsL7ozdFmzN3m8RrWc3IY=;
  b=vAmVKJlV5EAcSp1lQEnkCpKtW0uFEPd247ydwNxMxBAKSC6HIZv2h0A5
   Kz1zW9q4/TuZHzfOLPMbj1NhXiCi3BkYouO083rK3vWrQhmlF4NoSiGRo
   j9kG9FAzkQNHRM31tfNrCRDj9jfZTO066zXwiEWMNitenmCjUhzpNbVSe
   U=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=deller@gmx.de
X-IronPort-AV: E=Sophos;i="6.14,235,1736809200"; 
   d="scan'208";a="212038802"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2025 11:01:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B15F5E0D1D; Mon, 10 Mar 2025 11:01:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A68E1E0260
	for <cocci@sympa.inria.fr>; Sat,  8 Mar 2025 22:26:56 +0100 (CET)
IronPort-SDR: 67ccb620_n1PenwdiJdtNywKdjVPCIabfKJj6eV9Vg5WMfd/agEN7mPe
 Fw7etVnq9om/1XFZcNww7wgFPi4cGUcLUlALesg==
X-IPAS-Result: =?us-ascii?q?A0EJAADKtMxnfhUR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuHU4Rvh?=
 =?us-ascii?q?AaBVoF+DwEDAQ1BAQIEAQEDBDiBVIJ0AosaAh4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOECuFew2CYgGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQIsG0MBAQEBAyMVCAEBNwEPCxQBAwICHwcCAlYGARICAQGCfoIwA?=
 =?us-ascii?q?QMxB6NUikR6gTKBAYIMAQEG2lsBSwOCWwmBGi4BhHSDQBoBBW2EYBmDfXonG?=
 =?us-ascii?q?4INgTyDAz6IHoJpgjOBaQGDPZ57ih5SexwDWSwBVRMXCwcFgSlDAyo0MSMPg?=
 =?us-ascii?q?RQFNAo3OIILaUkwCgINAjWCG3yCK2oEBYEkgjQlhBcLg05md4JNggyCEYE2A?=
 =?us-ascii?q?yQDAyIBgx9dGhyEPjyEZS4yHUACAQttPTcJCxsGPaILOoNQc1KBB4Iqkm+zW?=
 =?us-ascii?q?II/gTsrhG+cXgYTL5dakn0umFAiozmFWIFnOoFcMxoIHBSDIk8DGQ+OITiDd?=
 =?us-ascii?q?ccOQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cs5aeKOTd+bkIMBcT5v155DYdb4zR+YMi2TDt3oedfUnSL3kqy
 nOpoVU6faQslxhP03I9urwQJVoK0mxyXdK2/hRAV7PZnirhILKFvAY0WKB+UyYJ8SkzJ8R6U
 4IScEXY7KQfDoK6bed3OShKadE/DDgytHmuQ7w9QYscegAUdAp0+4WMHfmLqQ7fng9OXIdfK
 Dsmbs41kvQCQVlUiyZbkN1KtQqZrXw5dnbiSVvPW9U1CC+yReh6Lv/Gx/d9g4GSDVRzbpn2X
 WtqX2x2k0t28vLgCM0ulW/03wo8+GA9jNwbPb8/vT8HF3X+3GVjLMIYcz1gBkF5N6C02sLuv
 Ho5zcYe/5Yw1T3Ukzdm2qP5zXd
X-Talos-CUID: =?us-ascii?q?9a23=3AVcX4K2qcbJkGUfEO2x0jPZrmUcYOKnvE7Cj7H0K?=
 =?us-ascii?q?TV35mTLKZYn+gyawxxg=3D=3D?=
X-Talos-MUID: 9a23:gUwPHwlqEsjlRfe/DoKHdnozEsluwL6PF3kziJ4PlM+UZBR3NT2k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,233,1736809200"; 
   d="scan'208";a="211901392"
X-MGA-submission: =?us-ascii?q?MDHC0t/1eiSFnwU6xDEtYBcOmrh6AMLpy6nS7T?=
 =?us-ascii?q?D8NkJ+Q7/INQY2qOnrh53Vs+3zqoEEDUI0jMMDZA6zkqoJbeTLdRSsqd?=
 =?us-ascii?q?1JiRR0xBchlWj5Loi1ZD89W9PSxHfswd8YMti75itY0F6f3mqfTR0Cbg?=
 =?us-ascii?q?+kY7b95XdFqeMdYGI8ReV3aQ=3D=3D?=
Received: from mout.gmx.net ([212.227.17.21])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 22:26:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741469178; x=1742073978; i=deller@gmx.de;
	bh=I3lgknlUNHEVj5zQIxnyrNmsL7ozdFmzN3m8RrWc3IY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nJLiYOtEuyeBzySCFjZPIrvPJ8eyyEzeD+LS9cW2GNzQQy9DWAiQ5GWnEXcAciQK
	 RtefVBGnQ51QiTURxE5t+7taYANYxH5ai87pa2jRiL0EdLwiK2ogN+wb4D0VDSKkk
	 WOO//TkWS5XlaoJm3XoMkOLObbF/88VcjsLTZebbPJPWRXmQxpwOa0b5zswsDZTw8
	 8npz5rHSFCpl7OJoXH6HSCVlEF4HcVAm+wTmPmeLdoYIfwDJ8Mbqu1lZmGFyJQlS/
	 OleETEH98QNg4EXkWplOo6MrL3FPU02037eDLhWbe/saqoO/Utro+9F6iiexq//8F
	 l1ug5DjTfW4PZAEY3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1tOofA1oKI-00gN93; Sat, 08
 Mar 2025 22:26:18 +0100
Message-ID: <f3e36573-e370-4f70-94d8-7a240d366e60@gmx.de>
Date: Sat, 8 Mar 2025 22:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Antonino Daplas <adaplas@pol.net>,
 Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C5tFhocLZ9Cyr0RTz7xybHr6k+B+bg56GkUhvUtn2P48DOT9VQ8
 2ilqi6Jqg7GmYQIoh6ClwZDuCRL0WWZRrAQwRbdrxhQK63qFlL0gaG+/f8fia+eaMkXGU9A
 SO80u3O5Y0nmNDYVKqIxLBaNDsnQj/qTO78b5lgcvNSYrAGGCL/JVL0Iktn6ZzL/x1fJkOK
 3ULv/tX0hZkF//Rog+YQw==
UI-OutboundReport: notjunk:1;M01:P0:IwnKJ7EsMes=;exxIbdJWGIHqteW1BHQ05ATTbTm
 Edycjeh0/Zqx8anVn1blG014GtWPCy4ni9+8MaZpsG3EFCByj5PALrxy3834xNVV1pfuS5/mH
 OsbyvKQOkAKK6B70B4iKpX/fzzxqFNa2f1xWLbClFUZ+BWG9BxrvF+f2ULHraVwZHpDnqVp1I
 kuG9CwbFfV1IaHRT4R9xPRsnVM30rhA999B2IUZjkW0ZJXvOG92fUwsxVXz5SqDky+jDAtIFC
 nYhzhz5B/rK++zpGQIyrN0Z3JeGIGmWnr+cdnDeYnJ2Xi9eK2wm0JAnPESyQiz20qm2Q9lFue
 CgrHAknrlf1BtyM4yDAUVHI8vFnBDbVEBBhJ++d1oQPlP8Kl42RogXW82euoN4l2xR5xDMSst
 Km4Ik9Ws14OZ6RPJsT4Ikc+uWazxgNXjIy/KiMBj/l9QWzg1UNNldu8p2hjgbe4kgjXf78k4V
 1/QfXZt+1pTu7shmrG/H8T76/KNtTvtsywyOKT4jEUua72oXt1HPC0uva0IyWggKNnjvN6T70
 vZCdwXVdkqn0b343qfYEIwBF3jFOwbfaZGf5oZ0VSmUy8rl+l+lkMCO60+u/r2hZgUlmg271w
 GH9ESdjFrtxV6b/MIpzLLM+2ak1XuUQkWgx20KFr+nVyTIy5k8Lx4tILhyC2QeiZKBMiXOSb2
 KmKa84YUXWTOSupoybYT/EeYlG4M59lbM2qSbN3PNQSJN7aEa7x7KJ0aR4wAUdq2CpxupNMbc
 8T4ckFwnmqRrbansF93YmSpg1MRbRFeA0zhYnsSIBs80YF/p4UNQOfSIk3uGR3pmHw+dvXSJk
 Uuu9SqLgNAG4f0LFESMxJuiDiPpAK4i/n4Z8w/3JxyW3h93jGataM8q1r/jW+1pwFYMr/iUsf
 MSVIVUUbt+RXesDh39rTP44OUKVRTjsy6CEYKPhWUh71+CdtDbvfEEobY2/xjlK9fdwJm6SLd
 C26CC2m6rUggzXJGPjwUjZnLVeO+spzQtgUXx6/1+DQT88XfWosO2xr1MWMkCsTCG7Vss5hR+
 whEqtGaMdmmjLR0cllR9ULfsaLOQJZMk2qSeF4C2mSBKU+vyNyHv+oKi77xvgdAIFKuhwgjMs
 sb7q4KLXboTHuO/W9VYujSwIepUDfhtpx7G+Bwa+vhl14oWULMsJItSBhXkIhpp5c5ade48W9
 9lUPudvOb4kxcDNfNx3sxscnUpxewPrX5hlkrjJcG44aZtCpHJi9w095wFujbLYIU6fIncJdu
 /1AwEWg2sy15FeDzSJ3kDtbk5EI08uhHbPjGgZFvgHaoT1LNP8nAqjP1jxnxn986CFwEK4pym
 OMPBEee1G3BXaYGQ2GoFuwMyUbslE1vhHFWBIlPUg8x0QRA1yJ/mrMn+1Q9YbaCiPjs+TwEkV
 7yUdWbeFWefTABSSzs/QU0yxp6vdqa8+dMdTRkllZCILNeMOQBklkprm3f
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] video: au1100fb: Move a variable
 assignment behind a null pointer check in au1100fb_setmode()
Reply-To: Helge Deller <deller@gmx.de>
X-Loop: cocci@inria.fr
X-Sequence: 2579
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/f3e36573-e370-4f70-94d8-7a240d366e60%40gmx.de>

On 3/3/25 10:19, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Thu, 13 Apr 2023 21:35:36 +0200
>>
>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Cau1100fb_setmode=E2=80=9D.
>>
>> Thus avoid the risk for undefined behaviour by moving the assignment
>> for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

applied to fbdev git tree (with minor modifications to commit
message and without stable tags).

Helge
