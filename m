Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FB0C02196
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a3P5t3YOD48EA0EV2RHNoq8geVxugYi56wkyKb35rHg=;
  b=SjCY24lxoyOQYFciUHTmehpEsE2lVSp7lyawykHdfd7Tme6OgUESX4rk
   8UTQIBQaYFTLKwXyZbwzhfaDS2hBYIAjSPv16OO56C2+FJ1/CFXpUMKnC
   ZfVrf6x9LI6Qvwh2DxJFXJTlGDL/Qa9MqRlOb2FAe5IbCOk7IrpNJ1wkp
   E=;
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
   d="scan'208";a="205325172"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0856FE0DF9; Tue, 28 Jan 2025 10:13:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A0B3E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 18:04:56 +0100 (CET)
IronPort-SDR: 6793c836_hAXm90fUkNbQ1yZvY+Pj5ygSmbBg6I0PipDw4c4cJqpjTc5
 g027jHaL67vzULPG/N8wnFeONffDEeSLaIkuP/A==
X-IPAS-Result: =?us-ascii?q?A0H8AgCNx5Nng3yBCqpaHQEBAQEJARIBBQUBQIFTghwoY?=
 =?us-ascii?q?huBDQRThFaDT4t/giEDgRODKIIulVmDVA8BAwELAQE5CwQBAQMBA4UAAop1A?=
 =?us-ascii?q?h4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBASAZB?=
 =?us-ascii?q?w47hUEGNA2CYgEzcYElAQEBAQEBAQEBAQEBAQEBAQEBARcCDX0BAQEBAgESE?=
 =?us-ascii?q?R0BAREmAQQLCxgCAiYCAjMBBQEcBgEUAQEQBQmCB1gBgkEjAwQNq1sBboEFQ?=
 =?us-ascii?q?opDAQEBeIEygQGBCYEDAQEGgQjbF4FkAwYJAQqBBi6Fa4JjAYVrO4NCeicPg?=
 =?us-ascii?q?VVEgRUnC4F2Sjg+gVKBDwGBdoNGgmmCM4F0gVaBaohvgiKLI4oKUnscA1ksA?=
 =?us-ascii?q?VUTFwsHBYEpEDgDKzYxI4EmBTUKNzqCDWlJNwINAjWCHiRYgitrBAWBK4I7h?=
 =?us-ascii?q?EWEU4JDgxiCFHprAwMWEAGCNXJ7H4EsHUACAQttPTcGAwsbBj2dGz2DHC4tR?=
 =?us-ascii?q?EwZEAgETDUMNAgNCh8BDx+TKUKCaY4ToDCBCjQHhB6BYwyKKZUzBg8EL4QEj?=
 =?us-ascii?q?QaGOhSSe5h8Io1ilSc0hSQCCgcGESOBWyOBXHCDN08DGQ+FBYkcGR+DQoEEx?=
 =?us-ascii?q?QZCNDwCBwsBAQMJkCOBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TGWJNq+jJS7TylW5hFtuk+B5I+orL9Y04lQ7vn2ZhyYlDfBw5P
 re6MjzsiWE/gr5OUtQ7uxoXZPqfZqyz+8M3WB8B8bSYOCighrZEGgA1/qY/9SDIVyGygc178
 4JGccObuEYT2IK8/oSiDPIdOrIq+P3jZxA692us0uFATsaEZ1I3kNXDB2EGlZ6SAQDKZ0yD4
 qE+8ZLzgDARV0nKuq+QlcKNtKzxOEjV6iHXffFPXAaAcW1/FaVABOQKXWl9yZbdzNKzb0r63
 WAtyPSoo2MnbWa53bnu1P73tBzmN/swNNYGYippeJQEw7LoEKJSe1aKs+/VLdfmpDb1L7/++
 O80CvI9v4DiQK0Ql2I
X-Talos-CUID: 9a23:I+mlxGNwWV1knO5DYRg+7mBTKusfUnDm6lbaLx/oWH50cejA
X-Talos-MUID: 9a23:PTBuCAYxZi0QLOBTuQLxmTA4LM1R8p+yGR8NstIotNLHDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="107304774"
X-MGA-submission: =?us-ascii?q?MDHLalYt59ocMj9fdxm4hC5lwPTOZH6faWzsa4?=
 =?us-ascii?q?8Yp6nJoaeh+jYkCQJWTs0361DZcq8tk7wMigyPCeTpIhMRX91cIuBUU/?=
 =?us-ascii?q?ceXrbZcTPJP20xkOj1l9LtOp2bKBjM9tjxIsSqdSvo+DjMQMviyCGU2a?=
 =?us-ascii?q?MVWxeMYF0oacf8NheroS6ZiA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:04:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737738293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3P5t3YOD48EA0EV2RHNoq8geVxugYi56wkyKb35rHg=;
	b=Hu85P9AwPswol7taw7iEQAblCn80G9n0TSBLSfZXMGsU7tSR1B4JKozYiwHXr4kxJKXy2c
	OCg8OuuQckI5I7TsjKJqvszG7mwA0PiOEqXI1hgepPRcPRxv24GQXVwAc8REbc0gF5hodu
	/ihLIosWZj/UphpTrjA0LocP7xnGDc0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-Kh8PZsYYP0mN2hQqtMNE1A-1; Fri, 24 Jan 2025 12:04:49 -0500
X-MC-Unique: Kh8PZsYYP0mN2hQqtMNE1A-1
X-Mimecast-MFC-AGG-ID: Kh8PZsYYP0mN2hQqtMNE1A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38bee9ae3b7so1511145f8f.1
        for <cocci@inria.fr>; Fri, 24 Jan 2025 09:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737738289; x=1738343089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3P5t3YOD48EA0EV2RHNoq8geVxugYi56wkyKb35rHg=;
        b=hYAWI3Xlw2II10sPdBYXnjz9LHYXczhGivTnovKER1scdj92xT0TBzJ1VL4kMR0zJ5
         eyN1jqzhs5qEQCKhVIgWrMkd3DsnuqZs3Hgyo7H/lSFu9KP44l5b/h3XrNPrFfXGHWp7
         qZ5R0Vum9mQHuZYLYxRRJlcbZhg2nbakgf7nyALhulW4k1v/xdrH7nf9jw8YTGy8VEix
         WjoMmH3l5Wnt5yYdlYinMCk0r6ayIo/0tYMlpcM11DpS7uNDQ3XfwjIyrmUsfjDSegmL
         /D5QPfToEpGIGKK9zReQXLLQgiuorGqLyVsEi4WiMp9MCUfTnG0DcVXuYDljVPs5NdTX
         dAUA==
X-Forwarded-Encrypted: i=1; AJvYcCW8wxV8drWqdgTgMM6Qxf0J+zfVOLGfLauKIQz596aDN+ydaCnWz+JfSSQIUi3ZBJvViM44Cw==@inria.fr
X-Gm-Message-State: AOJu0YzCnAPShJpJRMH5dAZXm+myGadvPWn+Ce30qf2VRbKUNaD0iyLZ
	onXzU9wdbs8cCm+PlOfa0R8n8+CwmECdOSfA1r5vDwgjUvP5UxFykZjfCj1WwbyDDulBWMjsgs0
	EVQtU+BBko3dl0kCtB7Rd9kCUMF24vhzzzvZez44EMqw=
X-Gm-Gg: ASbGncv/r4jAEfkfr+6caX/yg+mBdXh2S2dWLpRcUb7q/RxrZOeLi5KcVww9zFilFIj
	QdOWIyJg1hup4l3r5SPElQ9sLUgya9uGkedNE9krWn7beEG6TiRqDFEyJ1rrie2dt7ag9ONVfiv
	aSSsTxYXJZd6M8wliBxTNGuhF4TFbYbF6lzL7oEOyFyMDNWbzpZzGOALKmqwQKSSszDvPwgS5te
	6yPQIVu7Lyw3tiQepHxbtRFtt5jXB9v+eWKkUk8K/NmMYbbN5yC40IYlDTs5Zal1vW+0HZ7OQ3s
	Rj4QeWiigeIuecDqcO9775Sb+Xoko+nCJNhEkOP1tOqMlg==
X-Received: by 2002:a05:6000:1aca:b0:385:fb8d:8658 with SMTP id ffacd0b85a97d-38bf57b7fbdmr32674015f8f.40.1737738288499;
        Fri, 24 Jan 2025 09:04:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+G9Ly889nxwWYhEnpSlN2C9XnZE/zqCyWPABsxutMfB8Ly5aCQaffnJgn9avJEiwi5J80pg==
X-Received: by 2002:a05:6000:1aca:b0:385:fb8d:8658 with SMTP id ffacd0b85a97d-38bf57b7fbdmr32673940f8f.40.1737738287978;
        Fri, 24 Jan 2025 09:04:47 -0800 (PST)
Received: from [192.168.0.167] (h-185-57-5-149.na.cust.bahnhof.fi. [185.57.5.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1885besm3187760f8f.49.2025.01.24.09.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 09:04:47 -0800 (PST)
Message-ID: <8db7c8cf-6976-4dbd-92d1-62ce5288dfb7@redhat.com>
Date: Fri, 24 Jan 2025 19:04:45 +0200
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
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
 <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I59R6-n1p4RUgm6Gmbok7VvV_wMliUUvalEM9sKF-Qk_1737738289
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2256
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/8db7c8cf-6976-4dbd-92d1-62ce5288dfb7%40redhat.com>

Hi Jarkko,

On 1/24/25 6:32 PM, Jarkko Sakkinen wrote:
> On Fri Jan 24, 2025 at 2:58 PM EET, Nikolai Kondrashov wrote:
>> Of course we could keep it outside the kernel tree. However, the point of this
>> contribution is to provide kernel maintainers and developers with an easy way
>> to setup their CI pipeline on a GitLab instance (the main one, FreeDesktop
>> one, or any other). Basically this is like a template or a library, if you
>> wish, which helps you do that. Approved by Linus too.
> 
> With all due respect, "approved by Linus" is not an argument :-) I get
> that Linus can make the "ultimate decision" but in argumentation I'm not
> a strong believer of authority based decision making process. Not
> downplaying this more than that I knowingly ignore this comment.

Sure, fair enough!

>> Why GitLab? Because it's one of the best, if not *the* best CI system these
>> days, with lots of flexibility, and it's Open-Source too (well, at least
>> open-core, which is still very capable). And also because a number of
>> maintainers and companies are already using it.
> 
> There's also Github Runners and Woodpecker CI used by Codeberg. To add,
> some companies and other organizations prefer Jenkins. This one fit for
> all strategy is somewhat short-sighted.

We're not suggesting everyone should use this. We've just been using it, know
it well, know it works, and so are trying to help people use it. Please feel
free to use something else, and of course contribute the corresponding CI
setup to the kernel repo! Not that I can stop anyone, of course, but that's
the idea behind this. Note the "/ci/gitlab-ci/" path. Anything which could
help maintainers/developers integrate testing with their development workflow
cango under "/ci/", I think.

> Also running Gitlab tasks locally is possible but is heavy-lifting.

Yeah, it's not perfect.

> Can we then agree that any CI changes can be sent untested to LKML if
> a patch set needs to reflect on those? It's not reasonable to except
> local runs Gitlab from individuals for patch sets. It makes our lives
> more difficult, not easier.

This is not really for individual contributors, but for maintainers/subsystems
to help automate their team's (and contributor's) testing.

And this is not saying you're required to run GitLab CI for your contribution.
It's up to a particular subsystem to decide their policies: whether to just
have the maintainers send contributions off to a GitLab CI instance during
review, or larger merges, give co-maintainers access to it, or require
contributors to submit an (automatically-tested) MR.

If you send patches changing CI, then of course you're expected to test it, as
with any contribution to any project. But if you're not running it, why would
you do that? And if you or the recipient maintainer run it, then you get it
tested automatically.

> All maintainers I know test their patches for the most part with
> BuildRoot, distro VM's and stuff like that. Not claiming that they
> don't exist, but never heard of kernel maintainer who uses Gitlab
> as their main kernel testing tool.

Well, some of the people in this discussion do that, and more are mentioned in
that talk I linked. But sure, I think contributing their setups to the kernel
tree would help others who want to automate their testing.

>> Sure, a script could be contributed too, but the value of this contribution is
>> a ready-made integration. And we want to make it easily discoverable, and
>> easily contributed to.
> 
> This is definitely NOT "lots of flexibility".
> 
> Are you dead seriously claiming that DevOps engineers could not handle
> well defined CI scripts and bind to whatever CI makes sense to them?
> o_O

No, of course not. This is simply to make life easier for maintainers, who are
not necessarily DevOps engineers themselves, and want to try it out, or have
it setup.

Of course, having well-defined CI scripts would be great, and we enjoy e.g.
well-defined make interface in CI, for example. I assume engineers who
implemented this (Helen et al.) would be happy to use such a script, if it
existed and was suitable. The problem is that it would still need to interface
with GitLab CI, which is while flexible, suffers the flip-side problem of
being complex. And that's where the devil is, and this contribution is trying
to help defeat it.

>> BTW, here's the talk we gave at last year's LPC regarding current use of
>> GitLab in the kernel and surrounding community:
>>
>> https://lpc.events/event/18/contributions/1728/
> 
> This patch set should make the case, not an old presentation.

Well, I'm sure there are angles not covered by the cover letter and commit
messages of this contribution, and I'm partially to blame, as I was one of the
pre-reviewers. However, I'm sure we have left more stuff uncovered than we
discuss here, even considering the discussion of the first version. And so I
provided the link to the talk as a rectification. But if it would help, I can
provide a summary of it here too.

Nick

