Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D352C531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4CFDnU81eGJ4aIA2pJ+i439KKIKIofQhljvGQQb8tvc=;
  b=YLbnr20InWF2b18pjSj9FoK/eIfN8edeS2IOLSP2kTGjB3atP54VxVbC
   wJaSZzIUc38q1dreLk8kqnxBSQ2MoSN0cDqqJ7fH2a0JnsEQSHR7oLprQ
   70ohvhNCvJxikU3VbspQeEur/IeZOkm0AugU8h3apIlMWctgJi+rLYSBl
   c=;
X-CSE-ConnectionGUID: C/wMk4WmRtuetNZ36sSVJw==
X-CSE-MsgGUID: +116bxLYSyiBYnLx70KrxA==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287735546"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:56:22 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 490858040C; Fri, 24 Jul 2026 10:56:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2C9CC81A6F
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 21:26:30 +0200 (CEST)
X-CSE-ConnectionGUID: TWUXMpC8TOyviXP92ztqsA==
X-CSE-MsgGUID: ad0yrk1RR6KyEl7Ez7DVGg==
IronPort-SDR: 6a626ae5_oLQaXDr6Ap/z05pN9MFfP70hQEhjox4+mgUdNnaRQGQ/Moy
 W1JdzhM8DGwu5Tl6pbJFy19jP6vlqjaeygknfAw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EHAgC6aWJqg07ASNlaHgEBCxIMggULgkGBaDQEC0mEW?=
 =?us-ascii?q?I9SgiSEO4c8kE+BVYF8Ag8BAwENTgECBAEBAQIEgguCcwKNYAIeBwEEMAkOA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAToHDjuGT?=
 =?us-ascii?q?w2CW4EsgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgIYDgICV?=
 =?us-ascii?q?gcUAQGCfoIjAQYQAQMQJwfDPIEygQGCDAEBBoJq130fLCJdgWkJFAGBCi6Fc?=
 =?us-ascii?q?YJrAYYyhEEnD4FVRIE8gwQ+hENNgw6CaoImgQyDII8OUngcA1ksAVUTFwsHB?=
 =?us-ascii?q?YEjQwMqLy0jSwUtHYEjIR0XFh5YGwcFEiAqQUUjA0E2OAoBQwWBVgKBeD8jH?=
 =?us-ascii?q?wM5f4EvdUp3LWkBAhAXSjgkg0kCgTcCAQttPTcJCxkEPY5hI4NPgkoSF8Y1N?=
 =?us-ascii?q?AeCOIFogWYMn24GEy+XUw6TC5kII6kggWg6gVwzGiSDNlADGQ+OIRmEHMszR?=
 =?us-ascii?q?TI9AgcCBw4DC4VEAQGMVoFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:VXV1xKzHcVyX2ENreSHpKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZMmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bAYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3Ai9pCi2lWgv+ioY69wJrFqmno7lDXOUHi8Uf1O2T?=
 =?us-ascii?q?oNUF4VrylcQ7K6r99iOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ANmTcjA9TlafdzlHTdFQAU4uQf85ku7W0Cxk3q8s?=
 =?us-ascii?q?lquSAagFiZBujozviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152817040"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEtk3rVPPpAhPLHuNbOYDQ9+RalSsvYMheB6E?=
 =?us-ascii?q?8OgBnlZ8zXl3nINEipg6237eTmjTWMFWJsXmwyBgUs18DUs5MOzwuxxw?=
 =?us-ascii?q?D02w3XAj4f9u3BsGsxEYlAVQ0oWoMnOSdWgmvRP173VX4tIbh23EQm9L?=
 =?us-ascii?q?sAlvoixI1iW5FZgB8SYH9ysA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 21:26:29 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1wwMwg2qTW-00uSiA; Thu, 23
 Jul 2026 21:26:16 +0200
Message-ID: <406093f5-ee7d-4ae9-808b-2b42d4846eab@web.de>
Date: Thu, 23 Jul 2026 21:26:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <202dfb21-f5a2-4550-8a1f-aa07d84db345@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <202dfb21-f5a2-4550-8a1f-aa07d84db345@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SGzef8a7BpBkZr51MR4xka0CKPBZ23+k2lsMFBSGPPR7bDJA6Dw
 kAw/Vhn1+fGSNrFliRX7/WV59S+XVFwmXprU4G9e9K066sgHV1cob2cgNh7aYuWncoz9E54
 VYKCztD8ep6u52U08qh9ecrdH0Cb0QgRxJyKITe/6ZF39HokY7lpUrNMAnwvADWkexJiKfD
 gANvQvuWjdAORkLLIPlMQ==
UI-OutboundReport: notjunk:1;M01:P0:afTUKe7Uts4=;hZGSOwQ4hY+/64/G8DGTFkGPUGL
 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
 =
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Improving output for single characters (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3645
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/UM2U9eLjwZ2v7yq3-HS_bA>

> I would like to achieve further source code adjustments by the means of
> the following script variant for the semantic patch language.

Unfortunately, the SmPL code needs to be corrected a bit in the final
replacement rule.
The parameter order should be reversed from selected fprintf() to fputc() =
calls.

@initialize:python@
@@
input =3D ''

def convert(item):
   mark =3D ["'", item, "'"]
   coccinelle.text =3D cocci.make_expr(''.join(mark))

def common_checks(unescaped):
   if input[1] =3D=3D '"':
      if input[2:] =3D=3D '':
         convert(input[0] if unescaped else '\\' + input[0])
      else:
         cocci.include_match(False)
   else:
      cocci.include_match(False)

@find_update_candidate@
constant char[] input_string;
expression input_context;
position pos;
@@
 fprintf@pos(input_context, input_string);

@script:python selection@
param << find_update_candidate.input_string;
text;
@@
if param[0] =3D=3D '"':
   input =3D param[1:]
   if input[0] =3D=3D '\\':
      input =3D input[1:]
      if input[0] =3D=3D '"':
         if input[1] =3D=3D '"':
            if input[2:] =3D=3D '':
               convert('"')
            else:
               cocci.include_match(False)
         else:
            cocci.include_match(False)
      else:
         common_checks(False)
   else:
      common_checks(True)
else:
   cocci.include_match(False)

@replacement@
constant char[] find_update_candidate.input_string, selection.text;
expression find_update_candidate.input_context;
position find_update_candidate.pos;
@@
(
-fprintf@pos
+putchar
 (
-stdout,
-input_string
+text
 )
|
-fprintf@pos
+fputc
 (
-input_context
+text
 ,
-input_string
+input_context
 )
)


Another test result (according to the software combination =E2=80=9CCoccin=
elle 1.3.1=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --timeout 23  -j4 --chunksize 1 --no-loops --include-headers -dir =
tools =E2=80=A6/Projekte/Coccinelle/janitor/use_fputc-20260723.cocci > =E2=
=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20260721/use_fpu=
tc.diff
=E2=80=A6
548 files match
=E2=80=A6
real    0m35,324s
user    1m54,532s
sys     0m3,473s
Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyse=
s> lsdiff /home/altes_Heim2/elfring/Projekte/Bau/Linux/scripts/Coccinelle/=
tuning1/next/20260721/use_fputc.diff | wc -l
50



I hope that demonstrated data processing possibilities can influence furth=
er
development ideas in constructive ways besides hints that some compilers
can also perform such a source code transformation already.

Regards,
Markus
