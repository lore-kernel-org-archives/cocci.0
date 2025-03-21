Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10908C36002
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RxYuIwsVZMYw9oO0sh4fObk9THQvyZmMu0JIq9V+jrw=;
  b=AgSgol7f0WEFq0mdklb/7OH7TIvgS5dqpNWcPpSyHr/kP3ezHqUzWgkp
   Alb0XhUlDHuK0AQ9JhsNhfiMvLwczD/qg/1+V2+sz0ovb0ajva2TU10HI
   ChXo04TVmsrelHV0IuF7B6+cUv/TkNVqemfLGvQZFbt5u1npCqUIFMu8s
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208,217";a="214125021"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 13:46:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 910AFE0D1D; Fri, 21 Mar 2025 13:46:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 226B5E007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 13:46:38 +0100 (CET)
IronPort-SDR: 67dd5fad_mF9yd2G6DlG5fWNED9msDWXFEQHoTdlShEEAhBehU4SjFtT
 IYfo04p4rcB9YiPP5JigA8UUZ336x1AEghW+tVQ==
X-IPAS-Result: =?us-ascii?q?A0EFBABPXt1nganWVdFaHgEBCxIMgggLAoJCfVk0BAtIh?=
 =?us-ascii?q?FaBI44ugiSKJJNwgUA+DwEDAQ07CQQBAQMEgUsBgm5GAosiAh4HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDjuFew1JARABg?=
 =?us-ascii?q?gcBgSRRDQMCBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQINHz8BHwEBAQIBEhEdARsdAQMBCwYDAgQHNwICIQERAQUBHAYTIoJhg?=
 =?us-ascii?q?i8BAw4jAxGSBI9AgQVCiz6BFQUCFoEBgg0G2l0KGSgNb0GBIQIBBhSBNIR2K?=
 =?us-ascii?q?VyCVQGBXQIOh3x6JxuBS0KBFTWCdT6EcIMugmkEgi+BaYNBqjMmCAcXAwcHC?=
 =?us-ascii?q?QUECRMGBQUCQgkFAQ8SAwQDBAQBAgsJCgkDAwIOAggDAggGGQE/EgQTCg0LB?=
 =?us-ascii?q?wUfCggMEQooAyIEDisKAQIBWjQBCAYCAgQEAgQCCgIJAgIIBwITAwIEBAIBB?=
 =?us-ascii?q?RIDCwEFBgUBAQQJDgICAwMCAgEIAgIBAQITAQQDAQcCBQMFAwoBAQECAQQHD?=
 =?us-ascii?q?gQDBQMDBwMEAgMCBgIEBAEFAgIDAwIDAQMDAgECAwYEEA8WAgIDBAIGAgEEJ?=
 =?us-ascii?q?gIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICAgMVAgUBBAkDA?=
 =?us-ascii?q?wUSDCADAgICAgMHCgMFAgEBAgQDAwMDDA0HAgMBAgEDBQMBAgECCQMGAgIDA?=
 =?us-ascii?q?wQSGQUDAg8DAgEFBAIIEAsHAQEPFAUECRcDBgIDAxYLBAUDAwMBDA8OAgILA?=
 =?us-ascii?q?xcFAQEHAQMNCAMEBAIDAwkCARABAwQCCQIEAQIKAgICAgIEAQEFBAIEAwIFA?=
 =?us-ascii?q?gIBCAQDAwMNBAMICAMFAwwSAgICCQIDAQIDAwMOCB0FCRELAgkDBA0CBAICA?=
 =?us-ascii?q?QYDBgoGFAECEgICBgwEAwMIAwIDAgEBAgICARECCQgNBQkFBgICFQMCAwgBC?=
 =?us-ascii?q?QMRAhQBBgIIAwcBAQQCAgoTCgEBAgIBBiICAQECExMHAwgCAgICBhYMAQUHA?=
 =?us-ascii?q?wcPBQUEAgIWAwMRBAQQAgIDAwIBARQGFQEFAgMGCwEGAQIFBAIDBAISAgMOE?=
 =?us-ascii?q?wMDBAYDAQIKDgICAgkKAQUEAwcFAh8DAwICBQsCCAICBQIFBwMJDgECBQMEC?=
 =?us-ascii?q?QIUAhACAgIIFgICAgUFFwMmAgQDAwMDCwECAg4JBjYGEQQCAwMCDgECAgsBA?=
 =?us-ascii?q?gIEAgMBBAcJAwMJCgcBCg0HAgoICRABAgIQAwICAgIGBw4DAhMPBQYGAgoHD?=
 =?us-ascii?q?QsCAQICFQIDCQYDBQoDBwQKDQIVAhUFAyACCAkLAgcRAgUSAw4FAwICEQQCA?=
 =?us-ascii?q?wMFAwEHARUDBwgCAgwCAgICBQIFAgUXEQ0EAwMDAggBBBUGAwkIKhsQAQEFA?=
 =?us-ascii?q?QkCAwIDBAgDAwMCBgwLAgEHCAMDBgsICQYDAgcIGQMFBAMHBQshAgYDAgQFB?=
 =?us-ascii?q?AEFAhMNAgMZAgYDBhEJDQYIBwkDBwEBAQICAggBBgUSAgMEAgUEBAEBCAMDB?=
 =?us-ascii?q?AYCAQMCAgIBBAkCAQIKAggKAQkTBAMIAwMDAwMFAQICCAQRBQUCAQUKEwwKB?=
 =?us-ascii?q?gMGAwQCAgIKAQcCAwMDAgcBCyMCAQMCAgUCAgEFAwICBgQDAgEBCQIDAggBA?=
 =?us-ascii?q?gIBAgICBAEHAQQHBgEBAgQCAjICAQMJAgUBAQ4CAgQCAgECAgIEAgQBAgYLB?=
 =?us-ascii?q?AUNAQECAQICAQEBBAEIAwEBAQICAwMFAwUDCA8NAQEXCx0DBAUCAgEBAQECE?=
 =?us-ascii?q?wICAQcBAgEBAxoCAQMDBAELAgEBBB8EFgICAgICBAMCAgMCAgsTJQECAwUDE?=
 =?us-ascii?q?wICBAIBAgIFBQUBAwQREwYJAwIFBAICBgIEBgoCBwQCGgQCAgIBAwQGAwECC?=
 =?us-ascii?q?AICBwQEBgMCAgECAgcYAgIZAQMBAQICAgQCAgIJCgQFBAQEAwICAgEMAwECA?=
 =?us-ascii?q?wICAgIBAwICAQECAwECBQYNAhICAQMRCAQCAgcCAiMPCwEBAgEBAgYGAgMDA?=
 =?us-ascii?q?woDAQoBAgEBAgYCAQISBQICAQIEAQICBgQnAQIBAgEBAQUCAQIBAgQCBwIBA?=
 =?us-ascii?q?gIDCAEFAgYBAgIJAQIBAgICAQIBAQIGAgEBEQQBAgICAgIDAQMGAgICAgICC?=
 =?us-ascii?q?QICAgIFAgUDAgMBBgICBQIDAwICAwQDCQMDCAMGBAIDAQEBAgECAgIBAgIBA?=
 =?us-ascii?q?gIFAgMDCQEBAwIBAgICAgMGAgUFAQMIBwUEBwEBAgEDAgMFAwMCAwUFAQILH?=
 =?us-ascii?q?QIJAyMPAwsJCBM9AQsHMgQ2ARQUByshX6JnATqEI4EuLC+CSKJ2oyZogjSBC?=
 =?us-ascii?q?YwYlUozqlcumFCOBZsdESMSgTkNJoFccBVsgjZPAxkPjiEJGYNYuzNFMjwCB?=
 =?us-ascii?q?wEKAQEDCYI5ilODEIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RH0i0UD6I+5xIy9FVFYJcjlO368b57UMwz0sQ==
IronPort-HdrOrdr: A9a23:ot+pS6MXumBEBcBcTtSjsMiBIKoaSvp037BL7SBMoHNuGfBw+/
 rFoB15737JYVQqN03I8OroUJVoJ0mwyXcf2+cs1NmZMDXOiS+DKoZ+5YH+hx3scheOldJg6Q
 ==
X-Talos-CUID: 9a23:xJmdiWCMmPqWg736ExBL1XAFIpEgTibUkC3xElPjDW9Ec7LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AQi+gSAzjeF0BwbUoyES+boUI9/KaqOf0D3BSnLg?=
 =?us-ascii?q?FgdKvciBxEDG7tGWLRaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208,217";a="112253033"
X-MGA-submission: =?us-ascii?q?MDH49FRpfA09OmcdeGUnKhe+mwj5j+H/R/KTXk?=
 =?us-ascii?q?0EcGhEJiNrLVXF15o3uLve6JqxHFY+/xMEhxcVHRfQSkvU0uHYig5UMR?=
 =?us-ascii?q?Ni0jS6YlkNhE0nafSQwW46vrh0ifKwQbFpt/cpsCaFElbTSl97UOGeNC?=
 =?us-ascii?q?1RmrPGcupB+5mX6q+Dq7fobw=3D=3D?=
Received: from mail-pl1-f169.google.com ([209.85.214.169])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:46:36 +0100
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so37614465ad.2;
        Fri, 21 Mar 2025 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742561195; x=1743165995; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxYuIwsVZMYw9oO0sh4fObk9THQvyZmMu0JIq9V+jrw=;
        b=LhcIvS/YJzbCdGlPvVtLLY+9L2WJZvCUBnXLUylO+CdW0Ity7/qzJ0wdlQCAGkFzpK
         m3s/9OL8hz1qyezXtLqOfNs8BNoIy68e//KZnu6wYPy4RPWSkAwiRrtHXEqmm0M12N/v
         NxZskTOBcfKj26dof45UVGLenvcIOZ4rv58y/aRhKMQ/EE0t4trPC4Fkrs/51oeATdsR
         SL1dtm2ChrA9c+WpwgatQWU6b+67IZBpiBcYMppBfFozNn6OurQbCCTzuu2NHWcIad8F
         N761W9mc6DDqu0IK1DoCiXuIFImrvWXcw6e/W/92OVD0Q3cvmh3NBvd5oKuQ0ZGQrx1Y
         IZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742561195; x=1743165995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxYuIwsVZMYw9oO0sh4fObk9THQvyZmMu0JIq9V+jrw=;
        b=fOfFxhlyBHIx0NriRjvugElykdGjoCXBM0F/AcW8OmPAmD41/FgooiSph3hD36tvCd
         f6wtzRq8Uh1cyCuba1u4544va6nWfu6OfANqAcnYAC9mc1+0gaaY5pI36R7/pEsHtAbE
         mOZIyWBRYTuYjbQP9xYc/zd0ewEczHfiNPUYrGlmR6j/Wzj12iUW+uyd5wJlzazNHGEB
         6DHcl+J7095DSbhFF6FF+OBNdX1rcilX2JLczZ7XCBgZzxDs4KKEP5Pm24WI9UEWPc4V
         9QS/JabmOf1hImsnqf0AaTTsA4SSF7tvECyUgUJ4/g3VknGhGvq59oSw+BpPzEJKKQtQ
         jOng==
X-Gm-Message-State: AOJu0YzAaz/7/TuZ/qyaiseWB2RVJUDcdl1ia1pPMqyDNE+M9cih9jMF
	1n+xxbixgOJT9b4Zdn0Eh3XftohPACGC+wZqpFVqnOK8qe5mYNQzGBxs5qTGqHRcA8Zt2S5rl9S
	4DBrQ/3CPIdlIIaeyapCmnWxueq0ZHJq7
X-Gm-Gg: ASbGncvGPfAXMGMihEDRx8G/2LqoaDoTV0E8kznNEw9vijhdetzNnm2oWJn6rXvyh98
	p/FjNNVYVDYDZ+ybjOXcun16bnkjP4+KLR5yz1jwiqeNSVz8XdN9nuQd3LkOA6UMq+O5R/HQbNR
	4nY+E5JDpTZbeyd0fw2et+rh38ogxdV9KIBpyg
X-Google-Smtp-Source: AGHT+IHUemyAbiIFt9jbt5FwBbMFcfycnjsxyZUsu2cenIIVnUgrir3OkP1K4vQdbw7le+p5OFEKKQ1so7a58afiXYY=
X-Received: by 2002:a17:90b:4c0f:b0:2fe:99cf:f579 with SMTP id
 98e67ed59e1d1-3030fe5b15bmr4876207a91.4.1742561194539; Fri, 21 Mar 2025
 05:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
In-Reply-To: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
From: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Date: Fri, 21 Mar 2025 13:46:22 +0100
X-Gm-Features: AQ5f1Jo7Z1HKOydGQOz5hxYzAlPw0WyTtEPeV3CC_xp2c9UeKmjBd2S4RjvOOiU
Message-ID: <CAACXqO9vVrOFyrcZhKZxvO=H9C7Kp-x2jM9O_mCTd=RA0mQ5XA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000000009d30630d9a535"
Subject: Re: [cocci] scoped_guard
Reply-To: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2664
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/CAACXqO9vVrOFyrcZhKZxvO%3DH9C7Kp-x2jM9O_mCTd%3DRA0mQ5XA%40mail.gmail.com>

--0000000000000009d30630d9a535
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Mar 2025 at 12:50, Julia Lawall <julia.lawall@inria.fr> wrote:

> Coccinelle offers the "metavariable" type iterator for the names of things
> that work like for or while.  That is, they represent the header of a
> block and they cause a loop.
>
> Now the Linux kernel has scoped_guard that represents the header of a
> block, but isn't a loop.  So the name iterator is not suitable.  One
> option would be to just make special cases for scoped_guard and
> scoped_guard_cond, but other similar cases could come up over time.
>
> Any suggestions about a possible metavariable kind for these names?  Maybe
> just header and header name?


My first encounter with scoped_guard is looking it up just now, however
since the core functionality of the macros is to start a (guarded) block
I think "block" should be part of the name as the most essential property.

The Linux and resource specific properties are not essential, this could
also be used for a general hypotetical `mydebug` macro like the following:

    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        ...
    }

    fseek(file, 0, SEEK_END);
    long fileSize = ftell(file);
    fseek(file, 0, SEEK_SET);

    mydebug(dbg_ctx) {
        printf("%s is %l bytes\n", filename, fileSize);
    }

    char *content = (char *)malloc(fileSize + 1);
    if (content == NULL) {
        ...
    }

    size_t bytesRead = fread(content, 1, fileSize, file);
    ...

So brainstorming a few name suggestions:

block_header
block_start
block_begin
block_prefix
block_setup
block_factory
block_creator
block_constructor

Scope *could* perhaps be used instead of block, however scope does
not work without being associated with a resource, so I think it is a
poor fit.

The concept seems similar to the `using` statement in C#,
https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/using
.

--0000000000000009d30630d9a535
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, 21 Mar 2025 at 12:50, Julia Lawall &l=
t;<a href=3D"mailto:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Coccinelle =
offers the &quot;metavariable&quot; type iterator for the names of things<b=
r>
that work like for or while.=C2=A0 That is, they represent the header of a<=
br>
block and they cause a loop.<br>
<br>
Now the Linux kernel has scoped_guard that represents the header of a<br>
block, but isn&#39;t a loop.=C2=A0 So the name iterator is not suitable.=C2=
=A0 One<br>
option would be to just make special cases for scoped_guard and<br>
scoped_guard_cond, but other similar cases could come up over time.<br>
<br>
Any suggestions about a possible metavariable kind for these names?=C2=A0 M=
aybe<br>
just header and header name?</blockquote><div><br></div>My first encounter =
with scoped_guard is looking it up just now, however <br>since the core fun=
ctionality of the macros is to start a (guarded) block<br>I think &quot;blo=
ck&quot; should be part of the name as the most essential property.<br><br>=
The Linux and resource specific properties are not essential, this could <b=
r>also be used for a general hypotetical `mydebug` macro like the following=
:<div></div><div><br>=C2=A0 =C2=A0 FILE *file =3D fopen(filename, &quot;r&q=
uot;);<br>=C2=A0 =C2=A0 if (file =3D=3D NULL) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ...<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 fseek(file, 0, SEEK_END);<b=
r>=C2=A0 =C2=A0 long fileSize =3D ftell(file);<br>=C2=A0 =C2=A0 fseek(file,=
 0, SEEK_SET);<br><br>=C2=A0 =C2=A0 mydebug(dbg_ctx) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 printf(&quot;%s is %l bytes\n&quot;, filename, fileSize);<br>=C2=
=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 char *content =3D (char *)malloc(fileSize=
 + 1);<br>=C2=A0 =C2=A0 if (content =3D=3D NULL) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ...<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 size_t bytesRead =3D fre=
ad(content, 1, fileSize, file);<br>=C2=A0 =C2=A0 ...<br></div><div><br></di=
v><div>So brainstorming a few name suggestions:</div><div><br></div><div>bl=
ock_header</div><div>block_start</div><div><div>block_begin</div><div><div>=
block_prefix</div></div></div><div>block_setup</div><div>block_factory</div=
><div><div>block_creator</div>block_constructor</div><div><br></div>Scope *=
could* perhaps be used instead of block, however scope does<br>not work wit=
hout being associated with a resource, so I think it is a<br>poor fit.<br><=
div><br></div><div>The concept seems similar to the `using` statement in C#=
,</div><div><a href=3D"https://learn.microsoft.com/en-us/dotnet/csharp/lang=
uage-reference/statements/using">https://learn.microsoft.com/en-us/dotnet/c=
sharp/language-reference/statements/using</a>.</div><div><br></div></div></=
div>

--0000000000000009d30630d9a535--
