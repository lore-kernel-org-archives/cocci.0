Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA33C53209
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z3kTxhXUJAqu6YeMO4jBR/UMewULQEc8nT5/sQMj3Ec=;
  b=KRfOosqKYJSSS94AycFHdEavA0w6TIRm89sc91svybjmuIOapfHgQrNM
   P6euY+hUD2I49QnS8vLgzXRr9MUg0Uj/UWqL7gqHIQYEaAhV1PdSUAmVJ
   amWEoNGO2fXXaBVBMh37YGrUrM/ll3k3Rsb2yCKApe+8GuEqcXLTmLxBT
   w=;
X-CSE-ConnectionGUID: fZWnew5hTAGeQF6epKQDsw==
X-CSE-MsgGUID: SktaMFBRTrGACa148+Er1Q==
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
   d="scan'208";a="287871700"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:42 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4A164805BE; Sat, 25 Jul 2026 13:44:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 155E28132F
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 19:12:36 +0200 (CEST)
X-CSE-ConnectionGUID: nU8MNTLSTpS3jWxL9NR1ew==
X-CSE-MsgGUID: FqWDfnIETnOzQ97wSjWD8w==
IronPort-SDR: 6a639d02_wQZxB9p/DWdgno2YaJrzADk7P6oumS9Ioe7GShieTmzMpwe
 MdJmRKqqc6q7tz3wnS1QV7PD36J3GRuxjTLJ4Mw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FKAwAvnGNqgamAVdFaglkCgj9agQ40BAsZMIRYj1KCJ?=
 =?us-ascii?q?ItHMAKQTYFVgT89Ag8BAwENUQQBAQECBIR+Ao1gAh4HAQQxCA4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOO4ZPDUkBEAGCB?=
 =?us-ascii?q?wGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBB?=
 =?us-ascii?q?QIsXgEBAQECARIRHQEbHQEDAQsGBQsDCgICJgICIAEBEQEFARwGEwgahQMBB?=
 =?us-ascii?q?hABAxAnA7YtgQJCikN6gRUFAhaBAYINBtpoChkoDXWBZgIHFAEBgQkuhHgqX?=
 =?us-ascii?q?QOCOgQcAQVufYQHG4NneieCKIFKgnY+gVJNgiQVg0aCagSBDoEUgQyMWIU/J?=
 =?us-ascii?q?gEHAQYXAwcHCQUECRMGBQMCAj8JBgUKEgMEAwQEAQILEwkDAwIOAggDAggGG?=
 =?us-ascii?q?QE/EgQTAggJBAsHBR8KAgwUCigiBA4rCgECAVUQBhoBCAYCAgQEAgQCCgIJA?=
 =?us-ascii?q?gIFAwQCBA0DBAEBCAICAyoDAQMZCAkIAgsFERgMCwcxAxAJAwIdAxQWBQgRN?=
 =?us-ascii?q?AgGFgEaBwUGCwEgFhQBBQwRAQIbAiEEHQEQCAMBBwMOBAQCAQsDAQMBFQQIC?=
 =?us-ascii?q?QQMAQEPAQoSFQMDCwMHDwINBxQFFQsDAg4CCQgMFwICAgYCAwMDCgECAQEBA?=
 =?us-ascii?q?QEBAQIHAwMDAgMZBwYDAwEBAwEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIA?=
 =?us-ascii?q?wcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAwgFAwQCAwMDBAECAgEBAQIDAQMDB?=
 =?us-ascii?q?AMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICCgIDAwMCAQMCH?=
 =?us-ascii?q?AMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDAwMDBQECAgIDB?=
 =?us-ascii?q?QMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDAwUBAgcCAwcCA?=
 =?us-ascii?q?QsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBAQIBAggFBgMCA?=
 =?us-ascii?q?hEFCAoFBgICAh0DIQECAQ8GAQkFAgEFDgcFAgIKEgMGAQEDBAUFAQMBCgELA?=
 =?us-ascii?q?QECAwMBBAUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDAwMEBQUFA?=
 =?us-ascii?q?wIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDBAIDAQIIB?=
 =?us-ascii?q?AYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDCwICAyECB?=
 =?us-ascii?q?QMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMICxIJDQMLC?=
 =?us-ascii?q?QgTPQELBy4EBAwqARQUBSkhXxCNcyOCQAGBDU6BWxcegRwBAQGSKIMVAY8Qi?=
 =?us-ascii?q?3uUJkkeCQEGAmCBZ4EKFQovinuQZIYWM6psg1iHP41xkhORV4VIESQSgTQCN?=
 =?us-ascii?q?oFcMxojgQFtgUlQAxkPji0Wg2DOSTgyPQEBBwIHDgMLgWiEXoFmiXCBTAEB?=
IronPort-PHdr: A9a23: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
 0djMWWcL48=
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:6mwECKveor4s+DiSp5IAq+G37skDmtV00zEX/kB9WHVpm5Oj+/
 xGzc536farslwssb8b6Ky90c67MA3hHP9OkPYs1NKZMzUO11HYVb2KgbGSpQEIXheOkdK1tp
 0QFpSWaueAdmSS5PySiGKF+pQbsb26GcuT9J3jJhlWPHxXQpAlwAFjFA6BH0F6ACVAD4EoDY
 eR66N8xgaISDA4aoCVCnEZQ/POvbTw5erbSC9DKRpixgfmt0LK1Fc4KXilN9UlPQ+nCI1Sk1
 T4rw==
X-Talos-CUID: 9a23:XnLlXWP3ZsWZ4u5DXhQ30WgoPvsZakaGzkjABx6eMz9kV+jA
X-Talos-MUID: 9a23:3Z+Eawowr8krTW8VMPIezx97C+tm5YWDNEYqg6xX5Na/NxNcayjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287815089"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGbg4OLThBv4x9OyWDGbKmj5v1sq/WPRmiuZZ?=
 =?us-ascii?q?AJO86nadwPKZKa/CHnlWR04NFwnTn2QVpC+5scxi/V/D99pGYKMcC52F?=
 =?us-ascii?q?HqTofewZ12NekZPzYxHbUlsTsghEt728wlN8r17MshyWP2YDW2qMaQY7?=
 =?us-ascii?q?FfQJzE+dIeSJyeXINcfbSolA=3D=3D?=
Received: from mail-yw1-f169.google.com ([209.85.128.169])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 19:12:34 +0200
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81dfdbd86d1so6603547b3.1
        for <cocci@inria.fr>; Fri, 24 Jul 2026 10:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784913153; cv=none;
        d=google.com; s=arc-20260327;
        b=ST7lLNvpYs79I14bw19g4Msom0i3qcq28jJIXS+D5fU22nZwKCnvDaWLj9uKouRcKi
         1tVKBdfcimK0W+jvxfY9fdEyN1tQy/FgT1AlhAuPgZv63uNQ9/I63KMyFBV9PLb2bWd+
         2UxmBFVBefBoLgg4fTZfbsmiGb7/Nbynfl2aWdq+DdwQ3l7S95ryiPPVFG2y+BetJ8o+
         QITPcaU6O0PlUc4ewN2eaZ5D7hrs/T7e5lCFN7+PK/R2VjAjOXHyT0CieO4UTlBlQGAB
         2nqJ+XYVXvNvV18JEKNyHEepFguxXeS9nWtXkP3SPTl0TSss+Iv5sPpGXVGHNBG8VCr3
         qQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z3kTxhXUJAqu6YeMO4jBR/UMewULQEc8nT5/sQMj3Ec=;
        fh=cKKiGs4q+8l3b5AlEtRTE8OuMFrFKqOgBayWiaXxRRI=;
        b=IaLywOT0gA3JvilhkrLHdZo95clcsmn9bAaPd/g+Miuo5/x8tDEi6fe0QBCfVhYRw9
         0As7ai2AED1cDF34F9LQyBPvFEW7WK4rK2h5EZjZieQKLqymLmChAqx/fdJyzLRp9eZT
         d87kgppoDB9MFAvUffLA7ePTiZQKGPOZ9c6ywFUymsLcNYGIeYUhVnUOO1q1E0UBnnhM
         kDci59NduWdivRhiRyOmkr5vKoyJ6PIN5Gj0XnnmPg7S1Ak5VkioO4T4e9+r89/CsOeC
         wCegUlJoWnNu2uzpzKlc2ikM2KnF5e0LZP4ptzJeXJBAXJg/rcph1+z8gmD5TfhVkSte
         rCVg==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913153; x=1785517953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3kTxhXUJAqu6YeMO4jBR/UMewULQEc8nT5/sQMj3Ec=;
        b=cN/koeP5lUG1F34/tMJ3dWDS9y/82csK1iDtOZr4fHQpbYqw9CZQ+Hl5ujNQOLUiJz
         UORIEg2ytbV0Wqf2W+xT1Kr31ZCG8lifYFlLfsQoI+wZD9kJcyxXE7DXMUOTzDxoAjpT
         chZ+GtK4VqhLiTQP4V5rbmqiTfZG+YVL3e9F/GVx2jcuWEcd0T59a4PP89WYUCq2oGxj
         W0uZS/97SVX8LGs49r7Sp2MNMqtPqSnPGQlRhbBdzBiemDlnXrD3qbsR/B60ctbounQn
         /6VeG8xjebAkMMLoB4ma8wDhVT8nYlbP50S7tG6snHBKX3T9q9OJcFRT+uQNF5S3OUyo
         DhIA==
X-Forwarded-Encrypted: i=1; AHgh+RonMjVYPgFGGjT9MAjQ9RpcYWQbbRDftseu02vvvkGgWYhCZrfS4EuX4LdPEt/qGtuvL9th6Q==@inria.fr
X-Gm-Message-State: AOJu0YwJHOiEszK1d7bhGeWLA4ZUV1Fs/t0ouU5ocm//hBFL+WVdsbnM
	XQNcXSXx2BMaRRxGhEnSwe7APgAKN4wm+MBq/AcwDFZpG4moRvlYFrWL1kp1D8hVnmeWYw2hBGc
	dJIVDvkiB54v1xA2v2En6BqW/R5ZbceU=
X-Gm-Gg: AR+sD11tI1PG7ow8A6PB1G8EOkDZEVJVaOb70pioCcPTRdRvJwmPicnMAe79PsD7qIt
	B+hdNnpPmgkFCPWFx3WYcc0cjPF+iSTkvgYc6W8AxcOXWozKaIN/uFmQrzGF7xZZTHuK5a2ZkMq
	7MczjSWLF73BX63+PqjcOeqgd4sGAF+Teu8HDHoS6lmXpCxmbR3MjdM6V4EgkCk8NJJNHXXW9b8
	yBgQ4osNXCGqSKI8Fm5WuK/Jk06uFWn1vB4aQI2QcXloQs6AQbqB7mQvgA=
X-Received: by 2002:a05:690c:6308:b0:81e:742c:8c41 with SMTP id
 00721157ae682-81f4c31be28mr30534647b3.56.1784913153292; Fri, 24 Jul 2026
 10:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-35-ekffu200098@gmail.com> <CAH2r5muT20HXUANLnXQc1dAAvs+N=jFneSsV9gUqS8GE-wWNPQ@mail.gmail.com>
In-Reply-To: <CAH2r5muT20HXUANLnXQc1dAAvs+N=jFneSsV9gUqS8GE-wWNPQ@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 25 Jul 2026 02:12:22 +0900
X-Gm-Features: AUfX_mzuE8BIzTW71YBPHhbDBNC6znqF4qg4uLZzc1eHBFxwXGo8wazgEbSQ4ag
Message-ID: <CABFDxMH=1M2m8tyyHZHwpJ9OUmMRBCftfq2SiMxTyKUr7a9FNA@mail.gmail.com>
To: Steve French <smfrench@gmail.com>
Cc: Julia.Lawall@inria.fr, Steve French <sfrench@samba.org>, cocci@inria.fr, 
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, samba-technical@lists.samba.org, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 34/36] smb: client: remove conditional return
 with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3654
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/74m23Ry-ZIdJRjFrXw_H4w>

Hello,

On Fri, Jul 24, 2026 at 5:27=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> You can add my Reviewed-by if it is not going through my tree.
>
> Which tree do you want this changeset to go through?

I don't have a strong preference. But some patches in this series have
already been picked up by their subsystem trees, and I'm planning to
send v2 that fixes several issues and addresses feedback.

So could you take this patch through the cifs tree? Then I will
happily drop this patch from v2.

> On Thu, Jul 23, 2026 at 2:04=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail=
.com> wrote:
> >
> > Both branches of the check return the same value, so the check has
> > no effect. Remove it and return the value directly.
> >
> > This is the result of running the Coccinelle script from
> > scripts/coccinelle/misc/cond_return_no_effect.cocci.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  fs/smb/client/smb1maperror.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/fs/smb/client/smb1maperror.c b/fs/smb/client/smb1maperror.=
c
> > index ab3d09613c91..395299f9121b 100644
> > --- a/fs/smb/client/smb1maperror.c
> > +++ b/fs/smb/client/smb1maperror.c
> > @@ -234,11 +234,7 @@ int __init smb1_init_maperror(void)
> >         if (rc)
> >                 return rc;
> >
> > -       rc =3D mapping_table_ERRSRV_is_sorted();
> > -       if (rc)
> > -               return rc;
> > -
> > -       return rc;
> > +       return mapping_table_ERRSRV_is_sorted();
> >  }
> >
> >  #if IS_ENABLED(CONFIG_SMB1_KUNIT_TESTS)
> > --
> > 2.43.0
> >
> >
>
>
> --
> Thanks,
>
> Steve

Thanks for reviewing.

Best Regards,
Sang-Heon Jeon
