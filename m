Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402CBC43217
	for <cocci@archiver.kernel.org>; Wed,  2 Nov 2022 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LiVYmAj8NkK8hl/2Y4cjocfl2puqRvtArH8Rorhct7U=;
  b=Hf/m7MpMzGjjiHZu8OqjZHn4ihs/vpcQLyBOCblNkDjr4fjlT5JLVe8z
   x/4SLiO5gGmbluX7X0MvdNuWZZm49d/N1QOlTm/Hdb/5VdpBhCnibNj+G
   FUinGrtoArvAunNszF7fef/egdu6FK/3TavAm8TCyo6pRylY/7YmQNlIn
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72700833"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2022 18:11:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA916E01BE; Wed,  2 Nov 2022 18:11:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 09380E002A
	for <cocci@sympa.inria.fr>; Wed,  2 Nov 2022 18:02:16 +0100 (CET)
IronPort-SDR: 6362a297_PUym4R5bKm0psuTZq5g1gliY5MrjZ2LqYct9qOP/BNsmvjn
 BI2PQUkgbUXFIP78gDqlBUmkxnmWhYo2En1zDdg==
X-IPAS-Result: =?us-ascii?q?A0A0BwBPoWJjfzGAVdFaHQEBPAEFBQECAQkBFYFPAoIrM?=
 =?us-ascii?q?wGBIi8EC0WETo51jWyBB5BbgX0PAQMBDRQBLwQBAYoAAh0HAQQxCA4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEYCRkHDg4FJIVoDYI1IoQEE?=
 =?us-ascii?q?R0BGx4DEhAPAiYCJAERAQUBV4Jbgm0BAzADnWOCH4EEQosygRUFAhaBAYIJB?=
 =?us-ascii?q?lKXQQoZKA1rgVoCBxJ/LAGFDYITHFdchw+BIRyCDYEVNoJFAS6FT4MKgmYEl?=
 =?us-ascii?q?jsBAwcDBAYFDwMDAiEBAgFDHQIJAyMPAwsJCBM/BgECAQEMB0AEBhUfAwEBD?=
 =?us-ascii?q?yQBAQICAgMEBwIBAwYDDAICAQEBBQYNAwIDCBMDAgEDBQICBAECBAoIAQICA?=
 =?us-ascii?q?QIEBQcCAQgGBQ0FCQsBAQIDBwQDEQIFAwUFAwMCAQoFAgMBAgEBAwYEBAEBA?=
 =?us-ascii?q?gMCAgEGAgIBAQMDBAMBAgYCAgcCAwIBBAIDAwEBAQICAgICAgMDCQIIBwUBB?=
 =?us-ascii?q?gECAQQDAgIBAgcBBAEIAwMFBQkPAwUDAQMDAhQKBQEDCAYIAgQFAgUDAgQCA?=
 =?us-ascii?q?wICCAMCBAMLAwUEAgcEDwcCAwICBQICAgICBQQDAQICAgICAgUCAwIBBQECA?=
 =?us-ascii?q?gECAgIEAQICBwQCAwEDBA4EAwICBwECAgEGAgcDAQIBBAMBAQQCBAECBQIEA?=
 =?us-ascii?q?QMGAgQDCgICAwICAgYFAwMKCAIDBQIEAQECBwQCAgsBBgIHAgIDEAEDAQQFB?=
 =?us-ascii?q?QMDAwkCAgMCBAICCgEBAQECAQcCBAcNAgICBAICAgEDAgIBAQICChIBAQIDB?=
 =?us-ascii?q?gQGBQMCCBgBBgIBAQICAwMCBgIBAggCBAEEBQIBAgICAgQBAwYCAwEBAgECA?=
 =?us-ascii?q?gMDAgEEAgQDAwECAQICAgMCAgIDAgIBDwIGBgECAgICAgICAgIGAQIBAgQCB?=
 =?us-ascii?q?wIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCBwUCAwEEAwQDAwsFDAgBBQEDA?=
 =?us-ascii?q?SADAgIIAgcCAQYFAQ8DAgIDAgIBBAoCAwUCBAIBBAgHAgQBAgkDAgYCBwUYA?=
 =?us-ascii?q?QICBwQMCgICAgUGAgQBAQIDAQIBAQIDBAIDAgQFAQUCAQIFBAICAQECBQIMA?=
 =?us-ascii?q?QEHBgIHAgICAgMBBAIBAgEDAwIDAQEBAwYGBQQEAgMDBgICAgYCAgMCEQMHA?=
 =?us-ascii?q?gYDAgQBDQ8FBAUIAQIBAQcCBAIHCQ4CAQYBBQICAwICAQUCAQYDAQICAgIFC?=
 =?us-ascii?q?AUDBAUDBg8DAQEEAwIBAgEEAwIDBwMCBAQDAQIDBAYGAQkDAgIGAwICAg0DB?=
 =?us-ascii?q?AICAQIBAgMEBAYCAgIBAgICAgMBBAICAQEDAwMCAgIDBAIDAwsGCggCAgIDA?=
 =?us-ascii?q?gEFCwQCAwIBAwYJAgQCAgYBAgQCAgICAgICAwEBAwoEAgECAwICBgMGAgECA?=
 =?us-ascii?q?QIBCQUCAQkDAQIBAwQBAwkBAgIECQIEBwUEBgQCAgICCAICDgMDAgEBBAICB?=
 =?us-ascii?q?AUCAgsCAQIHAgUBAQMFBwICAQICAQQDAQkEAQICAwIBAQMDEQMDAwEEAgIFA?=
 =?us-ascii?q?wMNCQYCAgEDAgMBDQMDAQIBAgMBBQUXAwIBCAcDEwMCAQEDAgECAgMGDQICA?=
 =?us-ascii?q?wMDAgECBQIEAwMBBQIBAQMBBQMCDgMCAwMDAgYBAgEBAgMDAQwEBQEBAQEXA?=
 =?us-ascii?q?QIDAgQCAgEBAgUBBAMBAQIBAgMCAg4GAQQFDAMCAQIfAgIDAwEEBQICAggCA?=
 =?us-ascii?q?gIBAwMBAwMFAQIDBAICAQUECgICAgICAgIBDAIKAwIDAQMFAQEEAgkFAQUBA?=
 =?us-ascii?q?gcCBQKbNRNMW1KBLZI3jjihMWODDgWEN4VslicyqROXLaI0BYUuECMSgS4BO?=
 =?us-ascii?q?IFbTSNQMYI2TwMZD5ISil9DMTsCBwsBAQMJij4BAQ?=
IronPort-PHdr: A9a23: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
 54DDLRcUQ5tfs4=
IronPort-Data: A9a23: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
 aMJqayoja11pYMd0SqtRpKNJCwkgQ==
IronPort-HdrOrdr: A9a23:OH8GcaH0h39H9m8GpLqE5ceALOsnbusQ8zAXPiFKOHtom6mj/f
 xG885rtiMc5AxwZJhCo7G90cu7MBHhHPdOiOF7AV7IZniChILHFvAH0WIg+VHd8u/Fm9K1GZ
 0OT0G2MrPNMWQ=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72699321"
X-MGA-submission: =?us-ascii?q?MDE/ccl1BOkowlKlQJHszePL/pCN927xWfAerW?=
 =?us-ascii?q?e7BRO69k2E2t/4j++CIitlUlbtrL29avIjKYg5HsWpsoThytk/lxEu2I?=
 =?us-ascii?q?qSGCtkwWpXcSYjvzwBIaxV7fK6mfxZt/t3CbZXFNwUt1uP4OIiDPpQA7?=
 =?us-ascii?q?Mq6kLQjYl7tHtRRQ8u95Ez5w=3D=3D?=
Received: from mail-wm1-f49.google.com ([209.85.128.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 18:02:15 +0100
Received: by mail-wm1-f49.google.com with SMTP id v7so5282133wmn.0
        for <cocci@inria.fr>; Wed, 02 Nov 2022 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LiVYmAj8NkK8hl/2Y4cjocfl2puqRvtArH8Rorhct7U=;
        b=XYhUK6Ogmmg9cqXOBs0fQjCwdwA3rx7rVU8OZ7m8n0fE43kQGS27YbxyTDeqEsXHwv
         jVN4Nk29x8buJuzU/BPjDXMsN4mRBM03wrUc9lfhCxbG9Q3SDWwr04ZBbMN0yWP9HaO4
         0sOhHLTtSewFLVVP7adzXThbPvu/hPRMRdjsQKurfcjs0rfRGYF2ZA/jviSa1cEdnAXE
         EZ/D2dTGYHK5LO/FR3muCpy1TiNuUcWTDnCMQG9ICN68+8LxY9M4nTLMg9wAlAGl09h7
         5TF70XCaAjpzy2YjGmDssWF7tPjUIlpgaMBP4lhNVcslC4ndE3rdkA1SCyOX33P7TvM+
         jErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiVYmAj8NkK8hl/2Y4cjocfl2puqRvtArH8Rorhct7U=;
        b=yYy2IRPNMjAeguBbr22aFu5K+Nd6aBtNpcC+teY0t+x6IilOqaQMy5JgDOyVAwNKyP
         b3UbYCiBR1p5Vd07jp2LeKtBNxecTqdksCrWuhSX6taCU1I+l2ITFx79A2njC03mbR4Y
         NXkJ3OcoADQzS8KWmVbTK798r6TW4jJy+wLcJu88l0q7IDn0xUwUdadfcIITfaYAJfPh
         JwzSQ0mNPuj3lHUAwLUp+CbHUeg6PYdLX7IH8L/0/Xl+qLqh1qYPkHP74RERKj0N3+F2
         QUMae6bEUvi6ODo3vTKMW4w1DI+eXqMEo1sMkrxcBVFoTt3ShLRHpRa89DGUXa4kfQsi
         V+Xw==
X-Gm-Message-State: ACrzQf0tRbCYjrw+iMAD8yjPavGwFFP4Ei2A0ytPsWgRyjm/LUJ3pXfo
	gU2Z1HC8NSNFX6DiBAk3dcD0bzr9DBBDmrD3UqTy503IFsn6/A==
X-Google-Smtp-Source: AMsMyM4HvmGUz5RgSFNV3g57alR6wAoL9VyEAmNZ8QXPEdHhxU8CtLrL1h/xyZhTP+G14+mdHmSwRYJhtOc/7yZIPFw=
X-Received: by 2002:a1c:3841:0:b0:3cf:6d9a:7af4 with SMTP id
 f62-20020a1c3841000000b003cf6d9a7af4mr12872260wma.50.1667408534852; Wed, 02
 Nov 2022 10:02:14 -0700 (PDT)
MIME-Version: 1.0
From: Sebastiano Miano <mianosebastiano@gmail.com>
Date: Wed, 2 Nov 2022 18:02:03 +0100
Message-ID: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Replace custom function multiple times
Reply-To: Sebastiano Miano <mianosebastiano@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 697
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/CAMENy5qK-KB1_D-zgh%3DUyLarKVaup-J0yRdZwTL-fkyn_gQhJg%40mail.gmail.com>

Hello,

I am trying to use Coccinelle to replace a function that is called
multiple times in the code with a different version whose name is
taken from the string variable that is passed as the second parameter.

To explain better, my C code is the following:

#include <string.h>

static int process(__u64 off) {
  MERGE_FUNCTION_OPENED("file.c", "ping_pong", arg1, arg2, arg3, arg4, NULL);
  MERGE_FUNCTION_OPENED("file2.c", "ping_pong2", arg1, arg2, arg3, NULL);
  return 0;
}

I want my code to be transformed into the following version:

#include <string.h>
#include "file.h"

static int process(__u64 off) {
  ping_pong(arg1, arg2, arg3, arg4, NULL);
  ping_pong2(arg1, arg2, arg3, NULL);
  return 0;
}

where the string that is passed as the second parameter is used as the
function name, and all the other arguments are copied as they are.

I managed to write a working cocci script (listed below) that is doing the job.

@merge_annotation@
expression path, fn;
@@

MERGE_FUNCTION_OPENED(path, fn, ...);

@script:python merge_p@
path << merge_annotation.path;
fn << merge_annotation.fn;
new_fn;
include_name;
@@
print "Obtained path: %s and file name: %s" % (path,fn)
coccinelle.new_fn = cocci.make_expr(fn.strip('\"'))

import os
pre, ext = os.path.splitext(path.strip('\"'))
p = "%s.h" % (pre)

coccinelle.include_name = cocci.make_ident("\n#include \"%s\"" % (p))

@c@
expression merge_p.new_fn;
expression E1, E2;
expression list E3;
@@
- MERGE_FUNCTION_OPENED(E1, E2, E3);
+ new_fn(E3);

@add_include depends on c@
identifier merge_p.include_name;
@@

#include <...>
+ include_name

Unfortunately, this script works only when a single instance of the
MERGE_FUNCTION_OPENED(...) function is used. When I use both of them I
get a "c: already tagged token:" error.
Using "++" instead of "+" removes the error, but produces a code that
contains 2 calls to the ping_pong function, and 2 calls to the
ping_pong2 function.
Any ideas on how to solve this issue?

Thanks in advance,
Sebastiano
