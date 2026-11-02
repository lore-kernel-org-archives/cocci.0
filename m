Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E61606A32D
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=qmp7TyGX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7ILwAwzu57MKsu2U8qvPn8STc7HTVnKuk72Aio8hCfI=;
  b=qmp7TyGXeqFzbCtxG57ashyDDE0oSjXu6YPyAKuR7J5SKa1Nb/8CfYKp
   h0xm5yahWPSgDDmCVwCg/QsNQ+4hPT8vxpCzoCGuyDuaI4QDWTslF1SiE
   UrgoTUOVqK41LfWE41IFIanf2nz+zCg1PigA5obO6mscPEa/wieFPM4EX
   A=;
X-CSE-ConnectionGUID: aLit2rQLRI2AD4I8C3EY4Q==
X-CSE-MsgGUID: VhmNJw2JR82RzQGqmuGN4g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323395"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:20 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 48BCA81861; Sat,  7 Nov 2026 11:59:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7FF3F81811
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 10:01:43 +0100 (CET)
X-CSE-ConnectionGUID: jUa1yqU1SwmKzZlOw+wIGA==
X-CSE-MsgGUID: /ZH1TDBXRuaXl7eUhCweqw==
IronPort-SDR: 6ae85176_D/xqlmRFXhkIEsYSZDCIkq1mIlwqNXAgmQkmDHiQOFAd9eG
 DdHzzZ0UMfL9ccW2l1GAzZKURKkiLqgc4oaOunQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H2AgC8UOhqfCnaVdFaHgEBCxIMggULgkGBC2EzBFQEj?=
 =?us-ascii?q?U6GWYIhA4ETijUyhVGKf4FVFIErPQIPAQMBCwEBRA0EAQEBAgQ4hEYCjh0CH?=
 =?us-ascii?q?gcBBDAJDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABA?=
 =?us-ascii?q?SIZBw4SKYZPDYwaAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEFAg0fXgEBAQECAScTBgEbHQEDDAYFGC4gAhEBBQEcBhODA?=
 =?us-ascii?q?4IiAQYQAQMQJwMRsBuKeHiBARYFAhaBAYINBtpsChkoDXWBaAIBBgkBCgEBg?=
 =?us-ascii?q?TeEeSpdA4I8BBwBBW+FBYMaaXongiiBFYJzOD6CHyuBPIQAgwMEgiKBDBuCQ?=
 =?us-ascii?q?pQuAQcHMQkJEwYIAgJICwoZAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggJB?=
 =?us-ascii?q?AsHBR8KAgwWCigiBA4rCgNWEAYaAQgGAgIEBAIEAgoCCQICBQMEAgQNAwQBA?=
 =?us-ascii?q?QgCAgMqAwEDGQgJCAILBREYDAsHMQMQCQMCHQMUEQUIETQIBhYBGgYFBgsBI?=
 =?us-ascii?q?BYUAQUMEQECGwIfBB0BDggDARQEAgEJAwQWBAIUCiEFAhsBDwMDBgMHAwcCB?=
 =?us-ascii?q?AMIAggDAwgIAxYDAwUBAgIEAwMICAQDAwQCAgMLBQMCAwMFAwMHAgQCBAMDA?=
 =?us-ascii?q?QUBAgcCAwcCARgDAgQIBwcFAgsEAggEDQkEAgQCAg8EBgMDBwEBAgEHBQYDA?=
 =?us-ascii?q?gIQAQgKBQYCAgIcAx0BAgENAQkFAgEFDgcFAgIYAwYBAQMGBQEDAQkLAQECA?=
 =?us-ascii?q?QIKAQIEAgUDAwEDAgMCBgMDAgUFBQMJBwUVAQMDBgUCAgMCAwECCAQGBQMCA?=
 =?us-ascii?q?wUBAwQDBwMCCAMIAwwCFgIFAwMDBgkDBwcCAwcDAgUCBwUDAwUDBgEDAgEDA?=
 =?us-ascii?q?wgLEiIDAQUDAwIBAwIFAwMYAgIEBQMDAwMDCAQCAgEHBgQCAgIBBQUFBAUGA?=
 =?us-ascii?q?gQDCAEBBQMDCg0BAgcMAwwGAwcDAwQEAwIFCgIEAQcDAwcHCQcDAgMHAQELB?=
 =?us-ascii?q?AEDAwoDAwUCAQEHBQMGAwcCAwMDBQQFAwILAwcCAgMDAwInAQEBAwMDAwMEA?=
 =?us-ascii?q?wEDAQMDBwMFAwIOAggBCgMCBgMHBgMFAwMCAQIDAwURAwYEBQYXAgYRMgEIA?=
 =?us-ascii?q?gMDARQEBAUCBRUCCAEDBQMDAwMCBQEBBQEBAwMFAwMDAwMDBAEDBAIDBwYIA?=
 =?us-ascii?q?QEBAggDAwIFAwMDBAMDAgEJBAIFAwYCAgQCBAEHAwECAgMDAwMBAgQEAgcEB?=
 =?us-ascii?q?QILAwQCAwMFAgMCAwsGAgsEAgMDAwMDDQECCwYUBQkECAUDDwUBBQcHCQEDC?=
 =?us-ascii?q?AUDBgMJAxQDAwYDAwMKBAIFAQYODA0EAQgDAgQCDhUEBAMHCgoBAQQOAwQBB?=
 =?us-ascii?q?AECAgYPBQIIDAcBCAIFAgICAwMDAgUIAgUCBAIDAgcCBAkDAgMCAgIGAQMCB?=
 =?us-ascii?q?AEHAgIDAhkEBgMGAwMGBg4CBwMDAgMBCgYQAQUDAgMDAg4DDAcEAwMDBAUDA?=
 =?us-ascii?q?gEDAwMFAgIDCQMCBQcFBgIEBAYDAgQFCxIBBQcSAgEEBQMCAwIOCQgTPQwHL?=
 =?us-ascii?q?gQEDCoBFRQFKYEAEJF/gh4+LQYBPRYoEwETCBAXC3YIRRgFBA4LKQKBBAEBA?=
 =?us-ascii?q?ZU+jHKiP0keCQEGAg1UgWeBCxUKL4wjjz6FfE2EBJNPkx0ul197glmJN4F6h?=
 =?us-ascii?q?AqRVxOFGwIKBwcRJBKBMjqBXHBQgR6BSRI+AxkPjiKEAoUTyShDNQI7AgcCB?=
 =?us-ascii?q?w4DC5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 JDw9jRP3AVsaNNzLqvVdvIh8w==
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:Ek4hkKD8Wj2KvFblHelj55DYdb4zR+YMi2TDGXoBLiC9Vvbo6v
 xG/c5rryMc7Qx6ZJhOo6HjBEDtewK4yXcx2/hsAV7AZnichILLFvAa0WKK+VSJcFycygce79
 YZT0EXMr3N5DNB/KDHCWeDYrId6ejC36aym+/EwnthCS1sYbpx9hp0B2+gfnFedU1pAd4WGv
 OniPavZADORZ3UVKmG77A+PtT+mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AbG2T/mo9aqP4rXicV7h1BAfmUcIYeyTM1UqJGFC?=
 =?us-ascii?q?9KnRbTJqKCkCx14oxxg=3D=3D?=
X-Talos-MUID: 9a23:rA2Drgk7+1JCnH1Q7JrxdnolBucx34iEOHoQmKUC5MS5NQdvNi6C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="303294983"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHYIjr1Y+I+ybhOP6VKSEfsc1q9MPYuiBuCJo?=
 =?us-ascii?q?fBiXAoAuw9dKc/3wmjHWTR4bnpgi1/1rIyB51g45+Y7YOPWyH2t8j/ik?=
 =?us-ascii?q?tUxsX9fS6UeFON3BZUyymnoSbkzZCtefRNqepS5QNdY6G3re09RSnDS/?=
 =?us-ascii?q?31AqKGGkntC8hukHGm8YVpcQ=3D=3D?=
Received: from mail-ej1-f41.google.com ([209.85.218.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:01:42 +0100
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c37b612635bso373166866b.3
        for <cocci@inria.fr>; Mon, 02 Nov 2026 01:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610101; x=1794214901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ILwAwzu57MKsu2U8qvPn8STc7HTVnKuk72Aio8hCfI=;
        b=sVkfZiuVlSkdI3FYI9bMUnlkway+6Jn23uqB3Ao5ZIgNM+YeEaaT3RL31k6nOnRi32
         BEkAFR1JB8s3G0j2XdQN+ZvXMmnJ+QQMYsXsPkFtV0qecKXbfXzHdPkpt0Bc0lD4V0Zh
         uyR3v+f4zL9oEtzPXcsIqJXpC01q8oOEX/Keptrk5r0Wm/Nnb0Hw6GUVudHRSSBo/hxp
         U2Z1r5s9kukcOPEY/q6vKabl6tV+60IHEpnGPlVPwATY12S1WccUvITm/zeLIY4d73JB
         s4WSRlijmkK75DJavlqWnwNfdrKQ9SkCksVqYYh/vmmBegq0TmNx69rwLfUU00cLhtQx
         vrpw==
X-Forwarded-Encrypted: i=1; AKwUvBzlJDiT9pRjSYr80OD1VmkDyTgZ8156iTDDxiCH7GIV2JAs0cxQobtfyJ+WX9taJh6aXq2Dyw==@inria.fr
X-Gm-Message-State: AFq9FYKaFEplfeFIoYXaaxxisx0VKeBLLqJzevMW+HJv7bmMyYrD0Z/R
	Y0weLDaTzsiooYsbAtT7fz2zRoAn5sDy6oI/pZo3OgvvVrXbyoQfeEaM
X-Gm-Gg: AYBFou12JyX6OpoxC/3bredyUSMZLRP/odRaTjhW3KJC0CPt+y4O/5SVmeC+WV58LP8
	bMImCe0JNHQC+NtGDjxOZiUcB1EYFEaEAggodaJy4mVcErrweOC2MuA+Wv6TGtPLJDsBex42YCo
	NBVOH6CPE5gSW+KrWqU674RiniJaEP9quxswM0dE9oHUYCVLlhsfGgirD0ppv4FDfZAxSIJ2Yr5
	47x4Sj9y5BbslYc9WBAIiJcdKuMq56ANUi3I9AtbyPEcKa4jtUV2TLEpXIIbXBJe2jlWhseJ6/A
	RmarPQw5/s0jiPVWuCaTkqVdu3N6fXnGCer6jKgm7Zeb+tcEtU0y4S6fHe2quKloGAgBrdBvfOo
	9Yw8//HldF2XhOw1eInUo/Yaie7ZKgMa5J8tFxwu/4GekK9firfIdVRYpFzamTvvmullKHplGxB
	0dHLvPgRhoFCUvOjqeWXlmLZjUpuX9pSBIhGqt1muHP6hgqPmc/5Sw8YY0D04ak35q3uAHTaTWN
	z/z6eH1ILCoD9WGKKbZS7vyCQ29XCfEVq61nT2ALYsgHLFPMIr2Ln3GOW7787ypvAL2dpsOlRH1
	yHqnOtKKY6ZR7+x2e2DRWF836Hub3fX/RcndGOofNkb29LW33P0JXs+r19yOtcD0ooQwavrJ2Dt
	pWpd8ZQ==
X-Received: by 2002:a17:907:9805:b0:c46:723d:600 with SMTP id a640c23a62f3a-c4ca7aa4e06mr708475966b.41.1793610100432;
        Mon, 02 Nov 2026 01:01:40 -0800 (PST)
Received: from ptb-02009389.paris.inria.fr (wifi-pro-83-031.paris.inria.fr. [128.93.83.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm21082461f8f.31.2026.11.02.01.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:01:39 -0800 (PST)
Date: Mon, 2 Nov 2026 10:01:37 +0100
From: Ella Ma <alansnape3058@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: alansnape3058@gmail.com, cocci@inria.fr, linux-kernel@vger.kernel.org,
	nicolas.palix@imag.fr
Message-ID: <20261102090137.6brrzpq2zohop2il@ptb-02009389.paris.inria.fr>
References: <ec578f57-a7f5-7afc-ec2-9156c336187@inria.fr>
 <20261007164316.15102-1-alansnape3058@gmail.com>
 <f635d9fd-8dd5-47f-7996-239bc74bd828@inria.fr>
 <20261016135718.ab5322cdyozostuj@ptb-02009389.paris.inria.fr>
 <cd96489d-e980-c4a-9990-7a96e8b31ea@inria.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd96489d-e980-c4a-9990-7a96e8b31ea@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Ella Ma <alansnape3058@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3772
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/1wnrhGwfEV0hxoCCvRtMpQ>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 12:46:11AM +0100, Julia Lawall wrote:
> 
> 
> On Fri, 16 Oct 2026, Ella Ma wrote:
> 
> > On Wed, Oct 07, 2026 at 08:27:33PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 7 Oct 2026, Ella Ma wrote:
> > >
> > > > Using __cleanup(kfree) will pass the stack address of the annotated
> > > > local variable to kfree functions. This will lead to invalid
> > > > deallocation issues. Inspired by CVE-2026-45959 and similar bugs
> > > > recently detected.
> > > >
> > > > Signed-off-by: Ella Ma <alansnape3058@gmail.com>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Add virtual rules `report` and `org` as suggested by Sashiko
> > > > - Remove `kvfree_sensitive` from rule `cleanup` as suggested by Sashiko
> > > > - Add `free_percpu` to rule `free`
> > > > - Add `kfree_const` to rule `cleanup`
> > > >
> > > > Changes in v3:
> > > > - Edit the error messages to clarify the reasons and results
> 
> I applied this, but I changed the first error message to:
> 
> "ERROR: __cleanup({n}) will cause an invalid free: the stack address of
> the annotated variable will be passed to {n}; declare the variable using
> __free({n}) to cause the pointee to be freed"
> 
> The original message made it look like one should use __free when calling
> kfree.

OK. Thank you for the change.

> 
> Furthermore, there is one report in the kernel for this case.  It would be
> worth fixing it or checking whether it is dead code (it's immediately
> under an ifdef).

A patch fixing it has been reviewed by Thomas Huth <thuth@redhat.com> in
https://lore.kernel.org/lkml/ffebbb7b-a4f9-488e-8834-199da3073b96@redhat.com/
Should I reply something to the thread about this new coccinelle report?

ella

> 
> julia
> 
> 
> > > >
> > > >  scripts/coccinelle/free/cleanup-free.cocci | 112 +++++++++++++++++++++
> > > >  1 file changed, 112 insertions(+)
> > > >  create mode 100644 scripts/coccinelle/free/cleanup-free.cocci
> > > >
> > > > diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
> > > > new file mode 100644
> > > > index 000000000000..48e47ed2186a
> > > > --- /dev/null
> > > > +++ b/scripts/coccinelle/free/cleanup-free.cocci
> > > > @@ -0,0 +1,112 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +///
> > > > +/// Find __cleanup(kfree)
> > > > +/// Using __cleanup(kfree) will pass the stack address of the annotated
> > > > +/// local variable to kfree, causing an invalid free.
> > > > +/// I.e., `T v __cleanup(kfree);` --> `kfree(&v);`
> > > > +/// Such usage is impossible to be correct.
> > > > +///
> > > > +// Confidence: High
> > > > +// Copyright: (C) 2026 Ella Ma
> > > > +// Options: --no-includes --include-headers
> > > > +
> > > > +virtual report
> > > > +virtual org
> > > > +
> > > > +// Suggesting using __free for the functions with a DEFINE_FREE definition.
> > > > +// Update this list when new DEFINE_FREE definitions are added.
> > > > +@free@
> > > > +attribute name __cleanup;
> > > > +symbol kfree, kfree_sensitive, kvfree, kvfree_atomic, free_percpu;
> > > > +type T;
> > > > +identifier v, n;
> > > > +position p;
> > > > +@@
> > > > +
> > > > +(
> > > > +  T v __cleanup@p(
> > > > +(
> > > > +  n
> > > > +&
> > > > +(
> > > > +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> > > > +)
> > > > +)
> > > > +  );
> > > > +|
> > > > +  T v __cleanup@p(
> > > > +(
> > > > +  n
> > > > +&
> > > > +(
> > > > +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> > > > +)
> > > > +)
> > > > +  ) = ...;
> > > > +)
> > > > +
> > > > +@script:python depends on report@
> > > > +p << free.p;
> > > > +n << free.n;
> > > > +@@
> > > > +
> > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> > > > +coccilib.report.print_report(p[0], msg)
> > > > +
> > > > +@script:python depends on org@
> > > > +p << free.p;
> > > > +n << free.n;
> > > > +@@
> > > > +
> > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> > > > +coccilib.org.print_todo(p[0], msg)
> > > > +
> > > > +
> > > > +// Reporting __cleanup usage for the functions without a DEFINE_FREE definition.
> > > > +// The following list only contains frequently used functions. Supplement it if
> > > > +// necessary.
> > > > +@cleanup@
> > > > +attribute name __cleanup;
> > > > +symbol vfree, vfree_atomic, kfree_const;
> > > > +type T;
> > > > +identifier v, n;
> > > > +position p;
> > > > +@@
> > > > +
> > > > +(
> > > > +  T v __cleanup@p(
> > > > +(
> > > > +  n
> > > > +&
> > > > +(
> > > > +  vfree \| vfree_atomic \| kfree_const
> > > > +)
> > > > +)
> > > > +  );
> > > > +|
> > > > +  T v __cleanup@p(
> > > > +(
> > > > +  n
> > > > +&
> > > > +(
> > > > +  vfree \| vfree_atomic \| kfree_const
> > > > +)
> > > > +)
> > > > +  ) = ...;
> > > > +)
> > > > +
> > > > +@script:python depends on report@
> > > > +p << cleanup.p;
> > > > +n << cleanup.n;
> > > > +@@
> > > > +
> > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> > > > +coccilib.report.print_report(p[0], msg)
> > >
> > > Hello, this is more words, but is not what I was hoping for.  You explain
> > > the effect, but not the cause.  And to fix the bug with confidence the
> > > reader wants to know the cause.  Here I would have expected something like
> > > "__cleanup usage for a function without a DEFINE_FREE definition. This will cause an invalid free"
> >
> > Do you mean only the second rule needs a refinement, or both rules?
> >
> > ==> __cleanup vs __free, both rules:
> >
> > Using DEFINE_FREE declarer only defines a forwarding function that can
> > be annotated to a local variable via __free attribute. Defining such a
> > function with DEFINE_FREE will not automatically make __cleanup correct.
> > User still need to use __free instead.
> >
> > FYI: __cleanup will pass the stack address to the annotated function
> > directly; while __free will first call the forwarding function defined
> > with DEFINE_FREE, and then the forwarding function will correctly pass
> > the pointee address to the annotated function.
> >
> > ==> Only the second rule:
> >
> > Yes. For the functions without a forwarding function definition, one of
> > the root cause is lacking the definition. But I am not sure whether this
> > semantic patch should suggest adding one.  As these free functions are
> > all those frequently used, perhaps the DEFINE_FREE definition should be
> > added to the corresponding public header files.  Or, do you mean this
> > semantic rule only needs to report this missing, and the users will add
> > them where they think is good?
> >
> > Besides, after adding a definition, the current error message will
> > become misleading, as there are no rules to search for existing
> > DEFINE_FREE definitions in the code base. Do you think it is necessary
> > for this semantic patch to search for the corresponding DEFINE_FREE
> > definitions first and then generate the error message accordingly?
> >
> > I.e.,
> > with DEFINE_FREE:
> > requiring replacing __cleanup with __free.
> > without DEFINE_FREE:
> > reporting missing DEFINE_FREE and also requiring replacing __cleanup
> > with __free.
> >
> > ella
> >
> > >
> > > julia
> > >
> > >
> > > > +
> > > > +@script:python depends on org@
> > > > +p << cleanup.p;
> > > > +n << cleanup.n;
> > > > +@@
> > > > +
> > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> > > > +coccilib.org.print_todo(p[0], msg)
> > > > --
> > > > 2.34.1
> > > >
> > > >
> >
