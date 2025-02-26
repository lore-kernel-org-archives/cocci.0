Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D98FC19F2F
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qd/P01QUb5F02hWZoi0IIwP5a5sgbN5wVj3NeUV9KKE=;
  b=DfIk/4VTz0tr3WIQ8pSTP0+jeYXdIHV76z9xdh5QIO1Ey6gSORSHpPQC
   vvY+09xNgwzgLLC/LBo1VzgjUKkakfcV+DFd+CfozWNKVxcIRDAy5B9FJ
   Vhpw5ixRm/4Wd67jLm2EwW4j7hkL9kU7eh4ECGQQuYN/ypn82MrefZFQx
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.com
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210104235"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 09:59:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43E4FE0D65; Wed, 26 Feb 2025 09:59:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CAF9FE0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 09:29:48 +0100 (CET)
IronPort-SDR: 67bed0fc_qor2QIRm/uWw310u9qHh5rZlHvdCQqGGFoQG/lKjgyDLyMs
 kbbUWvCK9znr/8GR2ESAJlrRIf4fX1g5QFY/+oA==
X-IPAS-Result: =?us-ascii?q?A0EpAACjz75nfC/aVdFaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?QGCQn1ZNAQLSIRWiB2HMoIhA4tzkiGCDQEDAQ07CQQBAQMEhHwCAosUAh4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDhIph?=
 =?us-ascii?q?XsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBEhEEGQEBNwEEC?=
 =?us-ascii?q?wsLDQICJgICIRIBBQEcBhMigmGCQSMDEQaiL4EFQopEen8zgQGCDAEBBt4FA?=
 =?us-ascii?q?wYUgQYuAYhOAYFsg39Egzl6Jxt9gRCBSoJ1PoJhBIFeFYNGgmmEIYM+p2smC?=
 =?us-ascii?q?R0DBwcODR5JDwUcA1ksAVUTFwsHBYEpSAECAYEOI4EjBTQKNzqCC2lJOgINA?=
 =?us-ascii?q?jWCHnyCK4IdgjeCGIIrRBgvAwMDA4MqhVKCEYFgAwMWDwGBboExdxyEf4QFH?=
 =?us-ascii?q?UADC2ILPTcUG0yhLAE8g0p0gSkQex1lkzsUEAGDK7AEhCWMGJVKM6MSh0Muh?=
 =?us-ascii?q?2WQao4FmxoRI4FEOoFcMxoIGxVsBoIwTwMZD4gAhiGDess+RTICATkCBwEKA?=
 =?us-ascii?q?QEDCY1igjqBSwEB?=
IronPort-PHdr: A9a23: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
 bIVV6RWElcyE6FCYqyKNMcfO5oxVTQhw+fzsQ==
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:NkDDP668aKwXa3JqZQPXwDjXdLJyesId70hD6qm+c20uTiX+rb
 HToB17726ItN91YhsdcL+7Sc69qB/nhPpICMwqTNKftWrdyQiVxeNZnPLfKlTbckWUygce79
 YDT0EUMqyJMbEVt7eA3CCIV/kn28eO662liKPzyH13XRh2Z6wI1WtEIzfePEkzawVPGIYjGI
 D03LsgmxOQPVoSKuq0b0NqYwEBnbL2fVDdDCLuyyRH1OBGt1OV1II=
X-Talos-CUID: =?us-ascii?q?9a23=3AT5MKhWoHvnNv9MyMqYawYDjmUd85MSzf41XBGmy?=
 =?us-ascii?q?lE0tvT+2LYwSSu4oxxg=3D=3D?=
X-Talos-MUID: 9a23:BSVRpQZExJ/+0OBThzXXvANhL5pTw72BT1kprZgJqs+IOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210094523"
X-MGA-submission: =?us-ascii?q?MDG4TmYUX0HDT1KIB4KiRQz+QenZ+59CKjBGGS?=
 =?us-ascii?q?i4lknwveO1NPvRxudo+cIL5hq5HNOE7hSE6fD//+uwrErEL/55wiU+Vj?=
 =?us-ascii?q?5/BC5giLDmvQyKMct8INlnFxh6ehz38Q6YdJrRGnfLw+E1+dEbF3GthF?=
 =?us-ascii?q?rlyYbyjBGX5hEugWrasZgfxw=3D=3D?=
Received: from mail-ej1-f47.google.com ([209.85.218.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:29:48 +0100
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1311142266b.1
        for <cocci@inria.fr>; Wed, 26 Feb 2025 00:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740558588; x=1741163388; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd/P01QUb5F02hWZoi0IIwP5a5sgbN5wVj3NeUV9KKE=;
        b=OMg7DajdJkvuT4dMWRzyM1K/4/oOAN2dbgxevUbQRZ+dTDxNkMAEZuQmqQVU9Oe41N
         Vwg0M4QagWl71PBPsGV9aJEcTXzRypsZiOVIwe2ukht7bnKb6VyEAWadsKTmPiWDQ8R5
         Wo+9dcD6O0SeNRJlWLqwhhO6LKCvZQ/l3wMSQzijBTQLdlw5e/ehcYI/LnAOTTKQ2Isg
         yGgkKgU/tmGP3oNuPyCMGwTDHhDyQJ/6PUhL6cRRFVkpaTfglxl8jvxqLT3oU4dve9zs
         SqxdFRaW1mZjJLA6xl+PfYXen5dYbhAdw616LOs385eZWxRymo/RuH8V8Gv3m9pn0AHH
         9e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740558588; x=1741163388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd/P01QUb5F02hWZoi0IIwP5a5sgbN5wVj3NeUV9KKE=;
        b=BMsWzoXiezfVr+HbYG87e0FU5/HMvfZAl47eZVHq7r6riK77Xqmd1EDFCbxAquXpZ1
         Fl/vWhBEap4Pm/y4JkyihkEA2nFTJQ15THRVcv7g45hWJhpKe2VKDA3ukG45S1kPwXh4
         yuv5nO7gMV0GwnXQ7nAqVPywVY5145Lf8+qXD+HoHgakswMll02wZagZDFTuEp5lP/7j
         2O+Puv0QTbagH9L8VZwONquNCoGSqN+vIYStcREj5kkW7VjkLpYRDNb4LTm8GHnAW55+
         8T0KQJcrm1FjaPWmF/QccQuaRiCgcvEMO7WeNNKlHq6ASz7dKaqQlCmb9aHT8CxNVSlH
         77uw==
X-Forwarded-Encrypted: i=1; AJvYcCVXq+2wT2ftKFK1dZTVe77EAdD68v6Ble5/spENt5i5wI9+yluXOydNUz4Q9UiFAlsOTSTVIw==@inria.fr
X-Gm-Message-State: AOJu0YyOVFOV3M4ZD65PZcunIPlbhjq2zpRJZt3T0Wk+LtuPWgeBIYN3
	sTx0xw6J8sykyVO3dQ9hQdDQMcVvmozUBlUTuMgqIqY7gC7tsAeibUXxneLoX1mDu6FMM3qwvq+
	HOyjwLfasxceR906RGiyTHi4V+Rmor7z1gYvPtA==
X-Gm-Gg: ASbGncu+s5+sZUaTOu9lUS3i5hKg1SyX/vGvcnA4llzF2tRiCB+VKTVm4YoBWGl1E+a
	JU/+PMmKC3A/nMNirPFFM05KfECjph+U9+G3nlXayLRdouGWQqsHBSFcNKudtxthWFDAJ+NQ1RP
	R8ZD6TTQ==
X-Google-Smtp-Source: AGHT+IHCBmf3hFVyDRWrbNjNMJpg3u3tAe5Gkum3edJXg5+W5jYzpdGCY2CkRcaqBj3q4FkgF3ZBCF2Ur/l8ZS65ls8=
X-Received: by 2002:a17:907:7711:b0:ab7:c152:a3ca with SMTP id
 a640c23a62f3a-abed0c66952mr598124866b.6.1740558587743; Wed, 26 Feb 2025
 00:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr> <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
 <7b8346a1-8a7d-4fcf-a026-119d77f2ca85@wanadoo.fr>
In-Reply-To: <7b8346a1-8a7d-4fcf-a026-119d77f2ca85@wanadoo.fr>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 26 Feb 2025 09:29:36 +0100
X-Gm-Features: AQ5f1Jrr13SgxwVjT6ysFNM9oHlwZl6dEEKFUrutAasFQHuednVFm1EELk7zLLU
Message-ID: <CAPjX3Fc1UuWvih_krriaF32aPCbGP0SPg2TSrBA8Xb7a=Ozc5Q@mail.gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Frank.Li@nxp.com, James.Bottomley@hansenpartnership.com, 
	Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org, 
	axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org, 
	ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr, 
	dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org, 
	dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org, 
	dsterba@suse.com, eahariha@linux.microsoft.com, festevam@gmail.com, 
	hch@lst.de, hdegoede@redhat.com, hmh@hmh.eng.br, 
	ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com, 
	ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev, james.smart@broadcom.com, 
	jgg@ziepe.ca, josef@toxicpanda.com, kalesh-anakkur.purayil@broadcom.com, 
	kbusch@kernel.org, kernel@pengutronix.de, leon@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org, 
	perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de, 
	sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org, 
	sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 06/16] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Daniel Vacek <neelx@suse.com>
X-Loop: cocci@inria.fr
X-Sequence: 2461
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/CAPjX3Fc1UuWvih_krriaF32aPCbGP0SPg2TSrBA8Xb7a%3DOzc5Q%40mail.gmail.com>

On Wed, 26 Feb 2025 at 09:10, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 26/02/2025 =C3=A0 08:28, Daniel Vacek a =C3=A9crit :
> > On Tue, 25 Feb 2025 at 22:10, Christophe JAILLET
> > <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
> >>
> >> Le 25/02/2025 =C3=A0 21:17, Easwar Hariharan a =C3=A9crit :
> >>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> >>> secs_to_jiffies().  As the value here is a multiple of 1000, use
> >>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multipli=
cation
> >>>
> >>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci=
 with
> >>> the following Coccinelle rules:
> >>>
> >>> @depends on patch@ expression E; @@
> >>>
> >>> -msecs_to_jiffies(E * 1000)
> >>> +secs_to_jiffies(E)
> >>>
> >>> @depends on patch@ expression E; @@
> >>>
> >>> -msecs_to_jiffies(E * MSEC_PER_SEC)
> >>> +secs_to_jiffies(E)
> >>>
> >>> While here, remove the no-longer necessary check for range since ther=
e's
> >>> no multiplication involved.
> >>
> >> I'm not sure this is correct.
> >> Now you multiply by HZ and things can still overflow.
> >
> > This does not deal with any additional multiplications. If there is an
> > overflow, it was already there before to begin with, IMO.
> >
> >> Hoping I got casting right:
> >
> > Maybe not exactly? See below...
> >
> >> #define MSEC_PER_SEC    1000L
> >> #define HZ 100
> >>
> >>
> >> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
> >>
> >> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
> >> {
> >>          return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
> >> }
> >>
> >> int main() {
> >>
> >>          int n =3D INT_MAX - 5;
> >>
> >>          printf("res  =3D %ld\n", secs_to_jiffies(n));
> >>          printf("res  =3D %ld\n", _msecs_to_jiffies(1000 * n));
> >
> > I think the format should actually be %lu giving the below results:
> >
> > res  =3D 18446744073709551016
> > res  =3D 429496130
> >
> > Which is still wrong nonetheless. But here, *both* results are wrong
> > as the expected output should be 214748364200 which you'll get with
> > the correct helper/macro.
> >
> > But note another thing, the 1000 * (INT_MAX - 5) already overflows
> > even before calling _msecs_to_jiffies(). See?
>
> Agreed and intentional in my test C code.
>
> That is the point.
>
> The "if (result.uint_32 > INT_MAX / 1000)" in the original code was
> handling such values.

I see. But that was rather an unrelated side-effect. Still you're
right, it needs to be handled carefully not to remove additional
guarantees which were implied unintentionally. At least in places
where these were provided in the first place.

> >
> > Now, you'll get that mentioned correct result with:
> >
> > #define secs_to_jiffies(_secs) ((unsigned long)(_secs) * HZ)
>
> Not looked in details, but I think I would second on you on this, in
> this specific example. Not sure if it would handle all possible uses of
> secs_to_jiffies().

Yeah, I was referring only in context of the example you presented,
not for the rest of the kernel. Sorry about the confusion.

> But it is not how secs_to_jiffies() is defined up to now. See [1].
>
> [1]:
> https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/jiffies.h=
#L540
>
> >
> > Still, why unsigned? What if you wanted to convert -5 seconds to jiffie=
s?
>
> See commit bb2784d9ab495 which added the cast.

Hmmm, fishy. Maybe a function would be better than a macro?

> >
> >>          return 0;
> >> }
> >>
> >>
> >> gives :
> >>
> >> res  =3D -600
> >> res  =3D 429496130
> >>
> >> with msec, the previous code would catch the overflow, now it overflow=
s
> >> silently.
> >
> > What compiler options are you using? I'm not getting any warnings.
>
> I mean, with:
>         if (result.uint_32 > INT_MAX / 1000)
>                 goto out_of_range;
> the overflow would be handled *at runtime*.

Got it. But that may still fail if you configure HZ to 5000 or
anything above 1000. Not that anyone should go this way but...

> Without such a check, an unexpected value could be stored in
> opt->lock_timeout.
>
> I think that a test is needed and with secs_to_jiffies(), I tentatively
> proposed:
>         if (result.uint_32 > INT_MAX / HZ)
>                 goto out_of_range;

Right, that should correctly handle any HZ value. Looks good to me.

> CJ
>
> >
> >> untested, but maybe:
> >>          if (result.uint_32 > INT_MAX / HZ)
> >>                  goto out_of_range;
> >>
> >> ?
> >>
> >> CJ
> >>
>
> ...
