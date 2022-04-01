Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B9C433F5
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 04:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PlnMpYOXkJb3MsWMx3t3Karvr7oM4CxvFXYgLvSP2H0=;
  b=l/hpK9DrhLXoCY4eUuR9L5NVJZ+QGWVJGu1/+aizX1RC1ojEf0DY+IBW
   0hi90llR8zf/TuGK1XdU5xDzxhiFwTpx8BNreSf4IBEWyM42oILr6WvTg
   PuN7EifzX1+sX46XhgacTLAQ6ceIExkgy6/wdpzAX2HH5yYkRMoFvnB4y
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="5.90,226,1643670000"; 
   d="scan'208";a="29446034"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 06:31:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09AE5E033E; Fri,  1 Apr 2022 06:31:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1791CE0297
	for <cocci@sympa.inria.fr>; Fri,  1 Apr 2022 02:19:41 +0200 (CEST)
IronPort-SDR: +UW6IENlVbV6MYyQ79xB/WqRmQBXFiHMWG6QeLuMZjAhpvhfDmq+jl8+NwuzC8eybgZcUoq3J3
 FP4OvtGjIO1vsq4Akz4g+3Ebb1SjETa4aIn8VW0splqYs7k5oxqscyQ5YdeN0YRTD9H3Lp1W0H
 hEYQIVgYBhxkOBJwY3qydCIaEGfTxOsrkzm1RsETS4++J7Yb/PA0vJem7U5yv4sOZng1jVqsKg
 KExMP/2wxj8xiIQdIq/k9BfqllU48Xqwfd+OzNZeo3zjW2z5LrfAQR/OrLWXdgcYfgFfoXleQS
 tx6y49/KE9ZqhQwFye0yEh7k
X-IPAS-Result: =?us-ascii?q?A0ANAADEREZigDKAVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYInflYsBAtEA4RRiCaIcgOLEpFUFIERA1QLAQMBDTsIBAEBhQcCh?=
 =?us-ascii?q?FcCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0NC?=
 =?us-ascii?q?QUICgcODgU+ZGiBT4F0CzQNgjUpAYNkAQEBAxIRHQEBNwEPCwsNAgImAgIhA?=
 =?us-ascii?q?RIBBQEcBhMigmOCZQMuD6FJgQQ9izKBMYEBgggBAQaBPwGER4FcAwYSfiwBh?=
 =?us-ascii?q?hCBKIcVJxyBSUSBS4J0PoIhQgKBKwESAYM7gkMimF9jgTmBX2kylRiMfp0za?=
 =?us-ascii?q?4NTgUEMhh6DJ5RnM6hOhHWRaY0YlD40hHAQI4E+gQIjcDMaCBsVbAaCMhM7A?=
 =?us-ascii?q?QIBAg0BAgIDAQIBAgkBAQKOHTeDO4UUhVc3MQIBAQEzAgYLAQEDCZFgAQE?=
IronPort-PHdr: A9a23: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
 9nL0b32cXJMroqS8swbCMzZbsmANSh5WSc=
IronPort-Data: A9a23:K5V9nKN9uEJBsCHvrR2VkcFynXyQoLVcMsEvi/4bfWQNrUom32BSm
 2oYXj+EO/2LYDejco1xPo+z90wA7ZHWzoRqGXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiWFrV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB24wOso2
 txCvKaqSAEmYZbmiO0PbQJXRnQW0a1uoNcrIFC6uM2XilLDKj7inq0oA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3rjmhu/jIgVvrpxLwM3DMIoBu31vyi7xAvEhTpTOBa7N4Le02R9p3poVRayPP
 aL1bxJ1TUrjYBRKAG4eN54UzfiNqXPNKhBh/Qf9Sa0fujCPlmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyCTCE4T+M83bpmeqW2C2mAMQdE7q38vMsi1qWroAONPEIfWrkmqCrg0G3YcheL
 UNLwQA+pLoM70P+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8LoD+CxVjhsotlpOIxOiSMmedA5/
 gPQwoK2W1SDpJXQFinNpubJxd+nEXFNdTdqWMMScecSDzAPSqkMhwrXT9BsHbSuxvP8HTXrq
 9xhhHFk2uRL5SLn/4O24hj2hCivzqUloyYw7wTTG32gt0Z3OdbjaIuv5lzWq/1HKe51r2VtX
 lBUxqByD8hUVflhcRBhps1TRdlFAN7baVXhbaZHRcVJythU0yfLkXpsyD9/Plx1Fc0PZCXkZ
 kTe0SsIusMDYybzMfcvON/gYyjP8UQGPYS1PhwzRooeCqWdiCfalM2TTRLIjzG0yBZEfV8Xa
 cnCKZzE4Ykm5VRPlWLqHY/xIJckwScxwW67eHwI50XP7FZqX1bMEe1tGALWMIgRtfrYyC2Ir
 Ys3H5bUmn13DbymCgGKoNV7BQ1bfRATW8qqw+QJLbTrClQ9SAkc5wr5m+NJl3pNxPsEyY8lP
 xiVBidl9bYIrSaZcV/TMCAyNeuHsFQWhStTABHA9G2AgxALCbtDJo9EH3fuVbV4puFl09BuS
 PwJJ5eJDvhVE2yV9DMaYp3w6odlcU3z1w6JOiOkZhk5foJhF1OVoI66JlO3+XlcFDezuOs/v
 6akilHRT60FSlkwF83Rcv+ukw68sCFFyuJ/VkfFOPdJf0Do/NQ4IiD9lKZvcc4LLhrHy32R0
 APPWUUUouzEookU9tjVhPDb8934TbMmRkcDRjvV97e7MyXe71GP+44YXbbaZy3ZWUP15L6mO
 bdfwcb6PaBVh11NqYd9T+tmwK9itdvio7hWklZtEHnRNQ/5D7phJjyZ2JAKuPAVgLBevgSyV
 wSE/dwDYeeFP8bsEVgwIgs5b7TciatFxGGKtfllcl/n4CJX/aacVRkANRe7jiEAfqB+N5kow
 Lt8tcNKuRazjAEmboSPgixOrT/eK3UBV+A4s8hfDtKzzAUszV5GbNrXDSqvuMODbNBFM08LJ
 D6Ihfqd2+4NmBKaK3djR2LQ2ed9hIgVvEwYxlE1IVnUyMHOgeU63UEM/Dk6JuiPIs6rDw6u1
 qlX20xJyWGm+j5pgI1cWjnpFVwZQhKe/UP1xh0Ck2ixo4xEkIDSBDVVBApP1BlxH6Fgkvxz8
 7afx2LoFz3teakdGwMsDFV9paWLocNZr2X/dQPOIyhBN5Y9ZjXhj+mlYm9gR94Lxy8urBWvm
 NSGN9qcpUE22eD8bkH750SnOWwsdS25
IronPort-HdrOrdr: A9a23:ps6YbaDd1lBHCrrlHemT55DYdb4zR+YMi2TDGXoBMCC9E/bo7/
 xG+c5w6faaskd1ZJhNo6HjBEDEewK+yXcX2+gs1NWZLW3bUQKTRekI0WKh+V3d8kbFh4lgPM
 lbAs5D4R7LYWSST/yW3OB1KbkdKRC8npyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,225,1643670000"; 
   d="scan'208";a="10230292"
X-MGA-submission: =?us-ascii?q?MDEgD7kHxz3QVU2m2eWRA5pyOdyO1hKfE1Yu+n?=
 =?us-ascii?q?SsCUUkrCnUWWJ0Bv+Ykn6lEyAJ+KUhCSTsnEuRlOxFM1lnHSQi2ZJTOe?=
 =?us-ascii?q?zVU8EyIvVe5GpAwWzIc7SD9tAolxpWvp0gKkNHPOiniruRLK2zQiyL4b?=
 =?us-ascii?q?uHbfmB6TEG8YulkuRcSvcANQ=3D=3D?=
Received: from mail-wm1-f50.google.com ([209.85.128.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:19:26 +0200
Received: by mail-wm1-f50.google.com with SMTP id r7so753493wmq.2
        for <cocci@inria.fr>; Thu, 31 Mar 2022 17:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlnMpYOXkJb3MsWMx3t3Karvr7oM4CxvFXYgLvSP2H0=;
        b=kbN4drDWXGTqRpuC4U+JxL0qNBRMGx952a73rWLXDa3Hlm4aUdgJ31IqJEf0Jx+ckC
         1aJEH9r0xzziPwQvQ5yR1zUgu8b/A3UaeJj9uHP6ugBk9il8p0uWsatZhH3m63SU1PVb
         LN+cROaanx5Hz6L2eD/KARZEowFji8nqD3SDTP8xKSDNd/A+2m2aG1X7n3oXXmbJXACF
         hWT+lCd9PhmgX7/cm4cn2k1BfRaTONAJdglMtzT2LRzqKs1SgYRqmfcpiohHool4PHfC
         eBuxx0iSCjIKVM+oUt93JFB24big5m2lNXVTPtPBTXmCA350ONdXl0t25CsLDpnjccyz
         jRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlnMpYOXkJb3MsWMx3t3Karvr7oM4CxvFXYgLvSP2H0=;
        b=qpglPaxMm9FBu+XYo0If0lgA+KzXdpIjWOH8P6HI7LsS3yUsVdbu+To2WEridciZVA
         VgapWO9+DS+aApYbBNzBUwhInStiMGrQAcxxwRGCsEslp6UcECoXFcEDiGgGwIEpSdcl
         paQDZCqpTURku7D5zzOhwX1/LB2EHUeKeT4LnDGI6CnINM8Isu1iDgI+RlZhHSnch5MJ
         UWPPYQaSUTH7Moyk6WpwzYYCFHlK8Ac5N+c8kJHJrGHg/puFJoRcJTn/cS/oppttASNI
         GvPOWCo8OBp23rfMHnYcojdlh4kDU5QziOVi323o5WYzQ+VHO4/yKCing/Mlk1VMJERn
         5adg==
X-Gm-Message-State: AOAM530EDe6+vLZXYNnC5HiFY5YNU6cS8DJ8InclJrqo5gCadta2py+6
	tWnoq3bzAAkY1Qol6nIrWupOOy0tXtzxPBx8i/Pwag==
X-Google-Smtp-Source: ABdhPJxATEUZYxO0stl0ueoGYAY1YKf0hGiTqAZL1ta/p5x+yRtL2fXZ3p8DLYTHHVSN7tIVp+IEj9AzjRy7KIMBcrY=
X-Received: by 2002:a05:600c:40f:b0:38c:be5c:9037 with SMTP id
 q15-20020a05600c040f00b0038cbe5c9037mr6618416wmb.44.1648772365332; Thu, 31
 Mar 2022 17:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com> <20220331081409.GY12805@kadam>
In-Reply-To: <20220331081409.GY12805@kadam>
From: David Gow <davidgow@google.com>
Date: Fri, 1 Apr 2022 08:19:13 +0800
Message-ID: <CABVgOS=uaNJq8SivkxY_4L+HRh9bwadGRqF8_tQP_UNGNbmY3g@mail.gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Daniel Latypov <dlatypov@google.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-sparse@vger.kernel.org, cocci@inria.fr, 
	smatch@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: David Gow <davidgow@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 324
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/CABVgOS%3DuaNJq8SivkxY_4L%2BHRh9bwadGRqF8_tQP_UNGNbmY3g%40mail.gmail.com>

On Thu, Mar 31, 2022 at 4:14 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Mar 30, 2022 at 10:48:13AM +0800, David Gow wrote:
> > > +
> > > +Smatch does flow analysis and, if allowed to build the function database, it
> > > +also does cross function analysis. Smatch tries to answer questions like where
> > > +is this buffer allocated? How big is it? Can this index be controlled by the
> > > +user? Is this variable larger than that variable?
> > > +
> > > +It's generally easier to write checks in Smatch than it is to write checks in
> > > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > > +because there is no reason for re-implementing Sparse's check in Smatch.
> >
> > This last sentence isn't totally clear to me. Should this "because" be "so"?
> >
>
> I stopped reading your email when you wrote "Cheers, David" but I should
> have scrolled down.
>
> There is not very much overlap between Sparse and Smatch.  Both have a
> warning for if (!x & y).  That is a tiny thing.  The big overlap is when
> it comes to the locking checks.  The Smatch check for locking is
> honestly way better and more capable.
>
> I always run both Sparse and Smatch on my patches.  I should run
> Coccinelle as well, but I'm more familiar with Sparse and Smatch.

Makes sense. I agree that the overlap doesn't seem particularly
important: it's the differences which should be more evident.

v3[1] of the patch cuts this down to just "Nevertheless, there are
some overlaps between Sparse and Smatch checks.", which I think is an
improvement.

Thanks,
-- David

[1]: https://lore.kernel.org/all/62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com/
