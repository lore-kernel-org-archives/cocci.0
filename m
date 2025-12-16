Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BCAD5E36C
	for <cocci@archiver.kernel.org>; Tue, 16 Dec 2025 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6mnRQtOXL/Lx5m0p19XpDSbG4s5kLNm6nFPV+xm13pQ=;
  b=KulOuVlymmSoqalZMnyyTwp6GV/SlSyo3bGPzT5ihAkyAEW7n/9Aqlsw
   L0H4DuBv3rCQf0oqTPNXf+xRSMiyhXR+opvD/2scwY40GBpCS5L/23Syd
   LxUsWF/hIC4ETPpEUTUfl/m93vZ7RZEEJ7M8gBYmAd4DLmvrkobKn+ivc
   g=;
X-CSE-ConnectionGUID: +8vYSJYMRQeTwZ0HdMxV2A==
X-CSE-MsgGUID: 1hGk/1VmQnSeXW0yk53T9Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,153,1763420400"; 
   d="scan'208";a="254720329"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Dec 2025 15:35:54 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 648BE81C6C; Tue, 16 Dec 2025 15:35:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EC05281C7E
	for <cocci@sympa.inria.fr>; Tue, 16 Dec 2025 15:35:52 +0100 (CET)
X-CSE-ConnectionGUID: L0aUAKSLSgm5DZvn7/utQg==
X-CSE-MsgGUID: YrAMiEz/Q2u4XCa/0uM06Q==
X-IronPort-AV: E=Sophos;i="6.21,153,1763420400"; 
   d="scan'208";a="254720317"
Received: from lfbn-idf2-1-636-60.w86-246.abo.wanadoo.fr (HELO [192.168.1.14]) ([86.246.95.60])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 15:35:53 +0100
Message-ID: <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
Date: Tue, 16 Dec 2025 15:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <87v7i7g615.fsf@mmap.at>
Content-Language: en-US
Cc: Julia Lawall <julia.lawall@inria.fr>
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <87v7i7g615.fsf@mmap.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Pre-compiled spatch links against EOL PCRE version
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3264
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/B-ayJ2A23LuTovN6LN7ukQ>

Hi Manuel,

Thanks for the report. You're right, we should move to PCRE2.

Olaf Hering suggested a patch earlier this year to do just this and I 
forgot about it until now. I'll work on reviewing and merging it.

Victor

On 12/15/25 15:43, Manuel Wiesinger wrote:
> Hello everyone,
>
> The pre-compiled binary provided on the Download page [1] links against
> libpcre.so.3. This library is unmaintained by upstream [2] and not
> available on recent distributions, including Debian 13 [3], RHEL 10 and
> Arch Linux.
>
> I have been using spatch linked against PCRE2 (/usr/lib/libpcre.so.1)
> extensively for days without any issues on Arch Linux.
>
> [1] https://coccinelle.gitlabpages.inria.fr/website/distrib/coccinelle-1.3.1-bin-x86.tar.gz
> [2] https://www.pcre.org/ (See Versions)
> [3] https://lists.debian.org/debian-devel/2021/11/msg00176.html
>
> Take care,
> Manuel
