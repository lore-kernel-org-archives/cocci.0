Return-Path: <SRS0=L9f+=PJ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF4AC4332F
	for <cocci@archiver.kernel.org>; Thu, 21 Oct 2021 09:15:38 +0000 (UTC)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DB461186
	for <cocci@archiver.kernel.org>; Thu, 21 Oct 2021 09:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97DB461186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="asc'?scan'208";a="396671955"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail3-relais-sop.national.inria.fr with ESMTP; 21 Oct 2021 11:15:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C46AE001B; Thu, 21 Oct 2021 11:15:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 33A7EE0015
	for <cocci@sympa.inria.fr>; Thu, 21 Oct 2021 11:15:32 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=stefanha@redhat.com; spf=Pass smtp.mailfrom=stefanha@redhat.com; spf=None smtp.helo=postmaster@us-smtp-delivery-124.mimecast.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AYjnEaRWLPK8cmY74EszsbMvx1LHV8KxMVTF92vM?=
 =?us-ascii?q?cY1JmTK2v8tzYMVDF4r011RmVB92duqsP1rWempujcFRI2YyGvnEGfc4EfD4+o?=
 =?us-ascii?q?uJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgp?=
 =?us-ascii?q?pPOT1HZPZg9iq2+yo9JDffRlEiCC5bL9vIxm7rQfcvdQKjIV/Lao81gHHqWZSd?=
 =?us-ascii?q?eRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9LmA6/9brugX?=
 =?us-ascii?q?ZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/9KpgVgPmh?=
 =?us-ascii?q?zkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2hcUcZLTyFPDIO?=
 =?us-ascii?q?yYZUSAeQCM+ZXoJXyqEYMohalCgmgGPnixyVUinPqw6E31fkqHwHc3AwnGtIDq?=
 =?us-ascii?q?GnarMnrO6ccS++1yrTDwzfZYPNU3zf975THcxEgofqRWr9watbRxlchFwzfiFW?=
 =?us-ascii?q?QqZbqMiiP1usTrmeb7/BvVf61h2E7rAFxpyGiy8ExgYbGmowb0ErL9TllwIkrP?=
 =?us-ascii?q?924TlZ2b9C6HJZQuCyXKoV7TMwsTmx0pCs3170ItJC0ciYKyZkqxgLTZv+Efoa?=
 =?us-ascii?q?H7RzuUOmcLSt4in55Zb+ygxK//Fa+xuD6S8K6005KozJYntTOqnwBzQHf5tSdR?=
 =?us-ascii?q?vdg4Eus3SyD2x3N5uxLOUw4i7bXJpo7zrItmJcfr17PEjL1lUj4lqObeUMp8fW?=
 =?us-ascii?q?y5ev9eLXpvJqcOpd0ig7gNqQundSyAfkjMgQXRGib/Pi81KX68ULkXrpKivw2k?=
 =?us-ascii?q?rfHv5DAJcUXv7O1DxFa34o57ha/DjKm38oEknYdN1JFZAiLgJTuO1HLOPz4DPG?=
 =?us-ascii?q?/jEqwkDpz2vzLPKHtDo/QInTfirvtYKhx5kpGxAYu09xS6IpYCrQbL/LyXk/xu?=
 =?us-ascii?q?sbYDhg8MwGs2ObnFMty1o0EVmKJAq+WKrjfsUWW6e0yI+mDfpMVtCzhJPgi4v7?=
 =?us-ascii?q?ilWU5lkMFfam1wZsXb2i1EehhI0qFfXXsg8wMEXwKvwo7VOzlkkeOUT9VZ3aoX?=
 =?us-ascii?q?qIz/Cs3CIy8DdSLeof4oruMlB+2BJZWa3sOXlKLHF/wep+PW/oXLimVJ5kyvCY?=
 =?us-ascii?q?DUO2aV4Iv3BfmlAb4zb1sPOucrjYEuJzq0th8z/femRE76Xp/CMHLgDLFdH19g?=
 =?us-ascii?q?m5dH2x+56t4u0Eojw7bicCQYtRFDplI4u9RFws3MZ/CwvZrTomoBkTEf9KEQ1+?=
 =?us-ascii?q?9XpOtBjRjFrrZJvcUbkp9EsnkhRfGjXLC61A9jbGHBJUotKnb2iqoT/s=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AI/N/26NAXG980sBcTsajsMiBIKoaSvp037Dk?=
 =?us-ascii?q?7SxMoH1uA66lfq+V98jzuSWftN9VYh8dcLO7Scq9qBHnmqKdiLN5VYtKHjOGhI?=
 =?us-ascii?q?LCFuFfBP7Zslvd8lrFh4lgPMlbHpSWcOeAaWSS2vyKhTWFLw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ALAAASaxphh3yBCqpaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUUHAQELAYQyMYxrYIZFggcgiluRDYF8CwEDAQgFQQQBAYRhAoJ?=
 =?us-ascii?q?rAh0HAQQwCQ4BAgQVAQEFAQEBAgEDAwQBEwEBAQENCw4IOiSFaA2CNSkBg2MBA?=
 =?us-ascii?q?QEBAxIuAQE3AQ8LFQMuEBE2BhMigk8BglUDL5ocAYxjAQEBdoEzgQGCBwEBBoU?=
 =?us-ascii?q?2DWWBUwcJgToBgVKEJ4Z/eiccgUlEhDo+gVJOiB+DeBmDVZUcAagaXoMygTeXN?=
 =?us-ascii?q?oYQlUkMkSCmBZBYhHmBYIIUTSMVgyRQGQ6OIBmDWYpfQAEBMDgCBgsBAQMJiXU?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A0ALAAASaxphh3yBCqpaHAEBAQEBAQcBARIBAQQEAQFAgUU?=
 =?us-ascii?q?HAQELAYQyMYxrYIZFggcgiluRDYF8CwEDAQgFQQQBAYRhAoJrAh0HAQQwCQ4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBAQENCw4IOiSFaA2CNSkBg2MBAQEBAxIuAQE3AQ8?=
 =?us-ascii?q?LFQMuEBE2BhMigk8BglUDL5ocAYxjAQEBdoEzgQGCBwEBBoU2DWWBUwcJgToBg?=
 =?us-ascii?q?VKEJ4Z/eiccgUlEhDo+gVJOiB+DeBmDVZUcAagaXoMygTeXNoYQlUkMkSCmBZB?=
 =?us-ascii?q?YhHmBYIIUTSMVgyRQGQ6OIBmDWYpfQAEBMDgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="asc'?scan'208";a="396671942"
X-MGA-submission: =?us-ascii?q?MDGtMdaj4xhCN3BFZjsJF6WVOaloECfa7IkZ4k?=
 =?us-ascii?q?rY9kT7IZ8/EyV9/wcpQkcnnnH3T9o88OY0j3QqfptZeDq1TnatLGbwhO?=
 =?us-ascii?q?2LVbtDUj3zV4G98uFITb5SD3msxwnbYwESlEYuzZSPKOcJeNQtCeyABX?=
 =?us-ascii?q?5BYOrdnsRCc6fjmkYS8hDWMg=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 11:15:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634807729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eh0P5mryTqMVFT8OU4rlcC8njpXupHZKrJD/hBOoqL0=;
	b=iK2ZnSujiswKrz6vWpW4DNL8pBRP6TuoTK6oi217yjbnkKY/40wuUv1kOygbLOZ5imKhdy
	+1mXpmdKK8Jovd+Wmb2hKAbUDm1bPpwmlMZn+b2npEtq647ZTp4kvte/4fEl08AWHcDe7r
	NfziFBla+xOnhFhVNScpnL8ubCF1rjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-T9Ae63S8M3Cvpmz-nbegUg-1; Thu, 21 Oct 2021 05:15:26 -0400
X-MC-Unique: T9Ae63S8M3Cvpmz-nbegUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837D51922961;
	Thu, 21 Oct 2021 09:15:24 +0000 (UTC)
Received: from localhost (unknown [10.39.195.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CAE3014104;
	Thu, 21 Oct 2021 09:15:16 +0000 (UTC)
Date: Thu, 21 Oct 2021 10:15:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joe Perches <joe@perches.com>
Cc: cgel.zte@gmail.com, mst@redhat.com, Denis Efremov <efremov@linux.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Gilles Muller <Gilles.Muller@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Michal Marek <michal.lkml@markovi.net>, cocci@inria.fr,
	jasowang@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ye Guojin <ye.guojin@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Message-ID: <YXEvo5w6OzH3T0Tv@stefanha-x1.localdomain>
References: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
 <b85fee5ff20d2b398948a6bccf1bcc5eb22b49ff.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MKTZmaAbKHGPJEyk"
Content-Disposition: inline
In-Reply-To: <b85fee5ff20d2b398948a6bccf1bcc5eb22b49ff.camel@perches.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Subject: Re: [cocci] [PATCH] virtio-blk: fixup coccinelle warnings
Reply-To: Stefan Hajnoczi <stefanha@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 26
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/YXEvo5w6OzH3T0Tv%40stefanha-x1.localdomain>


--MKTZmaAbKHGPJEyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2021 at 12:08:23AM -0700, Joe Perches wrote:
> On Thu, 2021-10-21 at 06:51 +0000, cgel.zte@gmail.com wrote:
> > From: Ye Guojin <ye.guojin@zte.com.cn>
> >=20
> > coccicheck complains about the use of snprintf() in sysfs show
> > functions:
> > WARNING  use scnprintf or sprintf
> >=20
> > Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> []
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> []
> > @@ -624,7 +624,7 @@ cache_type_show(struct device *dev, struct device_a=
ttribute *attr, char *buf)
> > -	return snprintf(buf, 40, "%s\n", virtblk_cache_types[writeback]);
> > +	return sysfs_emit(buf, "%s\n", virtblk_cache_types[writeback]);
>=20
> Perhaps scripts/coccinelle/api/device_attr_show.cocci should be updated
> to be more like the script used in commit 1c7fd72687d6

This won't catch the case covered by the patch because it's
"snprintf(buf, 40" instead of "snprintf(buf, PAGE_SIZE", although
any size that's not PAGE_SIZE needs to be reviewed carefully in case the
intent of the statement is to truncate the output.

Stefan

--MKTZmaAbKHGPJEyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFxL6MACgkQnKSrs4Gr
c8js/wgAvvwLyhlzNHhPnOnKHV4zzRCS5mL7wTXIPYXRIuZLbmJe7cfyn2qfZtBE
o6KUg+EZMrSddh+yqN2A/D010ZKvothDHO+XHnjXjc1YEtD9gsUUTO0u4/3sjOwx
KZ04JmhYNuk3Q/KJNokoiqIQ4IYxx2g2puHbCXZBjoRwn2PQ5AmF5FmncmEOPaxy
0uK3v8fBNqBcYbaf759HJzAV3MfTV/kA+ybQIbTo/bt9iv8CVeM55kwPFqjGh0v2
/Lq0X45AKKRPF351kE7zO2F7/Bf4wVJEoeQVpct9rROwSNR52em6LuaRE5Q2s+ba
cVrOmOZTmCqirILmZ0Aqp+U8EnHEVA==
=qJkM
-----END PGP SIGNATURE-----

--MKTZmaAbKHGPJEyk--

