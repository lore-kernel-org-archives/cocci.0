Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E178EC28B23
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GkfOGAJyjI2lzXCaMBa1FddJd+TtvvII6nxqC6Kgsa0=;
  b=ioXjIPreD0qimYq4Nlm2zOYYrwmvtgM414bC1VTLEQ0s+5IDqAlYvmYv
   wo1YR8qO4f1znq+aFYRbR2m/wCHw/LS4BCqd7TPhNSBy/ABsp40Gk2FcA
   A+75oEif78+MXlflxFx2YLUStdiLsQhZYx6d9qqPD50eJwqirTNe+7eGn
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211491637"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BA638E0D7D; Thu,  6 Mar 2025 10:08:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 194CAE0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 22:35:05 +0100 (CET)
IronPort-SDR: 67c8c389_vF638ciZ36nFV76PuxTse/FweVXfgUwLnL060NPRYGtK1vu
 dPCRpVm5H8OfRdNVY8pSpDPnydcxPClOa0ABN0g==
X-IPAS-Result: =?us-ascii?q?A0FBBACWwshnfDKAVdFagQmBUwKCQoFXMwRTjVKGUzOBc?=
 =?us-ascii?q?YETimOCIYQ1fYwLPg8BAwELAQFCAgQBAQMEOIRIAosYAh4HAQQzBg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDhIphXsNSQEMAYILA?=
 =?us-ascii?q?YEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFA?=
 =?us-ascii?q?ixfAQEBAgESKAYBGx0BAwELBgVGIhEBBQERCwYTIoUQAQMOIwMEomyBBUKLP?=
 =?us-ascii?q?IEXBQIWgQGCDQbaXQoZKA1sA4FiAgcJAQoXgR2EdSlODoI4HQGFW4QNeieBA?=
 =?us-ascii?q?4ElgRWCcjg+iwcEgi+BaYM+lWCTEwgHMQgBCRMGCgJLCwoSAwQDBAQBAgsTC?=
 =?us-ascii?q?QMDAg4CCAMCCAYZAT8MBgQTCgMKCwcFHwoICAQRCigDIgQOKwoDNQwLDx8VA?=
 =?us-ascii?q?QgGAgIEBAIEAgoCCQICCAcCFAMCBAQCAQUSAwsBBQYFAQEECQ4CAgMDAgIBC?=
 =?us-ascii?q?AICAQECEwEEAwEHAgUDBQMKAQEBAgEEFAYDBQMDBwMEAgMCBgIEBQUCAgMDA?=
 =?us-ascii?q?gMBAwMCAQIDCRAPFgICAwQCBgIBBCYCARUFAgMEAgIHAgIDAQIBAgICBAIEA?=
 =?us-ascii?q?gIGAwkIAQICBwECAgIDFQIFAQQJAwMFEgwgAwICAgIDBwoDBQIBAQIEAwMDA?=
 =?us-ascii?q?wwNBwIDAQIBAwUDAQIBAgkDBgICAwMEEhkFAwIPAwIBBQQCCBALBwEBDxQFB?=
 =?us-ascii?q?AkFFQMGAgMDFgsEBQMDAwEIBA8OAgILAxcFAQEHAQMNBwEDBAQCAwMJAgEQA?=
 =?us-ascii?q?QMEAgkCBAECCgICAgICBAEBBQQCBAMCBQICAQgEAwMDDQQDCAgDBQMMEgICA?=
 =?us-ascii?q?gkCAwECAwMDBA0IHQUJEQsCCQMEDQIEAgIBBgMGCgYUAQISAgIGDAQDAwgDA?=
 =?us-ascii?q?gMCAQECAgIBEQIJCA0FCQUGAgIVAwIDCAEJAxECFAEGAggDBwEBBAICChEKA?=
 =?us-ascii?q?QECAgEGJQIBAQITEwcDCAICAgIGFgwBBQcDBw8FBQQCAhYDAxEEBBACAgMDA?=
 =?us-ascii?q?gEBFAYVAQUCAwYLAQYBAgUEAgMEAhICERMDAwQGAwECCg0CAgIJCgEFBAMHB?=
 =?us-ascii?q?QIfAwMCAgULAggCAgUCBQcDCQ4BAgUDBAkCFAIQAgICCBYCAgIFHAMmAgQDA?=
 =?us-ascii?q?wMDCwECAg4JAwQ3BhEEAgMDAg4BAgILAQICBAIDAQQHCQMDCQoHAQoNBwIKB?=
 =?us-ascii?q?gIJEAECAhADAgICAgYHDgMCEw8FBgYCCgcNCwIBAgITAgMJBgMFCgMHBAoNA?=
 =?us-ascii?q?hUCFQUDHwECCAkLAgcRAgUSAw4FAwICEQQCAwMFAwEHARcDBwgCAgwCAgICB?=
 =?us-ascii?q?QIFAgUXEQ0EAwMDAggBBBUGAwkIKhsSAQEFAQkCAwIDBAgDAwMCBgwLAgEHC?=
 =?us-ascii?q?AMDBgsICQYDAgcIGQMFBAMHBQshAgYDAgQFBAEFAhMNAgMZAgYDBhEJDAIGC?=
 =?us-ascii?q?AcJAwcBAQECAgIIAQYFEgIDBAIFBAQBAQgDAwQGAgEDAgICAQQJAQEBAgoCC?=
 =?us-ascii?q?AoBCRMEAwgDAwMDAwUBAgIIBBEFBQIBBQoTDAoGAwYDBAICAgsHAgMDAwIHA?=
 =?us-ascii?q?QsjAgEDAgIFAgIBBQMCAgYEAwIBAQkCAwIIAQICAQICAgQBBwEEBwYBAQIEA?=
 =?us-ascii?q?gI0AgEDCQIFAQEOAgIEAgIBAgICBAIEAQIGCwQFDQEBAgECAgEBAQQBCAMBA?=
 =?us-ascii?q?QECAgMDBQMFAwgPDQEBFwsdAwQFAgIBAQEBAhMCAgELAQIBAQMaAgEDAwQBC?=
 =?us-ascii?q?wIBAQQfBBYCAgICAgQDAgIDAgILEyUBAgMFAxMCAgQCAQICBQUFAQMEERUDC?=
 =?us-ascii?q?QEDAgUEAgIGAgQGCgIHBAIaBAICAgEDBAYDAQIIAgIHBAIDBgMCAgECAgcYA?=
 =?us-ascii?q?gIZAQMBAQICAgQCAgIJCgQFBAQEAwICAgEMAQEDAQIDAgICAgEDAgIBAQIDA?=
 =?us-ascii?q?QIFBg0CEgIBAxEIBAICBwICIw8LAQECAQECBgYCAwMDCgMBCgECAQECBgIBA?=
 =?us-ascii?q?hUFAgIBAgQBAgMDBCUEAQIBAgEBAQ0dAgkDIw8DCwkIBwwBPAwHCigENgEUF?=
 =?us-ascii?q?AcGJRlnBwegfzqDUYJDgW1KljsBjhahcQeEHoFjgjedLk0TlzOTEZh+qQkCC?=
 =?us-ascii?q?gcGBA0jEoFIJIFcMxojgzdPAxkPji0Wg1jIGEM1PAIHAQoBAQMJAYFVg20IA?=
 =?us-ascii?q?R0TCwGEB4YNgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:n6yf6q0lJRag+/h+/DAV0gqjBEkkLtp133Aq2lEZdPWaSL3/qy
 nIpoVk6faUskdvZJhEo7q90ca7MBbhHPJOkO0s1PKZLXLbUQiTXf1fBOnZskXd8kTFn4Y3pM
 VdmupFeafN5DBB/KXHCWKDYq8dKbe8gceVrNab4HF3UwlwZq1sqyt/AB2KC1B7SWB9aaYRJd
 6z4o5oqVObF0j/rf7VOpDGZYX+ThHw9a4OGSR2eiLPITPvsQ+V
X-Talos-CUID: =?us-ascii?q?9a23=3A3tA6QWtopeCW77xhuD2Qvwzt6Is7bmLPzFbVGHW?=
 =?us-ascii?q?EJmZ5aKGNYwfA3KN7xp8=3D?=
X-Talos-MUID: 9a23:A3CkDgZOLNqogOBT6A3juD9ABfVU5am8K2YGo4UU4NuqDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,224,1736809200"; 
   d="scan'208";a="211424007"
X-MGA-submission: =?us-ascii?q?MDG7YjPKRv5Nn4ihKIBjLeg5yrpFlGBNE6462I?=
 =?us-ascii?q?6X3P9X+92OAYIWLnweKGLSJkZyuXLpx8OSbCKUVMRRRuKyG3gBZdETjq?=
 =?us-ascii?q?HMHLM2rhnUepamzTAAYWiIgNpDbUCFMyM1/VirWuKOKRwPNocv/vNduu?=
 =?us-ascii?q?Hiy4mTaiZufIWK/cpJwXQiQw=3D=3D?=
Received: from mail-wm1-f50.google.com ([209.85.128.50])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:35:04 +0100
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso35076195e9.3
        for <cocci@inria.fr>; Wed, 05 Mar 2025 13:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741210504; x=1741815304; darn=inria.fr;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkfOGAJyjI2lzXCaMBa1FddJd+TtvvII6nxqC6Kgsa0=;
        b=TKgKrBs7yCBemtDkQf+sZofmQId2GzOQ0ou3/Kf4mWVm3r3BDQh7VlykvYq5xFdKIB
         coV6MKkNbajL5Pkp4lpbFrlZNlbxNgyvuZiXixM5pqIHKBnngIBKhvFu36/LTS4LuswC
         Eyc7JP6K8+0r5a6v2MJX/0B6vkaKBhT5zetTOqxJey0X0aLRMFsDwcwMCqd6pz9MJcHE
         m72VBmGT/EsXudgm3ZGfQXfBofZZ8CUqklIb1Z/5TECLHNfj+XfACdZpHL2WAb7RoG9j
         uT/BvYfv5V+hEqYDo3RgWMUzXdsxOvMYuVvxLVBzsefeZethoeSkzLnVW++nA6VlN87+
         SR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741210504; x=1741815304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkfOGAJyjI2lzXCaMBa1FddJd+TtvvII6nxqC6Kgsa0=;
        b=RuX9grONsKwGCTFFS+ooU1fCD1gMyW3K1Gs8SLh5RlymH+rIpRQYxrr/XfcoxjzMmz
         JfITS5mJHc/V/pMm3agpu1XlF84451zmI165RnlUT1UrziJ5a/ywdyRK2dQrcMFcq/RK
         SbDCCN/ecdyYbLOK8WL/qHvVlZWX+TJVCCU5KHoLuTKU3i3snfM8I+crgQ8SLY3A01IY
         L8Ys7abGeDXGpQ8Ov5GuUJdkXAVeNZzk9k8KWDbnt8RrlazZOfYpgc1tteGTCd9AnqQu
         GjT3wEuwawYBLpVQxfP4I92d6us0ivSHOEcBWcjaoSccraw8rFBVPG+cxUp2M6kyQqmc
         fzPg==
X-Forwarded-Encrypted: i=1; AJvYcCVewz1zUFv+4VIuEhdazmmVyl3z/kymhsod6miIf5iG2nG8rLvVDREZlv4qppdylED2pwI8cQ==@inria.fr
X-Gm-Message-State: AOJu0Ywlz/p+CF3PzxQZkUdplvAg5lB1v/pjvSv0EvCPOfffg/Q3NLKD
	cUKQ5teTrIUE3NM/fbY6n2t+kP7iPdhGR85SxJVElIchB0RxYgp8
X-Gm-Gg: ASbGncsuMvPtd5kDY/On0D1jiNq4JyS/NAOMp4GhEKZNoP8HSzwHZCstPoikzWWrffZ
	hSV1aHAqU+0931JSO6njOHjn7HZmLziuavJOJrcbZ9TTtPKCnnySw/5uaPoub3L5d926b0oPBb1
	Hic8yhY8oELqcLNWi08gNIM39Rrrs1BVXfEjNsvV6WVDy69XR0O6pdvXBI21gnPz9SspPqxDEbJ
	v+vkzo0+Y6B+2wx2rwavOegHbXgVHyDUCgEgyAwsINKSfF7npIFHvJM/AzU1Bxb/51nexf3FIgg
	MbUspmIwDy0uzz3H89/zVhVc8RWNTJIkzSqVa+R2gWRCrinTLljsbmlQ0v8hDGuu5L89cDOMcQt
	2Rr4IPA4=
X-Google-Smtp-Source: AGHT+IE8jxO6kdtaaWpEp4oWi8exS7NgMp++p3+pS078xL7aEkKJBfV7Vnbc8oFxX1styMXDjNOaDg==
X-Received: by 2002:a05:600c:190d:b0:43b:cf9c:6ffc with SMTP id 5b1f17b1804b1-43bd298a59emr40252875e9.12.1741210503722;
        Wed, 05 Mar 2025 13:35:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42e6bcfsm28935975e9.32.2025.03.05.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:35:02 -0800 (PST)
Date: Wed, 5 Mar 2025 21:35:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, kernel-janitors@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jeykumar Sankaran
 <jsanka@codeaurora.org>, Jordan Crouse <jordan@cosmicpenguin.net>, Marijn
 Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>, Vinod Koul
 <vkoul@kernel.org>, cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20250305213501.496ea4bf@pumpkin>
In-Reply-To: <ed9e65a7-6cdf-4d93-83a8-464b47a4bc1d@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	<1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	<13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
	<54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
	<k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
	<29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
	<e665514b-5a62-4afb-b267-7c320e4872af@web.de>
	<4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
	<20250305141732.26b91742@pumpkin>
	<ed9e65a7-6cdf-4d93-83a8-464b47a4bc1d@stanley.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RFC] Clarification for =?UTF-8?Q?=E2=80=9Cundefined_?=
 =?UTF-8?Q?behaviour=E2=80=9D=3F?=
Reply-To: David Laight <david.laight.linux@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2558
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250305213501.496ea4bf%40pumpkin>

On Wed, 5 Mar 2025 17:30:28 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, Mar 05, 2025 at 02:17:32PM +0000, David Laight wrote:
...
> > And the 'fun' starts because NULL isn't required to use the all-zero
> > bit pattern.
> > Regardless of the bit-pattern, things like (void *)(1 - 1) are valid
> > NULL pointers.
> > 
> > Of course, while C allows this, I doubt NULL has ever been other than 0.
> > (It was 0 on a system I used many years ago where the O/S invalid pointer
> > was ~0.)  
> 
> Kernel style guidelines don't even allow if (p == NULL) so we would be
> screwed.  :P

Doesn't matter:
	if (!p) ...
	if (p == 0) ...
	if (p == (void *)0) ...
	if (p == NULL) ...
	if (p == (void *)(constant integer expression with value 0)) ...
and the equivalent assignments all behave the same regardless of the
bit-pattern use for NULL.
So:
	union { long l; void *p; } lpu;
	lpu.p = 0;
	return lpu.l;
Returns ABI (implementation) defined constant value.
I think the only requirement is that it can never be the address
of a valid variable.

	David
