Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C3C02195
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:to:cc:references:in-reply-to:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qw9sL4e2WHFO0R0bwxLwz5BJzMvwrz0O7pdsb4Warso=;
  b=SSD9CW03S4kNNOcAdTwDhOEFyV3MqzjKt7riFAn5X3X3tNyIJ7if/5vi
   w8Ryv66Od1DdwifF7XWiLfJxqUN8ZtZIuK/07M61xD7i27G7op82fA0Ek
   9jfX8591DK4JMyaBIjqnLVwA56F7tMMQyqC4nM52AgHYFcv11OvUpWnTm
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325133"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99EE7E0DE3; Tue, 28 Jan 2025 10:13:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6244EE007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 17:36:07 +0100 (CET)
IronPort-SDR: 6793c177_caejLw2QzmY/UuO/WA7r33Q/zXSZToPUFxRUt9jhGlijom3
 p8OwlQLz3Jj3z+asUCdWYFDol0pdSHymOEmB/tg==
X-IPAS-Result: =?us-ascii?q?A0EhAADewJNnj1vBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHV+GUoIknEKBVoF+DwEDAQ1EBAEBAwSBUDyCd?=
 =?us-ascii?q?AKKdQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBAQE5BUmFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECASMdAQE3A?=
 =?us-ascii?q?Q8LGAICBSECAg9HBgEmgm2CQiMDuE96gTKBAYIMAQEGgmjbGwmBGi4BiE0Bh?=
 =?us-ascii?q?Ws7g0J6JxuCDYQ/PoQrGBWDRoJpgjOBdII0gQyLEYE9hEGEZz6KCUgKexwDW?=
 =?us-ascii?q?SwBVRMNCgsHBWFIEDgDKwsMCxQcFSOBJgU1Cjc6gg1pSTcCDQI1gh58giuCH?=
 =?us-ascii?q?4I7hEWEU4JDgxiCFHprAwMWEYI1cnsfgSwdQAMLGA1IESw3Bg4bBj0BbgecY?=
 =?us-ascii?q?oZIgQ4YkwCDTwGwAAqEG4FjAp9lFjOEBI0GhjqTD5h8IqkLgWc6gVx9CDuCZ?=
 =?us-ascii?q?08DGQ+OIRkfiFbAakE1PAIHCwEBAwmQI4FLAQE?=
IronPort-PHdr: A9a23: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
 CRZ
IronPort-Data: A9a23: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
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:nNgxuK2+thIBrYdQHEeLVwqjBLckLtp133Aq2lEZdPWaSL38qy
 nIppsmPH7P5gr5PUtMpTnuAsi9qB/nhP1ICMwqTM6ftXfd2FdAXbsP0WKK+VSJcEfDH6xmpM
 FdmsNFebnN5DZB/KTHCXGDYrEd/OU=
X-Talos-CUID: 9a23:GJhtEW8W2m5+r1rQlKaVv3VXI9o8Xm/48GfBHX+jCnZHEJurbGbFrQ==
X-Talos-MUID: 9a23:h53IJAbEBlCPTOBTtBavpBJTLOVSuIukGXJWuLgllu7cHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="204910857"
X-MGA-submission: =?us-ascii?q?MDGqjeuVEMWaAeKzIAD3rf6uoNgexlYLzhx6QE?=
 =?us-ascii?q?suvE0jfhq1ejtx864sp+QeToAllcY57Sy0ARZl8NVj4Ngpzup/taNlzj?=
 =?us-ascii?q?V5xJAKsI+rwxghjXcp16xa8bQFg0SxFQmWlZiHxWUbutkehNPgqvvUDh?=
 =?us-ascii?q?xh0xVJh9KjM1ZqxCBSYAXb4Q=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 17:36:06 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3B3C8A41B1F;
	Fri, 24 Jan 2025 16:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCC5C4CED2;
	Fri, 24 Jan 2025 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737736565;
	bh=qw9sL4e2WHFO0R0bwxLwz5BJzMvwrz0O7pdsb4Warso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFwlYNS7WTqSyyFtbpCZIYRS4wxfdkhkik45LEbaja2oWiiHOVSr3lLU5QUHdps/c
	 YMxmJksb+X1EJNVHdXthjkzKisj8OYFz5p0Z+3ky2onBSyb1ZxUuzjvCcaGmKhrpzz
	 5YGV+vbi3WNvxzAVeCOUqOOcV/pqw+alJ5YtglEKhI3YljsaolQcpHI2Km7o04lFYA
	 6N/uwwJ+nlehU77Ug0DAfqGHUCwN0MDEfOpIGh5wHxFPbkN+SoAK3lP8aIpU0jaqNG
	 7m3Sl0W69hRFPDyILQFu2mS63n/ZrKTyKx1dOnaWoqNKym1aOY2dBpxyPTwOunk1Os
	 12nC4dVCjtpRQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 18:36:00 +0200
Message-Id: <D7AG776AI2EQ.KLG13BCOXBJL@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Nikolai Kondrashov" <Nikolai.Kondrashov@redhat.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, =?utf-8?q?Leonardo_Br=C3=A1s?=
 <leobras.c@gmail.com>
Cc: "Vignesh Raman" <vignesh.raman@collabora.com>,
 <kernelci@lists.linux.dev>, <linuxtv-ci@linuxtv.org>,
 <dave.pigott@collabora.com>, <mripard@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kselftest@vger.kernel.org>, <gustavo.padovan@collabora.com>,
 <pawiecz@collabora.com>, <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>, <broonie@kernel.org>,
 <groeck@google.com>, <rdunlap@infradead.org>, <geert@linux-m68k.org>,
 <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
 <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
In-Reply-To: <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2255
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/D7AG776AI2EQ.KLG13BCOXBJL%40kernel.org>

On Fri Jan 24, 2025 at 3:00 PM EET, Nikolai Kondrashov wrote:
> On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:
> > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
> >> Gitlab as an open-source software project (the community edition) is o=
ne
> >> thing, but can we please avoid advertising specific proprietary servic=
es
> >> in the kernel documentation ?
> >=20
> > I don't think we should have any of this in the mainline kernel.
> >=20
> > One angle is that "no regressions rule" applies also to the shenanigans=
.
> >=20
> > Do we really spend energy on this proprietary crap to the eternity?
>
> This is not getting included into the kernel itself, the contributed code=
 is,
> of course, open-source. And yes it would execute just fine on the fully
> open-source community-edition GitLab. I don't think "no regressions rule"
> should apply here. This is for developers only, and is a template for mak=
ing
> your own pipeline mostly, with pieces which can be reused.

Ah, OK then it is fine. It was a kernel list so I assumed it was for
kernel.=20

Then: I don't care about this ;-) I use a different testing tool
(BuildRoot) and a different CI (Woodpecker in my local server).

So go ahead and do what you like...

>
> Nick

BR, Jarkko
