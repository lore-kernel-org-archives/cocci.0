Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5061CC44501
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TFphORjWZeHwwDGWo745fQA9tbBob0RIjzx2rIybyKQ=;
  b=SGlNn4rGPc/+1v5qR16H6qvlw6b5JI7MkNl+CxcMk5XmOB2hZVG6vidd
   h/3TeFrSJK2XLSXZce1flfBNN8lW/YYC0CW1Q4xIyZnb0KD9SQOQNgViQ
   4nNnwsToSYlECk/UvQOsJuCALYE4HOxCMX2VDFfQ8sE+6RfKTaFXAAyix
   A=;
X-CSE-ConnectionGUID: CFmJZDGSRDGvuQ/K4ilWOQ==
X-CSE-MsgGUID: SmNX8w+MRROdjuTSAIALCg==
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
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259634351"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 12:14:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E04B2818C7; Wed, 21 Jan 2026 12:14:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BF45F818C7
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 12:14:35 +0100 (CET)
X-CSE-ConnectionGUID: ghf8VVmtSay/IjZNpdU0ZQ==
X-CSE-MsgGUID: uPwvaW/DQ8Or2xXQ63ROKQ==
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259634338"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 12:14:35 +0100
Message-ID: <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
Date: Wed, 21 Jan 2026 12:14:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <87v7i7g615.fsf@mmap.at>
 <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Pre-compiled spatch links against EOL PCRE version
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3292
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/vjr2OE0blIMZZtFpb6OG6Q>

Hello,

Work on PCRE2 has been completed - I've finished what Olaf's started.

The patch is on master (b231de0db). Feel free to send feedback if you 
notice any issues once this becomes a release.

Victor

On 12/16/25 15:35, Victor Gambier wrote:
> Hi Manuel,
>
> Thanks for the report. You're right, we should move to PCRE2.
>
> Olaf Hering suggested a patch earlier this year to do just this and I 
> forgot about it until now. I'll work on reviewing and merging it.
>
> Victor
>
> On 12/15/25 15:43, Manuel Wiesinger wrote:
>> Hello everyone,
>>
>> The pre-compiled binary provided on the Download page [1] links against
>> libpcre.so.3. This library is unmaintained by upstream [2] and not
>> available on recent distributions, including Debian 13 [3], RHEL 10 and
>> Arch Linux.
>>
>> I have been using spatch linked against PCRE2 (/usr/lib/libpcre.so.1)
>> extensively for days without any issues on Arch Linux.
>>
>> [1] 
>> https://coccinelle.gitlabpages.inria.fr/website/distrib/coccinelle-1.3.1-bin-x86.tar.gz
>> [2] https://www.pcre.org/ (See Versions)
>> [3] https://lists.debian.org/debian-devel/2021/11/msg00176.html
>>
>> Take care,
>> Manuel
