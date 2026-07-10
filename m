Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E678C44501
	for <cocci@archiver.kernel.org>; Fri, 10 Jul 2026 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=41CjFcZHgGUStyQWZv3NgknJ9ek5Z1pn9KSqBtWSRvQ=;
  b=UCtQhjx6Pz679YOBevtBjPS6NuUQZ4//3NFsK4DgDs6GIzr7Ob/tpC2n
   7aMkyRb0yT4EnqZBReiAa/0zn/L6qpsZrg9HBOkOWcPmXabzTh4DrbfIV
   NhQhfqVfgjtvV5gTB5+7MYpJV/Qkxx0gnYjgikL/YkCDE5nFCXCXEzXEM
   4=;
X-CSE-ConnectionGUID: FeiiBjo4TzilYvF+aGJy8g==
X-CSE-MsgGUID: 3NCu/sFnRiiHYV8sdffH0A==
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
X-IronPort-AV: E=Sophos;i="6.25,154,1779141600"; 
   d="scan'208";a="285893491"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jul 2026 17:15:15 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A53DB827DF; Fri, 10 Jul 2026 17:15:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3FCF3813E7
	for <cocci@sympa.inria.fr>; Fri, 10 Jul 2026 13:28:29 +0200 (CEST)
X-CSE-ConnectionGUID: TWZbVkLzT2+76pL25Tmtug==
X-CSE-MsgGUID: OhlosgedSXO8kBYnD5uISA==
IronPort-SDR: 6a50d75c_XJ+xIp6eXytvJRdN2YQI/kHZ/YqXDS6uLr86Dc1g/pa/rOY
 PzKfhxiZR8PB1vFAZl2mAmifj1ZajkMZKZC0YyA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GkHQB51lBqfCvQVdFaHQEBPAEFBQECAQkBgVsIAQMBg?=
 =?us-ascii?q?VUCAWZaMF8zBFQEhFSIeoZYojsCDwEDAQwBFAIRIwcEAQEBAgSSTgIeBwEEN?=
 =?us-ascii?q?QUNAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHD?=
 =?us-ascii?q?hIphk8NgluBLIEmAQEBAQEBAQEBAQEBHQINgRYRHQEBOCUPAiYCIxIBBQE1I?=
 =?us-ascii?q?oJgAYIiAQZKAxGuboECQos9gTKBAYIMAQEG3DGBaQMGCQELAYEJLAIBAQGCV?=
 =?us-ascii?q?oYCAYFwiSkbgg2BSohEgw6CaoImgQyDX4IIi10mCR0DBwcOK0YPBRwDWSwBV?=
 =?us-ascii?q?RMXCwcFXoEIAQIBgQVuMh2BIz4XNFgbBwWBHUSBFYEChHkjHwM5f4EwdUp5L?=
 =?us-ascii?q?XMSHgqBUoIWVAMLYgs9NxQbSo4rFw+CP4EhGMkxhCeEc4culVQzg3EBk2GTG?=
 =?us-ascii?q?S6HfY9ie4wQgXqbDgIKBwcRJIFcIi6BLjMaCCgIbAaBfAEBMlADGQ+XNskpQ?=
 =?us-ascii?q?jUCOwIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
 aNMPzfeQLdQkr4mcnpk2la0hA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rHHbdagus5ZGqeGagDelV0LvP3BQXmgji2hC6mlwRA09TyX4rb
 HLoB1/73SftN9/YgBDpTj9U5PwP080maQFh7X5RI3SITUO4VHYU72Kk7GSswEIaheOk9J188
 5bAtJD4bTLZDAXsS/U2njaLz9K+qjhzEnHv5am859dJjsaF52J8mxCajqzIwlTTAlCC4Y/UK
 CR7MxBqjK6aTA7bMS+b0N1J9Qq77Xw9a7OUFojDx4j5hWIyQml77P7FBbd/g5bajVIxN4Zn1
 Ttokjc7qWnve29jiXR0GLS6JoTuMKk891EAYiqgswYQw+Ctu7jDL4NZ1US1wpF291GCD4R4a
 jxnys=
X-Talos-CUID: =?us-ascii?q?9a23=3AJl+qf2tyk20/C6FK38zhYXPy6IsZTU/X8nT0MXP?=
 =?us-ascii?q?iSjk3UJnPFGOV5L5rxp8=3D?=
X-Talos-MUID: 9a23:goHtJgU8Vl7UPYHq/BjsgDZ5O8pk2JSJWEMnoJMq5tSlDgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,154,1779141600"; 
   d="scan'208";a="285843586"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEyExp9tc8ZWP8n7wnU5fNEP50utJNWZOmQCS?=
 =?us-ascii?q?SfabWl2ZyjciGkxjfQhcc99VL976Ivxyc5Uny9koHTlIa+kQDepgIlyP?=
 =?us-ascii?q?F8uFB7Xi4vwJe2vuCD662E1b7yZNanY7NouGG/HSRzgVxDQzXwUuNVLP?=
 =?us-ascii?q?iHGepdAJp9h3z7aNTPl5zg7w=3D=3D?=
Received: from mail-ed1-f43.google.com ([209.85.208.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 13:28:28 +0200
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698b558a792so1040918a12.1
        for <cocci@inria.fr>; Fri, 10 Jul 2026 04:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682908; x=1784287708;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41CjFcZHgGUStyQWZv3NgknJ9ek5Z1pn9KSqBtWSRvQ=;
        b=Cdq4K0qlIU/ngAMTC9xDhY4LzoDRgi/e2LEiTmwGHMV4j4uu8mVvn7h5zjwaeYNUbc
         1jVGj9Xq7l3PbcrTluhQ2h5UyEn+fo6Q3V5fugbmTMf+jm1tCpF8NYXDzWE1Vnk++u9g
         Ysz2Jdn+kcmHwiJHzpFzM5WZijXWXKXmx070nEl2JU8nL5E9ClmOjhW7bOKWuYo7dbCG
         5uRvJdqE6MAnKeJlsnmXWcSN+Ly4l4S9v+xqMgIT533QrKHe40axRRERjPqUyBu5SWmY
         0ZMtbXs1QjnoA5La2qG/aY0OaS+/JFQCiVS6aGC/3XtzclGbfqi9n8acXVNt/nzKUm19
         t+cA==
X-Gm-Message-State: AOJu0Ywkw1WXmKpUm0dMMyWsjH2/3yoCZK08OUAIvyU3rI1KiGEzWYXc
	ZXMpp+2IxfSvttG5g2fAYaBZEsML/3Dqfub0y/eIsjMFPgkINErGVuxcZWpm2TY6OcAQZeH7Iaj
	jdGw=
X-Gm-Gg: AfdE7claeLj/71l0HxoA36PgH0F6FlgTwDk5E13FfyhJZ1itwV6TR3ZnoYxKoghF+0t
	qXPYAGNjjzrO/jhFSc4v+nG5t8QqBCb7h88YHh8Q3spEa9+Qk7j8fA6Ph3A6HtXCe1w7p9lLxk4
	THGGLp0/65q88rHGQhJmG609CslcVaM1WiiBchB3iziQesbNfLKN+iuFZuqgN7ul3kQN9u35B+t
	hJ9eT9VRusFwRgW+KW8lqYfn6aQDv24LGSn8sxmB8xrbReG7G9W+wmhI7Rsr3SWp3DHAPbskdmI
	2YqTnMjRFkrSWxmI0fxde9D6WcoiaCEa2GXImJEExjK8UQfIBD7C1kNOASPiCc+6Wuheq0PigJ/
	vwx2dW9x7iRloXjBmsHuz7F8Cmf2//4Ta/VEVFlK9WOFWgper+slK1jTwY3IZhv9/3JkKk6C3PH
	aotTEfXqEGpJKNE2jngcTeJW2rdenhqXt3f/nUsyqe2r0DZzztmg==
X-Received: by 2002:a05:6402:2b9b:b0:69a:57fb:4783 with SMTP id 4fb4d7f45d1cf-69ab445ed4cmr4313464a12.13.1783682908331;
        Fri, 10 Jul 2026 04:28:28 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69bfd7a20e5sm2553425a12.20.2026.07.10.04.28.27
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:28:27 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e2937e9dso115192566b.0
        for <cocci@inria.fr>; Fri, 10 Jul 2026 04:28:27 -0700 (PDT)
X-Received: by 2002:a17:907:5c9:b0:c15:b5fa:958 with SMTP id
 a640c23a62f3a-c15ce144de9mr563595166b.34.1783682906200; Fri, 10 Jul 2026
 04:28:26 -0700 (PDT)
MIME-Version: 1.0
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 10 Jul 2026 13:28:13 +0200
X-Gmail-Original-Message-ID: <CANiDSCui8KgH9NZYH=Ovsc-a5iNJZSYPK0Vd-+r2m8ycVpprBQ@mail.gmail.com>
X-Gm-Features: AVVi8CcfSpmjlInW40p8tmzAj_6MBgEYliFQkHFKW0du7oS_H2hsDTUXd5UCbbM
Message-ID: <CANiDSCui8KgH9NZYH=Ovsc-a5iNJZSYPK0Vd-+r2m8ycVpprBQ@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] A false positive for `free/devm_free.cocci`
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3596
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/vRZxYZBuZhzMxpeLVsQfjg>

Hi

This cycle, media-ci has triggered a false positive for devm_free.

The header already mentions that the check is prone to false
positives... but I hope that having a false positive could help you to
improve the check in the future.

https://patchwork.linuxtv.org/project/linux-media/patch/20260629-cocci-7-2-v1-6-5884c80ee3b6@chromium.org/

Thanks

-- 
Ricardo Ribalda
