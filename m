Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF204C3DA6D
	for <cocci@archiver.kernel.org>; Mon, 19 May 2025 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AF8se12e+/nH7BMoJ6KS+39IeIcoCFwaN4y5X7sceMc=;
  b=HKUUpunmS00RHyj7IrERLd2O8qQxtzDMQGkKQdVJCW78ay05MlG52sMl
   lk0t6lkP/7pWMJTwqm3ujAzm7dB7jXEOgMz894gkikcHeZNzJ4yAQqZ1o
   scA5GCMPqH1CTSa/jJdJcEOO+a2yeBj5yHJdrrd6o04p/CGS9ApmBdMrK
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.15,300,1739833200"; 
   d="scan'208";a="222725049"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 May 2025 11:45:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BD277E0131; Mon, 19 May 2025 11:45:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 02EF4E0131
	for <cocci@sympa.inria.fr>; Mon, 19 May 2025 11:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=AF8se12e+/nH7BMoJ6KS+39IeIcoCFwaN4y5X7sceMc=;
  b=HPYVjx9mAh0PRa69GDBoXxRTa6hsCMnsw2bxp9bThoF7wpsyHtl9IT0r
   ISdNfsLP5AD2fKQNGGMPY6AhEaxBN/MZWFUsKML2ZCDkCrPlcB8N3hhAd
   e0ddrqJDP0BoCbqiy+pJTVYxuQVr7Cek2jnoCsh4GN4m1yGXCNghOzF21
   c=;
X-IronPort-AV: E=Sophos;i="6.15,300,1739833200"; 
   d="scan'208";a="116928208"
Received: from lfbn-idf2-1-636-60.w86-246.abo.wanadoo.fr (HELO [192.168.1.12]) ([86.246.95.60])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 11:44:58 +0200
Message-ID: <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
Date: Mon, 19 May 2025 11:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2739
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/6007e0f7-3d15-4490-a000-b10797c9d579%40inria.fr>

Hi,

I believe the installation instructions in install.txt should be useful 
here - specifically the last 2 bullet points of the Ubuntu / Debian section.

It depends on your current setup and what you want to achieve, so I 
can't provide exact instructions here, but if you cannot figure it out 
from the instructions, please provide your OS, the output of `apt list 
--installed` (or the equivalent command of your distribution to list 
installed packages), specify if you're using opam, and the output of 
`spatch --version`.

Thanks,
Victor

On 18/05/2025 10:50, Markus Elfring wrote:
> Hello,
>
> I got into the mood to try another script variant out (like the following) for
> the semantic patch language.
>
>
> // See also:
> // update candidate: c4iw_rdev_open()
> // https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/infiniband/hw/cxgb4/device.c#L908-L909
> @Delete_unnecessary_checks@
> expression x;
> @@
>   if (...
> -    && x
>      )
>      kfree(x);
>
>
> Such SmPL code does not use features according to regular expressions.
> But I observed the following test result with the software combination
> “Coccinelle 1.3-00083-g4093aad2d” on my openSUSE Tumbleweed system.
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci delete_unnecessary_checks7.cocci
> spatch: error while loading shared libraries: libpcre.so.1: cannot open shared object file: No such file or directory
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --version
> spatch: error while loading shared libraries: libpcre.so.1: cannot open shared object file: No such file or directory
>
>
> Under which circumstances can the corresponding software dependencies become
> up-to-date again?
>
> Regards,
> Markus
