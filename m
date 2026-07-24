Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FDCC531C9
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BOCKzakybOjqx7KDtP7oAKFnixO+xKz5pdYAbzRqLcc=;
  b=JGMWuwai7/qcWw55XYN2fR9ocbwWOAGGmd9b5METWw7Xbuwc3Mu2uXJV
   uz0OO1vWbt1zAk7Q2bb2NRZDce1cJKXdHcus2a5JDc7eD4bCtNkRY0fEa
   DRn0PUkk8Q1wSUnMe9loOQf73hMWU3Cj5Lkf2aqDnme1FRwzHfAm49ZZJ
   I=;
X-CSE-ConnectionGUID: HWo9oYTbS/eo6lgVxPi8oA==
X-CSE-MsgGUID: ndh2AO6kS9iwZTXzaowfGA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="287871679"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:41 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9FCC8805F2; Sat, 25 Jul 2026 13:44:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id ADD0B81966
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 18:48:28 +0200 (CEST)
X-CSE-ConnectionGUID: OPyQMIBPT1mobK8Tm0un8A==
X-CSE-MsgGUID: KdffHZimTXSqu655T67rEQ==
IronPort-SDR: 6a63975c_9WULzC/Y1QVohqsew5bZBuHCZXbFWpXFVdkIKQMWSeZoLkQ
 4hMCdzTBz5E4FS+G04YopUJgRutrqShpbZdEjng==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FUBgBwlmNqfDHgfUpaHgEBCxIMggULAoI/WoEONAQLS?=
 =?us-ascii?q?YRYj1KCIQOBE4gbghkwAoxEhV4UgSs9Ag8BAwENUQQBAQECBDiERgKNYAIeB?=
 =?us-ascii?q?wEEMgcOAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBI?=
 =?us-ascii?q?hkHDg0FKYZPDUkBDAGCCwGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBBQIsXgEBAQECARIRHQEbHQEDAQsGBQsNAgImAgIgA?=
 =?us-ascii?q?QERAQUBHAYTIoUDAQYQAQMQJwO2X4ECQopDeoEVBQIWgQGCDQbaaAoZKA11g?=
 =?us-ascii?q?WYCBxQBAYEJLoR4Kl0DgjogAYFwhAdEglVpeieBGIEQgRU1gXRKOD6CH4FnI?=
 =?us-ascii?q?xoVg0aCagSBDoEUgQyCSIoNhT8mAQcBBhcDBwcJBQQJEwYFAwICPwkGBQoSA?=
 =?us-ascii?q?wQDBAQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAkECwcFHwoCDBQKKCIEDisKA?=
 =?us-ascii?q?QIBVRAGGgEIBgICBAQCBAIKAgkCAgUDBAIEDQMEAQEIAgIDKgMBAxkICQgCC?=
 =?us-ascii?q?wURGAwLBzEDEAkDAh0DFBYFCBE0CAYWARoHBQYLASAWFAEFDBEBAhsCIQQdA?=
 =?us-ascii?q?RAIAwEHAw4EBAIBCwMBAwEVBAgJBAwCDwEKEhUDAwsDBw8CDQcUBRULAwIOA?=
 =?us-ascii?q?gkIDBcCAgIGAgMDAwoBAgEBAQEBAQECBwMDAwIDGQcGAwMBAQMBBAQDAwIDB?=
 =?us-ascii?q?QEDAwMFAgIKBgkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMIB?=
 =?us-ascii?q?QMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDB?=
 =?us-ascii?q?QICAwUFAwUCAgoCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDC?=
 =?us-ascii?q?AMDAgkIAxYGAwMDAwUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHA?=
 =?us-ascii?q?gQCAwYDAwMBAwMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEA?=
 =?us-ascii?q?gIPBAQFAwMHAQECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAgEPBgEJBQIBBQ4HB?=
 =?us-ascii?q?QICChIDBgEBAwQFBQEDAQoBCwEBAgMDAQQFAwMFBwECBAIHAwMDBAMDAwMBA?=
 =?us-ascii?q?QICBAYEAwIDBwMDAwMDBAUFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDB?=
 =?us-ascii?q?QUDAgIDAwQBAgQGAwQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDC?=
 =?us-ascii?q?AcFAwMFAgkDAwkDAwsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHB?=
 =?us-ascii?q?QMDBQMGAQMCAQMDCAsSDwMLCQgTPQELBy4EBAwqARQUBSkhXxCNcCOCOQcBW?=
 =?us-ascii?q?BsagikBFQELgS8BAQGRbC6SNKAhSR4JAQYCYIFngQoVCi+bX4YWM6psLodmF?=
 =?us-ascii?q?5BdkhOSEIUPESQSgTgBM4FcMxojgQFtgUlQAxkPjiGEAs5JODI9AQEHAgcOA?=
 =?us-ascii?q?wuBaIRehheFP4FMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:H/bpSq1SgIHLc4+a7MmG1AqjBF4kLtp133Aq2lEZdPULSKClfp
 GV8cjziyWftN/eYgBdpTnmAtj/fZq8z+8L3WB1B9iftWbdyRKVxe1ZnO3fKnjbakrDH41mpM
 JdmspFeabN5DFB5K6Q3OD7KadF/DDtytHTuQ6x9QYRcShaL45n9BlwEQuWHwlbQwNcFYMlGJ
 f03Kt6jgvlV3BSQciyG2UfU/KrnayyqLvWJTADQzAogTP+7g9AK4SbL/Fb5Hkjuvp0sNUfzV
 Q=
X-Talos-CUID: 9a23:7TvfdGN0AHeDCu5DfxF2zWs1MPgZK3jaxlSAH0rgFGA5YejA
X-Talos-MUID: 9a23:KijbdgnnqXDCthoG+dOmdnpBOMlmw5avDXw9qowb5ZTZCXIvIRqk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="152892135"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEHHnl6LkSwSoudGpOkScj9Ekm1ALX5gjCG/e?=
 =?us-ascii?q?b+3N7UYecK/BjWJnJ7RNXVwG0P0Yygmqmi5T8FWkNpt9CSAZahC35yQc?=
 =?us-ascii?q?xT3ZLjSADZnBkRCLDTdbJE4O/q+K4tlo6AlfhKizdRaLJeuMg5ZGwPb1?=
 =?us-ascii?q?VocQS82s5s9OuGMPor2TgULw=3D=3D?=
Received: from mail-yx1-f49.google.com ([74.125.224.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:48:28 +0200
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-667bae10ba3so564226d50.2
        for <cocci@inria.fr>; Fri, 24 Jul 2026 09:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784911706; cv=none;
        d=google.com; s=arc-20260327;
        b=hSBi+s5n83tt3D2dPm1BQltXpiLai/MV55/WheYcXpgouoNXJ46F7i5zv6E8gFF0jm
         thGQtRI0EGvt4OITW6c8YjKdUyv7L93cHN8gDXxFpF4d9d5EV+1/qbTr31sUC5GWkzH+
         6BqIRj3oZ6i4zb3+A6jNLJTq1UWDMiNedsazJeoyzQFBYBrmPpJ8yp9JCOPz9Jj5aBME
         fQHbLNcCUlTd0KzkX+88UKBFns5tQv8U/5bxfjT0MKxdG+9BgZKlHw/iH79o5qpAjEdH
         Z8ZDxv79pJEvBvVJ6rCyOjzETBASpZDuGicYhnO8lHsIr9k6i63dlt/+tEOLtsmRvDDH
         SA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BOCKzakybOjqx7KDtP7oAKFnixO+xKz5pdYAbzRqLcc=;
        fh=+Tz1/vFvdCF3MKCrEjyf0kTa3+pA5A029yOMjxKnOv8=;
        b=AUayUZ+NJfZOGh0Kpa81rF5zurw9P8+fmO0jniBq7lO3iWgv04nOCVvMTY1U7Jxu8V
         UJZmTRv0/rk0RuBsyOlc6Kaq36TV5MFIQX3Q3rd0GelkbAbVtsxfpK3smaA5xi1dEvNM
         FyJrzM+Qs7UcYj4r5TV+KC0Hvk+5ANi4oqYqjjLjdpnvCILR/CHiX3LFHQd5yFOGnn6t
         eLyiEQstVgM1ALi3xOYboxVXBInZU1YKxZUt6bLokFMX+KEE5tOMcHAR4uig4XXtwRIE
         Fp2I3CuDWUg/VqRzDvLR4uTBNpy+XhEljO7UokxMtI8LwgvnKDc7WBgkp1J4SvCvQ8Si
         y5rw==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911706; x=1785516506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BOCKzakybOjqx7KDtP7oAKFnixO+xKz5pdYAbzRqLcc=;
        b=Wq1elb1rv92IW3Yh87DgbdJT9sDYTxZtd23aWife5elMtfoq7MvkN/qXiPR07H85y/
         0ai6hMm9j/NCA4Ec1RbMbXKCoSmsqgwipurCZn+9GFS53Krj6J2c8t1UDCF3KQC8othv
         JOW5ecXIQVid3NWq+vKVHxTptyRVp6orpVwSkWZW8Q07GLmjPUYagQ8e4aNkAOkVRNiI
         rR52ZRIk6igmeXhfT9iMH7ZVsbCSZ+t+g/NNuQhnhQUdEGnpkJxBVHFI8lPfD5pS2LFt
         ScLlsiIxfHaCmxgsFa9zjcGEPPjPvJ2QY0/HzdFhYcO6WOBlMlLjG6GHRYSIK/4xMF6c
         iOJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6vvUxjpsWE/cFHxi5wIU0Ad6N97q/7zQ30V9iykCKFZvY8/KUc5cyFSsVC4TsF13/H+lkMw==@inria.fr
X-Gm-Message-State: AOJu0Ywz3T5KaJDE+fcKkBVVHd5BaUWlR0cW0HRVsGF39N8dq6d1Rjxh
	A1SPtqlpftuPrkxwHOwjqxvi5Ksizjj/FbY6MfDkizj5AII50uLfErGNlgwni0G6bPvYyxsHio8
	czGDAbYFFOAfFYWAQM9Wam+PSCwEpIgs=
X-Gm-Gg: AR+sD13XhuZF2SlBI6c50j4yJ0UtUk1ajjgxz9b53BWn6zaV8BalNKFjzxaGXnn3H1K
	y34lNlQtwQmAQlpD/2lNO2f+L5qt6otYL1BOaxKMgxrf6rmZY0Ah4xbO/z3fyYJWJrxXli3yEP9
	ximOMQj71kBXFvfI7N9RNDApntaMo/XYP8JBzwWY8XW+18GKvopcuihPgTvEpH+dqcRh3epscZ1
	jsTYmQrapLSCjyog9/kBWCwP4ETGPW77CtfhcTPQ31q3GBvElhyOIM6TvPJZwMcVnHTPA==
X-Received: by 2002:a53:bb50:0:b0:667:bae0:e55e with SMTP id
 956f58d0204a3-668a4bc2cf5mr1568759d50.4.1784911706110; Fri, 24 Jul 2026
 09:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-2-ekffu200098@gmail.com> <CABFDxMEuccFb2zPoA_Fdc6jswhqzMN62At9kEFqGBL5DZOj3DQ@mail.gmail.com>
 <514fd536-291a-bfad-fac8-15e0d0611689@inria.fr>
In-Reply-To: <514fd536-291a-bfad-fac8-15e0d0611689@inria.fr>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 25 Jul 2026 01:48:14 +0900
X-Gm-Features: AUfX_my9-DVt0MZsch8QVUvGMyL9gh_z9Xyt5GfE_Huk_Fqv6-lF-y8JBCeptAs
Message-ID: <CABFDxMHOt2pAb913+uH3LFnv=W-af286NycwzJSe7hbK+V_H0A@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 01/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3653
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/F3qSyT1nzF7QbnNrhMsk2A>

On Fri, Jul 24, 2026 at 11:55=E2=80=AFPM Julia Lawall <julia.lawall@inria.f=
r> wrote:
>
>
>
> On Fri, 24 Jul 2026, Sang-Heon Jeon wrote:
>
> > On Fri, Jul 24, 2026 at 3:45=E2=80=AFAM Sang-Heon Jeon <ekffu200098@gma=
il.com> wrote:
> > >
> > > Add a new Coccinelle script which removes a conditional return that
> > > has no effect:
> > >
> > >         if (ret)
> > >                 return ret;
> > >         return ret;
> > >
> > > Both branches return the same value, so the check can be removed.
> > > The condition can also be a negation or a comparison with a
> > > constant. Such code is usually a leftover from removing a
> > > statement between the two returns.
> > >
> > > When a local variable is assigned right before the check, the
> > > assignment and the two returns turn into a single return of the
> > > assigned expression, and the declaration is dropped if nothing
> > > else uses the variable. Otherwise only the check is removed.
> > >
> > > The fold can delete comments between the check and the final
> > > return, so the generated patch should be reviewed.
> > >
> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > ---
> > >  .../misc/cond_return_no_effect.cocci          | 121 ++++++++++++++++=
++
> > >  1 file changed, 121 insertions(+)
> > >  create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.coc=
ci
> > >
> > > diff --git a/scripts/coccinelle/misc/cond_return_no_effect.cocci b/sc=
ripts/coccinelle/misc/cond_return_no_effect.cocci
> > > new file mode 100644
> > > index 000000000000..541aafdc32c6
> > > --- /dev/null
> > > +++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> > > @@ -0,0 +1,121 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +///
> > > +/// Remove a conditional return that has no effect:
> > > +///
> > > +///    if (ret)
> > > +///            return ret;
> > > +///    return ret;
> > > +///
> > > +/// Both branches return the same variable, so the check has no
> > > +/// effect. It can also be a negation or a comparison with a
> > > +/// constant.
> > > +///
> > > +/// When a local variable is assigned right before the check, the
> > > +/// assignment and the two returns turn into a single return of the
> > > +/// assigned expression, and the declaration is dropped if nothing
> > > +/// else uses the variable. Otherwise only the check is removed.
> > > +///
> > > +// Such code is usually a leftover from removing a statement between
> > > +// the two returns.
> > > +//
> > > +// Confidence: High
> > > +// Copyright: (C) 2026 Sang-Heon Jeon
> > > +// Comments: The fold can delete comments between the check and the
> > > +//           final return, so review the generated patch.
> > > +// Options: --no-includes --include-headers
> > > +
> > > +virtual patch
> > > +virtual context
> > > +virtual org
> > > +virtual report
> > > +
> > > +//----------------------------------------------------------
> > > +//  For patch mode
> > > +//----------------------------------------------------------
> > > +
> > > +@collect depends on patch@
> > > +identifier ret;
> > > +expression E;
> > > +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> > > +constant C;
> > > +@@
> > > +       ret =3D E;
> > > +       if (\(ret \| !ret \| ret cmp C\))
> > > +               return ret;
> > > +       return ret;
> > > +
> > > +@depends on patch@
> > > +local idexpression ret;
> > > +expression E;
> > > +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> > > +constant C;
> > > +@@
> > > +-      ret =3D E;
> > > +-      if (\(ret \| !ret \| ret cmp C\))
> > > +-              return ret;
> > > +-      return ret;
> > > ++      return E;
> > > +
> >
> > If we can make these rules depend on an earlier rule, it should
> > improve the performance a bit. I will look into whether it is
> > worthwhile.
>
> I don't see an opportunity for more efficiency for the above rules, but g=
o
> ahead if you have some idea.
>
> >
> > > +@depends on patch@
> > > +idexpression ret;
> > > +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> > > +constant C;
> > > +@@
> > > +-      if (\(ret \| !ret \| ret cmp C\))
> > > +-              return ret;
> > > +       return ret;
> > > +
> > > +@depends on patch@
> > > +type T;
> > > +identifier collect.ret;
> > > +@@
> > > +-      T ret;
> > > +       ... when !=3D ret
> > > +           when strict
> > > +
> > > +@depends on patch@
> > > +type T;
> > > +identifier collect.ret;
> > > +constant C;
> > > +@@
> > > +-      T ret =3D C;
> > > +       ... when !=3D ret
> > > +           when strict
> > > +
> >
> > While testing the script, I found that this rule can unexpectedly
> > remove the declaration of a global or static variable in the same
> > file, even when it is still used elsewhere. There is no such case in
> > this series, but I will fix it in v2 by matching the declaration
> > inside a function.
>
> I think you could avoid matching the path from the top of the function to
> the declaration by doing the following:
>
> declaration D;
> statement S;
>
> (
> - T ret =3D C
> (
>   D
> |
>   S
> )
> &
>   T ret =3D C;
>   ... when !=3D ret
>       when strict
> )
>
> The first part ensures that it is not a top-level declaration and the
> second part does the check you had previously.
>
> To ensure that it doesn't match "static T ret =3D C;" you can put the
> following in the @depends on patch@:
>
> disable optional_storage

Thanks for the suggestion. This looks much better than what I had in
mind. I'll use it in v2.

> julia
>
>
> > fn(...) {
> >       ...
> > -     T ret;
> >       ... when !=3D ret
> >           when strict
> > }
> >
> > > +
> > > +//----------------------------------------------------------
> > > +//  For context mode
> > > +//----------------------------------------------------------
> > > +
> > > +@depends on context@
> > > +idexpression ret;
> > > +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> > > +constant C;
> > > +@@
> > > +*      if (\(ret \| !ret \| ret cmp C\))
> > > +*              return ret;
> > > +       return ret;
> > > +
> > > +//----------------------------------------------------------
> > > +//  For org and report mode
> > > +//----------------------------------------------------------
> > > +
> > > +@r depends on org || report@
> > > +idexpression ret;
> > > +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> > > +constant C;
> > > +position p;
> > > +@@
> > > +       if@p (\(ret \| !ret \| ret cmp C\))
> > > +               return ret;
> > > +       return ret;
> > > +
> > > +@script:python depends on org@
> > > +p << r.p;
> > > +@@
> > > +cocci.print_main("WARNING: conditional return with no effect (both b=
ranches return the same value)", p)
> > > +
> > > +@script:python depends on report@
> > > +p << r.p;
> > > +@@
> > > +coccilib.report.print_report(p[0], "WARNING: conditional return with=
 no effect (both branches return the same value)")
> > > --
> > > 2.43.0
> > >
> >

Best Regards,
Sang-Heon Jeon
