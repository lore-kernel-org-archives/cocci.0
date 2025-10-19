Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600CCCCD195
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:references:from:in-reply-to:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=FGuwBldjJUPsc3TsPjyJRnDVBghxHW5up1pTixm0xfI=;
  b=fwTqy0a3qC9mt/i36yeM6KDzihl3PeWemBF2Q6hs5450dLKMjERx+Oh6
   avxNtxQPpOOltGWRza2LI65JndvTtrGx7RF7mYweigwrYQdJXnfqpXPIN
   SJknC2ZL26zTbp+a9yJ77WOb/JUehWUntvkVZpe1yjCDylaEYlZm31Ri0
   Q=;
X-CSE-ConnectionGUID: 4XS4VAQbScaoueMMKPLAhQ==
X-CSE-MsgGUID: cLDMvqevRki1TXpsC83fFQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@chud.cyou
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208,217";a="245026404"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 21:34:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9E537E0264; Sun, 19 Oct 2025 21:34:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D8BFDE0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 21:34:19 +0200 (CEST)
X-CSE-ConnectionGUID: YkMlV+zQTbegAHv8d0p8qQ==
X-CSE-MsgGUID: xn/3d32QQAS/1MYpKQvBLg==
IronPort-SDR: 68f53d3b_GDVOe9+8KlrCeufObOX0rzrjEm8ENGfR9Oki9nJcNbJhkS0
 b5nVGZZcVs6BT+O+MXPmPRlwYu+Wcp1FrGWMryg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GbNQBDPPVo/yIc7sJaHgEBCxIMTIQEgV80BwhJhFWIe?=
 =?us-ascii?q?4dOgSoDhDubXg8BAwENUQQBAYUHAk8Vi2kgBgEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECgQoThhUGNA2CRRqEAwEBAQECASMdAQE4B?=
 =?us-ascii?q?AsLBBQqAgJWGwEBF4JngiMCKCcHrDZ6gTKBAYIMAQEG3CWBZAmBSoVtgmQBK?=
 =?us-ascii?q?oE0AokEQoE7UoE8gwM+gVABgz+DDoJpgiZ6FB2GEZEtUnIiAyYzLAFVExcLB?=
 =?us-ascii?q?wWBIEMDgQsjSwUtHYEnIh8cE2BUQINJGwZoDwaBExlJAgICBQJCOoFpIgYfE?=
 =?us-ascii?q?gIDAQICOlcNgXcCAgSCMYEQgikPhkICAQttPTcJCxsGkxpbgnQGgQ8LgSaBO?=
 =?us-ascii?q?DqjCIE2oXQFhCaBZIMMnGwGDwQvgUupIJkGqUGBfyaBWTMaCDCDIk8DGQ+EK?=
 =?us-ascii?q?Yl4hCfHRkQyPAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 /DKhOT4KCpOtdnF+tZOXqDp
IronPort-Data: A9a23:z+Sc/K3Aknwc53KBFfbD5Zt1kn2cJEfYwER7XKvMYLTBsI5bp2MGy
 TMaD2qDOf6MN2qnKtx/aYm19U0BvMTXnNcxQAdp3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyazN8B56r8ks14a2q4WJA5DTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID/6vTqjnVaPpcTbJLwW28P49m6t4wZJ
 OF2iHCFYVxB0psgNwgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lXxOmg9z10ouHQORjr+Q9fMWzJNMGgyQ1pd3ZJa5OrZHrRrWM7t9F0HE7l8dTdRrcT
 5NINXw1N0SGOU0JYQt/5JEWxI9EglH2dTpegFmVuKZx6HnU0WSd1ZC3bIeNIILRFJQ9ckCwt
 mSBpGiiWCgjHefYkB+06lGVmMXrknauMG4VPOTirq462jV/3Fc7AxodXlqTuui8kkf4WtRFK
 kVS9DBGkEQp3EerU9W7VAy/vRZooyLwRfJhEMg+1kKf85be7gmwJnZUQmZZOMUf4ZpeqSMR6
 rOZoz/4LWUw7uXFFi/Bruf8kN+kBcQCwYY/ic44oegtuYWLTHkb1E6nczqaOPfdYx2cMWiYL
 8q2hCY/na4PqsUAyr+2+1vK6xr1+caRHldvvVuGATP1hu+cWGJDT9PzgbQ8xakbRLt1snHb5
 iJe8yRjxLFVV8HXyERhvs1WROrxvZ5pzwEwcXY2RcFxp27FF4+LYY1K+jhiPk5vKccYMTbmC
 HI/SisOjKK+/RKCM8dKXm5GI55ylPW5S4y7CKu8gxgnSsEZSTJrNRpGPSa4t10BWmB1+U3mE
 cbHK5SfHjwBBL55zTG7Ye4Y3PV5jmo93G7fD9SzhRiuzbPUNjbfRKYnIWm+SLkzzJqFhwHJr
 PdZFc+BkCtEXMPEPyL4zI80LHIxF0YdO6zYkcJsW9S4ElJUI115U/716pE9SrNhhJVQx7vp/
 Gnie0p2y2jfpHzgKCeIY1Bda5fqe8t19k86GQcOPl+Y/WcpTqjyzaUYdroxJaIG8s46x9FKb
 vA1QeeyKdURdW2f4BUbT532jLI6RSSRnQjUYhaUOmkuTaBvVyni24HCfDK20AIsEyDul881g
 4P45zPhWZBZGjhTVpfHWsmOkWG0k2MWwt9pfk3yJdJWRkXg3a5qJwH1jd41O8s8EgrC9BTLy
 zepBQokmseVr78X6NXpgYW2n7WtGcZ6HWtYGDD/xpSyPi/44GGi4NFhVMClQDPjb173qZ6SP
 bht8/LBMfM8jAlrtah4GO1V1q4Q3YbkiIJb6QVGJ0/1SWqXJIluGVS4+PVel7Zsw+ZZsDSmW
 0jU9dh9P66ICfzfE1UQBVQEa73f8fQynTXt1OkEe0Hk6BRW55uCa11ZZDOXuRxeLZx0EYIr+
 vggs8go8D6CigImH9KFryJM/VS3MX0LVps4uqEgAIPEjhQhzndAa8f+DhDazY6uadIWFGUXO
 R6R2bT/gopDynr4c3YcEWbH2cxfj88svDFI1FozGESbqOHah/MY3Axjzhpvd157li546uNUP
 nRnE2ZXJq/Upjdhu5VlblCWQgpEAEWUx1z1x143j1bmdkiPVFHWDWgDKO2IrVE48WVdQ2Bhx
 4um6l3ZCBTkQMKg+REJex9Bi+fiRtlP5AH9iJiZP8CaLaIbPxvhoIGTPFQtlTW2L/81tkP9o
 ctSwN1Rcoz+bC4ZnL06AdKV1JMWUxG1G1ZBSvBAooIMO2bQRwiv6GOKNUyKW9hsIsbS+hSSE
 P1eJcNoVjW/2h2RrzsdO7U+Hr9skNMt5/sAYrnbHnEHuL6hsTZZipLc2SzgjmsNQd81s8ICB
 q7OVjCFSEq8uGB1njLTkcx6JWaIW9kISwni1uST8u9SNZYisvlpQH4iwImPoHSZHwt2zS265
 DqZSfft8NVj7oBwk6/HMKZJXVy0IOyuctW4ylm4ttAWYO7fNcvLiRgulWDmGAZrJpoUZcV8k
 OWckdzw3X6dho0MbULip8CjGZVKtOKIZ8gGAvKveTMe1WGHVdT36hQOx3GgJNYb2JlB782gX
 E2jZNH2adcRXMxHyWZIbzRFVSwQELnzcryqsBbVQy5g0fTB+VevwBKbGX7VgaVzcz9OMJ3jB
 kn/qvGzjjydhJoZHwcKXpmKHLchSGIPm4N/HzEyidVcJmKon1/EsarliHLMLBnVX2KcHp+SD
 Y3tH3DDmdfbhE0M5NpZroA0tQwQER6RRAX2kl01o7ZLttxxMILKwSnx/3nL5lG4XxEeDK3FW
 Qw=
IronPort-HdrOrdr: A9a23:pwfaM64adjz9gVrX9APXwOHXdLJyesId70hD6qkDc20tTiX4ra
 CTdZEgvnHJYVkqKRMdcLy7SdG9qDbnhOVICOsqTNSftWDd0QOVBbpv54vv3DHscheVl9K1l5
 0QFZSWY+eAaWSS4/yKhzVQX+xQpeVv6JrEuQ7F9RtQpB9RBJ1d0w==
X-Talos-CUID: =?us-ascii?q?9a23=3AGiR302m0jhZL2tAHIXF6NBZZVkHXOUze6XPuYF2?=
 =?us-ascii?q?BNWxkR5S1Vw+coLs0ivM7zg=3D=3D?=
X-Talos-MUID: 9a23:rrpr0grzJhPEaD2lfPgezyFkc5xkuP6XMWk21swjitGnDDJaHzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208,217";a="245026399"
X-MGA-submission: =?us-ascii?q?MDH9w+WaTRpc8lEM1LuPuE0+IKzWoFZyfz87rM?=
 =?us-ascii?q?msAZQKvrYL/PAl6/9xZ3ZeB5JFUf1MKtNo/mVlLv0uRR79iyxhha/k2N?=
 =?us-ascii?q?R7xaMFdHF1x1W6ekWzk0LTBWaaPyXmLcx9Ip5iOhU1zwLwdWNDDHPIby?=
 =?us-ascii?q?d2FHsfXDGs/5AkritiijAsCw=3D=3D?=
Received: from chud.cyou (HELO mx.chud.cyou) ([194.238.28.34])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 21:34:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chud.cyou; s=mail;
	t=1760902456; bh=+Z5r7Z0XStxKZtxZYAYdywCfQ3KcnaYa5FCfu0m9Xro=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=yNTGzk1hk4U0X7muBCm2YiO/Myj7PdT+53LQIyjOliuJ12ETc3dYTMPh8v1SoDdXQ
	 Gu72UQQxV+4/c2nowTcJLdEH5LU4epQtudsUUlpOBZPdZc+AUYKPyHePYXiy0OdxSs
	 kruWR7E2HTiNHlegfeCkejuytJPTyJeZFIbOJ/4tPTv8kr3iBNUp7HDA/h8beYIjjh
	 aAm32sVfObf6NJJpHg8m3K7Nq2e4CaDUfwCiDjawFzQyt/D/D1kShp79Bt/plO2wFG
	 b1wy4Nkz+ShO3o0z1AhnYPoFx6C7mrZIaF754a+E5g7+7B3OCivkxmFV5Y2Kc1t35G
	 jr2DSC36dDKZw==
Recieved: hidden
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chud.cyou; s=mail;
	t=1760902455; bh=+Z5r7Z0XStxKZtxZYAYdywCfQ3KcnaYa5FCfu0m9Xro=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qoiei/IcfCfuL/yTlFAh4F6GbTB47BfPqp1u5rEofh/t3lyRbqSszYbLptvqwxPtF
	 og8m9f4oVNZPEYtgPm/oXvP4kp8GO1bFCCynOaGZmeTY+AGfHP4W5MNckXCOgezWfP
	 Ee6/t7pV3rKU4gIkiG7D8BYOasMA/5a38B7D9h/jZM+KIPk76YCLqIYU2xpvXzYEgp
	 I/3THTxvcU1K4kL/WNNgUBf0SZJZdqs7L57oY7UN5k4CIbKG28LI+pYtz8VdL/gvuI
	 OedS8CH/QEZ41uJCbYaBqsooYkHg0HS1Lx6+gm8IiBJnjOxA1o+8A2dAptiqFTqnia
	 hyi8y/AMpi7Uw==
Recieved: hidden
Content-Type: multipart/alternative;
 boundary="------------kN9wFs7ZPDMFkM0h2UoDjB0u"
Message-ID: <0340ae74-dffc-408e-952a-85a30b6ba4d5@chud.cyou>
Date: Sun, 19 Oct 2025 21:34:16 +0200
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
 <a38c126f-8a35-343-f7d0-d2a0da17f521@inria.fr>
Content-Language: en-US
From: Anon Anonson <anon@chud.cyou>
In-Reply-To: <a38c126f-8a35-343-f7d0-d2a0da17f521@inria.fr>
Subject: Re: [cocci] Possible bug
Reply-To: Anon Anonson <anon@chud.cyou>
X-Loop: cocci@inria.fr
X-Sequence: 3086
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/0340ae74-dffc-408e-952a-85a30b6ba4d5%40chud.cyou>

This is a multi-part message in MIME format.
--------------kN9wFs7ZPDMFkM0h2UoDjB0u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 11:37 PM, Julia Lawall wrote:

> I guess one could go either way on this.  Normally, a for loop header has
> the form
>
>   for ( ; ; )
>
> So the semicolons are part of thr for loop header, not part of the
> declaration.  So that's why your pattern doesn't match.  I think that
> currently the only solution is to make a special case for for loop
> headers.
>
> julia

I see. That works, thank you.
Any plans to change this? Seems like a bit of a footgun.


On 9/16/25 10:25 AM, Markus Elfring wrote:
> Can such a source code transformation approach ever work without the specification
> of the semicolon?
>
> @Renaming@
> @@
>   int
> -old
> +new
>
>
> Regards,
> Markus
Seems logical and useful.
Not sure whether it has problematic implications.

Similarly, is there a specific reason that:
@@
@@
- i
+ h

only matches uses, but not declarations of `i`?


On 9/16/25 10:00 AM, Markus Elfring wrote:
> Would you like to support any restrictions where anything should not be renamed accidentally?

If possible.
I was considering a solution where shadowing ambiguities would be 
resolved by providing a line number to my tool.
Then, an intermediate file with an inserted "marker pseudo-macro" would 
be used during matching.
E.g.:
@ rn_target @
type T;
identifier I = i;
@@
- T I; RENAME_TARGET;
+ T I;

@ rn_id depends on rn_target @
identifier I = rn_target.I;
@@
- I
+ h
However, it appears that `I` refers to the name and not the lexical 
variable.

--------------kN9wFs7ZPDMFkM0h2UoDjB0u
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font color="#99c1f1">On 9/15/25 11:37 PM, Julia Lawall wrote:</font></p>
    <blockquote type="cite"
      cite="mid:a38c126f-8a35-343-f7d0-d2a0da17f521@inria.fr">
      <pre wrap="" class="moz-quote-pre">I guess one could go either way on this.  Normally, a for loop header has
the form

 for ( ; ; )

So the semicolons are part of thr for loop header, not part of the
declaration.  So that's why your pattern doesn't match.  I think that
currently the only solution is to make a special case for for loop
headers.

julia</pre>
    </blockquote>
    <p>I see. That works, thank you.<br>
      Any plans to change this? Seems like a bit of a footgun.</p>
    <p><font color="#99c1f1"><br>
      </font></p>
    <div class="moz-cite-prefix"><font color="#99c1f1">On 9/16/25 10:25
        AM, Markus Elfring wrote:</font><span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:76442e22-a848-45ba-8d6c-96d544b8f906@web.de">
      <pre wrap="" class="moz-quote-pre">Can such a source code transformation approach ever work without the specification
of the semicolon?

@Renaming@
@@
 int
-old
+new


Regards,
Markus
</pre>
    </blockquote>
    Seems logical and useful.<br>
    Not sure whether it has problematic implications.<br>
    <br>
    Similarly, is there a specific reason that:<br>
    <font color="#2ec27e">@@<br>
      @@<br>
      - i<br>
      + h</font><br>
    <p>only matches uses, but not declarations of `i`?</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix"><font color="#99c1f1">On 9/16/25 10:00
        AM, Markus Elfring wrote:</font><span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:823b575c-505d-44bc-91cf-f424f9b2e14f@web.de">
      <pre wrap="" class="moz-quote-pre">Would you like to support any restrictions where anything should not be renamed accidentally?</pre>
    </blockquote>
    <p>If possible.<br>
      I was considering a solution where shadowing ambiguities would be
      resolved by providing a line number to my tool.<br>
      Then, an intermediate file with an inserted "marker pseudo-macro"
      would be used during matching.<br>
      E.g.:<br>
      <font color="#2ec27e">@ rn_target @<br>
        type T;<br>
        identifier I = i;<br>
        @@<br>
        - T I; RENAME_TARGET;<br>
        + T I;<br>
        <br>
        @ rn_id depends on rn_target @<br>
        identifier I = rn_target.I;<br>
        @@<br>
        - I<br>
        + h</font><br>
      However, it appears that `I` refers to the name and not the
      lexical variable.<br>
    </p>
    <p></p>
  </body>
</html>

--------------kN9wFs7ZPDMFkM0h2UoDjB0u--
