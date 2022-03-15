Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6390DC433F5
	for <cocci@archiver.kernel.org>; Tue, 15 Mar 2022 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=NJ1vDI/n5oeHAFlwHILYiKjy0DK9uSWphmDmNhbgw7g=;
  b=JrGiiwteZJio2fciw4xYkCbVQN222fZbgvqCkOBeW7wK2a68g7R1AEaV
   1Tey82AkmfLKV6ZNUzXxEaMSf1ZSlWEOgpRao7sksMLMT9RuTxTi3d6EE
   NE9STAmKFKm5j7EgavNHj40bk6FJ+C+yIX134HOxhB/9TcrzkF1SCMJNu
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,182,1643670000"; 
   d="scan'208";a="26121024"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Mar 2022 03:40:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0208E0048; Tue, 15 Mar 2022 03:40:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82118E0045
	for <cocci@sympa.inria.fr>; Tue, 15 Mar 2022 03:40:16 +0100 (CET)
IronPort-SDR: sSNP2CAMTz5rP844YR7bXoN+9vLLRocgKBygiUvNRtBJ9qEwAMo0bkzI1VceAL7OXbTe6Iy3bu
 1ioYki1JAeht6KohkA46BOUgM1lEE0MprM9ZYAAh4eszpkRnT4cuSALkyrcmtN7YInO4gJ07Zh
 lq/YxhX0zG0BVpvRBoEv6oSH/xNfVHXQf5jlI515tFj/mFl7l/4R4qbeaahbouhRX7hv2Vy+Dv
 4C9WsUCyeajk3VHT50+t7h3h7W0PAOWPOZ8PGBkSZXPhmJLlhr0qEpHHu9XX5ePr+EIHf8SXgQ
 CjIY5c3vIdCbih/1ZucSi5TB
X-IPAS-Result: =?us-ascii?q?A0CKBQBT+y9i/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuCK?=
 =?us-ascii?q?JxggXwLAQMBDUEEAQGFBwKEJwIdBgYyBw4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIDBAGBCCwBYwFnAYFOAYF5BgQ9gjUig2wBBTo/EAsOCi5XBoMXg?=
 =?us-ascii?q?xetSIEzgQGJe4E8hhQUQodeJxxAgU2EDzA+ikQEm1OiEZ4Tg1OfVhoulkWRc?=
 =?us-ascii?q?ZZXoUOFOIE/KQUwgVkfFBoIJgqDJU0BAgECAQwBAgIBAgECAQIBCAEBAgGOK?=
 =?us-ascii?q?BaOTiEBAQFpAgYLAQEDCY9KAQE?=
IronPort-PHdr: A9a23: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
 bb4uQ==
IronPort-Data: A9a23:4t7q4qDuslsP/BVW/wzlw5YqxClBgxIJ4kV8jS/XYbTApGsqhWYOz
 WdOWDvTOquDZGvzL9x0bNm29E8Pv5+HmNYyOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgXlvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoyS0otZT2
 tpTjs2TVBcgL7XpyOkBfAYNRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcCgm5q35gURZ4yY
 eIwbyY/YUqbTyF9P3E+JstnrdyGhnnWJmgwRFW9/vZpuDmMnGSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyCTCE4T+VtH+zhuLCmS7hHoQfCNVU68KGnnWC+1EVKg8ZS2DqguSpg1+mfoJSN
 2MLr39GQbcJyGSnSdz0XhudqXGCvwIBV9c4L9DW+D1h2YKPvFnEXjlsoippLY155JVvFFTGw
 3fQx4uxbQGDpoF5Xp50y1t5hTaifyUKLWIPYSIeCw0I/7EPQb3fbDqUEb6P84bv0rUZ/A0cJ
 BjT8UADa00715Jj6klC1QmvbvLFjsGhovQJzgvWRHm5yQhyeZSoYYelgXCCs6ofdtfBEQLb4
 yRd8yR70AzoJcrX/MBqaL5SdIxFGt7fbWO0baBHQfHNCAhBC1b4Id4LsW4uTKuYGssbeTLkZ
 ELJuAVaoccKVEZGnocsC79cyq0Ck8DdKDgSfquNP4QUPcQpKlPvEeMHTRf44l0BWXMEyckXU
 ap3u+71ZZrDIag4njewWckH1ronmnI3yW/JHMCpyxW8zaHYaWGVRLoBPUHIaO0ltfvWrALQ+
 tdZFs2L1xQGCrGlOHGKqNJKIABYN2U/CLD3t9dTKLyJLD1mL359WfXf9rUsJt5+lKNPm+aVo
 HzkAh1EyEDyjGHsIBmRbiwxc6vmWJty9CppPSElMVuy9WIkZIKjsPUWe5ctJOl18O140eUyQ
 uYFdsiED+4JTDnbomxPYZ74pY1kVRKqmQPXZXb+OmBiJsI5SlWQqNH+fwbp+C0fNQaNtJMz8
 ++6ywfWYZsfXAA8XszYX/KY0A/jt3Yqnu8vDVDDJcNeeRiy/dEyeTDxlPI+P+oFNQ7HmmmBz
 w+TDBoV+bvNrosy/IWbjKyItd70Qe5uWEdFH2TW6buscy/X4jP7k4NHVe+JexHbVX/1of/+P
 r8NkqigafBXzkxXt4dcEqpwyfxs7dXYp4hFklZuEkLNYgn5EbhnOHSHgJdC7/Uf2r9DtAKqc
 UuT4d0Ga66RMcboHQJDPgYjdejfh/gYliOLsKYwMAP3+y968b6KSwNUMgXV0H5RK758MYUEx
 +Y9uZdMt1fl0kdzbo+L3nJO6mCBDn0cSKF55JsUN4/clVZ5wF91Z5GBWDT954uCaogSPxByc
 COUnqfLm59V2lHGLygoDXHI0OdQ7XjUVMumELPWy5W1dtv5ajsf2Q0X/Cs3QwlRww8B1e9vU
 oSu24uZOo3WlwqERuAaN4xvJ+2FLBmY4VDqjVYWlGDUS0SyEGrAMAXR/ApLEF8xqwphk/syw
 F1c4GLkSirxOszu3iY/XUN/7fruUbSdM+EEdN+PR6y4InXxXdYpbmJCq4bFR9sLzP7dXHH6m
 NQ=
IronPort-HdrOrdr: A9a23:Aru/GKs1EDL0HjvhOEXSiS9z7skDctV00zEX/kB9WHVpm62j5r
 mTdJZy73DJYVkqNk3I9ergBEDEewK4yXcX2/h2AV7BZniDhILAFugLhuaP/9SjIVyYygc379
 YDT0ERMr3N5IdB5/rS6gPQKadC/OW6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,182,1643670000"; 
   d="scan'208";a="26121020"
X-MGA-submission: =?us-ascii?q?MDG1yBrkdjVlp1yHZcKWG05hV847ZhL0LyY7g6?=
 =?us-ascii?q?88nFe0bpFb222xCQtTuTTTDDva2Q6BIeWs+DCxEX1Q7U8qmwlXmChOf1?=
 =?us-ascii?q?eHSfyDpJcPoD6uCCsXleKVZn3OTCf1TjeCiZCbtKv/hu352Q0qhVWdWj?=
 =?us-ascii?q?1bJpqcCgbqSC0UaH/8vdN9iA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:40:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 4FBAE4A;
	Mon, 14 Mar 2022 19:40:12 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eFuuAh-TahdI; Mon, 14 Mar 2022 19:40:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 2D21F39;
	Mon, 14 Mar 2022 19:40:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 2D21F39
Date: Mon, 14 Mar 2022 19:40:08 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Luis Chamberlain <mcgrof@kernel.org>
cc: cocci@inria.fr
In-Reply-To: <Yi4ce+2k03795Rut@bombadil.infradead.org>
Message-ID: <9bc7a82-f14-d122-b59a-39db1749cb56@ewheeler.net>
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net> <Yi4ce+2k03795Rut@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can Coccinell concatinate or append to existing string
 literals?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 226
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/9bc7a82-f14-d122-b59a-39db1749cb56%40ewheeler.net>

On Sun, 13 Mar 2022, Luis Chamberlain wrote:
> On Sat, Mar 12, 2022 at 04:53:22PM -0800, Eric Wheeler wrote:
> > Hello,
> > 
> > I would like to do something like this:
> > 
> > 	@ a @
> > 	constant C;
> > 	constant CN ## "_bar";
> > 	@@
> > 	-foo(C);
> > 	+foo(CN);
> > 
> > to produce this:
> > 
> > 	void f()
> > 	{
> > 	-	foo("foo");
> > 	+	foo("foo_bar");
> > 	}
> > 
> > It looks like `fresh identifier` can do something like this, but I can't 
> > get it to work with strings.  Is there a way?
> 
> Yes sure below is an example I used recently in Linux:
> 
> @c1@
> expression E1;
> identifier subdir, sysctls;
> @@
> 
> static struct ctl_table subdir[] = {
>     {
> 	    .procname = E1,
> 	    .maxlen = 0,
> 	    .mode = 0555,
> 	    .child = sysctls,
>     },
>     { }
> };
> 
> @c2@
> identifier c1.subdir;
> 
> expression E2;
> identifier base;
> @@
> 
> static struct ctl_table base[] = {
>     {
> 	    .procname = E2,
> 	    .maxlen = 0,
> 	    .mode = 0555,
> 	    .child = subdir,
>     },
>     { }
> };
> 
> @c3@
> identifier c2.base;
> identifier header;
> @@
> 
> header = register_sysctl_table(base);
> 
> @r1 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.subdir, c1.sysctls;
> @@
> 
> -static struct ctl_table subdir[] = {
> -       {
> -               .procname = E1,
> -               .maxlen = 0,
> -               .mode = 0555,
> -               .child = sysctls,
> -       },
> -       { }
> -};
> 
> @r2 depends on c1 && c2 && c3@
> identifier c1.subdir;
> 
> expression c2.E2;
> identifier c2.base;
> @@
> -static struct ctl_table base[] = {
> -       {
> -               .procname = E2,
> -               .maxlen = 0,
> -               .mode = 0555,
> -               .child = subdir,
> -       },
> -       { }
> -};
> 
> @initialize:python@
> @@
> 
> def make_my_fresh_expression(s1, s2):
> return '"' + s1.strip('"') + "/" + s2.strip('"') + '"'
> 
> @r3 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.sysctls;
> expression c2.E2;
> identifier c2.base;
> identifier c3.header;
> fresh identifier E3 = script:python(E2, E1) { make_my_fresh_expression(E2, E1) };
> @@
> 
> header =
> -register_sysctl_table(base);
> +register_sysctl(E3, sysctls);
> 


Thanks everyone for answering this thread and providing these examples and 
explanations to reference!

--
Eric Wheeler


