Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F47C3601A
	for <cocci@archiver.kernel.org>; Sun,  6 Apr 2025 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OvvDo4pyralnF/L14UJqE2wJZmyUK1M1zJPti7+rMsc=;
  b=F0TEee3ysRpeUfo9cJEUMFbSoJL9Eptqi3OnsJ9BAStt3aSvSis/1Nhr
   +D63nMtsXV5gGoDqJv4Mo+WQcak3e/+zwkqWAOylIkeDYcDGUFaY/B9fX
   KN8dxVDLF8qXXekAhifv0645gqxLGn9uyWI9lp++b3MpUei3bDTvCQn57
   k=;
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
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="216550904"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2025 16:07:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC6C7E0264; Sun,  6 Apr 2025 16:07:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4CEB3E007A
	for <cocci@sympa.inria.fr>; Sun,  6 Apr 2025 16:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OvvDo4pyralnF/L14UJqE2wJZmyUK1M1zJPti7+rMsc=;
  b=WbRGHtmxk05E9NoDfDYKkAlrTs4KAzIUJ6xereeMXW73/Y8GD9Ivpw0I
   SiVw5HoHL9q9Lv0DLWhb9AxVTqCZStb11wXf0BTw5USx+XJrf1QJLhKdr
   Sjkbde0jht8Hw+VBV+5HMjLQvJ+vl3SNWv7vN1R9cPITJNEPILqilKGdF
   4=;
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="216550903"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 16:07:17 +0200
Date: Sun, 6 Apr 2025 10:07:15 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Luis Chamberlain <mcgrof@kernel.org>, kdevops@lists.linux.dev, 
    cocci@inria.fr, gost.dev@samsung.com, Davidlohr Bueso <dave@stgolabs.net>, 
    Jan Kara <jack@suse.cz>, Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <dc6b7ff7-8da7-4d02-8fb4-52593137bf11@web.de>
Message-ID: <6418648b-ade1-93af-c7e1-d41578ad3d3e@inria.fr>
References: <20250403020123.1806887-1-mcgrof@kernel.org> <dc6b7ff7-8da7-4d02-8fb4-52593137bf11@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-270754257-1743948438=:3229"
Subject: Re: [cocci] [PATCH kdevops] scripts/coccinelle/generation: add
 example generation script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2685
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/6418648b-ade1-93af-c7e1-d41578ad3d3e%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-270754257-1743948438=:3229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 6 Apr 2025, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/generation/check_for_atomic_calls.py
> > @@ -0,0 +1,443 @@
> …
> > +header = f"""// SPDX-License-Identifier: GPL-2.0
> …
> > +/// Detect atomic context in ANY transitive caller (up to {max_depth} levels)
> …
> > +virtual after_start
> > +virtual report
>
> Can any code refinements trigger desirable effects?

How should I know?  If you want these changes to be made, do some
performance tests and show that this is beneficial in some way.

> +virtual after_start, report
>
>
> …
> > +@irq_handler_def@
> > +identifier fn;
> > +@@
> > +(
> > +DEFINE_IRQ_HANDLER(fn, ...)
> > +|
> > +DECLARE_TASKLET(fn, ...)
> > +)
>
> +(DEFINE_IRQ_HANDLER
> +|DECLARE_TASKLET
> +)(fn, ...)

Intuitively this is of no benefit, because Coccinelle will generate the
first case internally.

>
>
> …
> > +@irq_func_names@
> > +identifier fn =~ "(_irq|_intr|_isr|_napi|_poll|_tasklet|_softirq|_bh)$";
> > +@@
>
> +identifier fn =~ "_(?:i(?:rq|(?:nt|s)r)|napi|poll|tasklet|softirq|bh)$";

I would imagine that a regular expression compiler would generate the same
code in both cases.

julia

>
>
> …
> > +@interrupt_prefixed@
> > +identifier fn =~ "^(irq_|intr_|isr_|napi_|poll_|do_softirq|tasklet_)";
> > +@@
>
> +identifier fn =~ "^(?:i(?:rq|(?:nt|s)r)|napi|poll|tasklet)_|do_softirq)";
>
>
> …
> > +@atomic_name{level} depends on after_start exists@
> > +identifier virtual.transitive_caller;
> > +identifier atomic_fn =~ "(_irq|_intr|_isr|_napi|_poll|_bh|_softirq|_tasklet|_atomic)$";
>
> +identifier virtual.transitive_caller,
> +           atomic_fn =~ "_(?:i(?:rq|(?:nt|s)r)|napi|poll|bh|softirq|tasklet|atomic)$";
>
>
> …
> > +++ b/scripts/coccinelle/generation/check_for_sleepy_calls.py
> > @@ -0,0 +1,678 @@
> …
> > +    f.write(f"""// SPDX-License-Identifier: GPL-2.0
> …
> > +def register_sleep_point(caller_func, sleep_func, file, line, reason=""):
> …
> > +        if reason:
> > +            message = f"{{symbol}} {'VERIFIED' if expected_to_sleep else 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} - {{reason}} (via {{sleep_func}})"
> > +            path_message = f"   Call path: {{path_str}} → {{sleep_func}}"
> > +            print(message)
> > +            print(path_message)
> > +        else:
> > +            message = f"{{symbol}} {'VERIFIED' if expected_to_sleep else 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} (via {{sleep_func}})"
> > +            path_message = f"   Call path: {{path_str}} → {{sleep_func}}"
> > +            print(message)
> > +            print(path_message)
>
> +        if reason:
> +            message = f"{{symbol}} {'VERIFIED' if expected_to_sleep else 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} - {{reason}} (via {{sleep_func}})"
> +        else:
> +            message = f"{{symbol}} {'VERIFIED' if expected_to_sleep else 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} (via {{sleep_func}})"
> +
> +        print(message)
> +        print(f"   Call path: {{path_str}} → {{sleep_func}}")
>
>
> > +        # Store this for our final stats
> > +        if path:
> > +            path_value = path_str + " → " + sleep_func
> > +        else:
> > +            path_value = caller_func + " → " + sleep_func
>
> +        path_value = " → ".join(((path_str if path else caller_func), sleep_func))
>
>
> …
> > +@check_sleep_names@
> > +position p;
> > +identifier fn;
> > +identifier sleep_fn =~ "(_sleep|_timeout|_wait|_block|_sync|_lock|create_|alloc_|_kmalloc|_mutex)";
>
> +identifier fn,
> +           sleep_fn =~ "(?:_(sleep|timeout|wait|block|sync|lock|kmalloc|mutex)|(?:create|alloc)_)";
>
>
> > +@@
> > +fn(...) {{
> > +  <...
> > +  sleep_fn@p(...)
> > +  ...>
>
> May the search pattern be really optional here?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/fe67e5985c72582553ecde33cd7d6e6c2643ef00/docs/manual/cocci_syntax.tex#L802-806
> https://github.com/coccinelle/coccinelle/blob/4093aad2da23ea5c86916de0a71f43032fc2bb2f/docs/manual/cocci_syntax.tex#L802-L806
>
>
> …
> > +    if sleepy_func:
> > +        message = f"\n\n{{symbol}}: {{caller_func}}() can sleep at {{file}}:{{line}} - {{reason}} (via {{sleep_func}})"
> > +        print(message)
> > +    else:
> > +        message = f"\n\n{{symbol}}: {{caller_func}}() found to may sleep."
> > +        print(message)
>
> +    if sleepy_func:
> +        message = f"\n\n{{symbol}}: {{caller_func}}() can sleep at {{file}}:{{line}} - {{reason}} (via {{sleep_func}})"
> +    else:
> +        message = f"\n\n{{symbol}}: {{caller_func}}() found to may sleep."
> +
> +    print(message)
>
>
> …
> > +msg = f"✅ Generated {outfile} to check if '{target_func}' might sleep"
> > +if sleepy_func:
> > +    msg = f"✅ Generated {outfile} to check if '{target_func}' calls '{sleepy_func}'"
> > +print(msg)
>
> +if sleepy_func:
> +    msg = f"✅ Generated {outfile} to check if '{target_func}' calls '{sleepy_func}'"
> +else:
> +    msg = f"✅ Generated {outfile} to check if '{target_func}' might sleep"
> +
> +print(msg)
>
> …
>
>
> Regards,
> Markus
>
--8323329-270754257-1743948438=:3229--
