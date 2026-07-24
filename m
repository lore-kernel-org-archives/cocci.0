Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD0C531C9
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TJX8c1l7bNf1nCAUMU+apxojJw0oV6bZPA+WzbaLkAc=;
  b=osTY97xgzKaiOqOKNJRMUPX7LZSnFu9LBwLdJFhF/nL+1RxC+/SPMBRg
   tFdDZLHqFaoStCG9aOYYEYV9F2zHraoa9HOl8cf+fwodq71FS23WYQ0cW
   L3R0d8x8PxwaNUwOrhYqEy2AcHtRbd4Uqr9KdnGCIhVL5bik2uTfMdnkX
   s=;
X-CSE-ConnectionGUID: Xjgy1D01QA2DggR8L0VNaA==
X-CSE-MsgGUID: BHejRF69TiKYQhL1f1dWyg==
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
   d="scan'208";a="287871532"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8BBED8057A; Sat, 25 Jul 2026 13:44:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 147E481A04
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 16:42:13 +0200 (CEST)
X-CSE-ConnectionGUID: lHzSw757SEikzlnhfJkV7g==
X-CSE-MsgGUID: In7WBfXhSQqPSsx/7BXoGw==
IronPort-SDR: 6a6379c4_OR3pvfgpqcsjOMrYAT/D5aHO4jdcaY4FS8A5XlR7BJq2e0L
 tDmY2I4fxW2xUfyYk0vsmV5K2dqbKDJDpxQo/pA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FnAwBWeWNqgbaAVdFaHgEBCxIMggULAoI/WoEONAQLS?=
 =?us-ascii?q?YRYj1JdBoE+A4ETiBuCGTACjESECYFVFIErPQIPAQMBDVEEAQEBAgQ4hEYCj?=
 =?us-ascii?q?WACHgcBBDEIDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBA?=
 =?us-ascii?q?hABASIZBw47hk8NSQEMAYILAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEFAixfAQEBAxIRHQEbHQEDDAYFCw0CAiYCAiABA?=
 =?us-ascii?q?REBBQEcBgESCBqFAwEGEAEDNwO2VYECQos9gRUFAhaBAYINBtpoChkoDXWBZ?=
 =?us-ascii?q?gIHFAEBgQkuhHgqXQOCOiABgXCEBzsJglVpeieBGIEQgRU1gj44PoIfgWcjG?=
 =?us-ascii?q?hWDRoJqBIMukg8mAQcBBhcDBwcJBQQJEwYFAwICPwkGBQoSAwQDBAQBAgsTC?=
 =?us-ascii?q?QMDAg4CCAMCCAYZAT8SBBMCCAkECwcFHwoCDBQKKCIEDisKAQIBKSwDDQYaA?=
 =?us-ascii?q?QgGAgIEBAIEAgoCCQICBQMEAgQNAwQBAQgCAgMqAwEDGQgJCAILBREYDAsHM?=
 =?us-ascii?q?QMQCQMCHQMUFgUIETQIBhYBGgcFBgsBIBYUAQUMEQECGwIhBB0BEAgDAQcDD?=
 =?us-ascii?q?gQEAgELAwEDARUECAkEDAIPAQoSFQMDCwMHDwINBxQFFQsDAg4CCQgMFwICA?=
 =?us-ascii?q?gYCAwMDCgECAQEBAQEBAQIHAwMDAgMZBwYDAwEBAwEEBAMDAgMFAQMDAwUCA?=
 =?us-ascii?q?goGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAwgFAwQCAwMDB?=
 =?us-ascii?q?AECAgEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDB?=
 =?us-ascii?q?QICCgIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDF?=
 =?us-ascii?q?gYDAwMDBQECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDA?=
 =?us-ascii?q?wEDAwUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDA?=
 =?us-ascii?q?wcBAQIBAggFBgMCAhEFCAoFBgICAh0DIQECAQ8GAQkFAgEFDgcFAgIKEgMGA?=
 =?us-ascii?q?QEDBAUFAQMBCgELAQECAwMBBAUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDA?=
 =?us-ascii?q?gMHAwMDAwMEBQUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDB?=
 =?us-ascii?q?AECBAYDBAIDAQIIBAYFAwMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFA?=
 =?us-ascii?q?gkDAwkDAwsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGA?=
 =?us-ascii?q?QMCAQMDCAsYAwsJCBM9AQsHLgQEDCoBFBQFKSFfEI1uI4I5BwGBDYIpARUBC?=
 =?us-ascii?q?4EvAQEBkhqSNKAhSR4JAQYCYIFngQoVCi+bX4YWM6psLodmF5BdI5FwkhCFD?=
 =?us-ascii?q?xEkEoEzATiBXDMaI4EBbYFJUAMZD44hhALONTgyPQEBBwIHDgMLgWiKdYU/g?=
 =?us-ascii?q?UwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:RtlTTa39L1zmrum9oxScBAqjBHMkLtp133Aq2lEZdPULSKClfp
 GV8cjziyWftN/eYgBcpTnmAtj+fZq8z+8I3WB1B9iftWbdyQ2Vxe1ZnOzfKnjbaknDH41mpM
 VdmspFeaXN5DFB5K6Q3OD7KadE/DDtytHSuQ6x9QYWcShaL49lqyh0AhuGCUFtLTM2fKYRJd
 6z4o5oqVObGUj/rf7bOpDGZYb+ThTw5fHbXSI=
X-Talos-CUID: =?us-ascii?q?9a23=3AuSVpimhuhA9jqSbF/ODdfLbmWDJudl3P92iPfhC?=
 =?us-ascii?q?DJGdqWrmTSVGy+507nJ87?=
X-Talos-MUID: 9a23:KnPFWgtpG5M5Y9sv+s2npTc9C+1m06SVMVk1qo4W/JauBStfJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="152882829"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFQG5E+iXM33eCP99vf00/s0CccmtBMt7lx16?=
 =?us-ascii?q?1fckT8/w1JJNnZN9HzMo25mlHafU4qPUk7r0U5qRwM+vate3EKklMTTf?=
 =?us-ascii?q?VrbLfKzsWXr2AkXIdsfKPWGPuHxBj1JVRP9sELM13zxb7Wf9qJNT/rFA?=
 =?us-ascii?q?IeaUyLhmz2SHTSlQHqohq6Lg=3D=3D?=
Received: from mail-yw1-f182.google.com ([209.85.128.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 16:42:12 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7ff05e5d009so3879057b3.1
        for <cocci@inria.fr>; Fri, 24 Jul 2026 07:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904129; cv=none;
        d=google.com; s=arc-20260327;
        b=giS4evQ830msNabWuRidWmTk9Tr4KXjg0XwtSYXfV1CoK8VikpKS1IIdG0tGEDgD0f
         EJk7lTWW21mijqkbSbCqzL4p8j270SGAN+jICmoOGadN8z8NEWt1BqbaSPdflKf3n3l1
         tkhVL9IS/y6G64EQU3jyfmUiLL/IurvHcbE7fWeR4AR9uCFWBA3uQ1KpFdtm5kguiYFm
         xJvhA9ItrD4VqAV060lgRTrKuZx1y9XIcsZk1NaHpj3stf436z/k1mE2L7rc0FTU3acL
         74r/SghiJHkUAgLhmnGCa/BXzzWQEYvsnNBjAamdXAt5a71Op9XU2O6pW6F3R4ax29ub
         WT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TJX8c1l7bNf1nCAUMU+apxojJw0oV6bZPA+WzbaLkAc=;
        fh=323DWxEHDEKablpF4sx0RpclR6YD4OjGhKv5gBLBeyg=;
        b=pmTAjiw3MuEnSPfKLif2IqJheQzVGDsubLqYZjC8LE2qSH5DMJumeC4c1T0TCHedF4
         94krRG5bS3Tqd5h2WKp2QCZFSkCPlM+zBGJKHpPHsrMSz7rUDGnV5Io9IUqcFMbDU+Qb
         jC8K0tbG40SYll7piyj8xozucEMLQ2FQ6xxR56VNkC8gxTW1CGUfz68bLROT5BQ/7Zkc
         YrOzx57l9G7iJ5Kxt/nOagvejNeX+QJ3U/mWIyZzMF/mwMCObjbajhbBpvqUFZihQR9T
         3Hpe5nP21oyHGCB/Ey1p7nZ881z9SO9Xkg5TbB+TsX4a6rDT298xi4mBkje2KWs2zLri
         2xVA==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904129; x=1785508929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJX8c1l7bNf1nCAUMU+apxojJw0oV6bZPA+WzbaLkAc=;
        b=b2DlXBAACXDlLhpr1kyYxrXAg4/yUvkvp1ZvUJXweLeFL/NNFtwNg0zqbclJj18uyt
         me20PHN57EFupC8mUX+dwpemkm3PZ7JRRXRpDJhbenY/0HnmRigISzN/sbgQMM5mkDZY
         tFN0WrDNEUUrrmE9pYblhZBbBtMXzLQIkv2QDWrb3hb5dEMNkOzPkFrOEzZ9/rCtHAOL
         IjNDG+67lDF6OUyxT3y+dnmPSHF6PptMOdIQvXDq54dhkfBK/FZDVRjhHMzbvDMe3LYC
         D777zHh/TK2tWCUQ0bRy2c5VHFGxEezpQ8E9uJMXEEGJJvsF7kNV+3nu7898CJUK6AlI
         kJCQ==
X-Gm-Message-State: AOJu0YwZyDEtJpA5qGW0eD+6Ztlt6h7VmwnKD5rO/MuLoVDNWIYl2E6w
	HeCQrM30H/iMgT5c5C+Oad6w3n7ByzVvDvaB5Ah/+nNyT5syu8G9ho4BzJCFaWoXxrEe0lElqIo
	+lOmTnklYSioRnq6lZOd/40FfXYrJ7QH5yG8q+4lF1Q==
X-Gm-Gg: AR+sD12Ds/FaSw+uycWvqnRENwIq5Jm08E4rhNfHa/iYW7oVM6VSVne7f8aRVGBHWsk
	l5iTp4RmZ3AUlXQAReSoeKiu7RpcYY9rLDDNuTirZmt7TJFKV90x6yP4oh4vI8VylfHx8U8faoX
	Y1ySvgEyHrq0o+S++hLGk68iK1FmNE/i6SqctzKXNMogCY3QXb1Ak16KAw9OY6tWwQ4keBVDhGO
	b8s8qA6VeVb811hTgEMRtRjO7532739J60nthgOhLeYzZGi8t7cdCxCFTs=
X-Received: by 2002:a05:690c:d90:b0:81d:42e6:6a82 with SMTP id
 00721157ae682-81f4c1c1df6mr25909007b3.25.1784904129118; Fri, 24 Jul 2026
 07:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <20260723184538.3888637-2-ekffu200098@gmail.com>
In-Reply-To: <20260723184538.3888637-2-ekffu200098@gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 24 Jul 2026 23:41:57 +0900
X-Gm-Features: AUfX_mwP-n3qWT2SXXQaTH_QaF8VZshl5LPoIEv_xSwCMHlWAguSE8ebB0NDx98
Message-ID: <CABFDxMEuccFb2zPoA_Fdc6jswhqzMN62At9kEFqGBL5DZOj3DQ@mail.gmail.com>
To: Julia.Lawall@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 01/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3648
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/lNwdVHHuDCdpSGvBoFZ6Pw>

On Fri, Jul 24, 2026 at 3:45=E2=80=AFAM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> Add a new Coccinelle script which removes a conditional return that
> has no effect:
>
>         if (ret)
>                 return ret;
>         return ret;
>
> Both branches return the same value, so the check can be removed.
> The condition can also be a negation or a comparison with a
> constant. Such code is usually a leftover from removing a
> statement between the two returns.
>
> When a local variable is assigned right before the check, the
> assignment and the two returns turn into a single return of the
> assigned expression, and the declaration is dropped if nothing
> else uses the variable. Otherwise only the check is removed.
>
> The fold can delete comments between the check and the final
> return, so the generated patch should be reviewed.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  .../misc/cond_return_no_effect.cocci          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.cocci
>
> diff --git a/scripts/coccinelle/misc/cond_return_no_effect.cocci b/script=
s/coccinelle/misc/cond_return_no_effect.cocci
> new file mode 100644
> index 000000000000..541aafdc32c6
> --- /dev/null
> +++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Remove a conditional return that has no effect:
> +///
> +///    if (ret)
> +///            return ret;
> +///    return ret;
> +///
> +/// Both branches return the same variable, so the check has no
> +/// effect. It can also be a negation or a comparison with a
> +/// constant.
> +///
> +/// When a local variable is assigned right before the check, the
> +/// assignment and the two returns turn into a single return of the
> +/// assigned expression, and the declaration is dropped if nothing
> +/// else uses the variable. Otherwise only the check is removed.
> +///
> +// Such code is usually a leftover from removing a statement between
> +// the two returns.
> +//
> +// Confidence: High
> +// Copyright: (C) 2026 Sang-Heon Jeon
> +// Comments: The fold can delete comments between the check and the
> +//           final return, so review the generated patch.
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@collect depends on patch@
> +identifier ret;
> +expression E;
> +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> +constant C;
> +@@
> +       ret =3D E;
> +       if (\(ret \| !ret \| ret cmp C\))
> +               return ret;
> +       return ret;
> +
> +@depends on patch@
> +local idexpression ret;
> +expression E;
> +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> +constant C;
> +@@
> +-      ret =3D E;
> +-      if (\(ret \| !ret \| ret cmp C\))
> +-              return ret;
> +-      return ret;
> ++      return E;
> +

If we can make these rules depend on an earlier rule, it should
improve the performance a bit. I will look into whether it is
worthwhile.

> +@depends on patch@
> +idexpression ret;
> +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> +constant C;
> +@@
> +-      if (\(ret \| !ret \| ret cmp C\))
> +-              return ret;
> +       return ret;
> +
> +@depends on patch@
> +type T;
> +identifier collect.ret;
> +@@
> +-      T ret;
> +       ... when !=3D ret
> +           when strict
> +
> +@depends on patch@
> +type T;
> +identifier collect.ret;
> +constant C;
> +@@
> +-      T ret =3D C;
> +       ... when !=3D ret
> +           when strict
> +

While testing the script, I found that this rule can unexpectedly
remove the declaration of a global or static variable in the same
file, even when it is still used elsewhere. There is no such case in
this series, but I will fix it in v2 by matching the declaration
inside a function.

fn(...) {
      ...
-     T ret;
      ... when !=3D ret
          when strict
}

> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@depends on context@
> +idexpression ret;
> +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> +constant C;
> +@@
> +*      if (\(ret \| !ret \| ret cmp C\))
> +*              return ret;
> +       return ret;
> +
> +//----------------------------------------------------------
> +//  For org and report mode
> +//----------------------------------------------------------
> +
> +@r depends on org || report@
> +idexpression ret;
> +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> +constant C;
> +position p;
> +@@
> +       if@p (\(ret \| !ret \| ret cmp C\))
> +               return ret;
> +       return ret;
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +cocci.print_main("WARNING: conditional return with no effect (both branc=
hes return the same value)", p)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +coccilib.report.print_report(p[0], "WARNING: conditional return with no =
effect (both branches return the same value)")
> --
> 2.43.0
>
