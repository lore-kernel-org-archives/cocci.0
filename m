Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88035C28B24
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=R0yOXShCD331pfPEJ3FsGxKQVoIHXaBgZZkBDARsPvQ=;
  b=Ok++7rfIJBXEn48ixHfXTyV1FmgE7GeNOUJRvR80WBkHI1W/Enjp/EWz
   4YR3LhF2I1ir7H6jsA2MyFbnBNAsMcb0lLc66nFwPLMZu6TTpa0NWt7Ut
   Yk9fjLyu1n77N5t13bj2RW/ZEKF9Ij5OjReMzIIwI2Ssh0D6v9Y5C0uXj
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211491611"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 42BDDE0D47; Thu,  6 Mar 2025 10:08:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B13A9E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 15:30:33 +0100 (CET)
IronPort-SDR: 67c86009_Wuv3dCEF58gY0eACEZ9T8rw2Ynl8YB4d0KbTFIxjXC18wxz
 zzfyyjsFfQABEQa9QBx8Ag24vRTKqdn2jkLX33w==
X-IPAS-Result: =?us-ascii?q?A0HzAwCsXshnfC+AVdE9HYEJgVOCRH1aMwRThBo8jV2Bc?=
 =?us-ascii?q?oF0LQOeFIF+DwEDAQsBATkJAgQBAQMEhQACixYCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfQEBAQECAQwGEQ8BDQEBNwEPCQIYAgImAgIzAQUBEQsGE?=
 =?us-ascii?q?yKBYX8BgkEjAQIHCpJ0j0CBBUKKRHqBMoEBggwBAQbcIIFlAwYJAQqBBi6Fb?=
 =?us-ascii?q?IJjAYVbhQcnD4FVRIEVJ4MDPoJhBYU4gmmCM4Fpgz6VYIENgxmOXFJ7HANZL?=
 =?us-ascii?q?AFVExcLBwVhSEMDgQ8jgSMFNEE6ggtpSToCDQI1gh58gitqBAWBJII3hD2EQ?=
 =?us-ascii?q?oVSghGBYAMDFg8Bgx93HIRDO4RyHUACAQttPTcJCxuiMAE6g1BzgTkXgWcGS?=
 =?us-ascii?q?pJrg1ABjnugWDQHhB6BXQYMiimVNQYTL5dGDJMFhiKSXI4Flg+EdQIKBwYRI?=
 =?us-ascii?q?xKBMjqBXE0wgypPAxkPji0Wg1iFE8NIQDU8AgcBCgEBAwkBgVWDbSYTiiCBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 khpcjzDQuAJ54Y=
IronPort-Data: A9a23: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
 J88e4dBD616FJDeVWvFdu/FWZNJNM8=
IronPort-HdrOrdr: A9a23:R3CbDq9zuzIWQ7dfZU5uk+AjI+orL9Y04lQ7vn2ZhyYlFPBws/
 re4MjzsiWE9wr5OUtQ5OxoXZPrfZqyz+8R3WB8B8bHYOCighrXEGgA1/qZ/9SDIVyHygc178
 4JGNkdNDSzNykAsS+T2njaLz9K+qj/zEnHv5a4815dCS5tcL9p9Ap0B0K2FUdsVBBaCZdRLv
 ahz/sCiT7lV3p/VKqG77o+MNQrZeenqHsrW3877tcciDWzsQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AgO5BEWq9SzCQTvnT9X7huzDmUcAffUyHx0qKGmy?=
 =?us-ascii?q?9ND1QWIOzVVuL47wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A+FVrnA9zD98qWzSS7cH4ReuQf8ExyoChKHwzqo4?=
 =?us-ascii?q?pgJSlJwxTKiuWsx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="211352399"
X-MGA-submission: =?us-ascii?q?MDFZ5xps2E6BMXLEX8KmbljjVelQiLkon40T62?=
 =?us-ascii?q?+33Nmmt0vSoddU+eITQuTeJdVLQj9Qpeh2wCQn+hRxPC0p1PBcFejsmG?=
 =?us-ascii?q?ivWGa1/EWuDIcbT6eibTuX2c+XvtHBBhpekAPGTc6g8BDu5JGY+rn20t?=
 =?us-ascii?q?15i5MYBMzVV9RxO1q6tea1Xw=3D=3D?=
Received: from mail-wm1-f47.google.com ([209.85.128.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:30:33 +0100
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc30adad5so22494795e9.1
        for <cocci@inria.fr>; Wed, 05 Mar 2025 06:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741185033; x=1741789833; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R0yOXShCD331pfPEJ3FsGxKQVoIHXaBgZZkBDARsPvQ=;
        b=Zwf0Z0AYp7steQilgi2mdh3vD1itRZYMDZZPJlSXJHVCJ4+Z9eIO+KRxSSoFvrijL1
         1KjUCd+vgvvQvxDxExZwAmZT0P04ziO8KTSJxVKArspDYU6+WnrjCuYTjDQcppeYQsaz
         W47qjn2/yrz4+3ZPD5TWSl0ncxLfSqlo4wculr8493f0HFICrJluxrvkeicI9OJwBGJd
         aC94F1KWmYmQAeLbXzA7L7drL+EL+GGIyZNJiJbZ+1k2M58C6L1LZqRRfq5wY7EXgFSi
         i7pHRd1xxgK6C0o0UFxi4AOQbmU7ez4AuWev2BP42VrpZpt/P31iHOFy1kDpdpWEj8mY
         AiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185033; x=1741789833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0yOXShCD331pfPEJ3FsGxKQVoIHXaBgZZkBDARsPvQ=;
        b=uA0cd+tRtTeqPWtlL3/seHzyqZnulSRK0FYMsvchvvyv9zOc9KOcr/kaHcVYMMJsNh
         0kqbSaiGwo6Lk0892Mt1ZYir2qveb7dE1xjgLDEdo3sOMh1JkjWaVE35WNGbtlj9tBDs
         fsWoW/Noxp3DrCajzLBmVqWDuzAPoRXPNP2HkpmMI8KB0jLaBzHWM2QvkIRBIIvDB5g5
         9WXbjLdE5Flh2UlIqdCAdvWTRnO6+NWpX5Rxmuy53HTznCttrcE9Z3RTOl4sggFYVz6O
         sRHmqdoeMRkWD5qZFPXwn3YOYPVAmWa10RCXxBXXbFXTm0PwbGzpl9fkN5w+twM1G/wJ
         sb5g==
X-Forwarded-Encrypted: i=1; AJvYcCVt1ZZDv5LlLwJWg9M/AR8bfS6fKf16TXO6bdwDPxCVLTXox2O0rkqmTqGiLOTRHhe7traxOA==@inria.fr
X-Gm-Message-State: AOJu0YzyCWFeO0CgNZEr66/LFwIvYeb/LS2rmB9cUNuYdX/RbmIdqkN2
	TDX+HbMQuSnshYE2+c7sQiTY+MUhg17U6O5YS9NUkTjKeYD91i7ob73sPvuTzq8=
X-Gm-Gg: ASbGncvmEDVaDuC+dw8rD3qJyciYaQXXzghu5YschYPzzAQgD2tLBr7872sicn2V9OI
	IRekHc92jfDSmmqp/x8vGFrIrL4u/sBGrktrAifmH2daEdstcF1CJbvEpBXtcYh2DmaZQAPd+fV
	b8UG1tUuWWtOAsB4iYuuY/kme5G3hm/kGxX4vdjb5T3AM4D2AWUJbAHMak5DaZEIthh8VBhrWPr
	Wgpf49ikFervoKj42uMFhOSbyPIy0bGCu0TOteNQSmM78uZZjNzJMbzht79U1nAARUcuXz7Ib0j
	tQp0vw7stx9eMsGeOoCyJTFxQjHG64eJB0yRmaYclz0KWOnMEw==
X-Google-Smtp-Source: AGHT+IHFtdp8P9AwIBs/SYYRDTy7hEWSk3RAiMKjuzC82tpdeKPpX7kjP/l1pi94ZuG5P/EuaCVziw==
X-Received: by 2002:a05:6000:1844:b0:390:f698:ecd0 with SMTP id ffacd0b85a97d-3911f726495mr2931784f8f.11.1741185032737;
        Wed, 05 Mar 2025 06:30:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485d785sm21057865f8f.83.2025.03.05.06.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:30:32 -0800 (PST)
Date: Wed, 5 Mar 2025 17:30:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Archit Taneja <architt@codeaurora.org>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
	cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <ed9e65a7-6cdf-4d93-83a8-464b47a4bc1d@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
 <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
 <e665514b-5a62-4afb-b267-7c320e4872af@web.de>
 <4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
 <20250305141732.26b91742@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305141732.26b91742@pumpkin>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RFC] Clarification for =?UTF-8?Q?=E2=80=9Cundefined_?=
 =?UTF-8?Q?behaviour=E2=80=9D=3F?=
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2557
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/ed9e65a7-6cdf-4d93-83a8-464b47a4bc1d%40stanley.mountain>

On Wed, Mar 05, 2025 at 02:17:32PM +0000, David Laight wrote:
> On Wed, 5 Mar 2025 11:51:59 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > On Wed, Mar 05, 2025 at 09:40:43AM +0100, Markus Elfring wrote:
> > > >>> The address of a data structure member was determined before
> > > >>> a corresponding null pointer check in the implementation of
> > > >>> the functions “dpu_hw_pp_enable_te” and “dpu_hw_pp_get_vsync_info”.
> > > >>>
> > > >>> Thus avoid the risk for undefined behaviour by removing extra
> > > >>> initialisations for the variable “c” (also because it was already
> > > >>> reassigned with the same value behind this pointer check).  
> > > > There is no undefined behavior here.  
> > > 
> > > Is there a need to improve the wording precision?
> > > 
> > > There are words which denote a special meaning according to aspects of
> > > the programming language “C”.
> > > https://en.cppreference.com/w/c/language/behavior
> > > 
> > > Dereferences of null pointers are treated in special ways.  
> > 
> > This not a dereference.  It's just pointer math.
> 
> And the 'fun' starts because NULL isn't required to use the all-zero
> bit pattern.
> Regardless of the bit-pattern, things like (void *)(1 - 1) are valid
> NULL pointers.
> 
> Of course, while C allows this, I doubt NULL has ever been other than 0.
> (It was 0 on a system I used many years ago where the O/S invalid pointer
> was ~0.)

Kernel style guidelines don't even allow if (p == NULL) so we would be
screwed.  :P

> 
> I know Clang has started warning about arithmetic on NULL.

Huh.  You're right.

$ clang -Weverything test.c
test.c:13:22: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   13 |         printf("%p\n", NULL + 1);
      |                        ~~~~ ^
test.c:13:22: warning: arithmetic on a pointer to void is a GNU extension [-Wgnu-pointer-arith]
   13 |         printf("%p\n", NULL + 1);
      |                        ~~~~ ^
test.c:11:14: warning: unused parameter 'argc' [-Wunused-parameter]
   11 | int main(int argc, char *argv[])
      |              ^
test.c:11:26: warning: unused parameter 'argv' [-Wunused-parameter]
   11 | int main(int argc, char *argv[])
      |                          ^
test.c:13:17: warning: unsafe pointer arithmetic [-Wunsafe-buffer-usage]
   13 |         printf("%p\n", NULL + 1);
      |                        ^~~~
/usr/lib/llvm-19/lib/clang/19/include/__stddef_null.h:26:14: note: expanded from macro 'NULL'
   26 | #define NULL ((void*)0)
      |              ^~~~~~~~~~
5 warnings generated.

Well, that's stupid.

regards,
dan carpenter

