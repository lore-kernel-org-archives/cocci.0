Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED94BC64EC4
	for <cocci@archiver.kernel.org>; Sat,  4 Mar 2023 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=references:from:to:cc:date:in-reply-to:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ykAX5woDC3mRymPiVbbo2VDyZOKxKj2NLBbdN7+oOMM=;
  b=s9dYSXqLVSEPsbTa+J97HyPnocwiVrkkGLsIZBmtJVgQdi6dK3NT9fSq
   qPNppTXUi9rLXQAkU56s9J+WFGGlCIbTIHQGfI/cZ08yq5G9e7GmRyaTm
   0kkmlba7lfSqLa2wHt02hzMNv8bod7FBbx0z3SpYX6ZKcEV7TldKc6Fp7
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.98,233,1673910000"; 
   d="scan'208";a="95427764"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2023 17:39:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E714E0385; Sat,  4 Mar 2023 17:40:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 583B2E00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 17:32:07 +0100 (CET)
IronPort-SDR: 63fcdb05_WzHiH0XAbuWkc15D6cL2AE1ok1FYv2BruJXf4mC0TcBXlSd
 A7uZhUJlJ/2rv6CxniEPaqhWOacscHKIq9Vq0LA==
X-IPAS-Result: =?us-ascii?q?A0FMAwAK2vxjfzOgVdFSCB0BAQEBCQESAQUFAYIPgi2BC?=
 =?us-ascii?q?VYuBFEEk0qCJQOdW4EsPg8BAwEMAT0FAgQBAQMEOIRGAoUwAh0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBIhkHDg4phWgNgjcpA?=
 =?us-ascii?q?XVNAzgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBAINU?=
 =?us-ascii?q?h85AQEdAQEBAQIBEi4BGx0BAwELBgULDQklDwERAhEBBQEOAQ0GEyKCXYJtA?=
 =?us-ascii?q?QMOIwMQoEuBBEKKOIIPBQIWgQGCCQaBQQGaSAoZKA1oA4FbAgEGCQEIgS6EW?=
 =?us-ascii?q?IJnhQFGgy16JxuCDYEVgTyBbj6CIEIEgSEWhmYEiXyEWoZ2AQMCAgMCAgMGB?=
 =?us-ascii?q?AICAgUEAgECBAIOBA4DAQECAgEBAgQIAgIDAwIIDxMDBwIBBgUBAwECBgQCB?=
 =?us-ascii?q?AELAgUCCgECBAECAgIBBQkBAwEDAQwCAgcCAwUGBAIDCQUCAQEDAgICDQMCA?=
 =?us-ascii?q?wIEAQUFAQEQAgYECQEGAwsCBAEEAwECBQcDBwMCAgICCAQSAgMCAgQFAgICA?=
 =?us-ascii?q?QIEBQIHBgIBAgICBAIBAwIEAgIEAgIEAxsCAwUDDgICAgICAQkLAgMHBAIDA?=
 =?us-ascii?q?wEHAgICAQwBAxgDAgICAgICAgEDBwoECQQCBQECAQQLAQUBDQQBAgICAgIDA?=
 =?us-ascii?q?gEBAwYIBgMKAgcEAgMDBgkPDwgFAwEEAwIDAgEICwIDAgICBAgCAwECAgEGA?=
 =?us-ascii?q?gMBAgIBAgIBCwEBAgMFAgIRAQICAgICAQECAwIDAQcBAgIYBgQFAwMFAgIBB?=
 =?us-ascii?q?AECAgQEBQsCBAMBAQECAgICAwILAwUDAQYDAwoHBAEIAgYDBAIFBAMEBAYCA?=
 =?us-ascii?q?gICAgEEAQYLAwIEBAMDBgMJAgIMAhQCEAQGAQQLCwIEAgIBAgICDgMEBgIDA?=
 =?us-ascii?q?wICBQkCBAICAgICAwYCCQQCAgMCAQICBAECBBQPAwMCIAMZKx0CCQMjDwMLC?=
 =?us-ascii?q?QgTFygGDAc0BDQBFBIHBwYmAQEFDgYCBgMEAQoLBQQFCAECAQEGAgQCBwkMA?=
 =?us-ascii?q?gEGAQUCAgMCAQQBAgEGAwECAgICBQcFAwQFAwkKAwEBBAMCAQIBAgMCAwcDA?=
 =?us-ascii?q?gQCAwECAwQGBgEJBAYFDQMEAgIBAgEBAwQEBAICAQICAwEEAgIBAQMDAwICA?=
 =?us-ascii?q?gMEAgMDCwQKBwMDAgEFCwQCAwIBAQMBBgkEAgIGAQIEAgICAgICAwEBAwkEA?=
 =?us-ascii?q?gEDAgIEAwYCAQIBCQUCAQkDAQIBAgEEAQMJAQICBAkCAwcFCgICAgIIAgIOA?=
 =?us-ascii?q?wMCAQEEAgIEBQkBAgcCBQEBAwUHAgIBAgIBBAMBCQQBAgMCAQEDEgMDAQQCB?=
 =?us-ascii?q?QMDDQkGAgIBAwIBDQMBAgECAwEFBRcDCAcUAwUCAgQEAQcCAgMDAwIBAgkGA?=
 =?us-ascii?q?QMBBQIOAwICBAYBAgEBAgMPBQEBAQEXAQMEAgMBBAMBAQIBAgMCDgQBBAUMA?=
 =?us-ascii?q?xwCBAEICAICAwMBAgMFAQIDBAIBCAoCAgICCQIKAwIDAQMFAQMCCQMBBQECB?=
 =?us-ascii?q?wIGAQEBAgICBgIIAgMLAQMFBgIBAgIBBQIBAgIFAwUCAgICBA0CBQICAgUBA?=
 =?us-ascii?q?gcEAgICAwECAgYFAQIHBwIFAgICAwMKBAQHBAEBAQIBAQUBAgEDAwECBAECA?=
 =?us-ascii?q?QIFAwYCAgICAQICAQEBCAICAgICAgMEAgiZEkgHARVeBxMsUBpbCA0QDgVLA?=
 =?us-ascii?q?i0DkgwmATmCYAGLTYIWnSeBRWQLZIMfgVWCeocUjw2GBzKDeoxlhiRFkXCXW?=
 =?us-ascii?q?YtjgW+DbJEfhRECCgcGECMSgUQjPIEgMxoIGxU7MYI2EzwDGQ+OIAwWg1CFF?=
 =?us-ascii?q?IpyNDQCATgCBwsBAQMJhUMmE02FBQEB?=
IronPort-PHdr: A9a23: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
 pUJTbBfWRo+EfZIUiyN+fQNJZ52WnUvlrvJ1KY1
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YiBQKaP5mp+bqsBcThOjsMiBIKoaSvp037Dk7TEXdfU1SL3kqy
 nKpp4mPHDP+U8ssR0b6LW9EYmGBWjR7JtkpZQWVI3SJDUO21HYVr2Kj7GSuAEIcheWnoU86U
 4jSdkcNDSZNzlHZK3BkW+F+rgbsb262Zyzifybx3lgShwCUdAD0+67MGqm+49NKTWuyaBXKH
 NU3KR6mwY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="48749499"
X-MGA-submission: =?us-ascii?q?MDE/IFsJZ1ugOS2B46zr5cLExxabQuhOFbjlE+?=
 =?us-ascii?q?76I/3BRSMVwpmoFo9GNO2h+E7OrTCfvvNfWB48i3nzJUf8koOp+2Wdkj?=
 =?us-ascii?q?WLdhq5k6eOrnyuTlSq6BfZy6nuMA0vgx8g15Hi0fHpl4i5LpsRk+PNpu?=
 =?us-ascii?q?6ejcK2/zo3GTubefjj/saaHA=3D=3D?=
Received: from mail-oa1-f51.google.com ([209.85.160.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 17:32:05 +0100
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-172a623ad9aso7901269fac.13;
        Mon, 27 Feb 2023 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ykAX5woDC3mRymPiVbbo2VDyZOKxKj2NLBbdN7+oOMM=;
        b=UOMDtGg/ynZ88DEpE4VpZTUV/FqnKD2fz36KU1mFrdJcOjwJ11QbKCwi8XskEylpD6
         JL0Tmsi64RQPL6ycJ8QDaTA38JZ9v6TV7nYLxGyPrLIis+q0tF3xkrKDQpMfuvH9V/j5
         VPLG/Zg0GPTzNUFKdyhRDHMygvqPqsQGeGG3pUX3wVF3jr40EqKekxaLFi/JWqxZPSvN
         YeFEoYbW8YyCaGCh54Sq2IjApJCBHWa85rxtYPi6hlscN3sI/zsEov007TfsEG6/qcIP
         yBm4j3qVKc2QzlB/GJwstBiBpZVq2eVxwL/8Zt3pBpRRnck4nuPSKTlLn1sZ0Z1tUZrg
         2m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykAX5woDC3mRymPiVbbo2VDyZOKxKj2NLBbdN7+oOMM=;
        b=GeX47ws4XTjQGDfoZXT7S6IdlkZ/TOon2ex3EaCQoDEg45YcJbfunVXyTJ4busKu7d
         nIEUctyPBYwy52Ugx9OhfvhzhSAdtDIIK4en68sDWRy36CioO4NERUMxypV87csectHF
         z/+BLF5ts6O0q1CnPmGprkCUKmXZnJUt2V46QvMiwVIfS6TTvNpHSXgS39P0ZfGVU56Z
         oh/AFcQ2tWxn3KF9D/LDTF9IvlxHAyZuwHmUygu4HN8bza0QZfgCyO6fjxRZtNNR7Hl5
         WvJowxvcNafmuqdaWJqanUkO6mwkwdVTYlY5Lo1Q4K4qmjdd6gOCIROIQZAlxsiNT6N6
         dg7Q==
X-Gm-Message-State: AO0yUKXlNcIiklPgewQKnezfxTTDX201aq2A0q6cE/XdHMjsUHoX0hB+
	H5HHoUmzGYu+rS+2qsJdWFI=
X-Google-Smtp-Source: AK7set8JrmQPXI/+U9esCHo92SVr2hSyJywv45zSD2QlNF5cOT/7jtM6w7j7MSiA3lYY8GEvpc/57Q==
X-Received: by 2002:a05:6871:29c:b0:172:6cfc:6ff4 with SMTP id i28-20020a056871029c00b001726cfc6ff4mr11441076oae.41.1677515523473;
        Mon, 27 Feb 2023 08:32:03 -0800 (PST)
Received: from ArchLinux ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id q190-20020a3743c7000000b00742a23cada8sm2895394qka.131.2023.02.27.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:32:03 -0800 (PST)
References: <20230227075346.69658-1-schspa@gmail.com>
 <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.7.5; emacs 28.2
From: Schspa Shi <schspa@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, cocci@inria.fr, mcgrof@kernel.org, Julia
 Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, buytenh@wantstofly.org,
 johannes.berg@intel.com, gregkh@linuxfoundation.org, tomba@kernel.org,
 airlied@gmail.com, daniel@ffwll.ch
Date: Tue, 28 Feb 2023 00:10:35 +0800
In-reply-to: <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
Message-ID: <m2ttz75ati.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC PATCH] cocci: cpi: add complete api check script
Reply-To: Schspa Shi <schspa@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 873
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/m2ttz75ati.fsf%40gmail.com>


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Feb 27, 2023 at 03:53:47PM +0800, Schspa Shi wrote:
>> When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
>> process won't reference the completion variable on stack. For a
>> killable/interruptiable version, we need extra code(add locks/use xchg) to
>> ensure this.
>> 
>> This patch provide a SmPL script to detect bad
>> DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.
>
> Documentation/process/submitting-patches.rst:instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>
> But also, wth is SmPL, the actual thing included is a coccinelle script.
>
Thanks for reminding.

>> This is a common problem, and a lot of drivers have simpler problem. The
>> fellowing is a list of problems find by this SmPL patch, due to the complex
>> use of wait_for_complete* API, there will still be some false negatives and
>> false positives. This RFC patch is mainly used to discuss improvement

There are still many defects in this script that are commented here.

>> methods. If we introduce the wait_for_complete*_onstack API, it will be
>> easier to modify these problems, and the patch rules of SmPL will be very
>> easy. In the process of trying to write SmPL scripts, I strongly recommend
>> introducing two onstack APIs to complete this operation.
>> 
>> file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack
>
> What's with this retarded file path? Are you running on Windows or
> something daft like that?
>
> Please, make them relative to srctree.

It's the raw output from this coccinelle script running from macOS. So,
I did not remove the prefix from the file path.

>
>> file:/Users/schspa/work/src/linux/drivers/misc/tifm_7xx1.c::268 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/firmware/arm_scmi/driver.c::1001 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::595 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::491 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::538 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::645 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::3175 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2360 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2314 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2634 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1804 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1758 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::2034 was suspected to return a variable on stack
>
> These don't seem buggy, they take the whole DSI out -- which lives on
> stack too.
>

This RFC patch is only used to illustrate the complexity of this
detection. As rewritten in the comments, this coccinelle script is
already somewhat complicated, but it still cannot avoid false positives
and false negatives. For code writing like dsi, I think it is difficult
to cover it with coccinelle script. So I want to introduce the onstack
version of the API, so that the checking work will be much easier. It is
also much easier to read the source code. When you see such APIs when
reviewing the code, you can easily know that there are detailed
exception mirroring considerations here, instead of carefully reviewing
whether there are some implicit conditions to ensure that there are no
problems.

>> file:/Users/schspa/work/src/linux/drivers/net/wireless/marvell/mwl8k.c::2259 was suspected to return a variable on stack
>
> Heh, they seem to have the right idea but a buggy implementation.
>
>> file:/Users/schspa/work/src/linux/drivers/net/wireless/mediatek/mt7601u/mcu.c::317 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/net/wireless/ti/wlcore/main.c::6674 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/net/wwan/t7xx/t7xx_state_monitor.c::416 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::647 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::653 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/soc/qcom/rpmh.c::269 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic94xx/aic94xx_tmf.c::339 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_ctl.c::242 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1811 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2266 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1603 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2073 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1807 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1328 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/ibmvscsi/ibmvfc.c::2466 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::844 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::2334 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c::2297 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/lpfc/lpfc_nvmet.c::2119 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/ipr.c::5153 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/scsi_error.c::1157 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_main.c::1215 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c::996 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c::867 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/isci/task.c::317 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::1844 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2310 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2086 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2579 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::6752 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::4074 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/thunderbolt/ctl.c::604 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i2c/busses/i2c-hisi.c::206 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/s390/cio/vfio_ccw_drv.c::71 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/messaging.c::154 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::894 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::932 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ctrl.c::377 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/usb/core/devio.c::1142 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/usb/core/hcd.c::2229 was suspected to return a variable on stack
>
> These do usb_kill_urb() in the fail case. IIUC this avoids the UaF
> problem this script is trying to finger, no?
>

This is a similar usage to DSI, with some implied conditions

>> file:/Users/schspa/work/src/linux/drivers/spi/spi-hisi-sfc-v3xx.c::337 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/bluetooth/hci_bcm4377.c::955 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c::336 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c::278 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::360 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::312 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::238 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/ata/libata-core.c::1558 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::285 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::233 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::262 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/lib/kunit/try-catch.c::76 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/sound/aoa/soundbus/i2sbus/pcm.c::264 was suspected to return a variable on stack
>> 
>> To fix this, we can add introducing two new API for this.
>> 
>> +
>> +void complete_on_stack(struct completion **x)
>> +{
>> +       struct completion *comp = xchg(*x, NULL);
>> +
>> +       if (comp)
>> +               complete(comp);
>> +}
>> +EXPORT_SYMBOL(complete_on_stack);
>> +
>> +int __sched wait_for_completion_state_on_stack(struct completion **x,
>> +                                       unsigned int state)
>> +{
>> +       struct completion *comp = *x;
>> +       int retval;
>> +
>> +       retval = wait_for_completion_state(comp, state);
>> +       if (retval) {
>> +               if (xchg(*x, NULL))
>> +                       return retval;
>> +
>> +               /*
>> +                * complete_on_stack will call complete shortly.
>> +                */
>> +               wait_for_completion(comp);
>> +       }
>> +
>> +       return retval;
>> +}
>> +EXPORT_SYMBOL(wait_for_completion_state_on_stack);
>
> So going by the 3 random samples above, only 1 would use this pattern.
>
> Does that mean you 'forgot' to audit all these results before proposing
> a fix?
>

I checked the output here, and there are instances of incorrect error
alerts in this output already pointed out in the previous comments.

> What does that mean for this script?
>

This RFC PATCH is intended to be used to discuss whether to add a new
API to simplify this detection and repair work.

>> Link: https://lore.kernel.org/all/20221115140233.21981-1-schspa@gmail.com/T/#mf6a41a7009bb47af1b15adf2b7b355e495f609c4
>> Link: https://lore.kernel.org/all/7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp/
>> 
>> CC: Julia Lawall <Julia.Lawall@inria.fr>
>> CC: Nicolas Palix <nicolas.palix@imag.fr>
>> CC: Matthias Brugger <matthias.bgg@gmail.com>
>> CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Juri Lelli <juri.lelli@redhat.com>
>> CC: Vincent Guittot <vincent.guittot@linaro.org>
>> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Ben Segall <bsegall@google.com>
>> CC: Mel Gorman <mgorman@suse.de>
>> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
>> CC: Valentin Schneider <vschneid@redhat.com>
>> 
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  scripts/coccinelle/api/complete.cocci | 160 ++++++++++++++++++++++++++
>>  1 file changed, 160 insertions(+)
>>  create mode 100644 scripts/coccinelle/api/complete.cocci
>> 
>> diff --git a/scripts/coccinelle/api/complete.cocci b/scripts/coccinelle/api/complete.cocci
>> new file mode 100644
>> index 000000000000..d4cf32187180
>> --- /dev/null
>> +++ b/scripts/coccinelle/api/complete.cocci
>> @@ -0,0 +1,160 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +///
>> +//  Copyright: (C) 2023 Schspa Shi.
>> +//  Confidence: High
>
> I'm thinking that 'high' is somewhat premature, 2 out of 3 false
> positive rate does not inspire confidence.
>
OK, this definition is not appropriate.

>> +virtual report
>> +
>> +@r1 exists@
>> +declarer name DECLARE_COMPLETION_ONSTACK;
>> +declarer name DECLARE_COMPLETION_ONSTACK_MAP;
>> +position p;
>> +identifier done;
>> +identifier func;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +DECLARE_COMPLETION_ONSTACK(done@p);
>> +|
>> +DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...);
>> +)
>> +...
>> +}
>> +
>> +@locked exists@
>> +identifier func=r1.func;
>> +identifier done=r1.done;
>> +position p1,p;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +mutex_lock@p1
>> +|
>> +mutex_trylock@p1
>> +)
>> + (...)
>> +...  when != mutex_unlock(...)
>> +done@p
>> +...
>> +}
>> +
>> +
>> +@elocked exists@
>> +identifier func=r1.func;
>> +identifier done=r1.done;
>> +position p1,p;
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +e = &done;
>> +...
>> +(
>> +mutex_lock@p1
>> +|
>> +mutex_trylock@p1
>> +)
>> + (...)
>> +...  when != mutex_unlock(...)
>> +e@p
>> +...
>> +}
>> +
>> +
>> +@has_wait_for_completion exists@
>> +position p;
>> +identifier done;
>> +identifier func=r1.func;
>> +identifier fb = { wait_for_completion, wait_for_completion_io};
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +...
>> +fb(&done@p);
>> +...
>> +|
>> +e = &done;
>> +...
>> +fb(e@p);
>> +)
>> +...
>> +}
>> +
>> +@has_while_wait exists@
>> +position p;
>> +identifier done, ret;
>> +identifier func=r1.func;
>> +identifier fb =~ "wait_for_completion.*";
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +while (...) {
>> +	...
>> +	ret = fb(&done@p, e);
>> +	...
>> +}
>> +...
>> +}
>> +
>> +@has_while_wait2 exists@
>> +position p;
>> +identifier done;
>> +identifier func=r1.func;
>> +expression fb =~ "wait_for_completion.*";
>> +@@
>> +
>> +func(...) {
>> +...
>> +while (fb(&done@p, ...) == 0) {
>> +	...
>> +}
>> +...
>> +}
>> +
>> +
>> +@r2 depends on (!has_wait_for_completion && !has_while_wait && !has_while_wait2) exists@
>> +declarer name DECLARE_COMPLETION_ONSTACK;
>> +position p!={locked.p, elocked.p};
>> +identifier done=r1.done;
>> +identifier func=r1.func;
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +wait_for_completion_interruptible(&done@p)
>> +|
>> +wait_for_completion_killable(&done@p)
>> +|
>> +wait_for_completion_timeout(&done@p, ...)
>> +|
>> +wait_for_completion_io_timeout(&done@p, ...)
>> +|
>> +wait_for_completion_interruptible_timeout(&done@p, ...)
>> +|
>> +wait_for_completion_killable_timeout(&done@p, ...)
>> +|
>> +try_wait_for_completion(&done@p)
>> +|
>> +wait_for_completion_timeout(e@p, ...)
>> +)
>> +...
>> +}
>> +
>> +
>> +@script:python depends on report@
>> +fp << r2.p;
>> +@@
>> +
>> +print('file:{:s}::{:s} was suspected to return a variable on stack'.format(fp[0].file, fp[0].line))
>> +
>> -- 
>> 2.37.3
>> 


-- 
BRs
Schspa Shi
