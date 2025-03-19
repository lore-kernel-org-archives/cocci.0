Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C56C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gMIHlwxyco1A+rM1wOPZE3QQkn6AWKetTxoPcp21tpU=;
  b=GtUmHOpLEAT0V86WMakgcAkf2BiygjcRtqTWh7KYfOmcpiKEhQSkNZp8
   viGwpG68/57EKgvhKe0f7BjcgEgdoUshfj8DRnZWiwquNUa2uHw8w7wCI
   dbahpzj2nWHddSjExOTwx1ujAzo8wB8q0inLoUFhj9D18mCj3cKLpRnTk
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208,217";a="213723615"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 15:15:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 869E8E0D1D; Wed, 19 Mar 2025 15:15:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B021AE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 15:15:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to;
  bh=gMIHlwxyco1A+rM1wOPZE3QQkn6AWKetTxoPcp21tpU=;
  b=PK3H299Lc4SusWW4TyaI9UWyUzT13j8C/ZdyefOLvl4/ubdacX4gYI+Q
   j1bCBU+wdmsNVbbBbs3LCy+pWTl8rqoVlS8ti64wN1dbOkymtXCdA051x
   Pw+sDuD2ELGzm6sMc/m5P0y9AD0ebs6FoNP0SfRLQUidWAQYT2upnyVDS
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208,217";a="112038016"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:15:13 +0100
Content-Type: multipart/alternative;
 boundary="------------p09hUXvT0X3rOSHIjNAiV02W"
Message-ID: <cbc0e8ca-fca0-4533-9351-859dd98bca25@inria.fr>
Date: Wed, 19 Mar 2025 15:15:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
References: <8886034f-43ac-4475-9f16-faa2db8de5de@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <8886034f-43ac-4475-9f16-faa2db8de5de@web.de>
Subject: Re: [cocci] Improving find commands?
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2657
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/cbc0e8ca-fca0-4533-9351-859dd98bca25%40inria.fr>

This is a multi-part message in MIME format.
--------------p09hUXvT0X3rOSHIjNAiV02W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2025 15:06, Markus Elfring wrote:
> How do you think about to enclose file filters by single quotation characters
> (instead of double quotes)?
> https://unix.stackexchange.com/questions/170179/whats-the-difference-between-using-single-quotes-or-not-in-find-command

What would be the point of using single quotes? I also don't think you 
understand what's being said in that link.

Victor

--------------p09hUXvT0X3rOSHIjNAiV02W
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 19/03/2025 15:06, Markus Elfring
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:8886034f-43ac-4475-9f16-faa2db8de5de@web.de">
      <pre wrap="" class="moz-quote-pre">How do you think about to enclose file filters by single quotation characters
(instead of double quotes)?
<a class="moz-txt-link-freetext" href="https://unix.stackexchange.com/questions/170179/whats-the-difference-between-using-single-quotes-or-not-in-find-command">https://unix.stackexchange.com/questions/170179/whats-the-difference-between-using-single-quotes-or-not-in-find-command</a></pre>
    </blockquote>
    <p>What would be the point of using single quotes? I also don't
      think you understand what's being said in that link.</p>
    <p><span style="white-space: pre-wrap">Victor
</span></p>
  </body>
</html>

--------------p09hUXvT0X3rOSHIjNAiV02W--
