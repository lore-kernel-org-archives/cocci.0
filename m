Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F009DC433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4/uSoxt/FX+nv3SXN65QqRG7TsLlfnrufCvAoa5CSCM=;
  b=geVnqIFK5OmwOge0Irz4twPzS3l27rzC1kJQoxRs8L3zSWpObQ3Wyb3r
   ANCe39fQ/kSsY1gi8F9L+XTOXEykq+glOCno7sw315B/kcJZ9VsvXSTNC
   i1P/++fBw1DtxTgt/AuYQ3Vk7heq1PhmujOkMIYuT/h8dxwoLOC9i5/+/
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56681857"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:31:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 685F6E0290; Sun,  9 Oct 2022 17:31:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 99EE3E028F
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:27:06 +0200 (CEST)
IronPort-SDR: 6342e84a_LjSPkCNyk8Mfp1g2KoIYjUa1qUyNwcBPxeOh/PtjuW98KyW
 ooLXaLMYAgHwCs7D4u7lKSBjE5x1OgD75lR/gMw==
X-IPAS-Result: =?us-ascii?q?A0CiAgA050JjkNlUsotaHQEBAQEJARIBBQUBQIFPAoIig?=
 =?us-ascii?q?VcuBAtFhE6Ifpp6jDwBAwENQgQBAYl7Ah0HAQQ1BQ0BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAETAQEBAQEBFgkeHgUihWgNgjUpAYNkBiMdAQE3A?=
 =?us-ascii?q?Q8LCw8CJgICIhMFHQaDEIMhAwOrfoEMJoEBgggBAQaGbH4JgREsAYhQhmV6J?=
 =?us-ascii?q?4IpgUuCdD6IG4JmmhgKAwQGBTgBAgFDHUADC0IxBRgDFAMFIQcDGQ8jDQ0EF?=
 =?us-ascii?q?gcMAwMFJQMCAhsHAgIDAgYTBQICTTQIBAgEKyQPBQIHLwUELwIeBAUGEQgCF?=
 =?us-ascii?q?gIGBAQEBBUCEAgCCCYXBxMzGQEFWQ4JIRwOGg0FBhMDIG8FQg8oL2krHRsHO?=
 =?us-ascii?q?FQqKBUDBAQDAgYTAyACDSkxFAQpEg8tBylxCQIDImUFAwMEKCwDCUAHKCQ8B?=
 =?us-ascii?q?1g6AQQDAhAiPQYDCQMCJFmBKA4YBQMNGSYIBTcaBAg8AgUGUxMCChIDEg8GJ?=
 =?us-ascii?q?0kPSj49nBKnNZ5oBwODXoNKnHIyg2QBkwOSHpcQp2+BeSKBW3CBAQaCME4cD?=
 =?us-ascii?q?44gDBaDUIp9IjQ7AgYLAQEDCYsVAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:bMYJA6tYemHGRY/DiIKD9SoV7skDoNV00zEX/kB9WHVpm6yj+v
 xGUs5rqCMc6QxhJE3I/OrtBEDuewK7yXcY2/h3AV7mZniDhILKFvAB0WKB+UyZJ8SWzIc0vs
 0OHZSWSueAaGSS5vyKmzVQfexQuuVvM5rIuc7ui1loRQFuL4d67wl4DQ6fVml7XhNPC5Z8NL
 f03Ls/m9NtQxQqhw2Adxo4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="25890554"
X-MGA-submission: =?us-ascii?q?MDG728PYNVvumc+83ubcI7v2s73RWNU76wsfXt?=
 =?us-ascii?q?LXkm36yFupzNjlDuyxOGp7pgcSn7c5I2+49UffbxAPUsDJ/sCifdxWP0?=
 =?us-ascii?q?uMpZFDjGS8V7KFaoAN3AjpJFVMOxQWWkEn7hICpv7Fk3rKgRw/9GRUoW?=
 =?us-ascii?q?yjoRysqRKOhFUzIt804UUbzA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:27:06 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D3AF460C09;
	Sun,  9 Oct 2022 15:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001E2C433C1;
	Sun,  9 Oct 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665329221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/uSoxt/FX+nv3SXN65QqRG7TsLlfnrufCvAoa5CSCM=;
	b=lQhwDan8O8em34WetfwAFeCEb1yen9b1zKoCj9rZP5VxXRsIaKhqRNG4sDRG1va5xn+qNu
	SL5E4oQkRgCErzyXLC58ttXWxixdR/XBLwJ159OnBqU07ZzfjkHnL2zCen3lDjKOTxiK1A
	H0Scj/AJ/MAiPfIRaa/wecER0DTYtVQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4b25a60f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Oct 2022 15:27:01 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id k6so7065433vsp.0;
        Sun, 09 Oct 2022 08:27:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf0JfDaX1iSoq2+y4t+R5M/Z/yi8p6+IyCvYp3N1hnZVtsqAZY2E
	2Gg/Z8PSIOccDVs5+4VIvwd8HzvbsPsQYZHiRdA=
X-Google-Smtp-Source: AMsMyM5DVjuDYYSYnsmnYdkuQMyVJfHH5sHxfzbV6n+s/JUZi2DMNngChedXIOpsz6zE21NqI2236DdTG3/b0Mj+73k=
X-Received: by 2002:a67:c297:0:b0:3a7:5f0c:54c4 with SMTP id
 k23-20020a67c297000000b003a75f0c54c4mr4502393vsj.76.1665329220834; Sun, 09
 Oct 2022 08:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com> <alpine.DEB.2.22.394.2210091713270.3091@hadrien>
 <CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F=y3=+rh2Gw@mail.gmail.com> <CAHmME9pzRtsEBFNBvX=j25D8ANUjLHoVxn0fLnFERgr6FR+VfA@mail.gmail.com>
In-Reply-To: <CAHmME9pzRtsEBFNBvX=j25D8ANUjLHoVxn0fLnFERgr6FR+VfA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 9 Oct 2022 09:26:50 -0600
X-Gmail-Original-Message-ID: <CAHmME9rmbS7gfgzbjtzg5NMWO1wi1+opfbLzH--FdEMe77kKog@mail.gmail.com>
Message-ID: <CAHmME9rmbS7gfgzbjtzg5NMWO1wi1+opfbLzH--FdEMe77kKog@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] "reachable by inconsistent control-flow paths"
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 631
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAHmME9rmbS7gfgzbjtzg5NMWO1wi1%2BopfbLzH--FdEMe77kKog%40mail.gmail.com>

Two minimal reproducers:

1)

void blah(void)
{
u16 off;
switch (b) {
case 0:
goto l;
#ifdef x
case 1:
goto l;
#endif
}
l:
off = prandom_u32();
}

2)

void blah(void)
{
u16 off;
goto l;
goto l;
l:
off = prandom_u32();
}
