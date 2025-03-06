Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28908C282D1
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zm0uCJ5PWbDZ59chkURVe3ql0EMkTYlaB80NiKqlpDY=;
  b=JAyJpQtIbQdaCSogLC6BWJCPxoYA9p6traQRo6Sl6nnBm7J6/U4/nhLb
   MVnOi6NKHuBRpOPucm8oMIsVBLj0SiYL48LRv42qSCUi6990hP2/MPmav
   wPRih9z1S7DUBiWgH3zZhV+RazPsDG2/4v3CGr7+vi4PLAd1UMJE2j0+Y
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
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="211543782"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 13:19:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B63F9E0D1F; Thu,  6 Mar 2025 13:19:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E0A1DE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Mar 2025 13:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zm0uCJ5PWbDZ59chkURVe3ql0EMkTYlaB80NiKqlpDY=;
  b=P4egWT3tcwI/cQIOdGwgWQxdUKPmHbZWFej2XKRVqpX5qO9GotAJjIuM
   jC3gfgJHt14nhRVK9KEzKv51DRU96JZ6m4y7n/Q00CSRtIq1LVo3Jf3qh
   ZPi8BTK7951uuonXyyYoHJl3YqEaye1S1xXyPjH8Vzq4k9ycbP6Rx+zAH
   4=;
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="110843396"
Received: from unknown (HELO hadrien.lan) ([172.59.112.6])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:19:37 +0100
Date: Thu, 6 Mar 2025 07:19:34 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Danikka Jelski <cmj136@scarletmail.rutgers.edu>
cc: cocci@inria.fr
In-Reply-To: <CABDMBwh_LRL+Dxz94caz+ybJT5MLP9usBs12fLeDHaTSnOES3A@mail.gmail.com>
Message-ID: <f3c7b17c-dbdc-44a3-43d9-bca26a95bf3a@inria.fr>
References: <CABDMBwh_LRL+Dxz94caz+ybJT5MLP9usBs12fLeDHaTSnOES3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-383197752-1741263577=:3340"
Subject: Re: [cocci] Question about Coccinelle (with __uint macro)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2567
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/f3c7b17c-dbdc-44a3-43d9-bca26a95bf3a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-383197752-1741263577=:3340
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 5 Mar 2025, Danikka Jelski wrote:

>
> I hope this email finds you well. I’m reaching out to seek guidance about
> how Coccinelle parses complex macros. In my current research project, I am
> working with Coccinelle on Ubuntu 22.04 (kernel version 6.0 generic), and
> I’m experiencing issues regarding parsing complex macros. Specifically, I
> was trying to modify BPF map definitions, and I encountered an issue when
> applying a patch:
>
>
> @@
>
> @@
>
>  struct {
>
> -  __uint(type, BPF_MAP_TYPE_ARRAY);
>
> + __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>
>   __type(key, u32);
>
>   __type(value, struct array_elem);
>
>   __uint(max_entries, 1);
>
> } port_state SEC(".maps");

Please try adding a metavariable:

declarer name __uint;

On the other hand, I don't know how the SEC thing will work.  Is that
something that you care about whether it is there or not?  Do you care
about the declaration of port_state?  If you actually just want to change
the type declaration wheerer it occurs, you can get rid of "port_state
SEC(".maps");".  Then it will just work on the type.

As Markus mentioned, please make messages that contain only text.

thanks,
julia

>
>
> In this patch, I wanted to change the BPF map from BPF_MAP_TYPE_ARRAY to
> BPF_MAP_TYPE_PERCPU_ARRAY from the __uint. I have a similar problem where it
> cannot parse the __type macro either when I had tested for that macro
> independently. 
>
>
> The error I get is:
>
> [AD_4nXdSOIb1mx6UOgK95vL1l3BTTwStJgl3BWKcm0S7gx13MpOcwIBj5hyWIY9R6lFCBn_7al
> jh2uohN2suEGtxDPjP5Q9Qh0S6wDo496iVST5EbGj7v7uU17ul68j8K09zMG436N5NrQ?key=H
> Dx3ebciDTqk2MuXMXjB9X1r]
>
> Some troubleshooting I have done included:
>
>  1.
>
>     I made simplified .c files with simplified headers to check if the issue
>     was due to missing kernel dependencies and to isolate the issue. It
>     seems that it wouldn’t parse it this way, either.
>
> One of the simpler examples I did was:
>
>
> [AD_4nXcze023-F5OV4Rax-hTjRdtcBoJVlO03zGi1HwEJW6YULoqcVl41_liGdiiQU40tigM4q
> bzBGkLpzifzmy-NCew7kr7BNi3nfc_pdNZAp7QcWj4mkab6thRYrgNamaAzz0zY6II-w?key=H
> Dx3ebciDTqk2MuXMXjB9X1r]
>
> [AD_4nXe44xFLkphNYL16klw0BOw1N-sgjYydSe4K8ebUEf0P7LzHzXHh64dyXSkBSl7fQrVVhc
> NF7SJWZDB-gELO0_FJIgdPL2ZwzuA0wVQbTPwx7-4vn5dg16FE2HCsAn2UUgMJI29GHA?key=H
> Dx3ebciDTqk2MuXMXjB9X1r]
>
> I received the same error message as before. 
>
>
>  2.
>
>     Checking out the preprocessed code to see if the macro is expanding
>     correctly. I understand that Coccinelle has the option to preprocess the
>     code before applying a spatch, but I had also preprocessed with the C
>     preprocessor (gcc -E) of the file. I understand that applying a patch on
>     preprocessed code, where the macros are expanded, requires that the
>     spatch match those expansions.
>
> With simplified examples, such as the one above, I tried to apply the patch
> on preprocessed code, where it expands to:
>
> [AD_4nXfZSAGZD1liPgdEWRbWd2soFXXvuN7Ln66V6LBlHF3xnBEHrcEdWIyfMM2N10_dtXzWiw
> s2SDvPnU1MWlS5O5ANOMJZ_XOMEHKVUkPXHJ2V0kPXmrNvQUPIQ6Xy0Ih4MraUS8Zk?key=HDx
> 3ebciDTqk2MuXMXjB9X1r]
>
> With adjusted .cocci:
>
>  [AD_4nXcLELlpbC3w5XjioTqe60X0rcj1hqVyzFOm-DhDteLCJLtxuGYn1x41j0r-p8-yvEw7X
> _L5gcyK65E6SNSDpIXrW4fW0SnzYHju7Y1kgJw9StoBsRiTidIn9ELWZvy0WKWY08Cq?key=HD
> x3ebciDTqk2MuXMXjB9X1r]
>
> Using the spatch on such preprocessed code leads to other errors, like: 
>
> [AD_4nXfGz64oFjBTtPyjoJsSMTRXrW-ELoXUc0wug9NyW1Gy83piBuORsvO4UjBfByAC73dE5h
> 56s2TzcQ4mZEi4RfsFtluLJwGTzyNpe_5ZJnlIBeNIL-r0UsBwjxI5lyVKHUjOp6iKhw?key=H
> Dx3ebciDTqk2MuXMXjB9X1r]
>
>
> Another more simplified case with testing the expansion alone without the
> struct:
>
> [AD_4nXcV_sFkshVZkb7elsFL97QAbZYWETLMdaILEyiP00TUIssUQGpUBk2QJT-cpLZHdKqtLJ
> 8OncW7EU96sMad_umZBgpBDrNKvjNBvfrw2kQPTxVLa11baGtLr4xGF45zNrSulTwAZQ?key=H
> Dx3ebciDTqk2MuXMXjB9X1r]
>
> [AD_4nXfj46ZjPdGs_w31DavWeAge8ODdFevKPZIL-jStK8u081pXcLdqCjwpQI0cDUCwvMcZyz
> TngQ_S8qGSRB1Vcimrm6Z1_0vJtmdLrgX2leAkK2MQMrKqB6RNhSqqtWBVHB6d2Vdv?key=HDx
> 3ebciDTqk2MuXMXjB9X1r]
>
> [AD_4nXfO8A2d5ngtG01ULaQvxMU1tWI9PybYeJ0QokLN_XkG_u1B3hcAB0N6hyLYtont7w84IZ
> hpqTbxq_k_Ae-0HKcSmwpIzP2lKRKo8q9h9NQ_qxN9G80wERvaAUJxNF93UyGy56ltKw?key=H
> Dx3ebciDTqk2MuXMXjB9X1r]
>
> The transformation unfortunately was unable to be applied in these cases. 
>
>
> Some specific questions I have:
>
>  1.
>
>     Can Coccinelle recognize the __uint macro inside the struct and apply a
>     patch that uses such a macro?
>
>  2.
>
>     Can you provide any guidance on how to properly match and modify this
>     struct in Coccinelle? 
>
>
> I would greatly appreciate any insights you can offer. Please let me know if
> you need more information.
>
>
> Thank you so much for your time and consideration.
>
>
> Best, 
>
> Danikka Jelski | cmj136@scarletmail.rutgers.edu
>
>
>
>
--8323329-383197752-1741263577=:3340--
