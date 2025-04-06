Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EABC3600C
	for <cocci@archiver.kernel.org>; Sun,  6 Apr 2025 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uwigZTDyFPeJg69EKyvejZYzGKbaL4PcG9bMjbiL2Ik=;
  b=LrQkpEC9gneol1xVOgNbnWT+9RW48+ph4LywgKpPdA1UR4m2F199A14o
   QglKoCN/7b3/AgVUxkI6fjdizNt44o8yUIK7+sE49hodIW6GtgcW0VdoU
   tuuQQ0k/LZ8fD7iCEAnBgRergkR6AAvPpQQhbNh66H1YX3FBICQCBvsbx
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="216550452"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2025 16:01:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 654F7E0264; Sun,  6 Apr 2025 16:01:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2A42DE007A
	for <cocci@sympa.inria.fr>; Sun,  6 Apr 2025 16:01:26 +0200 (CEST)
IronPort-SDR: 67f28935_/39jpd/Ce/sHuTdI5FIr+/q2UYwLHljG0k9XVBedburrt8N
 h9pjqWI4PtTOolUx/1/HQ3vXbDJ0gzUTKt20j8A==
X-IPAS-Result: =?us-ascii?q?A0HLAgCwiPJng07ASNlaHgEBCxIMQIFIC4JEfVozBAtIC?=
 =?us-ascii?q?IRNj1GBdC2BFoMomAKBVoF+DwEDAQ09BAECBAEBAwMBgWsBgxQCiykCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4VBB?=
 =?us-ascii?q?zMNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAg06RAIBAyMdAQERJgEPCw4MAiYCAlYGARQBAYJ+AYIvAQMxBw0Gr?=
 =?us-ascii?q?AZ6gTKBAYIMAQEGgVhB2EMfLCJXgWUDBoEaLoVtgmMBhieEPCcPgVVEgRUng?=
 =?us-ascii?q?RSBNzg+gmEBAQKBXoNbgmmCMYEFFo1igxeQDFJ7HANZLAFVExcLBwWBKUMDK?=
 =?us-ascii?q?jQxI1QFMx2BfIN4hTqCEYFcAwMiAYMVeRyDRYEphBNHLU+DM0AdQAIBC209N?=
 =?us-ascii?q?wkLGwY9l2CDdw4TYC0sVIIKHJJmsn80B4I4gWaBYwyKKZU1BhMvl0YOBpJ9m?=
 =?us-ascii?q?H4ijWOWD4UfgWc6gVwzGiSDNk8DGQ+HV4ZKGR+DQjOBC8cVQTUCCTECBwEKA?=
 =?us-ascii?q?QEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 pYDGOYzaQ==
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:Mdn3jqt8PZhKlzS4QISl3UgG7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:MzDSZ26YJlbo0TKIENssrhY5COYpf0bh3TT+LH3hMmlNZbHScArF
X-Talos-MUID: =?us-ascii?q?9a23=3A8aJa1g+Dq5+ezgYEZzAMJReQf9ZS6KK/FngQqo5?=
 =?us-ascii?q?YsfiKGHRhARfA0TviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="216550448"
X-MGA-submission: =?us-ascii?q?MDFC/LzNMBDWSc7G58NezfScMohEGNGuhU9Ues?=
 =?us-ascii?q?Zf5FAnt51OgTFuWdsJdmtkbiKYXUKonyCfbYtXJQet/YG/PqwEyYuyc0?=
 =?us-ascii?q?UWtdSamlcQx/0sIOFj1/fuMhZu/bt7t8o1E+I1VV9faMlAXHKNng/HWF?=
 =?us-ascii?q?iyQCg6I7aiv9EbN8pVKR9NAw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 16:01:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743948060; x=1744552860; i=markus.elfring@web.de;
	bh=uwigZTDyFPeJg69EKyvejZYzGKbaL4PcG9bMjbiL2Ik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sT9XtKQiIV1vhLj28dY0pMC08gTrAWXktiIXgVC1cY2PhJq5QQGy7J5xuIDwsVCI
	 4LR4+MgqGphYOJLfLhM8KkqH/QNdjXznzr7rhhXYIk3bDUWSQtwoXQqJiEyvOItkq
	 tT92qAujfkAL3YHIxYT1dOHWzriCoxgTTEdih3iPeIuzcniUICQWU52151GO9p3sB
	 cu1n9ET3egOtFErsZb6RWD1cjeuxJzTgcRgRpE0vjerOYkY+UL8YsskPJVLv1SId4
	 /Ovav7ZAW8pb2HG1Jk0SI7SKowufAHmfvGl3RJtAGrLBXGd3TQy8EBs9nCIl2BUYm
	 OGdKV422+pf0NuEclA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.38]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWz8l-1tZDOf2lWD-00OJgW; Sun, 06
 Apr 2025 16:01:00 +0200
Message-ID: <dc6b7ff7-8da7-4d02-8fb4-52593137bf11@web.de>
Date: Sun, 6 Apr 2025 16:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luis Chamberlain <mcgrof@kernel.org>, kdevops@lists.linux.dev
References: <20250403020123.1806887-1-mcgrof@kernel.org>
Content-Language: en-GB
Cc: cocci@inria.fr, gost.dev@samsung.com, Davidlohr Bueso
 <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
 Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250403020123.1806887-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PJO956NId/erXPMZxq+Yuk75Ty59yYDA+O+/XeoxSnDrNItySzp
 dgadlxGbPiWrI+0RvWUdmrTzNQmtrOMjhIG6En8gtI8ik0RFlNphK8epfEp0Yt4Toc95lt8
 6SdIHjsDE1eUbrK5GEctmPmSYCbImegvLGl2fpXWO6PdYtl0DdyDjz2TJGC5thSj/mptpnd
 APVGV4qhAslLNsf2PfzDw==
UI-OutboundReport: notjunk:1;M01:P0:4LClOEfa27U=;QB4JiBTZW7m7M/yIUqPIm8BmWM3
 1wFg4nyKP/OEkRX93GplXfmpMddbXhhfOMFczs9H7w5/h300/dbOHXdNtUrn7yrrkLEJG8uP1
 jAcScup13N91Ca7BrtQ3s77FTET1vg7Cp5qM/G+5WVD1qhOO8L2MI2aHYNfka60+82Hl40U68
 3BifxA9t3gZYwfr30Dw+VyHL1lD5ImTFrDwoK7JRQFkoQb8sR4rLbFSD14gDVU2cNyWE+9Caf
 t3hfcS1U03dpE6Gel4PK+JGTmAsQFAIxBsb+jq3oX8pSbd1G1Omb0XjQhJGNi88vlEXclKGAQ
 sMrSoM4MK8rJzHO3RfTsPF8s6dhsRYk+BVbr6HqmW6DZgnSC5yV64m3CAU1yj4JP2mtdhlwdy
 RNQYVnrMh+aI5/l6BgskT8QpwwVy1DBJOtas59ZjiWyvqF5lny+xnbSacMGUk4CSJKZkIBUmz
 5030vyaP4FK02R3Z2uJ2GK5Xs+tH24n6kcDgJP8p7QscXfOWFwDLwOfHhFEqr9m1384CTAgDv
 uCbbmNcJ3F77z1dXqeAvv5ZPlgnGDuWuamx5A8TAfDjDbbAlYQvHdc693ZYklMuZVN1rtM6M2
 v9A9b376Vs2bFllBccD38DLRffuLbvYa5L8n6MCTs/kbflXUHnza/QNmF9AVq25AkQxhWZGIW
 X16flW0wMgQqnzivEW25qGY0uQwzGgpLZ5jsoPVvIsAG8w2sHQk8OX+CDA3+E2A0zjeLizAYQ
 9j9W2FPCh9Vupbl8S2gKKsoi2WsvDGm2Ey5xukK3HBbJHdYS4ceC4sALsgkE+c8H7KZRlzHU5
 dAyaq/q+83l2ZYQ0qFapWobk5t/rRMK3JWCP90OH8DS/YuuZ7VHQIKLcFSkcmot/oVRlcTO5m
 e/gpXj3T4m6/LPBPEVn8Qq+Eogqr17XN3r36Ypir/OP+eee1P5cjAAxzz3jlWS4XGUfZBmWdR
 IyhuQbFJqc2BRFWMw6D8D6rlhGZPAs/BdLI4XYlQS81BCz22cSJhNxjlOVOfV+R5wRr0Kb7zU
 D724Tk/AezV8JCJxiCkIF3grezyCrd9iEu7lcyborlr2zVqOevzv6rZeynDlaE1xW1tLHroBI
 4mXMd/nw9Q0aqj4WG99cyV/Fr+EYMO6oZ4qX0bFUcNicI1b21jLntx4kkMWAR41fFMayptePI
 +Lc9rJoCAlj2JKDkjm5bfFlgszUve4J/vC53XEyIsmv9DyTHzQQbVeDhxjxBTRvnowpDj8+a3
 IfyU/O0i7x8nvvTHbHM6cw7yYiILmfwIrckFBXq2HPBUQVirE2Zu+wEGaES8BvHcxwpmf6XtE
 jsQaEampdzg76OtAw8KRPdRpxO56frPa8UFS2BcUH/ZUXNeJ9R3LLWWtrj2m+rQmAmQt/CWQt
 qnyX1C7pUNQ/nF4aY10B4dVHZkxRobcDduL5OwNVgdgS7Dbt1dql/5t3Kl6/Dcug14v9TkMIE
 07tSkGSnLzHHfjOi6H0tK2O41U8sYLflare9rSztvpZ4Q7a02lcXMRRfz/MkYQTgd0otOiYKc
 tRFt/lBI5V0yuMEv4bs=
Subject: Re: [cocci] [PATCH kdevops] scripts/coccinelle/generation: add
 example generation script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2684
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/dc6b7ff7-8da7-4d02-8fb4-52593137bf11%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/generation/check_for_atomic_calls.py
> @@ -0,0 +1,443 @@
=E2=80=A6
> +header =3D f"""// SPDX-License-Identifier: GPL-2.0
=E2=80=A6
> +/// Detect atomic context in ANY transitive caller (up to {max_depth} l=
evels)
=E2=80=A6
> +virtual after_start
> +virtual report

Can any code refinements trigger desirable effects?

+virtual after_start, report


=E2=80=A6
> +@irq_handler_def@
> +identifier fn;
> +@@
> +(
> +DEFINE_IRQ_HANDLER(fn, ...)
> +|
> +DECLARE_TASKLET(fn, ...)
> +)

+(DEFINE_IRQ_HANDLER
+|DECLARE_TASKLET
+)(fn, ...)


=E2=80=A6
> +@irq_func_names@
> +identifier fn =3D~ "(_irq|_intr|_isr|_napi|_poll|_tasklet|_softirq|_bh)=
$";
> +@@

+identifier fn =3D~ "_(?:i(?:rq|(?:nt|s)r)|napi|poll|tasklet|softirq|bh)$"=
;


=E2=80=A6
> +@interrupt_prefixed@
> +identifier fn =3D~ "^(irq_|intr_|isr_|napi_|poll_|do_softirq|tasklet_)"=
;
> +@@

+identifier fn =3D~ "^(?:i(?:rq|(?:nt|s)r)|napi|poll|tasklet)_|do_softirq)=
";


=E2=80=A6
> +@atomic_name{level} depends on after_start exists@
> +identifier virtual.transitive_caller;
> +identifier atomic_fn =3D~ "(_irq|_intr|_isr|_napi|_poll|_bh|_softirq|_t=
asklet|_atomic)$";

+identifier virtual.transitive_caller,
+           atomic_fn =3D~ "_(?:i(?:rq|(?:nt|s)r)|napi|poll|bh|softirq|tas=
klet|atomic)$";


=E2=80=A6
> +++ b/scripts/coccinelle/generation/check_for_sleepy_calls.py
> @@ -0,0 +1,678 @@
=E2=80=A6
> +    f.write(f"""// SPDX-License-Identifier: GPL-2.0
=E2=80=A6
> +def register_sleep_point(caller_func, sleep_func, file, line, reason=3D=
""):
=E2=80=A6
> +        if reason:
> +            message =3D f"{{symbol}} {'VERIFIED' if expected_to_sleep e=
lse 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} - {{rea=
son}} (via {{sleep_func}})"
> +            path_message =3D f"   Call path: {{path_str}} =E2=86=92 {{s=
leep_func}}"
> +            print(message)
> +            print(path_message)
> +        else:
> +            message =3D f"{{symbol}} {'VERIFIED' if expected_to_sleep e=
lse 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} (via {{=
sleep_func}})"
> +            path_message =3D f"   Call path: {{path_str}} =E2=86=92 {{s=
leep_func}}"
> +            print(message)
> +            print(path_message)

+        if reason:
+            message =3D f"{{symbol}} {'VERIFIED' if expected_to_sleep els=
e 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} - {{reaso=
n}} (via {{sleep_func}})"
+        else:
+            message =3D f"{{symbol}} {'VERIFIED' if expected_to_sleep els=
e 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} (via {{sl=
eep_func}})"
+
+        print(message)
+        print(f"   Call path: {{path_str}} =E2=86=92 {{sleep_func}}")


> +        # Store this for our final stats
> +        if path:
> +            path_value =3D path_str + " =E2=86=92 " + sleep_func
> +        else:
> +            path_value =3D caller_func + " =E2=86=92 " + sleep_func

+        path_value =3D " =E2=86=92 ".join(((path_str if path else caller_=
func), sleep_func))


=E2=80=A6
> +@check_sleep_names@
> +position p;
> +identifier fn;
> +identifier sleep_fn =3D~ "(_sleep|_timeout|_wait|_block|_sync|_lock|cre=
ate_|alloc_|_kmalloc|_mutex)";

+identifier fn,
+           sleep_fn =3D~ "(?:_(sleep|timeout|wait|block|sync|lock|kmalloc=
|mutex)|(?:create|alloc)_)";


> +@@
> +fn(...) {{
> +  <...
> +  sleep_fn@p(...)
> +  ...>

May the search pattern be really optional here?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/fe67e5985c72582553ecd=
e33cd7d6e6c2643ef00/docs/manual/cocci_syntax.tex#L802-806
https://github.com/coccinelle/coccinelle/blob/4093aad2da23ea5c86916de0a71f=
43032fc2bb2f/docs/manual/cocci_syntax.tex#L802-L806


=E2=80=A6
> +    if sleepy_func:
> +        message =3D f"\n\n{{symbol}}: {{caller_func}}() can sleep at {{=
file}}:{{line}} - {{reason}} (via {{sleep_func}})"
> +        print(message)
> +    else:
> +        message =3D f"\n\n{{symbol}}: {{caller_func}}() found to may sl=
eep."
> +        print(message)

+    if sleepy_func:
+        message =3D f"\n\n{{symbol}}: {{caller_func}}() can sleep at {{fi=
le}}:{{line}} - {{reason}} (via {{sleep_func}})"
+    else:
+        message =3D f"\n\n{{symbol}}: {{caller_func}}() found to may slee=
p."
+
+    print(message)


=E2=80=A6
> +msg =3D f"=E2=9C=85 Generated {outfile} to check if '{target_func}' mig=
ht sleep"
> +if sleepy_func:
> +    msg =3D f"=E2=9C=85 Generated {outfile} to check if '{target_func}'=
 calls '{sleepy_func}'"
> +print(msg)

+if sleepy_func:
+    msg =3D f"=E2=9C=85 Generated {outfile} to check if '{target_func}' c=
alls '{sleepy_func}'"
+else:
+    msg =3D f"=E2=9C=85 Generated {outfile} to check if '{target_func}' m=
ight sleep"
+
+print(msg)

=E2=80=A6


Regards,
Markus
