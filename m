Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B135C02196
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z0J5Z2SBoY0f55z7emiVbfYnb6Y91DGR2ecZHMgdiZ4=;
  b=LES8HQlelkEWQHLTP8CxZXojsvIHeH7x37oZ9bgp4AsYF9IyTSf2OrT8
   dlhfpdMZmTDzl4q4lTwgTWZ2k0kx1Mxhx//DWHcRYYxdLnKpRR5btgsUr
   zeX/SNqLu6YCNHktO682/y1vEIPn3+GciKuu9drkFHR0awFOeSLEIo8qh
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324858"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A103FE0137; Tue, 28 Jan 2025 10:13:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 18094E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 13:58:23 +0100 (CET)
IronPort-SDR: 67938e6e_FruSESt8yONAQhH8lRdT+UVWR6FhgH0O1RXbjQRGNm17jVb
 JsnE03hsbHsI4VViLEPGMe/f2gPy7/eSmIoEklg==
X-IPAS-Result: =?us-ascii?q?A0EwAAARjZNng3yFCqpaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYIaKGIbgQ0EU4RWg0+Lf4IkhDuYB4FWgX4PAQMBCwEBOQsEAQEDA?=
 =?us-ascii?q?QOFAAKKdQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBOQcOO4V7DYJiATNxgSUBAQEBAQEBAQEBAQEBAQEBAQEBFwINfgEBA?=
 =?us-ascii?q?QMSER0BAREmAQ8LGAICJgICMwEFARwGARQBARAOggdYAYJkAwQNqyEBboEFQ?=
 =?us-ascii?q?opDAQEBeIEygQGCDAEBBoEI2xeBShoDBgkBCoEGLgGFaoJjAYVrO4NCeicPg?=
 =?us-ascii?q?VVEgTwLgXaBAj6BUoEPAYF2g0aCaYIzgXSDQIEiiW+LI4oFUnscA1ksAVUTF?=
 =?us-ascii?q?wsHBYEpEDgDKzYxI4EmBTUKNzqCDWlJNwINAjWCHiRYgitrBAWBK4I7hEWEU?=
 =?us-ascii?q?4JDgxiCFHprAwMWEAGCNXJ7H4EoHUACAQttPTcGAwsbBj2dGT2EOnUIgQUMS?=
 =?us-ascii?q?QqUO4JnjhOhOjQHhB6BYwyKKZUzBg8EL5dEFJJ7mHwijWKVW4UkAgoHBhEjg?=
 =?us-ascii?q?UsMJ4FccIM3TwMZD44hGR+DQoEExGJCNDwCBwsBAQMJkCOBSwEB?=
IronPort-PHdr: A9a23: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
 5j5d88natmmUh5SvXSlhj41Rtu3N9GofPHgvA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3aq57KPq4c3l38BcTmCjsMiBIKoaSvp037Dk7TEPdfUnSL3tqy
 nIpoVs6faUskdnZJhEo7u90ca7MAvhHPJOkPgs1PKZLXnbUQiTXfpfBOnZskTd8kTFn4Y2ut
 YHT0E9MqyPMbETt7ec3ODSKadc/DDoytHVuQ6T9QYWcShaL45n9BlwEQuWHwlbQwNcFYMlGJ
 f03Kt6jgvlV3BSQMrTPAhnYwEBnb32fVDdDyLuyyRXjTVnIFiThYLSIly93hMTWTtU3PMH3k
 KAuyLWooWP2svW9jbsk0vS65hdkMH9jv9tLoi0se4+bhXA4zzYFriI3Na5zUUISDXF0idYrD
 AEmWZDTqBO108=
X-Talos-CUID: =?us-ascii?q?9a23=3ARxs2RGrueArfC8JSYC4p2SjmUe8XSmPl1VfsHxS?=
 =?us-ascii?q?9SkBwaeCfSG+66bwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Am7NXXgx64+a5upF2PHMpqbIwUbSaqIK0D002tNI?=
 =?us-ascii?q?Kgs2BcikqOzOeiXeRb7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="204852850"
X-MGA-submission: =?us-ascii?q?MDES/hcO5L57TabXPLIkXjwoj3GMKqT2Ipt4pO?=
 =?us-ascii?q?PqLrHkd2QnQJOZvpIj7Qnodu5zRo4O4V9ApWPGWugju+4daVG+/Yq+t3?=
 =?us-ascii?q?udrcS8BtAcQQkh3yIvFGAB5/H1iYSh1OxtKVjdQEziKhX055yEhLOvRG?=
 =?us-ascii?q?u9XG2ZRmYN9BuQmVuO+S/mZg=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:58:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737723500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0J5Z2SBoY0f55z7emiVbfYnb6Y91DGR2ecZHMgdiZ4=;
	b=WW8u5gxVfB7fNEPbftWXTlLBjMjBdgZ/XRHq5UQuAC2exOLa0nUxFLD+eL7isujAXBtzfA
	d7G0odA1ByZpggsqMcRwdgpTneoqSEOuOiNkdX8K7ygllJCfqPQRe+cz7/EV1lgsCYBIGF
	QHLNX4tJp272sf2lw6qMiFi7g6CKdDE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-OUIwuwCCNFK7XuLew_MJYA-1; Fri, 24 Jan 2025 07:58:19 -0500
X-MC-Unique: OUIwuwCCNFK7XuLew_MJYA-1
X-Mimecast-MFC-AGG-ID: OUIwuwCCNFK7XuLew_MJYA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso9771205e9.2
        for <cocci@inria.fr>; Fri, 24 Jan 2025 04:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723498; x=1738328298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0J5Z2SBoY0f55z7emiVbfYnb6Y91DGR2ecZHMgdiZ4=;
        b=h4hZlu80iR1dvwDxwt9RHIQpSD/2FUP83IVpUnObkXy8tpAgUu6ViMqwCv8SyIaijo
         cDRIeT8lZLBuz/o80sbvLX2Zin3bC1jCzl5jmV6NhmntGV/UZalD/+EAucJH9OvM/Tl9
         0p8stCHvAHdz3yTcoFbFcP9aI9+31dQeLtX3lR/o5Qj/QLoJjzdxdUY2R2oIvfjMHfG6
         y7T9/jGt7NdFw/6+f5flpzBh3gWxddUPgVJ1Wl6uJjw4l6g2AUAQXZgjhP21kL5CWwn0
         //5ysp5LUGeN0PX5rNdaMFmGmHPX1+QUZbS1s2N4jg55ixvvQYezfcuHdGmhdzUrfaUl
         ZdPA==
X-Forwarded-Encrypted: i=1; AJvYcCVt8LeNzZD11mPzfd6+ixTgQDI/CyiDvLINy9pCirR/0xmfkdWCSDahIutQ/oLDTDcnF/XBvA==@inria.fr
X-Gm-Message-State: AOJu0YzSM06jKGiGWzTxmVbodzgljBTkEZzBoW7NPErVYQXrk+1gKfmO
	g27a/zzb3JtBXgJMlAGZd1n7FsU+54kSgbKORTzyQ78s3RI41j/ELfJVx1b1SG9TG5zFvpqvtp8
	i+UzRghgGqNVAekS916iNEmfc+2r26V6vzC8OrMHo2uQ=
X-Gm-Gg: ASbGnctusvfnRJWfjKjyeIveLR90FzLHaCQuZDESiQ4mi8OmUMfGla1C5oJuiLghugt
	yJ52Rc5fPuJTFURQEQWrQL9tAXNRofFDnx0HehpZOh+C4/0LLgqOCrIiQVdDRlQUZB14W9kermo
	lPbbtNUQvKfdpXhCZlN1Mp30qfkF5o5nALFBe9VUdS2X3r3+SorDHuyMkglClw0dSGR7fRSSDu5
	NscFUZWCCE5zoX3w/B0NEaL8p9LLOGtR7ewc/nSolQq8C68kYh5lkRv4Mbb+yn+A4eV4IIZqzv2
	IwRnrnd9j+PKZUJBrJ6p1VEYND+LxzaIY19fAs8TwTYAMg==
X-Received: by 2002:a05:600c:4c24:b0:434:f3a1:b214 with SMTP id 5b1f17b1804b1-4389da1e6c7mr254283095e9.28.1737723498238;
        Fri, 24 Jan 2025 04:58:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRs0Glx89jQkSNFnV105jdUfXdwoCdvq5qiGz1yC35tKkgkMxhavVq6LlrhT4jZWikxY+ngg==
X-Received: by 2002:a05:600c:4c24:b0:434:f3a1:b214 with SMTP id 5b1f17b1804b1-4389da1e6c7mr254282705e9.28.1737723497800;
        Fri, 24 Jan 2025 04:58:17 -0800 (PST)
Received: from [192.168.0.167] (h-185-57-5-149.na.cust.bahnhof.fi. [185.57.5.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47eecasm25576245e9.6.2025.01.24.04.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 04:58:17 -0800 (PST)
Message-ID: <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
Date: Fri, 24 Jan 2025 14:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com,
 laurent.pinchart@ideasonboard.com, broonie@kernel.org, leobras.c@gmail.com,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h1zc0RGRdcX36Is4aQmwCrGDou49VX1a-CoVL3z1IWc_1737723498
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2247
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/a77f2eea-1793-4e83-92b0-92b5bbd23a5e%40redhat.com>

Hi Jarkko,

On 1/23/25 11:30 PM, Jarkko Sakkinen wrote:
> On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
>> We are working towards creating a generic, upstream GitLab-CI pipeline
>> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
>> is designed with a distributed infrastructure model, making it possible
>> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
>> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
>> integration.
> 
> Why can't you keep the next version of your great pipeline outside the
> kernel tree?
> 
> If there is a legit motivation for doing that, why it needs to be bound
> to Gitlab? Why can't you make script callable from any CI?

Greetings from the (today's) sunny Espoo!

Of course we could keep it outside the kernel tree. However, the point of this
contribution is to provide kernel maintainers and developers with an easy way
to setup their CI pipeline on a GitLab instance (the main one, FreeDesktop
one, or any other). Basically this is like a template or a library, if you
wish, which helps you do that. Approved by Linus too.

Why GitLab? Because it's one of the best, if not *the* best CI system these
days, with lots of flexibility, and it's Open-Source too (well, at least
open-core, which is still very capable). And also because a number of
maintainers and companies are already using it.

Sure, a script could be contributed too, but the value of this contribution is
a ready-made integration. And we want to make it easily discoverable, and
easily contributed to.

BTW, here's the talk we gave at last year's LPC regarding current use of
GitLab in the kernel and surrounding community:

https://lpc.events/event/18/contributions/1728/

Nick

