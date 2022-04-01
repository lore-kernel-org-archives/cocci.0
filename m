Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB11C433FE
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 04:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SKqz1Mdn+a76YTOAN4pkLcsDdxqMIb341GyJ1mMbn4g=;
  b=U98iIbXneFuk3rdz9BYa0RH+T0CirxaZZV3Ao/bhgtuil15G5Ri7v9Fm
   1A/vd3CyDcG4laCkaO0uU4eAynAQuA3F1Gjo4LEPq7JE+vTCZ+ov/BfiI
   R+DipjNj3HobDefn9VACHk/NuUZKDQ9357NSYm+vSZ8D50DFOIHKER0fs
   k=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="5.90,226,1643670000"; 
   d="scan'208";a="29446072"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 06:31:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4A0ADE033D; Fri,  1 Apr 2022 06:31:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B8281E00A8
	for <cocci@sympa.inria.fr>; Fri,  1 Apr 2022 02:22:18 +0200 (CEST)
IronPort-SDR: voaZ92wBqboD0S+t0aUrgqxc5h7gw3sl9MXDDiHgZY1VrV+SRSiB+KrHV4S1TPkImHZhaKY8ib
 oNPN3lJeftF2TNShf4Qnf4Q8ZQR4MJbTGwL3tqHVUGssP1Y5u5RKPf7AmMPxjKrEcy517MiCu3
 aNDDN4aYd5reFo55WlM+s7/UvJY7+o7IhiiUPakP5j4tT644EibooVWamgrqjtU/m7M2N7TPUZ
 cT9UMZbbmAFg2XBfLZc796RBcg739vpF3B1K1D/qO4xNnVq3KdTux0VQWroE3LF07xU1kMqzCd
 q2QcOz784tF5MftT3PM7Qwz3
X-IPAS-Result: =?us-ascii?q?A0ANAADEREZigDKAVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYInflYsBAtEhFSIJoh1ixKRVIElA1QLAQMBDTsIBAEBhQcChFcCH?=
 =?us-ascii?q?QcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0NCQUIC?=
 =?us-ascii?q?gcODgU+ZGiBT4F0CzQNgjUpAYNkAQEBAxIRBBkBATcBDwsLDQICJgICIQESA?=
 =?us-ascii?q?QUBHAYTIoJiAYJlAy4PoUmBBD2LMn8ygQGCCAEBBoE/AYNTDWeBXAMGEn4sA?=
 =?us-ascii?q?YYQgSiHFSccgUlEgUuCdD6CIUICAoR4gkMimUABgSoQpRCdM2uDU4FBDIYeg?=
 =?us-ascii?q?yeObIV7BS6oToR1kWmNGINVlg0QI4E+dYEgMxoIGxVsBoIyEzsBAgECDQECA?=
 =?us-ascii?q?gMBAgECCQEBAo4dN4M7hRSFVzcxAjYCBgsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:6Sfd5qwpVF+/+XFHyfl6t+cHwCrEfRIJ4+MujC+fZmUNrF6WrkUGy
 2RLWmHSa62NY2LzfdslPdy+9koGucTXyoQ3TVBk/lhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 oqq+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhU5
 f5JrpzgTz0PBaHMgds6VRR0NTlXaPguFL/veRBTsOSWxkzCNmTpmrBgURlwMoof9eJ6R2pJ8
 JT0KhhXNkHF17/wmejrDLQ07iggBJGD0Ic3tnh+zD3WCukOTpfETKHHo9Rf2V/cg+gXRayFP
 5FCOVKDajzAJD5dFHotKqlgt/aZvmPRKGcJ+Ays8P9fD2/7lVQtitABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2nelh+uKgiaiHYxPTPu38fllhFDVzWsWYPELabelidyUoUqlW4JZE
 Wov9io3ko80+WCNVvCoCnVUv0W4lhIbXtNRFcgz5weM1rfY7m6l6o4sHm4phDsO5J9eeNA66
 rOat4+wWG0w7tV5XVrYqezE/WLvUcQABTZaPXdscOcT3zX0TGjfZDrwR857Eai6g8fuUR/5x
 zSRxMTVr+xJ0J9Tv0lX1XbKnHqdoYLKJjPZCy3SV2Ohqxx8PcurOtTu5l/c4vJNao2eSzFtX
 UToeeDOsYji7rnXzERhpdnh+pn3vp5p1xWC2DZS82EJrWjFxpJaVdk4DMtCDEloKN0YXjTif
 VXevwhcjLcKYif6MvIuP9rpUJl7pUQFKTgDfqCEBjapSsghHDJrAAkzDaJt9zy1wBl1yf9X1
 WmzIZj1VSxy5VtbIMqeHr9Bi9fHNwgxwmTcQZ2T8vhU+ev2WZJhcp9caAHmRrlhssus+VyJm
 /4CaZbi40gBAYXWP3iPmaZOfAtiBSVqVfje9ZYLHsbdeVAOMD96W5fsLUYJIdwNc1J9zbiZo
 RlQmyZwlDLCuJEwAV7UMio6MuO+AM4XQLBSFXVEAGtEEkMLOe6HhJrzvbNuFVX+3OA8n/NyU
 dcffMCMXqZGRjjdomxPYp76o4hvMh+sgFvWbSaiZTE+eb9mRhDIqoC4JFqxrHFWA3rlr9Y6r
 p2hyhjfHcgJSTNkAZuEc/mo1V6w4SUQlbsqDUvFK9VeYmv2941uJ3Cjh/M7OZhUexrEwTSe2
 kCdBhJB/bvBpIo88d/og6GYrtf2T7EvQBICR2SCtOS4LyjX+Gan0LRsaufQcGCPTn7w9YWje
 f5Rk6P2PsoBkQsYqIF7Cbtqkf8z6taz9b9XygNoQCfCY1ixUOgyJ3CH2YxQs/QIyOIB/wSxX
 U2L959RPrDQYJHpF1sYJQwEaOWf1KFLxmODs6xteEiqtjVq+LenUFlJO0XegiJqKrYoYpgux
 v0suZJL5gHj2AAmNM2K0nJd+2iWdCdSVqwmstQFBdauhFdzjF5FZpPYB2n955TWM4dANUwjI
 zm1gqvehuQDmhCTLSJrTXWdj/BAgZkuuQxRyANQLVq+nNeY1OQ82wdc8GhqQwlYpvmdPzmf5
 oS224xJyaSyE/NAgcFCWyWzHlgECkDBvEP2zFQNmSvSSEzAuqkh6oEiEb7lwazb2zs0kvtnE
 HWwx2HiXjLnOsr220PenGZ7/uf7Q4UZGhLqwaia8gfsI3X+STXihaCqaCwDrB6P7QbdQqHYj
 bECwducopEX+cLdT2PXxmVaOXktpMi4GVF/
IronPort-HdrOrdr: A9a23:JWCfG6rfCIVCf5KKwBTx+kUaV5oUeYIsimQD101hICG9vPbo7v
 xG/c5rrSMc7Qx6ZJhOo6HkBEDtewK/yXcx2/hzAV7AZmjbUQmTXeVfBOLZqlWKJ8S9zI5gPM
 xbAs9D4bPLfD5HZAXBjDVQ0exM/DBKys+VbC7loUtQcQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,225,1643670000"; 
   d="scan'208";a="10230338"
X-MGA-submission: =?us-ascii?q?MDEzFoWO66ndf4qaS1rdS222UK+INMiQajANIE?=
 =?us-ascii?q?uxuPZNHb3Ki+TyVq9rU1+flAoPBhCrupyVvCTMQ+qhk/AYujNFuh4Kpp?=
 =?us-ascii?q?UVg4qQ0cpOtKoiiLb10m+ZmNZ5jTS4sjiLrULVdvktyLq89XbI/HvNvj?=
 =?us-ascii?q?2YYNjUbzhZRt+Y4lKCFNuAGw=3D=3D?=
Received: from mail-wm1-f50.google.com ([209.85.128.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:22:17 +0200
Received: by mail-wm1-f50.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so569286wme.2
        for <cocci@inria.fr>; Thu, 31 Mar 2022 17:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKqz1Mdn+a76YTOAN4pkLcsDdxqMIb341GyJ1mMbn4g=;
        b=r7/0P+gLeJObOX79hjnX/5UuEQeJl4zuAbrJGyhV08YNdiRMj8TzrvJbe5YkmUAGWY
         mZhA9emHoEHCn4lEv4EvNc8fqo4nqUyfDQFq4BEwCQx/DTtnpWDwjd3/IaEZsI8pSqyS
         WjpMp3DpVBxwsEJ95nCBJ+/pczjqk7ilCSfpnVILZ7SWNsYZmbp3MDKNhETQzOYksHYF
         qhGFQxDs8lUwKxvSdlJn+vSLlyHqbuXTRb1N11WJyph0kUPERw3FVbCryrZTBj2Tweo9
         RJpGE7f0J9S2buBc0BEs6Q2CQdJ5UwjnCB//QwYVmRQoKId9dxhttnNc/CCDe/PtT7UL
         PY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKqz1Mdn+a76YTOAN4pkLcsDdxqMIb341GyJ1mMbn4g=;
        b=a2fGv9JbhLloq6ea4bl35JKL6AU7BiSrQgeI0BfkT9gbbPeguKSuYCI37LLYgBUckb
         L0CqGYPtw7ODcyGx8wl3U0fDniMXgzK3FN5z6vmpTUPpJwY/a0b2te5i9ZVNHlIZtDy+
         WKR8PoRU6J+9PvXY8t61OrrG+47XWGtgk1AKGw28USJV4FONWA5MfXWWjei5r/qUCU8w
         aiGJhGZQB/xSwyyqq+VV2B5EW2YS/4NtxsdF6UN9sR0W5yhEUb2tqgnu/uCBsl4nbA/S
         3u90Da2B/Xu0vUhfy3r/iAAJfkRbelHfTVMoMXMNj/17Mo8VEady93AkE8pAgvSilHcR
         JJig==
X-Gm-Message-State: AOAM532BuByRPh9wwdmm5EZ0ozScUPD6n77Xc2EhU5xNrqGPzdVqicAW
	QAA/vwqwK105FAKCfDMHx2i0ZyXrg7UnU9E8YXh8vQ==
X-Google-Smtp-Source: ABdhPJyXs2kiijhvj7ZEIkf4LgFEBAL3bNGbwnp9Hp9Ce+KJcEqlpKTa5nUQk4PlzawW8Gaz7vFgZm/0MW22sAEhJh4=
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id
 m8-20020a05600c4f4800b0038ca4600cb6mr6654078wmq.96.1648772536629; Thu, 31 Mar
 2022 17:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com> <62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 1 Apr 2022 08:22:05 +0800
Message-ID: <CABVgOSktSP6GwU+zfJLC7A-UZUKT0QHSmACG-ScFDhb34Jf-aw@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Daniel Latypov <dlatypov@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: David Gow <davidgow@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 326
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/CABVgOSktSP6GwU%2BzfJLC7A-UZUKT0QHSmACG-ScFDhb34Jf-aw%40mail.gmail.com>

On Thu, Mar 31, 2022 at 5:50 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Enhance the static analysis tools section with a discussion on when to
> use each of them.
>
> This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> a previous documentation patch for static analysis tools.
>
> Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: David Gow <davidgow@google.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> ---
> Change log v2 -> v3:
> - Changed the paragraph about Sparse to make it sound better (hopefully)
> - Minor adjusts to make the considerations about Coccinelle sound better
>   and be precise

These (plus the cut down note on Sparse/Smatch overlaps) are
definitely an improvement.

Assuming no-one with more knowledge of these that me objects, I think
this is good-to-go!

Thanks,
-- David
