Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513BDCD5BD1
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=abUTWd0IeEUZl5yHHb4AYgNaTki5i5+0wjvbp6NZtTM=;
  b=Wvm1TFTw4vyRFh2GrQHkvctPkryhECUFeW7aIA/JSLWVqezbZnxAPns5
   kzoxqfwlcLAK/Wjy783BMGIZLGWRepFkkaNcvywqO3YwQ7aGzKiAZVeQf
   2++FtOpcdpjc8vsMUu0s0MsiwGXyBrnni10UqWTOrnMhVWsjP/XMFaVQp
   M=;
X-CSE-ConnectionGUID: 6FJuN//RT+it0rCS6J4rCg==
X-CSE-MsgGUID: 94Eljx7sRxOBIIUdzJDzmw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208,217";a="278650562"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 11:32:52 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B99EC816BA; Thu, 28 May 2026 11:32:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 176EF80545
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 08:53:11 +0200 (CEST)
X-CSE-ConnectionGUID: FVWTXnAIQwmadsqbCDQUoA==
X-CSE-MsgGUID: tCRZysZ7Rw+Uh8Z4RM1qwA==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208,217";a="147778897"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:53:10 +0200
Content-Type: multipart/alternative;
 boundary="------------npCJmiaCxwUX00vZV4TeFhHN"
Message-ID: <067a58ea-abe7-46d0-9dfc-9f5e4422db73@irisa.fr>
Date: Thu, 28 May 2026 08:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
 <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
 <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
 <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de>
 <6c02bb11-7816-4258-b2fa-9dc63ef2a268@irisa.fr>
 <44dd7481-648f-4ae2-ad4c-10eb0609fefb@web.de>
 <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr>
 <ad06211-6441-9568-e643-c39df9bf8494@inria.fr>
 <186417e3-b2d4-4f1c-9790-8fd1b836e946@irisa.fr>
 <4221c671-682-68de-9a94-1634364b6685@inria.fr>
 <363a5557-fcfc-4856-b4a9-17bbdadff8b0@irisa.fr>
 <c21e4ca-3771-192d-eb44-80837b4319e1@inria.fr>
 <7670a200-249d-4156-8363-4d24c14be452@irisa.fr>
 <31ba5c26-0ff2-4873-ac8f-d7f93f5cd30b@web.de>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <31ba5c26-0ff2-4873-ac8f-d7f93f5cd30b@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3540
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/veMUpqxR0qsIG9DeYm_Xxg>

This is a multi-part message in MIME format.
--------------npCJmiaCxwUX00vZV4TeFhHN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 08:05, Markus Elfring wrote:
>> I apologize to both of you for the confusion, I do want quote, but I do not want escaped quote (I haven't tried it with escaped quote, but I'm pretty sure it won't be a valid string for GCC).
> I suggest to reconsider known use cases for corresponding quoting
> (in discussed source code variants).
Not sure what you meant here, I am sorry.
>> The attribute I'm working with is taking an optional parameter, which, if present, should be a string (const char *) containing the field name of interest.
> Where would you like to benefit from the knowledge of such an identifier?
My use case is a plugin to GCC where I use this attribute to identify
variables of interest for a specific analysis. To be even more precise,
its purpose is to identify variables (or types) that are known to hold
secret data (cryptographically speaking) in order to run static analysis
to detect misuses of such data (e.g., a call to memcmp). The idea to use
Coccinelle here is to be able to patch the source code of huge code base
in order to run our analysis.

Regards,

Pierrick

> Regards,
> Markus
--------------npCJmiaCxwUX00vZV4TeFhHN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 5/28/26 08:05, Markus Elfring wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:31ba5c26-0ff2-4873-ac8f-d7f93f5cd30b@web.de">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">I apologize to both of you for the confusion, I do want quote, but I do not want escaped quote (I haven't tried it with escaped quote, but I'm pretty sure it won't be a valid string for GCC).
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">I suggest to reconsider known use cases for corresponding quoting
(in discussed source code variants).</pre>
    </blockquote>
    Not sure what you meant here, I am sorry.
    <blockquote type="cite"
      cite="mid:31ba5c26-0ff2-4873-ac8f-d7f93f5cd30b@web.de">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The attribute I'm working with is taking an optional parameter, which, if present, should be a string (const char *) containing the field name of interest.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Where would you like to benefit from the knowledge of such an identifier?</pre>
    </blockquote>
    <span style="white-space: pre-wrap">My use case is a plugin to GCC where I use this attribute to identify variables of interest for a specific analysis.
</span><span style="white-space: pre-wrap">To be even more precise, its purpose is to identify variables (or types) that are known to hold secret data (cryptographically speaking) in order to run static analysis to detect misuses of such data (e.g., a call to memcmp).
The idea to use Coccinelle here is to be able to patch the source code of huge code base in order to run our analysis.</span>
    <p><span style="white-space: pre-wrap">Regards,</span></p>
    <p><span style="white-space: pre-wrap">Pierrick</span></p>
    <blockquote type="cite"
      cite="mid:31ba5c26-0ff2-4873-ac8f-d7f93f5cd30b@web.de">
      <pre wrap="" class="moz-quote-pre">Regards,
Markus
</pre>
    </blockquote>
  </body>
</html>

--------------npCJmiaCxwUX00vZV4TeFhHN--
