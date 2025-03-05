Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C5EC28B23
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vqon+S9Ipw5UPV60ZyyfCMLbQpC4hNpOVkhF0+gwZNk=;
  b=EvK6x8H/q+VeIvXzH6CNDM5HGfyWJMvgZmgNmz0C+Uq7kmkqyI7SZAtJ
   +CxpViRE031xgKEOWKW4/CMhHEg1wGpXLirzKU+qQzR963QE3p8Ch2rnp
   hA5LP1lj73QH6VlNPHFcwv898J8Iw8gEnXjClwIaMBF3A4no/9RcsWF86
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@scarletmail.rutgers.edu
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208,217";a="211491717"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:09:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 643C9E0D1E; Thu,  6 Mar 2025 10:09:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D2B21E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 22:14:52 +0100 (CET)
IronPort-SDR: 67c8becc_Tc1e3kIw0VS0gzGYZNYDdjJcAajuS68Ss1m7A+mGZswIQsS
 owNts8x8XBQFKz6F7y32MHEwisY4DD/COwaPzWA==
X-IPAS-Result: =?us-ascii?q?A0HvAgDovchngS2AVdFaFoJGgUENdn1ZNAQLSIRWgSOCL?=
 =?us-ascii?q?IwAUwoGgTsDi3aSIRSBLBYoBgkBAwENNg4EAQEDAQOFAIsaAh4HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDjuFew2CRRk4c?=
 =?us-ascii?q?WUJNwEBAQEBAQEBAQEBAQEBAQEBAQEBFgINBxJ9ER0BATglLQEJAiMSAQUBN?=
 =?us-ascii?q?SKCYYJkAxGiV4EFQos+gTKBAYIMAQEGgQhQQdlxCXN/AwYUgRwYiE8BgVwCD?=
 =?us-ascii?q?od8eieBGIEQgUqGFAQYgREBEgFOgy6CaYIzgTuDbIFshE+DGoJsDQ8tgiWDA?=
 =?us-ascii?q?oQckgAmJgMHBw4rSQ4BIQMmMywBVRMXCwcFMIE8AQIBgQ6BRno5ggxpSToCD?=
 =?us-ascii?q?QI1gh58gUJphE6CF4ImLxWCKIFWJoJogkSCEYIIgW+HRYRpFh1AAwtiCzwBN?=
 =?us-ascii?q?xQbTDihMwE6hDwGAjwkEQkTASsgAoEjFQQBJoFJAQEBpDqhBQEGAoQdBYthM?=
 =?us-ascii?q?pVKM4QDjQmZSy6YUI4FlWmFNBEjgUsCMWxwMxolfwZngRUBATJPAxkPji0Wg?=
 =?us-ascii?q?1hqgXrFTCgyPAIHAQoBAQMJkBxrYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:J7zuP6Ndl7mG4sBcTuyjsMiBIKoaSvp037BL7TEJdfUxSKalfq
 +V7ZYmPHPP+VUssRIb+exoWpPwJU80nKQdieIs1NyZLW7bUQWTXedfxLqn7TmlNCH36/JH2b
 0ISdkaNPTASXZ/yej1iTPWLz/i+rW6GWKT6Ns2A00CceiiUcBd0zs=
X-Talos-CUID: =?us-ascii?q?9a23=3A85htuWl70XL4WbYZJ77PLzOKSjfXOXHPxWXCOxW?=
 =?us-ascii?q?BNXpKGZaaCmOC0apmuNU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ADub8nw2/7CjQ7EIYX9+O8WxbnTUj6bb0DG0roZg?=
 =?us-ascii?q?6lua0b3ZPMiWFj2WKe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,224,1736809200"; 
   d="scan'208,217";a="211422739"
X-MGA-submission: =?us-ascii?q?MDGgsul3He9aWlD/RX/P76/uv/y/XjlR+j43nV?=
 =?us-ascii?q?IYW1Up6KzKCjoFdzVgiynh2opOwoMv4Ygw2dB7GUOdj/2OxNR+zELo8H?=
 =?us-ascii?q?MQvUqfedL9jgwtQHQqvQ9LFW48lV7FNFV2C74PgnDovAo/GMn4/zHhVY?=
 =?us-ascii?q?JX5s8Gfwtt6BoHAFYwxdCKZA=3D=3D?=
Received: from mail-wm1-f45.google.com ([209.85.128.45])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:14:52 +0100
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so50034715e9.0
        for <cocci@inria.fr>; Wed, 05 Mar 2025 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529; t=1741209291; x=1741814091; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqon+S9Ipw5UPV60ZyyfCMLbQpC4hNpOVkhF0+gwZNk=;
        b=Y59ibpidoCzyVJco5GfFbnDL+8toeG0OT9Gnx+nOUeAfl5rA8+j+G5C6Uc2vI89kHV
         IIgalnKlkqwhL2J78IC2QL4j9pe5bvAlv0TNPmXmMzMoCGkm1jxPPL+VeMyxshdokkH5
         imazNiXYynctGUoEBEXdluRpgDJAlPGvTtiIvdfkJop1CL864FAsr9Mh0/vwJ5CXdzjS
         bk7pG5bvaZzRVdN5mMaEH/MuSLgWYGAn4DM64NLesK4W3+fTnxWjw1B75MqC0TgGuWdl
         4jQ6BP1lQeoOB1LsFUW17qxzcO4eZGcm5Ck8/lncvzz3WmkCKd0HZvFJnOQP7wYfnNbh
         wbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741209291; x=1741814091;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqon+S9Ipw5UPV60ZyyfCMLbQpC4hNpOVkhF0+gwZNk=;
        b=kUAsC7yJuJwXyixzDMj2i5ChI6oJj4+C8zBKWoVfdU+5uSOZanwK9g5rf3AdCtERKP
         mhHkmUjGLML5tHp+ciYGzGnqygKhtIXesGCmSrR8D9sotPD9v4fg8Q6bcnKfjUjyBdBH
         fVFcHsWNjP5MvD6VKKcZJftYiJYV9tRIW9Ru/uirdFypqdZmG5fa5fUSiM+AcvRGHgoo
         zYOCoD3xq1AkdGu68GeNZltfJs+iBb2tfceuY9iBm52NcAoRC0B5w+wVqlKHGeXmAUCW
         6mSzlTnib6tYf8fPOz0Qo7Xbi/5ycGOimlBI2o1YEjD6mSv0ddBUw/hGbdu8PnCRZGH6
         xbnA==
X-Gm-Message-State: AOJu0YzYGQoHFNQvTqwsLY3apTRtJ/a7chjSZyLLQMwQmdpSeGnK7zqK
	crEOql4HWFcbsvxxNg0zmvistFOddwEXuW1wdsYrT0yyJbyuAuXLxVSFaTbU7MicJoJea2xsvJR
	UGUhg/CRbfstlQujZ6pzbF7LeNdAnLHynXpF0E0FqGezM7tt8nKoMAA==
X-Gm-Gg: ASbGnctVZaJKAsolxkuobzuIYGyhorUpgjgVODH8P8HgyUsHjYmgqrxGIw/WY1E8P3J
	iDEXU8eog/+bxhfVmgUc2l82CKm8FXoLoQCRYvYf9xDPkOc3SNn3CB3dv12SkwolMqXGz2Spr+O
	Eia8sAC79fC5wimXV2ijFAQuLE
X-Google-Smtp-Source: AGHT+IEHAZLMekvhH63jPPEE8e68ht8mpqL2Jtc+0trVcEHju28elp24+YrnMN2SFPZKRoNXVjponBVBr3VHwsHxgGY=
X-Received: by 2002:a05:6000:156a:b0:391:bed:ec9e with SMTP id
 ffacd0b85a97d-3911f5945b1mr4357747f8f.0.1741209290817; Wed, 05 Mar 2025
 13:14:50 -0800 (PST)
MIME-Version: 1.0
From: Danikka Jelski <cmj136@scarletmail.rutgers.edu>
Date: Wed, 5 Mar 2025 16:14:40 -0500
X-Gm-Features: AQ5f1Jr-mOjDVNyEo5W8A7jJRCH_yImmgeZzGQmxVpjem-TFpWLW3B6ucVA6Crc
Message-ID: <CABDMBwh_LRL+Dxz94caz+ybJT5MLP9usBs12fLeDHaTSnOES3A@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="00000000000042a492062f9ee1a9"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Question about Coccinelle (with __uint macro)
Reply-To: Danikka Jelski <cmj136@scarletmail.rutgers.edu>
X-Loop: cocci@inria.fr
X-Sequence: 2559
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/CABDMBwh_LRL%2BDxz94caz%2BybJT5MLP9usBs12fLeDHaTSnOES3A%40mail.gmail.com>

--00000000000042a492062f9ee1a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I hope this email finds you well. I=E2=80=99m reaching out to seek guidance=
 about
how Coccinelle parses complex macros. In my current research project, I am
working with Coccinelle on Ubuntu 22.04 (kernel version 6.0 generic), and
I=E2=80=99m experiencing issues regarding parsing complex macros. Specifica=
lly, I
was trying to modify BPF map definitions, and I encountered an issue when
applying a patch:


@@

@@

 struct {

-  __uint(type, BPF_MAP_TYPE_ARRAY);

+ __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);

  __type(key, u32);

  __type(value, struct array_elem);

  __uint(max_entries, 1);

} port_state SEC(".maps");

In this patch, I wanted to change the BPF map from BPF_MAP_TYPE_ARRAY to
BPF_MAP_TYPE_PERCPU_ARRAY from the __uint
<https://docs.ebpf.io/ebpf-library/libbpf/ebpf/__uint/#:~:text=3DThe%20__ui=
nt%20macros%20is,integer%20properties%20of%20BTF%20maps.>.
I have a similar problem where it cannot parse the __type
<https://docs.ebpf.io/ebpf-library/libbpf/ebpf/__type/> macro either when I
had tested for that macro independently.

The error I get is:

Some troubleshooting I have done included:

   1.

   I made simplified .c files with simplified headers to check if the issue
   was due to missing kernel dependencies and to isolate the issue. It seem=
s
   that it wouldn=E2=80=99t parse it this way, either.

One of the simpler examples I did was:

I received the same error message as before.


   2.

   Checking out the preprocessed code to see if the macro is expanding
   correctly. I understand that Coccinelle has the option to preprocess the
   code before applying a spatch, but I had also preprocessed with the C
   preprocessor (gcc -E) of the file. I understand that applying a patch on
   preprocessed code, where the macros are expanded, requires that the spat=
ch
   match those expansions.

With simplified examples, such as the one above, I tried to apply the patch
on preprocessed code, where it expands to:

With adjusted .cocci:



Using the spatch on such preprocessed code leads to other errors, like:


Another more simplified case with testing the expansion alone without the
struct:

The transformation unfortunately was unable to be applied in these cases.

Some specific questions I have:

   1.

   Can Coccinelle recognize the __uint macro inside the struct and apply a
   patch that uses such a macro?
   2.

   Can you provide any guidance on how to properly match and modify this
   struct in Coccinelle?


I would greatly appreciate any insights you can offer. Please let me know
if you need more information.

Thank you so much for your time and consideration.

Best,

Danikka Jelski | cmj136@scarletmail.rutgers.edu

--00000000000042a492062f9ee1a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-1b5776e3-7fff-572e-93=
1f-47646ee4af14"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;vertical-alig=
n:baseline">I hope this email finds you well. I=E2=80=99m reaching out to s=
eek guidance about how Coccinelle parses complex macros. In my current rese=
arch project, I am working with Coccinelle on Ubuntu 22.04 (kernel version =
6.0 generic), and I=E2=80=99m experiencing issues regarding parsing complex=
 macros. Specifically, I was trying to modify BPF map definitions, and I en=
countered an issue when applying a patch:</span></p><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;font-variant-numeric:normal;font-variant-east-asian:normal;font-vari=
ant-alternates:normal;vertical-align:baseline"><br></span></p><p dir=3D"ltr=
" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline">@@</span></p><p =
dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><sp=
an style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;vertical-align:baseline">@@</span=
></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:=
0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline">=
=C2=A0struct {</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sa=
ns-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric=
:normal;font-variant-east-asian:normal;font-variant-alternates:normal;verti=
cal-align:baseline">-=C2=A0 __uint(type, BPF_MAP_TYPE_ARRAY);</span></p><p =
dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><sp=
an style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;vertical-align:baseline">+ __uint=
(type, BPF_MAP_TYPE_PERCPU_ARRAY);</span></p><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;=
font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;vertical-align:baseline">=C2=A0=C2=A0__type(key, u32);</span=
></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:=
0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline">=
=C2=A0=C2=A0__type(value, struct array_elem);</span></p><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font=
-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:t=
ransparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-=
variant-alternates:normal;vertical-align:baseline">=C2=A0=C2=A0__uint(max_e=
ntries, 1);</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0=
pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-=
serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:no=
rmal;font-variant-east-asian:normal;font-variant-alternates:normal;vertical=
-align:baseline">} port_state SEC(&quot;.maps&quot;);</span></p><br><p dir=
=3D"ltr" style=3D"line-height:1.38;text-indent:36pt;margin-top:0pt;margin-b=
ottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color=
:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;font-variant-alternates:normal;vertical-align:base=
line">In this patch, I wanted to change the BPF map from BPF_MAP_TYPE_ARRAY=
 to BPF_MAP_TYPE_PERCPU_ARRAY from the </span><a href=3D"https://docs.ebpf.=
io/ebpf-library/libbpf/ebpf/__uint/#:~:text=3DThe%20__uint%20macros%20is,in=
teger%20properties%20of%20BTF%20maps." style=3D"text-decoration-line:none">=
<span style=3D"font-size:11pt;font-family:Arial,sans-serif;background-color=
:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fon=
t-variant-alternates:normal;text-decoration-line:underline;vertical-align:b=
aseline">__uint</span></a><span style=3D"font-size:11pt;font-family:Arial,s=
ans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;vert=
ical-align:baseline">. I have a similar problem where it cannot parse the <=
/span><a href=3D"https://docs.ebpf.io/ebpf-library/libbpf/ebpf/__type/" sty=
le=3D"text-decoration-line:none"><span style=3D"font-size:11pt;font-family:=
Arial,sans-serif;background-color:transparent;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-variant-alternates:normal;text-decoratio=
n-line:underline;vertical-align:baseline">__type</span></a><span style=3D"f=
ont-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fo=
nt-variant-alternates:normal;vertical-align:baseline"> macro either when I =
had tested for that macro independently.=C2=A0</span></p><br><p dir=3D"ltr"=
 style=3D"line-height:1.38;text-indent:36pt;margin-top:0pt;margin-bottom:0p=
t"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0=
,0);background-color:transparent;font-variant-numeric:normal;font-variant-e=
ast-asian:normal;font-variant-alternates:normal;vertical-align:baseline">Th=
e error I get is:</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-left:72pt;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;=
font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;vertical-align:baseline"><span style=3D"border:none;display:=
inline-block;overflow:hidden;width:442px;height:102px"><img src=3D"https://=
lh7-rt.googleusercontent.com/docsz/AD_4nXdSOIb1mx6UOgK95vL1l3BTTwStJgl3BWKc=
m0S7gx13MpOcwIBj5hyWIY9R6lFCBn_7aljh2uohN2suEGtxDPjP5Q9Qh0S6wDo496iVST5EbGj=
7v7uU17ul68j8K09zMG436N5NrQ?key=3DHDx3ebciDTqk2MuXMXjB9X1r" width=3D"442" h=
eight=3D"102" style=3D"margin-left: 0px; margin-top: 0px;"></span></span></=
p><p dir=3D"ltr" style=3D"line-height:1.38;text-indent:36pt;margin-top:0pt;=
margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-ser=
if;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-al=
ign:baseline">Some troubleshooting I have done included:</span></p><ol styl=
e=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-=
type:decimal;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);b=
ackground-color:transparent;font-variant-numeric:normal;font-variant-east-a=
sian:normal;font-variant-alternates:normal;vertical-align:baseline;white-sp=
ace:pre;margin-left:36pt"><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11=
pt;background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-variant-alternates:normal;vertical-align:baseline">I m=
ade simplified .c files with simplified headers to check if the issue was d=
ue to missing kernel dependencies and to isolate the issue. It seems that i=
t wouldn=E2=80=99t parse it this way, either.</span></p></li></ol><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-left:72pt;margin-top:0pt;margin-bott=
om:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rg=
b(0,0,0);background-color:transparent;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;font-variant-alternates:normal;vertical-align:baselin=
e">One of the simpler examples I did was:</span></p><br><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font=
-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:t=
ransparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-=
variant-alternates:normal;vertical-align:baseline"><span style=3D"border:no=
ne;display:inline-block;overflow:hidden;width:304px;height:116px"><img src=
=3D"https://lh7-rt.googleusercontent.com/docsz/AD_4nXcze023-F5OV4Rax-hTjRdt=
cBoJVlO03zGi1HwEJW6YULoqcVl41_liGdiiQU40tigM4qbzBGkLpzifzmy-NCew7kr7BNi3nfc=
_pdNZAp7QcWj4mkab6thRYrgNamaAzz0zY6II-w?key=3DHDx3ebciDTqk2MuXMXjB9X1r" wid=
th=3D"388" height=3D"211" style=3D""></span></span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:tr=
ansparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-v=
ariant-alternates:normal;vertical-align:baseline"><span style=3D"border:non=
e;display:inline-block;overflow:hidden;width:344px;height:210px"><img src=
=3D"https://lh7-rt.googleusercontent.com/docsz/AD_4nXe44xFLkphNYL16klw0BOw1=
N-sgjYydSe4K8ebUEf0P7LzHzXHh64dyXSkBSl7fQrVVhcNF7SJWZDB-gELO0_FJIgdPL2ZwzuA=
0wVQbTPwx7-4vn5dg16FE2HCsAn2UUgMJI29GHA?key=3DHDx3ebciDTqk2MuXMXjB9X1r" wid=
th=3D"344" height=3D"210" style=3D"margin-left: 0px; margin-top: 0px;"></sp=
an></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;co=
lor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:b=
aseline">I received the same error message as before.=C2=A0</span></p><br><=
ol style=3D"margin-top:0px;margin-bottom:0px" start=3D"2"><li dir=3D"ltr" s=
tyle=3D"list-style-type:decimal;font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;vertical-alig=
n:baseline;white-space:pre;margin-left:36pt"><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span st=
yle=3D"font-size:11pt;background-color:transparent;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-=
align:baseline">Checking out the preprocessed code to see if the macro is e=
xpanding correctly. I understand that Coccinelle has the option to preproce=
ss the code before applying a spatch, but I had also preprocessed with the =
C preprocessor (gcc -E) of the file. I understand that applying a patch on =
preprocessed code, where the macros are expanded, requires that the spatch =
match those expansions.</span></p></li></ol><p dir=3D"ltr" style=3D"line-he=
ight:1.38;margin-left:72pt;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-co=
lor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;=
font-variant-alternates:normal;vertical-align:baseline">With simplified exa=
mples, such as the one above, I tried to apply the patch on preprocessed co=
de, where it expands to:</span></p><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-left:72pt;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;font-variant-numeric:normal;font-variant-east-asian:normal;font-vari=
ant-alternates:normal;vertical-align:baseline"><span style=3D"border:none;d=
isplay:inline-block;overflow:hidden;width:289px;height:93px"><img src=3D"ht=
tps://lh7-rt.googleusercontent.com/docsz/AD_4nXfZSAGZD1liPgdEWRbWd2soFXXvuN=
7Ln66V6LBlHF3xnBEHrcEdWIyfMM2N10_dtXzWiws2SDvPnU1MWlS5O5ANOMJZ_XOMEHKVUkPXH=
J2V0kPXmrNvQUPIQ6Xy0Ih4MraUS8Zk?key=3DHDx3ebciDTqk2MuXMXjB9X1r" width=3D"28=
9" height=3D"93" style=3D"margin-left: 0px; margin-top: 0px;"></span></span=
></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-left:72pt;margin-top:0=
pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-=
serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:no=
rmal;font-variant-east-asian:normal;font-variant-alternates:normal;vertical=
-align:baseline">With adjusted .cocci:</span></p><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-left:72pt;margin-top:0pt;margin-bottom:0pt"><span sty=
le=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgrou=
nd-color:transparent;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;font-variant-alternates:normal;vertical-align:baseline">=C2=A0</span><=
span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);=
background-color:transparent;font-variant-numeric:normal;font-variant-east-=
asian:normal;font-variant-alternates:normal;vertical-align:baseline"><span =
style=3D"border:none;display:inline-block;overflow:hidden;width:347px;heigh=
t:223px"><img src=3D"https://lh7-rt.googleusercontent.com/docsz/AD_4nXcLELl=
pbC3w5XjioTqe60X0rcj1hqVyzFOm-DhDteLCJLtxuGYn1x41j0r-p8-yvEw7X_L5gcyK65E6SN=
SDpIXrW4fW0SnzYHju7Y1kgJw9StoBsRiTidIn9ELWZvy0WKWY08Cq?key=3DHDx3ebciDTqk2M=
uXMXjB9X1r" width=3D"347" height=3D"223" style=3D"margin-left: 0px; margin-=
top: 0px;"></span></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margi=
n-left:72pt;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;vertical-align:baseline">Using the spatch on such preproces=
sed code leads to other errors, like:=C2=A0</span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-left:72pt;margin-top:0pt;margin-bottom:0pt"><sp=
an style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;vertical-align:baseline"><span st=
yle=3D"border:none;display:inline-block;overflow:hidden;width:624px;height:=
112px"><img src=3D"https://lh7-rt.googleusercontent.com/docsz/AD_4nXfGz64oF=
jBTtPyjoJsSMTRXrW-ELoXUc0wug9NyW1Gy83piBuORsvO4UjBfByAC73dE5h56s2TzcQ4mZEi4=
RfsFtluLJwGTzyNpe_5ZJnlIBeNIL-r0UsBwjxI5lyVKHUjOp6iKhw?key=3DHDx3ebciDTqk2M=
uXMXjB9X1r" width=3D"624" height=3D"112" style=3D"margin-left: 0px; margin-=
top: 0px;"></span></span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline"><span class=3D"gmail-Apple-tab-span" style=3D"t=
ext-wrap-mode: nowrap;">	</span></span><span style=3D"font-size:11pt;font-f=
amily:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-variant-alternate=
s:normal;vertical-align:baseline">Another more simplified case with testing=
 the expansion alone without the struct:</span></p><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transp=
arent;font-variant-numeric:normal;font-variant-east-asian:normal;font-varia=
nt-alternates:normal;vertical-align:baseline"><span style=3D"border:none;di=
splay:inline-block;overflow:hidden;width:468px;height:264px"><img src=3D"ht=
tps://lh7-rt.googleusercontent.com/docsz/AD_4nXcV_sFkshVZkb7elsFL97QAbZYWET=
LMdaILEyiP00TUIssUQGpUBk2QJT-cpLZHdKqtLJ8OncW7EU96sMad_umZBgpBDrNKvjNBvfrw2=
kQPTxVLa11baGtLr4xGF45zNrSulTwAZQ?key=3DHDx3ebciDTqk2MuXMXjB9X1r" width=3D"=
320" height=3D"180" style=3D"margin-left: 0px; margin-top: 0px; margin-righ=
t: 0px;"></span></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-=
top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,=
sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-variant-alternates:normal;ver=
tical-align:baseline"><span style=3D"border:none;display:inline-block;overf=
low:hidden;width:624px;height:161px"><img src=3D"https://lh7-rt.googleuserc=
ontent.com/docsz/AD_4nXfj46ZjPdGs_w31DavWeAge8ODdFevKPZIL-jStK8u081pXcLdqCj=
wpQI0cDUCwvMcZyzTngQ_S8qGSRB1Vcimrm6Z1_0vJtmdLrgX2leAkK2MQMrKqB6RNhSqqtWBVH=
B6d2Vdv?key=3DHDx3ebciDTqk2MuXMXjB9X1r" width=3D"624" height=3D"161" style=
=3D"margin-left: 0px; margin-top: 0px;"></span></span></p><p dir=3D"ltr" st=
yle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fo=
nt-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color=
:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fon=
t-variant-alternates:normal;vertical-align:baseline"><span style=3D"border:=
none;display:inline-block;overflow:hidden;width:624px;height:101px"><img sr=
c=3D"https://lh7-rt.googleusercontent.com/docsz/AD_4nXfO8A2d5ngtG01ULaQvxMU=
1tWI9PybYeJ0QokLN_XkG_u1B3hcAB0N6hyLYtont7w84IZhpqTbxq_k_Ae-0HKcSmwpIzP2lKR=
Ko8q9h9NQ_qxN9G80wERvaAUJxNF93UyGy56ltKw?key=3DHDx3ebciDTqk2MuXMXjB9X1r" wi=
dth=3D"624" height=3D"101" style=3D"margin-left: 0px; margin-top: 0px;"></s=
pan></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;c=
olor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:=
baseline">The transformation unfortunately was unable to be applied in thes=
e cases.=C2=A0</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margi=
n-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Aria=
l,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;v=
ertical-align:baseline">Some specific questions I have:</span></p><ol style=
=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-t=
ype:decimal;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;vertical-align:baseline;white-spa=
ce:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bott=
om:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fo=
nt-variant-alternates:normal;vertical-align:baseline">Can Coccinelle recogn=
ize the __uint macro inside the struct and apply a patch that uses such a m=
acro?</span></p></li><li dir=3D"ltr" style=3D"list-style-type:decimal;font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:tr=
ansparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-v=
ariant-alternates:normal;vertical-align:baseline;white-space:pre"><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"p=
resentation"><span style=3D"font-size:11pt;background-color:transparent;fon=
t-variant-numeric:normal;font-variant-east-asian:normal;font-variant-altern=
ates:normal;vertical-align:baseline">Can you provide any guidance on how to=
 properly match and modify this struct in Coccinelle?=C2=A0</span></p></li>=
</ol><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:r=
gb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-var=
iant-east-asian:normal;font-variant-alternates:normal;vertical-align:baseli=
ne">I would greatly appreciate any insights you can offer. Please let me kn=
ow if you need more information.</span></p><br><p dir=3D"ltr" style=3D"line=
-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11p=
t;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparen=
t;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-a=
lternates:normal;vertical-align:baseline">Thank you so much for your time a=
nd consideration.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:A=
rial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">Best,=C2=A0</span></p><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant=
-alternates:normal;vertical-align:baseline">Danikka Jelski | <a href=3D"mai=
lto:cmj136@scarletmail.rutgers.edu">cmj136@scarletmail.rutgers.edu</a></spa=
n></p></span><br class=3D"gmail-Apple-interchange-newline"></div>

--00000000000042a492062f9ee1a9--
