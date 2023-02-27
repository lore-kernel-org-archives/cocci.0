Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097E4C678D5
	for <cocci@archiver.kernel.org>; Sat,  4 Mar 2023 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=references:from:to:cc:date:in-reply-to:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mZK6LeX7z5VZYct/x3qbpKzfYxbIlheF7rhtEPOT3/8=;
  b=YopsUGqBAzz5Zvy1XgK4kK/9Kh4cr9LKcBRtdEV8Dk8i4POXv/yFwm6I
   RT2m9nOPVBtIKgViDOmLIkpjSuNa3/Bc2Kxf0wCvPQkR0ZSxNmm7Ju4v6
   2X1KiJ9tcIX65bSPEDvh5wuRzWCuSOqzkCCs757Y2FilawoRqK/JJbabG
   E=;
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
   d="scan'208";a="95427782"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2023 17:40:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D63A5E4EBB; Sat,  4 Mar 2023 17:40:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DFFBDE00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 17:41:33 +0100 (CET)
IronPort-SDR: 63fcdd3b_0YZf3IPzLvBsb/jHjGPdfVlWfsojIhRCleAAr+KBcbIz8Yx
 Ar0qjDdj7BPYVtx72z4wmppIGQtJelRGrCzFYJg==
X-IPAS-Result: =?us-ascii?q?A0FcAwAj3Pxjf6mgVdFaHQEBAQEJARIBBQUBgg+CLYFfL?=
 =?us-ascii?q?gRRk06CJQOLVZMyPg8BAwELAQFCAgQBAQMEOIRGAoUwAh0HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBGQkZBw4OBSSFaA2CNykBd?=
 =?us-ascii?q?U0DOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEEAn45A?=
 =?us-ascii?q?QEdAQEBAQIBEhUZARsdAQMBCwYFCw0JJQ8BExEBBQEcBhMihUoBAw4jA6Beg?=
 =?us-ascii?q?QRCijiBeRYFAhaBAYIJBpwKChkoDWgDgVsCBwkBCIEuhFiHaINzeicbgg2BF?=
 =?us-ascii?q?YMqPosDBJVMAQMCAgMCAgMGBAICAgUEAgECBAIOBA4DAQECAgEBAgQIAgIDA?=
 =?us-ascii?q?wIIDxMDBwIBBgUBAwECBgQCBAELAgUCCgECBAECAgIBBQkBAwEDAQwCAgcCA?=
 =?us-ascii?q?wUGBAIDCQUCAQEDAgICDQMCAwIEAQUFAQEQAgYECQEGAwsCBAEEAwECBQcDB?=
 =?us-ascii?q?wMCAgICCAQSAgMCAgQFAgICAQIEBQIHBgIBAgICBAIBAwIEAgIEAgIEAxsCA?=
 =?us-ascii?q?wUDDgICAgICAQkLAgMHBAIDAwEHAgICAQwBAxgDAgICAgICAgEDBwoECQQCB?=
 =?us-ascii?q?QECAQQLAQUBDQQBAgICAgIDAgEBAwYIBgMKAgcEAgMDBgkPDwgFAwEEAwIDA?=
 =?us-ascii?q?gEICwIDAgICBAgCAwECAgEGAgMBAgIBAgIBCwEBAgMFAgIRAQICAgICAQECA?=
 =?us-ascii?q?wIDAQcBAgIYBgQFAwMFAgIBBAECAgQEBQsCBAMBAQECAgICAwILAwUDAQYDA?=
 =?us-ascii?q?woHBAEIAgYDBAIFBAMEBAYCAgICAgEEAQYLAwIEBAMDBgMJAgIMAhQCEAQGA?=
 =?us-ascii?q?QQLCwIEAgIBAgICDgMEBgIDAwICBQkCBAICAgICAwYCCQQCAgMCAQICBAECB?=
 =?us-ascii?q?BQPAwMCIAMZKx0CCQMjDwMLCQgTFygGDAc0BDQBFBIHBwYmAQEFDgYCBgMEA?=
 =?us-ascii?q?QoLBQQFCAECAQEGAgQCBwkMAgEGAQUCAgMCAQQBAgEGAwECAgICBQcFAwQFA?=
 =?us-ascii?q?wkKAwEBBAMCAQIBAgMCAwcDAgQCAwECAwQGBgEJBAYFDQMEAgIBAgEBAwQEB?=
 =?us-ascii?q?AICAQICAwEEAgIBAQMDAwICAgMEAgMDCwQKBwMDAgEFCwQCAwIBAQMBBgkEA?=
 =?us-ascii?q?gIGAQIEAgICAgICAwEBAwkEAgEDAgIEAwYCAQIBCQUCAQkDAQIBAgEEAQMJA?=
 =?us-ascii?q?QICBAkCAwcFCgICAgIIAgIOAwMCAQEEAgIEBQkBAgcCBQEBAwUHAgIBAgIBB?=
 =?us-ascii?q?AMBCQQBAgMCAQEDEgMDAQQCBQMDDQkGAgIBAwIBDQMBAgECAwEFBRcDCAcUA?=
 =?us-ascii?q?wUCAgQEAQcCAgMDAwIBAgkGAQMBBQIOAwICBAYBAgEBAgMPBQEBAQEXAQMEA?=
 =?us-ascii?q?gMBBAMBAQIBAgMCDgQBBAUMAxwCBAEICAICAwMBAgMFAQIDBAIBCAoCAgICC?=
 =?us-ascii?q?QIKAwIDAQMFAQMCCQMBBQECBwIGAQEBAgICBgIIAgMLAQMFBgIBAgIBBQIBA?=
 =?us-ascii?q?gIFAwUCAgICBA0CBQICAgUBAgcEAgICAwECAgYFAQIHBwIFAgICAwMKBAQHB?=
 =?us-ascii?q?AEBAQIBAQUBAgEDAwECBAECAQIFAwYCAgICAQICAQEBCAICAgICAgMEAgiZY?=
 =?us-ascii?q?hVeLjkzcTiWSQGNY59QC2SDH4FVgnqcKDKXA5I1l1midg6EagIKBwYQIxKBR?=
 =?us-ascii?q?COBXDMaCBsVbII2TwMZD44gg3KQBjQ0OwIHCwEBAwmFQyYThVIBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:R4LyC65fVkb5BsCIuwPXwBrXdLJyesId70hD6qm+c20zTiX4rb
 HSoB1/73XJYVkqKQgdcLy7Scy9aFPasYV4+IwAeaqlNTOWwFdAT7sSl7cKoQeQYBEWn9Q1vc
 wBT0E9MqySMbETt6fHCWKDYrAdKbe8gcSVrNvFw2woRQ9nbLwI1XYaNu9ZKCFLrct9aKbR2K
 Dy2iOPnVSdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="94571616"
X-MGA-submission: =?us-ascii?q?MDESp6qTSRYCpv6sOZGRMW5GEZAzNkcsrMc6kh?=
 =?us-ascii?q?tDBzUrcUPbdHmSqI38C1WQH1Ef/u6knzqBP4tJ6Sb6p63Z3CWLFAcOFV?=
 =?us-ascii?q?NrVVUF+ogAUKrSrYlbUQ/KhVND8n3mQjqEtaqCLUPTeNMC+LaHut6ipO?=
 =?us-ascii?q?fzzMHQNMib4dd4FV5zPnBYOQ=3D=3D?=
Received: from mail-qt1-f169.google.com ([209.85.160.169])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 17:41:32 +0100
Received: by mail-qt1-f169.google.com with SMTP id c19so7248433qtn.13;
        Mon, 27 Feb 2023 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mZK6LeX7z5VZYct/x3qbpKzfYxbIlheF7rhtEPOT3/8=;
        b=I5O5uZecNoO8yiPrQ8I40mdCE2jF9q9/jiCuSWkn4+4XpmLRp6+E/uHofwQaLm2tKK
         BaVnbOA0Cc9zD8CF4+vfUiUHAywVdR86dilzPLPVrpFT34+JzzZ4Z9yDWHUlsDoXXJNd
         9bW5z5455LPCpwyNQdPZ2JvvCTB4jMKcKizffH9BCrQQYp5XcRnxXZU9sfOUimoyOOta
         JFI7yKFKEUKijQTaQRm0VJAL74GrJ7viAQ+dm+tNQsOD+886Yo+IqDruoTecf767/50i
         vEr69rXB+xhsv00T1m9MRCWegS9EEYfzZM6x1YVnsD6qH9fV7pH/Uaz0jSTdnnMrQcpz
         1MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZK6LeX7z5VZYct/x3qbpKzfYxbIlheF7rhtEPOT3/8=;
        b=LcIOhckgGaIag1PSr2OrSm/D43wpkB9cnusMzUaGFMD1U24XIwrGLIFevTIBjYDanl
         KQ3UtdNl8CLDPRpTBMGJNMvpbqsyRDgb34Fagn1PpfnExM/OgsjTockBbMFaQWD6rE2Q
         QgWtgqUheSckYx5s/OITpFFIPDfMo+7YHnxtQHNR64ZUymrYWE2NErwZ9pt79X1m4K5u
         XXnvYug5TN2bTBK8xWx8ONH4MVyUJLZTELwqHzATcAQhnSAhhWJO7gLrKeaBSb/8E91p
         u0gB3TOQGcxZ/QkQSEzBSDGNwH9Ng+55t4amgTlwRpPOCtxBMbCsmExOFSwGIUngyhPX
         GgAA==
X-Gm-Message-State: AO0yUKVMY29wBdo6yTO+yzd8Y6WT5Z/dEVROsZacc2JuArXcH375OoVG
	lM2bOYt3+8d+pBzuzFlt5cw=
X-Google-Smtp-Source: AK7set8dfzlW7a/WkPN2lUpzoC8W7qX3y3mq+kVuU0A3p0XBKYanpamyYslp9JtVHLn56Xh34vZOSw==
X-Received: by 2002:ac8:5803:0:b0:3b6:2c3b:8c00 with SMTP id g3-20020ac85803000000b003b62c3b8c00mr44096137qtg.66.1677516091850;
        Mon, 27 Feb 2023 08:41:31 -0800 (PST)
Received: from ArchLinux ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87108000000b003bf9f9f1844sm4869361qto.71.2023.02.27.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:41:31 -0800 (PST)
References: <20230227075346.69658-1-schspa@gmail.com>
 <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
 <20230227102808.2cea9705@gandalf.local.home>
 <Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
 <20230227105310.08d9a46e@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.2
From: Schspa Shi <schspa@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 cocci@inria.fr, mcgrof@kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, buytenh@wantstofly.org, johannes.berg@intel.com,
 gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch
Date: Tue, 28 Feb 2023 00:36:26 +0800
In-reply-to: <20230227105310.08d9a46e@gandalf.local.home>
Message-ID: <m2mt4z5adr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC PATCH] cocci: cpi: add complete api check script
Reply-To: Schspa Shi <schspa@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 874
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/m2mt4z5adr.fsf%40gmail.com>


Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 27 Feb 2023 16:43:59 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Mon, Feb 27, 2023 at 10:28:08AM -0500, Steven Rostedt wrote:
>> 
>> > So what exact race are you trying to catch here?  
>> 
>> on-stack copmletion with a wait_for_completion that can return early
>> (eg. killable, interruptible, or timeout) can go out of scope (eg, free
>> the completion) with the other side calling complete() on some possibly
>> re-used piece of stack.
>> 
>> IOW, Use-after-Free.
>> 
>> Care must be taken to ensure the other side (whatever does complete())
>> is either terminated or otherwise stopped from calling complete() on an
>> out-of-scope variable.
>
> I got that. But as you were stating as well, when care is taken, the script
> appears to still report it. The example I gave has:
>
>         req = blk_mq_alloc_request(q, REQ_OP_DRV_OUT, 0);
> [..]
>         req->end_io_data = &wait;
> [..]
>         hba->tmf_rqs[req->tag] = req;
> [..]
>         err = wait_for_completion_io_timeout(&wait,
> [..]
>         spin_lock_irqsave(hba->host->host_lock, flags);
>         hba->tmf_rqs[req->tag] = NULL;
>         __clear_bit(task_tag, &hba->outstanding_tasks);
>         spin_unlock_irqrestore(hba->host->host_lock, flags);
>
>
> And where the complete is:
>
>         spin_lock_irqsave(hba->host->host_lock, flags);
>         pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
>         issued = hba->outstanding_tasks & ~pending;
>         for_each_set_bit(tag, &issued, hba->nutmrs) {
>                 struct request *req = hba->tmf_rqs[tag];
>                 struct completion *c = req->end_io_data;
>  
>                 complete(c);
>                 ret = IRQ_HANDLED;
>         }
>         spin_unlock_irqrestore(hba->host->host_lock, flags);
>
> So the spinlock is making sure that the complete() only works on a
> completion if it is still there.
>
There is nothing wrong with your code.

This script will not check the hba->host->host_lock lock, and there is
another hba->outstanding_tasks bit mask to ensure that there is no UAF
here. But this script doesn't have a way to get these implicit
conditions.

> I guess I should have asked, how is this script differentiating between
> where there's a problem and where there isn't.
>
> If you remove the spinlocks, then there would most definitely be a race,
> and I'm not even sure if the supplied patch would improve this much.
>
> -- Steve


-- 
BRs
Schspa Shi
